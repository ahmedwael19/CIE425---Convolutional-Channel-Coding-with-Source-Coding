function [enc] = encoder(input)
%Encoder Summary : input stream as a block
%Encoder Detailed Explantion : 
% First : Padding with 2 zeros ( k-1)
% Second : create a temporary array and shift it each time instance by one
% 2 elements one by one.
% Third : Partiy Generations is [ 1 1 1] , [ 1 1 0 ] , [ 1 0 1] 
% Forth : concatenate the elements of the output in a loop from 1 to the
% length of the input

input = [ input 0 0 ]; %%padding by zero

temp = zeros(1,3); % input and two shift registers
Output = [];
in = [];
state=[];

%% Generate the output parity matrix

for j = 1 : length(input)
    temp(3) = temp(2);
    temp(2) = temp(1);
    temp(1) = input(j);
    p1 = mod(temp(1) + temp(2) + temp(3), 2); %% generation 1 1 1 
    p2 = mod(temp(1) + temp(2), 2); %% generation 1 1 0  
    p3 = mod(temp(1) + temp(3), 2); %% generation 1 0 1 
    Output = [ Output p1 p2 p3];
end

enc = Output;


