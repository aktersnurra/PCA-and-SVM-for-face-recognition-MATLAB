function [ w_unknowns ] = project_test_eigspace( unknown_faces, x_bar, eigenvectors, sub_space_dim )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    start = 1;
    stop = sub_space_dim;
    w_unknowns = [];
    for unknown_face = unknown_faces
        phi = unknown_face - x_bar;
        w_n = [];
        for i = start:stop
           u = eigenvectors(:, i);
           a = phi' * u;
           w_n = [w_n a];
        end
        w_unknowns = [w_unknowns w_n'];
    end
end

