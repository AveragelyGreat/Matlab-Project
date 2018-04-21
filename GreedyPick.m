function [NewPosition] = GreedyPick(CurrPos,Direction,ElevD)
%The GreedyPick function chooses which array element to go to next, based
%on which adjacent element result in the minimum change in elevation
%The inputs respectively are:
%1). A 2 element 1D array representing the current position where the first
%number is the row number and second is the column number.
%2). An integer representing direction +1 for east, -1 for west.
%3). The elevation data in a 2D matrix.
%Outputs: a 2 element 1D array representing the new position that has been
%picked,where the first element is the row number of the new position and
%the second element is the column number.
%Author: George Mcerlean

%Finds the number of rows in the data to use as a conditional for when the
%point we select is on the last row.
[rows,~] = size(ElevD);

%Creating an array of our future possible elevations, this is split into 3
%different possibilities to allow pre-allocation of memory.
if CurrPos(1) == 1 %If our current position is in the first row
    PossElevsArray = zeros(1,2);%Create our possible elevation array
    for i = 1:2 %Loops for each possible future position
        %Creates an array with our possible future position
        FuturePossPos = [CurrPos(1)+(i-1),CurrPos(2)+Direction];
        %Calculates the elevation of that future position
        PossElevs = ElevD(FuturePossPos(1),FuturePossPos(2));
        %Stores the elevation in an array of possible elevations
        PossElevsArray(i) = PossElevs;
    end
elseif  CurrPos(1) == rows %If our current position is in the last row
    PossElevsArray = zeros(1,2);%Create our possible elevation array
    for i = 1:2 %Loops for each possible future position
        %Creates an array with our possible future position
        FuturePossPos = [CurrPos(1)+(i-2),CurrPos(2)+Direction];
        %Calculates the elevation of that future position
        PossElevs = ElevD(FuturePossPos(1),FuturePossPos(2));
        %Stores the elevation in an array of possible elevations
        PossElevsArray(i) = PossElevs;
    end
else %If our Current position isn't in the first or last row
    PossElevsArray = zeros(1,3);%Create our possible elevation array
    for i = 1:3%Loops for each possible future position
        %Creates an array with our possible future position
        FuturePossPos = [CurrPos(1)+(i-2),CurrPos(2)+Direction];
        %Calculates the elevation of that future position
        PossElevs = ElevD(FuturePossPos(1),FuturePossPos(2));
        %Stores the elevation in an array of possible elevations
        PossElevsArray(i) = PossElevs;
    end
end

%Finds the current elevation
CurrElev = ElevD(CurrPos(1),CurrPos(2));
%Find the 1D position of the smallest change in elevation
NewElev1DPos = FindSmallestElevationChange(CurrElev,PossElevsArray);

%Converts the 1D position into co-ordinates in the elevation data
if  CurrPos(1)-1 < 1 %If the current position is in the first row
    %NewElev1DPos(1) ensures it uses the northernmost pick.
    NewPosition = [CurrPos(1)+(NewElev1DPos(1)-1),CurrPos(2)+Direction];
else %If the current position isnt in the first row
    NewPosition = [CurrPos(1)+(NewElev1DPos(1)-2),CurrPos(2)+Direction];
end
end

