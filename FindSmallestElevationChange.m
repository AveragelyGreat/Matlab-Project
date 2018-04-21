function [smallestPos] = FindSmallestElevationChange(CurrElev,NewElev)
%FindSmallestElevationChange finds the position in an array of elevations
%of the element or elements that correspond to the smallest change in
%elevation, given the current elevation.
%Inputs(respectively):
%1). A number giving the Current elevation.
%2). A 1D array of new elevations to choose from.
%Output: A 1D array containing a list of indices that identify the array
%element(s) that correspond to the smallest change in elevation.
%Author: George Mcerlean

%Create an array to store elevations distance changes in
Distances = zeros(1,length(NewElev));

%Filling the elevation changes(distances) array.
for i = 1:length(NewElev)%Repeat the loop for each value in the input array
    %Replace the zeros in the Distance array with the positive values for
    %the change in distance between the current elevation and possible new
    %elevation
    Distances(i) = abs(CurrElev - NewElev(i));
end

%Finds the position(s) in the 1D distances array of the minimum elevation
%change and puts them into the output array.
%The find function returns the position of what is specified(in this case
%the minimum value, if there are multiple outputs you can specify the
%number you want by putting a number after. If no number of outputs is
%specified all are returned.
smallestPos = find(Distances == (min(Distances)));
end