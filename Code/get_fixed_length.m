function [bits_per_symbol] = get_fixed_length(vector_length)


%% get_fixed_length Function Summary
% 
% * Inputs : 
%%
% 
% # The length of the probability vector
% 
% * Outputs : 
% 
% # The bits per symbol needed using a fixed length algorithm
%

%% get_fixed_length Function Details
% convert the lenght of the vector into a binary format and take the length
% of it.


bits_per_symbol =  length(dec2bin( vector_length) ) ;
end

