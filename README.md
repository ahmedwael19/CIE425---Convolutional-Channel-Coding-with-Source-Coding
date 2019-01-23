# CIE425---Convolutional-Channel-Coding-with-Source-Coding
This program will take a text file as input and encode it using Huffman lossless algorithm.

This code is fully developed by Ahmed Wael for the Information Theory and Coding class in Fall 2018.

## How to use
Run the .m file named Huff as it is the main program where all the functions are called.

For code details and documentation, please take a look at the Documentation folder, where both the details of the algorithm and the code details are explained throughly. 


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

## SNR vs BER

For the attached example, the SNR vs BER can be generated in a MATLAB as following :
![alt text](https://raw.githubusercontent.com/ahmedwael19//CIE425---Convolutional-Channel-Coding-with-Source-Coding/master/SNR%vs%BER.jpg)




## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
