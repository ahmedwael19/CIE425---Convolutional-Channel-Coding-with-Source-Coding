function [encoded] = huff_encoder(text_mapped,dict)

%%  huff_encoder Function Summary
% 
% * Inputs : 
%%
% 
% # The text file mapped array obtained from *get_prob_indicies* function. 
% # The dictionary containing the symbols,the codes,and the index for each
% code obtained from *decision* function.
% 
% * Outputs : 
% 
% # The encoded sequence using the Huffman code.
%

%% huff_encoder Function Details
%%
% 
% # Encode by assigning the value of each element in the mapped text vector
% to the corresponding code in the dictionary.
% # converting the encoded cell array into a matrix *( i.e. the first cell
% array is { [0,1,1] } and it should be converted into [ 0 0 0] as three
% different elements )* .
% 

encoded = dict.code(text_mapped);
encoded = cell2mat(encoded');
encoded = encoded';

end

