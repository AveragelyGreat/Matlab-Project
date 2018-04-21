function [pathRows,pathCols,pathElevs] = BestGreedyPathHeadingEast(ElevD)
%BestGreedyPathHeadingEast will find the best greedy path starting from
%the westerly edge (i.e.using starting points in column 1). In the event
%of one or more paths tying for the lowest cost, the path that starts with
%the lowest row number will be returned.
%The Input is the elevation data stored in a 2D array
%The outputs respectively are:
%1). A 1D array representing the row indices of the path
%2). A 1D array representing the corresponding column indices of the path
%3). A 1D array containing the elevation data for the corresponding row and
%column numbers
%Author: George Mcerlean

%Find the number of rows and columns in the data
[rows,cols] = size(ElevD);
%Create our Array of path rows
pathRowsArray = zeros(rows,cols);
%Create our array of path columns (always just 1 to the number of columns)
pathCols = 1:cols;
%create our array of elevations for the corresponding row and column
%numbers
elevsArray = zeros(rows,cols);
%create our array of costs
costArray = zeros(1,rows);

%Filling our rows,cols,elevs and cost arrays.
for i = 1:rows %repeat for each starting point on the westerly edge
    %Get the path for our starting point
    [CurrRow,CurrCol] = GreedyWalk([i,1],1,ElevD);
    %Store the path in our arrays
    pathRowsArray(i,:) = CurrRow;
    %Find the cost and elevations of the path
    [elevs,Cost] = FindPathElevationsAndCost(CurrRow,CurrCol,ElevD);
    %Store the cost and elevations in an array
    elevsArray(i,:) = elevs;
    costArray(i) = Cost;
end

%Find the path with the smallest cost
%The find function returns the position of what is specified(in this case
%the minimum value, if there are multiple outputs you can specify the
%number you want by putting a number after (in this case 1), it always
%returns the first one found in the array.
smallestCostPosition = find(costArray == (min(costArray)),1);

%Set the path with the smallest costs as the output for our rows, cols and
%elevs.
pathRows = pathRowsArray(smallestCostPosition,:);
pathElevs = elevsArray(smallestCostPosition,:);
end
