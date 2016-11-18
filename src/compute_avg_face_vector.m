function [ x_bar ] = compute_avg_face_vector( training_data )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

start = 1;
N = length(training_data(1, :));
x_sum = [zeros(length(training_data(:, 1)), 1)];

for i = start:N
    x_sum = x_sum + training_data(:,i);
end
x_bar = (1/N) * x_sum; 


end

