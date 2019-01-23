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
input = huff_encoder(text_mapped,dict);

%% Data Input and allocation

L = length(input); % Block length
N = 1; % Number of blocks
% input = randi([ 0, 1] , N,L); % Row representing block
snr = [ -2:0.5:18];
BER_no_encoding = zeros(1,length(snr));
BER_with_encoding = zeros(1,length(snr));
ber_index = 1;
input  = input';
for snr = -2:0.5:snr(end)
    
    %% Encoding
    
    encoded = zeros(N, ( L+2) * 3);
    for i = 1 : N
        encoded= encoder(input);
        
    end
    
    %% Adding Noise
    
    m_noise = round(awgn(input,snr,'measured')); %% Without coding
    m_enc_noise = round(awgn(encoded,snr,'measured')); %% with coding
    
    
    %% Decoding
    
    decoded = zeros(N,L); % preallocation
    
    for i = 1 :N
        [dis,decoded] = decoder(m_enc_noise,L);
    end    
    BER_no_encoding(ber_index)  = sum(sum( m_noise ~= input ) )/ numel(input); 
    BER_with_encoding(ber_index) = sum(sum( decoded ~= input ) )/ numel(input);
    ber_index = ber_index +1;
end


%% 8 - Decode the encoded file using the dictionary


decoded_2 = huff_decoder(decoded',dict);


%% 9 - Convert the index array back into char array and write into output file
decoded_symbol = huff_decoder_symbol(decoded_2,dict);
 
fileID2 = fopen('output.txt','w');
fprintf(fileID2,'%c',decoded_symbol);

snr = [ -2:0.5:18];

%% 10 - Calculate the Huffman Algorithm Efficiency
efficiency_huffman  =  ( entropy / avg_huffman ) *100
figure;
semilogy( snr,BER_with_encoding,'-o');
title('SNR vs BER');
xlabel('SNR(dB)'); 
ylabel('BER');
hold on
semilogy(snr,BER_no_encoding, '-o');
legend('BER with convolution encoding','BER without convolution encoding');
grid on