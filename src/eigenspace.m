function [ w_n ] = eigenspace( eigenvectors, phi, sub_space_dim )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    w_n = [];
    start = 1;
    for k = start:sub_space_dim
        u = eigenvectors(:, k);
        a_ni = phi' * u;
        w_n = [w_n a_ni];
    end
end

