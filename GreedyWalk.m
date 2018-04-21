function [pathRows,pathCols] = GreedyWalk(Position,Direction,ElevD)
%The GreedyWalk function finds a greedy path from a specified start
%position heading in a specified direction(either west or east) and
%continue walking until the eastern or western edge of the array is
%reached. At each step along the path the next element in the path is
%picked using a greedy choice(i.e. we choose the adjacent element that
%results in the minimum elevation change, with the northern-most element
%chosen in an event of a tie).
%The inputs respectively are:
%1). A 2 element 1D array showing the starting position with first being
%row number and second being column number.
%2). An integer representing direction +1 for east, -1 for west.
%3). The elevation data in a 2D matrix.
%Outputs(respectively):
%1). 1D array containing the row indices of the path
%2). 1D array representint the corresponding column indices of the path
%Author: George Mcerlean

%Finds how many columns the Data has
[~,cols] = size(ElevD);

%Creating the GreedyWalk path
if Direction == 1 %If if is heading east
    %Create our rows array using the elevation data columns to get the
    %right size
    pathRows = zeros(1,(cols-Position(2)+1));
    %Creates our columns array
    pathCols = zeros(1,(cols-Position(2)+1));
    %Puts the initial position in the rows
    pathRows(1) = Position(1);
    %Puts the initial position in the cols
    pathCols(1) = Position(2);
    %Because we have already set the initial position we start at 2 and
    %fill the rest of the array
    for i = 2:(cols-Position(2)+1)
        %Get our next position
        Position = GreedyPick(Position,Direction,ElevD);
        pathRows(i) = Position(1);%Put the new position row into the path
        pathCols(i) = Position(2);%Puts the new position col into the path
    end
else %If it is heading west
    %Create our rows array using the elevation data columns to get the
    %right size
    pathRows = zeros(1,Position(2));
    %Creates our columns array
    pathCols = zeros(1,Position(2));
    %Puts the initial position in the rows
    pathRows(1) = Position(1);
    %Puts the initial position in the cols
    pathCols(1) = Position(2);
    %Because we have already set the initial position we start at 2 and
    %fill the rest of the array
    for i = 2:Position(2)
        %Get our next position
        Position = GreedyPick(Position,Direction,ElevD);
        pathRows(i) = Position(1);%Put the new position row into the path
        pathCols(i) = Position(2);%Puts the new position col into the path
    end
end
end