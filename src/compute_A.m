function [ A ] = compute_A( training_data, x_bar )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
    start = 1;
    N = length(training_data(1, :));
    A = [];
    for i = start:N
       x = training_data(:, i);
       phi = x - x_bar;
       A = [A phi];
    end
    

end

