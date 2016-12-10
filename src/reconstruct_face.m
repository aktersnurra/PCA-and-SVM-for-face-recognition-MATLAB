function [ x_tilde ] = reconstruct_face( x_bar, w, eigenvectors, face )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
    start = 1;
    M = length(w(:, 1));
    sum_eig_vec = [];
    for i = start:M
       u = eigenvectors(:, i);
       a_ni = w(i, face);
       sum_eig_vec = [sum_eig_vec a_ni * u];
    end
    x_tilde = x_bar + sum(sum_eig_vec, 2);
end

