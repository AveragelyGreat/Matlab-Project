function [ReversedArray] = Reverse(Array)
%This function reverses the values in a 1D array for example [1 2 3] will
%become [3 2 1]. This function works for both 1 column and 1 row arrays.
%Input: A 1D array to reverse
%Output: A 1D array with the elements in reverse order to the input.
%Author: George Mcerlean

%Creates the output array and fills it with zeros.
[rows,cols] = size(Array); %Find the dimensions of the current array
%Uses the dimensions to create the Reversed Array
ReversedArray = zeros(rows,cols);

%Creating the Reversed Array
for i = 1:length(Array) %Repeats the loop for each value in the Array
    %Replaces the zero in the output array with the Reversed value from the
    %input array
    ReversedArray(i) = Array(length(Array) - (i-1));
end
end