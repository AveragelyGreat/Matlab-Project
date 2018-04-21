function [pathRows,pathCols,pathElevs] = BestGreedyPath(ElevD)
%BestGreedyPath will find the best greedy path by calculating greedy paths
%from every single element in the elevation array. For points not on the
%eastern or western edge it will find a path east and a path west and
%combine them. In the event of a tie it will return the first path
%discovered.
%The input is the elevation data stored in a 2D array
%The outputs respectively are:
%1). a 1D array representing the row numbers
%2). a 1D array representing the corresponding column numbers
%3). a 1D array containing the elevations for the corresponding row and
%column number for the path
%Author: George Mcerlean

%Get the number of rows and cols from the elevation data
[rows,cols] = size(ElevD);
%Creates an array for all possible path rows
pRowsArray = zeros((rows*cols),cols);
%Creates our columns output(always from 1 to the number of columns)
pathCols = [1:cols];
%Creates an array for all possible path elevations
pElevsArray = zeros((rows*cols),cols);
%Creates and array for costs of all paths
costA = zeros(1,(rows*cols));

%This nested loop allows us to select all points within the array as
%starting positions
for i = 1:rows %Row number of the starting position
    for j = 1:cols %Column number of the starting position
        %Find the row in the Rows array and elevs array to store the data
        %for the current starting position
        Ar = j+(i-1)*cols;
        %Find the path for our starting postition heading east
        Direction = 1;
        [pRowsArray(Ar,j:cols),~] = GreedyWalk([i,j],Direction,(ElevD));
        %Find the path for our starting position heading west
        Direction = -1;
        %Store the path rows in our array
        [pRowsArray(Ar,j:-1:1),~] = GreedyWalk([i,j],Direction,(ElevD));
        %Find and store the cost and elevations for our path.
        [pElevsArray(Ar,:),costA(Ar)] = ...
            FindPathElevationsAndCost(pRowsArray(Ar,:),pathCols,ElevD);
    end
end

%Find the path which has the smallest cost
%The find fuunction returns the position of what is specified(in this case
%the minimum value, if there are multiple outputs you can specify the
%number you want by putting a number after (in this case 1), it always
%returns the first one found in the array.
smallestCostPosition = find(costA == (min(costA)),1);

%Set the output rows and elevations array to the one with the lowest cost
pathRows = pRowsArray(smallestCostPosition,:);
pathElevs = pElevsArray(smallestCostPosition,:);
end

