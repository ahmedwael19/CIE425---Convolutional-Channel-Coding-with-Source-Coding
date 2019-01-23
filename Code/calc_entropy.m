function [entropy] = calc_entropy(probability)


%% calc_entropy Function Summary
% 
% * Inputs : 
%%
% 
% # The probability array 
% 
% * Outputs : 
% 
% # The Theoritical Entorpy  
%

%% calc_entropy Function Details
%%
% 
% # The Entropy formula is $-\sum p \log p$ , so it's implemented using
% vectorization instead of a loop in order to increase performance.
% 

i = 1:length(probability);
entropy = sum ( - ( probability(i) .* log2(probability(i))));
end
