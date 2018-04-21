function [pathElev,Cost] = FindPathElevationsAndCost(pRows,pCols,ElevD)
%FindPathElevationsAndCost takes a specified path and finds the elevations
%encountered while walking along the path and also calculates the total
%cost of traversing that path
%The Inputs respectively are:
%1). A 1D array representing the row numbers of the path
%2). A 1D array containing the corresponding column numbers of the path
%3). Elevation data in a 2D array
%OutPuts(respectively):
%1). A 1D array containing the elevations for the corresponding row and
%column numbers for the path
%2). The total cost of traversing the path
%Author: George Mcerlean

%Find the number of columns in the elevation data
[~,cols] = size(ElevD);
%Creates the elevations array
pathElev = zeros(1,cols);
%Sets the current elevation as the first point in the path
CurrentElevation = ElevD(pRows(1),pCols(1));
%Find the elevation of the first point in the path
pathElev(1) = CurrentElevation;
%Sets the initial cost
Cost = 0;

%Finding the Cost and path elevations
for i = 2:cols %loops for each column excluding the first
    %Sets the current elevation as the previous
    PreviousElevation = CurrentElevation;
    %Find the new current elevation value
    CurrentElevation = ElevD(pRows(i),pCols(i));
    %Add the current elevation to the path
    pathElev(i) = CurrentElevation;
    %Add the cost for moving to the new elevation (cost is always positive)
    Cost = Cost + abs(CurrentElevation - PreviousElevation);
end
end

