function [decoded] = huff_decoder(encoded,dict)

%% huff_decoder Function Summary
% 
% * Inputs : 
%%
% 
% # Encoded sequence
% # The dictionary containing the symbols,the codes,and the index for each
% code obtained from *decision* function.
% 
% * Outputs : 
% 
% # The decoded sequence using the Huffman code.
%

%%  huff_decoder Function Details
%%
% 
% # Initialize the end and start indicies to be 1.
% # Create a flag to indicate if a code for a symbol is found.
% # Iterate over the encoded sequence until the end index is equal to the
% and do the following :
%%
% 
% * Save the values of the encoded sequence from the start index to the end
% index in a temporary variable.
% * Loop for a number of times equal the number of the symbols and do the
% following :

%%
% 
% * Create a compare variable which contains the code of each symbol for
% each iteration *( i.e. if j = 1 then compare will be [0;1;1;0] for example
% which corresponds for the huffman code for 'a')* . This can be done be
% calling the built-in function _cell2mat_ and transponsing it for convience.
% * If the values of the temporary variable and the compare variable are
% equal, concatenate the decoded array with corresponding index *( i.e. if
% 'a' is found, write 1)* .
% * Raise the found symbol flag and break from the loop as the following
% iterations are unnecessary.
% * Increase the end index by one , and increase the start index by end +1
% if a the flag is raised *( i.e. the flag = 1 for start = 2 and end = 6,
% then we need to have start = 7 and end =8 )* .
% 

start_index=1;
end_index = 1;
decoded = [];
found_symbol_flag=0;

while(end_index <= length(encoded))
    temp_code = encoded(start_index:end_index);
    for j = 1:length(dict.code)
        compare = dict.code(j);
        compare = cell2mat(compare');
        compare = compare';
        if ( isequal ( temp_code, compare ) )
            new = (dict.index(j));
            decoded = [ decoded ; new];
            found_symbol_flag =1;
            break;
        end
    end
    if found_symbol_flag ==1
        start_index = end_index +1;
    end
    end_index = end_index +1;

    found_symbol_flag =0;
end
    
    
end

