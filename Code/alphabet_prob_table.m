function [Table] = alphabet_prob_table(prob)


%%  alphabet_prob_table Function Summary
% 
% * Inputs : 
%%
% 
% # The probability vector 
% 
% * Outputs : 
% 
% # Table with three data types ( probabilities - alphabet - indicies ) to link them into one data structure
% # Array of probabilities for each symbol
%

%%  alphabet_prob_table Function Details
%%
% 
% # Create a character array of the alphabet.
% # Convert the character array into cell array in order to separate the
% symbols from each other using the built-in function _num2cell_ .
% # Create a indicies array with values equal to the length of the
% probability array.
% # transpose all the vectors for convience and later use.
% # Construct the table by using the command _table_ .
%


alphabet = [ 'a':'z' ' ().,/-'];
alphabet = num2cell(alphabet)';
indices = [1:length(prob)]';
prob = prob';
Table = table(prob, alphabet,indices);
end

