function [prob,text_mapped] = get_prob_indicies(text)

%% get_prob_indicies Function Summary
% 
% * Inputs : 
%%
% 
% # The char array Text file 
% 
% * Outputs : 
% 
% # A corresponding array to the text file array but mapped into double values  
% # Array of probabilities for each symbol
%

%% get_prob_indicies Function Details

%%
% 
% # Convert the text file into its corresponding ASCII code using the
% build-in function _double_
% # Pre-allocate the probabilities array with the length of the alphabet
% used ( *33* ) with the following mapping : 
    %%
    %
    % * 	1:26 -> a:z
    % * 	27   -> space character
    % *     28   -> ( character
    % *     29   -> ) character
    % *     30   -> . character
    % *     31   -> , character
    % *     32   -> / character
    % *     33   -> - character
    %
% 3. Pre-allocate the mapping array with the length of the text file.
%
% 4. loop over the text file and do the following :
%%
% 
% * Get the remainder of the current ASCII symbol and *96* which correspond
% to 'a' -1.
% * If the remainder less than or equal 26 , then increase the
% corresponding index in the probability array by one. If not , compare it
% with corresponding ASCII code for the remaining symbols  ().,/- ,
% then do the same.
% * Map this value into the same index in the mapping array.
%
% 5. Transpose the index array for convinence in subsequent functions.
%
% 6. Get the probability by dividing the probability array by the length of
% the text file. This can be done as MATLAB supports broadcasting.


text_to_ascii = double(text);
prob = zeros(1,33);
text_mapped= zeros(1,length(text));

for i = 1: length(text_to_ascii)
    alphabet = mod( text_to_ascii(i) , 96 );
    if alphabet <= 26
        prob(alphabet) = prob(alphabet) +1;
        text_mapped(i) = alphabet;
        
    elseif alphabet == 32
        prob(27) = prob(27) +1;
        text_mapped(i) = 27;
   
    elseif alphabet == 40
        prob(28) = prob(28) +1;
        text_mapped(i) =28;
    
    elseif alphabet == 41
        prob(29) = prob(29) + 1;
        text_mapped(i) = 29;
    
    elseif alphabet == 46
        prob(30) = prob(30) +1;
        text_mapped(i) =30;
    
    elseif alphabet == 44
        prob(31) = prob(31) +1 ;
        text_mapped(i) = 31;
    
    elseif alphabet == 47
        prob(32) = prob(32) +1;
        text_mapped(i) = 32;
    
    elseif alphabet == 45 
        prob(33) = prob(33) +1;
        text_mapped(i) = 33;
    end
end

text_mapped = text_mapped';
prob = prob /length(text_to_ascii);
end
