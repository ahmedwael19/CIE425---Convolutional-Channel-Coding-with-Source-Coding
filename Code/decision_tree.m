function [tree,dict,avg] = decision_tree(table)

%% decision_tree Function Summary
% 
% * Inputs : 
%%
% 
% # The table structure obtained from *alphabet_prob_table* function
% containing three data types ( probabilities - alphabet - indicies ).
% # ITEM2
% 

%%
% 
% 
% * Outputs : 
% 
% # The construced tree with all the nodes, edges and weights *plotted* .
% # Dictionary containing the alphabet, the huffman code and the index.
% # The average number of bits needed in huffman code.
% 

%% decision_tree Function Details ( Construct the tree )
% 
%%
% 
% # Copy the table into another variable in order to save its content for
% later use when constructing the dictionary.
% # Create a graph with directed edges using the built-in function
% _digraph_
% # Constuct the weight vector for the nodes.
% # Loop over the symbols in a descending order and do the following :
%%
% 
% * Sort the table by rowing in a desecnding order.
% * Get the first and second least probabilities by accessing their
% corresponding index in the table.
% * Sum the two least probabilities and assign the value into a variable.
% * Construct the two children nodes by getting the corresponding symbol
% from the sorted table entry. 
% * Create a 1*2 string array containing both children nodes after
% converting each one of them seperately into string ,otherwise they will
% be treated as one symbol *( x= 'c' , y = 'v' , then MATLAB will evaluate
% z = [ x y] as 'cv' , while it needed here as "c", "v" )* .
% * *The magic happens here* Construct the parent node by first
% concatenating the two children nodes as characheres, then convert the
% whole character array into string array *This is needed because for
% example 'cv' is stored as a 1*2 char array while "cv" is stored as 1*1
% string array, which is needed in this case*.
% * Add a new edge to the tree by passing the parent and the children nodes
% with the weight vector for each node (* The smallest one is assigned 0 
% and the second smallest one is assigned 1*).
% * Delete the last entry of the table and store the sum of the two least
% probabilities in index before the last.
% * Store the parent node symbol as a cell in the index before the last in
% the table using the built-in function _cellstr_.
%

%%
% 
% * plot the tree with the weights on each edges.
% * Note that the nodes are unique so the tree will be constructed
% correctly. This is a manipulation of the graph as tree is a special case
% of a graph with special properties. These properties are forced here,
% therefore the graph behave *exactly* as a tree.
%

sorted_table =table;
tree = digraph();
w = [1;0];
for last_symbol_index = length(table.prob):-1:2
  
    sorted_table = sortrows(sorted_table,{'prob'},{'descend'});
    
    first_two_least = sorted_table.prob(last_symbol_index);
    second_two_least = sorted_table.prob(last_symbol_index-1);
    sum_two_least = first_two_least + second_two_least;
  
    first_child_node = cell2mat(sorted_table.alphabet(last_symbol_index));
    second_child_node = cell2mat(sorted_table.alphabet(last_symbol_index-1));
    children_nodes =[convertCharsToStrings(first_child_node)  convertCharsToStrings( (second_child_node)) ];
    
    parent_node = convertCharsToStrings( [ (first_child_node) (second_child_node)] );
    
    tree = addedge(tree,(parent_node),children_nodes,w );
    
    sorted_table(last_symbol_index,:) = [];
    sorted_table.prob(last_symbol_index-1) = sum_two_least;
    sorted_table.alphabet(last_symbol_index-1) = cellstr(parent_node);


end

plot(tree,'EdgeLabel',tree.Edges.Weight);
title('Huffman Decision Tree');


%% decision_tree Function Details ( Construct the dictionary )

%%
% 
% # Create an empty cell array and name it dict.
% # Assign the table alphabet to the first column in the dict.
% # Initialize a flag and name it found_symbol_flag. This will be used in
% the following loop.
% # Loop for a number of times equal to the number of alphabet symbols and
% do the following :
% 
%%
% 
% * Initialize a flag variable each iteration with the name of first_time_flag which will
% be used to indicate if this is the first time to find this symbol. This
% will prevent putting a false 0 or 1 at the beginning of the code.
% * Initialize temp_weight = 0 each iteration.
% * Store the current alphabet symbol in a variable alphabet_symbol.
% * Loop through symbols and compare the symbol character by character
% using a for loop.
% * If a match is found, raise the found_symbol_flag and break from the
% nested loop. Then, if the flag = 1, concatenate the temp_weight array.
% *restart the state of found_symbol_flag.
% *Assign the weight vector to the second column with the corresponding
% row.
% *Assign the table indicies to the third column with the corresponding
% row.
%
%%
% 
% * convert the dictionary data type into a table in order to deal with the
% names of each column.
% * Assign {'alphabet','code','index'} to the variables names
% 



dict = {};
dict(:,1) = table.alphabet;
found_symbol_flag = 0;

for i = 1: length(table.prob)
    first_time_flag = 0;
    temp_weight=0;

    alphabet_symbol = cell2mat(table.alphabet(i));

    for j = length( tree.Edges.Weight) : -1 :1
        current_symbol = cell2mat(tree.Edges.EndNodes(j,2));

        for k = 1:length(current_symbol)
            char_in_symbol = current_symbol(k);
            if alphabet_symbol ==char_in_symbol
                found_symbol_flag = 1;
                break;
            end
        end
        if found_symbol_flag ==1
            if first_time_flag == 0
                temp_weight= tree.Edges.Weight(j);
                first_time_flag =1;
            else
                temp_weight_temp =tree.Edges.Weight(j); %%lol
                temp_weight = [ temp_weight temp_weight_temp];

            end
        end
        found_symbol_flag =0;
    end

    dict(i,2) = {temp_weight};
    dict(i,3) = {table.indices(i)};


end
dict = cell2table(dict);
dict.Properties.VariableNames = {'alphabet','code','index'};


%% decision_tree Function Details ( Calculate the averege bits per symbol )

%%
% 
% * Sum over the probability of each symbol with its corresponding code in
% the dictionary
% 

avg=0;
for i = 1:length(table.prob)
    avg = avg+ table.prob(i)*length(cell2mat( dict.code(i)));
end


end
