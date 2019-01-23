%% 1 - Open the Textfile and save its content in a char array then close it
fileID = fopen('Huff.txt','r');
text = fscanf(fileID,'%c');
fclose(fileID);

%% 2 - Get the probability of each symbol and convert the char array into index array ( ex : replace each 'a' with 1 )

[probabilities,text_mapped] = get_prob_indicies(text);


%% 3 - Calculate the Entropy of the file
entropy = calc_entropy(probabilities);


%% 4 - Calculate the number of bits needed using run length algorithm and calculate its efficiency
fixed_length = get_fixed_length( length(probabilities) );
efficiency_fixed_length  =  ( entropy / fixed_length ) *100


%% 5 - Create a table with three data types ( probabilities - alphabet - indicies ) to link them into one data structure
table = alphabet_prob_table(probabilities);


%% 6 - Construct the decision Tree and then calculate the avergae number of bits needed and return the dictionary containing each symbol with its index and its Huffman code
[tree,dict,avg_huffman] = decision_tree(table);

%%
% 
% <<tree.bmp>>
% 


%% 7 - Encode the file using the dictionary
encoded = huff_encoder(text_mapped,dict);


%% 8 - Decode the encoded file using the dictionary


decoded = huff_decoder(encoded,dict);


%% 9 - Convert the index array back into char array and write into output file
decoded_symbol = huff_decoder_symbol(decoded,dict);
 
fileID2 = fopen('output.txt','w');
fprintf(fileID2,'%c',decoded_symbol);
%% 10 - Calculate the Huffman Algorithm Efficiency
efficiency_huffman  =  ( entropy / avg_huffman ) *100