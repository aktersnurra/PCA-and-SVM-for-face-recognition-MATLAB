function [ eigenvectors_u ] = compute_eigenvectors_u( A, eigenvectors_v )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    eigenvectors_u = [];
    for v = eigenvectors_v
        u = A * v;
        u = (1 / norm(u)) * u;
        eigenvectors_u = [ eigenvectors_u  u ];
    end
end

