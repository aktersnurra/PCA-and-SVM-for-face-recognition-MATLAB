function [ class_cell_arr ] = partition_classes( train_data, train_labels)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    M = unique(train_labels,'first');
    class_cell_arr = {};
    start = 1;
    stop = 7;
    step = 7;
    for i = M
        class_cell_arr{i} = train_data(:, start:stop);
        start = start + step;
        stop = stop + step;
    end
end

