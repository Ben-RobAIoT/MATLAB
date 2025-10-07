%   This program is a test for the golomb encoding/ decoding porgram suite.
%   Call the golomb_enco function to perform golomb coding of input codeword
%   and coding parameter.
%   Call the golomb_deco function to decode the golomb coded codeword.
% 
% Author: Vishnu Muralidharan
%         University of Alabama in Huntsville
% Done for the project:
% 'Implementation of Golomb Encoder/Decoder to perform image coding'
% CPE 790: Data Compression, Fall 2014

clc;
clear all;
close all;

%% Golomb coding/decoding for single numbers
% total = 10000;
% n = randint(1,total,[0,1024]); % generate an input vector of random numbers
% m = randint(1,total,[1,1024]);  % generate coding paramter vector
% y=zeros(1,total); % array to store decoded values
% 
% % Encoding and Decoding
%  for i = 1: total
%     x = golomb_enco(n(i), m(i)); % Golomb coding of ith number
%     y(i) = golomb_deco(x, m(i)); % Decoding the corresponding golomb code
%  end
%  
%  % test to verify correct decoding
%  if isequal(y,n)
%      fprintf('Decoding successful \n');
%  end
 
 %% Golomb coding/decoding for grayscale images
 
 I=imread('lena_bw.gif');
 I=double(I);
 
 [size_x,size_y]=size(I);
 I_dec=zeros(size_x,size_y); %decoded image will be stored in this matrix
 m=randint(size_x,size_y,[1,max(max(I(:,:)))]); % generate a random set of coding parameters

 % Encoding/Decoding for image
 for i=1:1:size_x
     for j=1:1:size_y
         x = golomb_enco(I(i,j),m(i,j));
         I_dec(i,j) = golomb_deco(x, m(i,j));
     end
 end
 
 % Test to verify correct decoding
 if isequal(I_dec,I)
     fprintf('Decoding successful');
 end
 
 
