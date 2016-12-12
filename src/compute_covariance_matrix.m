function [ S ] = compute_covariance_matrix( A )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    N = length(A(1,:));
    S = (1/N) * A * A';
end

