# CIE425---Convolutional-Channel-Coding-with-Source-Coding
This program will take a text file as input and encode it using Huffman lossless algorithm.

This code is fully developed by Ahmed Wael for the Information Theory and Coding class in Fall 2018.

## How to use
* For channel coding only:
    - Run the .m file named main_channel.
* For both the source and channel coding :
    - Run the .m file named main.
    
For code details and documentation, please take a look at the documentation folder.


# Algorithm

1. Encode the input stream block by block
    - creating a temporary array and shift the elements right with each
iteration a new input bit enters.
    - Calculate the parity output bits based on the chosen generation
functions K.
2. Add the additive white gaussian noise (AWGN) to simulate the channel
effect.
3. Decode the encoded stream block by block
    - Calculate the output of each of the different branches are the are equal
to 2n where n is equal to the output size over the input size.
    - For each K bits, calculate 2n hamming distances corresponding the
different branches by summing the different bits.
    - Calculate the hamming distance for each node by comparing the
accumulated distances of the branches leading to this node.
    - Loop from the end of the trellis to the beginning of it, and get the
current state and the previous state, which can lead to finding the
decoded bit.
4. Calculate the bit error rate by summing all the different bits of the decoded
versus the input streams, and divide by the input size.
5. Compare the performance of the uncoded code versus the convolutional
code.
6. All this is integrated with the source coding from [Huffman project](https://github.com/ahmedwael19/CIE425---Huffman-Algorithm).
## SNR vs BER

For the attached example, the SNR vs BER for both the encoding with the convoluational encoding and without the convolutional encoding can be generated in a MATLAB as following :
![alt text](https://raw.githubusercontent.com/ahmedwael19/CIE425---Convolutional-Channel-Coding-with-Source-Coding/master/SNRvsBER.jpg)




## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
