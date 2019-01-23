
%% Data Input and allocation

L = 500; % Block length
N = 100; % Number of blocks
input = randi([ 0, 1] , N,L); % Row representing block
BER_no_encoding = zeros(1,length(snr));
BER_with_encoding = zeros(1,length(snr));
ber_index = 1;

for snr = -2:0.5:snr(end)
    
    %% Encoding
    
    encoded = zeros(N, ( L+2) * 3);
    for i = 1 : N
        encoded(i,:)= encoder(input(i,:));
        
    end
    
    %% Adding Noise
    
    m_noise = round(awgn(input,snr,'measured')); %% Without coding
    m_enc_noise = round(awgn(encoded,snr,'measured')); %% with coding
    
    
    %% Decoding
    
    decoded = zeros(N,L); % preallocation
    
    for i = 1 :N
        [dis,decoded(i,:)] = decoder(m_enc_noise(i,:),L);
    end    
    BER_no_encoding(ber_index)  = sum(sum( m_noise ~= input ) )/ numel(input); 
    BER_with_encoding(ber_index) = sum(sum( decoded ~= input ) )/ numel(input);
    ber_index = ber_index +1;
end
snr = [ -2:0.5:18];

semilogy( snr,BER_with_encoding,'-o');
title('SNR vs BER');
xlabel('SNR(dB)'); 
ylabel('BER');
hold on
semilogy(snr,BER_no_encoding, '-o');
legend('BER with convolution encoding','BER without convolution encoding');
grid on