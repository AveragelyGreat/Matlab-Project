function [pathRows,pathCols,pathElevs] = BestPath(ElevD)
%BestPath provides the path where a person walking from the west side to
%the east side would experience the smallest possible total change in
%elevation. This code takes inspiration from Dijksra's Algorithm and works
%by finding the best path to each point starting from the west and moving
%along in columns till it gets to the final column where it calculates the
%best path of the best paths heading to each point in the final column.
%Dijkstra's Algorithm researched from:
%http://www.geeksforgeeks.org/greedy-algorithms-set-6-dijkstras-shortest-path-algorithm/
%Inputs: The elevation data stored in a 2D array
%The Outputs respectively are:
%1). a 1D array representing the row numbers of the path
%2). a 1D array representing the corresponding column numbers of the path
%3). a 1D array containing the elevation for the corresponding row and
%column numbers for the path.
%Author: George Mcerlean

%Setting up arrays
%Find the number of rows and columns of the data
[rows,cols] = size(ElevD);
%Create and array for our current points
CurrPoints = zeros(1,rows);
%Create an array for our next points
NextPoints = zeros(1,rows);
%Set our current points to be the first column in the data
CurrPoints(1,:) = ElevD(:,1);
%Create an array to contain all the potential path row numbers
rowPArray = zeros(rows,cols);
%Create an array to contain all the potential path costs
pCostArray = zeros(1,rows);
%Create an array to contain all the potient path elevations
pElevsArray = zeros(rows,cols);
%Set the first row of each path to its row number
rowPArray(:,1) = 1:rows;
%Set the path columns to 1 to the number of columns because you always head
%from west to east.
pathCols = 1:cols;
%Set our first column of each path to its elevation corresponding with its
%row and column numbers.
pElevsArray(:,1) = ElevD(:,1);

%Creating the potential paths
for i = 2:cols %Repeats for each column
    %Sets up our next points
    NextPoints(1,:) = ElevD(:,i);
    %Creates a throwaway array so our path arrays don't get changed till i
    %loops again
    TRowsArray = zeros(rows,i);
    TElevsArray = zeros(rows,i);
    TCostArray = zeros(1,rows);
    for j = 1:length(NextPoints) %Repeat for each point in our column
        if j == 1 %If it is in the top row
            %Creates costs for moving from the points previous to the new
            %point
            Path1Cost = abs(NextPoints(j)-CurrPoints(j))+ pCostArray(j);
            Path2Cost = abs(NextPoints(j)-CurrPoints(j+1))+pCostArray(j+1);
            %Puts these points in an array
            TempCostArray = [Path1Cost,Path2Cost];
            %Checks the array for which path costs less and returns its
            %position
            Point = find(TempCostArray == min(TempCostArray),1);
            %Sets our cost, rows and elevations array's to represent this
            %point.
            TCostArray(j) = TempCostArray(Point);
            TRowsArray(j,:) = [rowPArray(Point+j-1,1:(i-1)),j];
            TElevsArray(j,:) = [pElevsArray(Point+j-1,1:(i-1)),ElevD(j,i)];
        elseif j == length(NextPoints) %If it is in the bottom row
            %Creates costs for moving from the points previous to the new
            %point
            Path1Cost = abs(NextPoints(j)-CurrPoints(j-1))+pCostArray(j-1);
            Path2Cost = abs(NextPoints(j)-CurrPoints(j))+ pCostArray(j);
            %Puts these points in an array
            TempCostArray = [Path1Cost,Path2Cost];
            %Checks the array for which path costs less and returns its
            %position
            Point = find(TempCostArray == min(TempCostArray),1);
            %Sets our cost, rows and elevations array's to represent this
            %point.
            TCostArray(j) = TempCostArray(Point);
            TRowsArray(j,:) = [rowPArray(Point+j-2,1:(i-1)),j];
            TElevsArray(j,:) = [pElevsArray(Point+j-2,1:(i-1)),ElevD(j,i)];
        else
            %Creates costs for moving from the points previous to the new
            %point
            Path1Cost = abs(NextPoints(j)-CurrPoints(j-1))+pCostArray(j-1);
            Path2Cost = abs(NextPoints(j)-CurrPoints(j))+ pCostArray(j);
            Path3Cost = abs(NextPoints(j)-CurrPoints(j+1))+pCostArray(j+1);
            %Puts these points in an array
            TempCostArray = [Path1Cost,Path2Cost,Path3Cost];
            %Checks the array for which path costs less and returns its
            %position
            Point = find(TempCostArray == min(TempCostArray),1);
            %Sets our cost, rows and elevations array's to represent this
            %point.
            TCostArray(j) = TempCostArray(Point);
            TRowsArray(j,:) = [rowPArray(Point+j-2,1:(i-1)),j];
            TElevsArray(j,:) = [pElevsArray(Point+j-2,1:(i-1)),ElevD(j,i)];
        end
    end
    %Makes the values in the throwaway permanent before looping back to the
    %next value of i.
    rowPArray = TRowsArray;
    pElevsArray = TElevsArray;
    pCostArray = TCostArray;
    %Sets the current points to the points just checked
    CurrPoints = NextPoints;
end

%Finds the best path of all the final column point paths returning only 1
%value
smallestpath = find(pCostArray == min(pCostArray),1);

%Sets the output path rows and elevations to the minimum cost path values.
pathRows = rowPArray(smallestpath,:);
pathElevs = pElevsArray(smallestpath,:);
end
