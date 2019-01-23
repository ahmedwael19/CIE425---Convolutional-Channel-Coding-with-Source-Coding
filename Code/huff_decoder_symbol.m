function [decoded_symbol] = huff_decoder_symbol(decoded,dict)
%% huff_decoder_symbol Function Summary
% 
% * Inputs : 
%%
% 
% # Decoded sequence
% # The dictionary containing the symbols,the codes,and the index for each
% code obtained from *decision* function.
% 
% * Outputs : 
% 
% # The decoded sequence using the Huffman code but converted back into char array.
%

%% huff_decoder_symbol Function Details
%
%%
%
% # Find the mapped value for each symbol by accessing the decoded
% vector.
% # Find the corresponding character by using accessing the dicitonary
% element of this mapped value
% # Convert the cell into vector using _cell2mat_ and transpose it.
%
index_of_symbol = 1 : length(decoded);
decoded_symbol = cell2mat(dict.alphabet( decoded(index_of_symbol)) )';
    



