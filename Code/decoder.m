function [distance,decoded] = decoder(encoded,N)

%% Summary : Input the enocded sequence and the length of one block

distance=zeros(4,N+1); %% create a distance matrix

for k = 1:N
    
    inputbits = encoded(3*k-2:3*k); % take the stream 3 bits by 3 bits

    %% Get the output at each branch
    
    tempa0 = [ 0 0 0]; %% a0 output
    tempa1 = [ 1 1 1]; %% a1 output
    tempb0 = [ 1 0 1]; %% b0 
    tempb1 = [ 0 1 0]; %% b1
    tempc0 = [ 1 1 0]; %% c0
    tempc1 = [ 0 0 1]; %% c1
    tempd0 = [ 0 1 1]; %% d0
    tempd1 = [ 1 0 0]; %% d1
    
    %% Calculate the hamming distance for each branch
    
    hamminga0 = sum( tempa0 ~= inputbits); 
    hamminga1 = sum( tempa1 ~= inputbits);
    hammingb0 = sum( tempb0 ~= inputbits);
    hammingb1 = sum( tempb1 ~= inputbits);
    hammingc0 = sum( tempc0 ~= inputbits);
    hammingc1 = sum( tempc1 ~= inputbits);
    hammingd0 = sum( tempd0 ~= inputbits);
    hammingd1 = sum( tempd1 ~= inputbits);
    
    %% Calculate the hamming distance for each node by comparing the accumlated distances of the branchs leading to this node
    distance(1,k+1)=min(distance(1,k)+hamminga0,distance(2,k)+hammingb0);% 00 node
    distance(2,k+1)=min(distance(3,k)+hammingc0,distance(4,k)+hammingd0);% 01 node
    distance(3,k+1)=min(distance(1,k)+hamminga1,distance(2,k)+hammingb1);% 10 node
    distance(4,k+1)=min(distance(3,k)+hammingc1,distance(4,k)+hammingd1);% 11 node
    
end
 
decoded = zeros(1,N); % preallocation for the decoded stream

decoded_index = N;  % starting from N and decrementing beacuse it's back propagating

%% Loop over the minimum distance of the current state and the previous state and deduce the input from it

for i = N+1:-1 : 2
    [~,state] = min(distance(:,i)); % current state
    [~,prev_state] = min(distance(:,i-1)); % Previous state
    
    %% From the trellis diagram %% 
    
    if state == 1 && prev_state == 1
        decoded( decoded_index) = 0;
    elseif state == 1 && prev_state == 2
        decoded(decoded_index) = 0;
    elseif state == 2 && prev_state == 3
        decoded(decoded_index) = 0;
    elseif state == 2 && prev_state == 4
        decoded(decoded_index) = 0;
    elseif state == 3 && prev_state == 1
        decoded(decoded_index) = 1;
    elseif state == 3 && prev_state == 2
        decoded(decoded_index) = 1;
    elseif state == 4 && prev_state == 3
        decoded(decoded_index) = 1;
    elseif state == 4 && prev_state == 4
        decoded(decoded_index) = 1;
    end
    
    decoded_index = decoded_index -1; % decrease the index by one
    
    
end
