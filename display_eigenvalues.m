function [  ] = display_eigenvalues( eigenvectors, eigenvalues )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    N = length(eigenvectors(:,1));
    Dimension = 0:length(eigenvectors(:,1))-1;
    eigenvalues_arr = [];
    for i = 1:N
        eigenvalues_arr = [eigenvalues_arr real(eigenvalues(i,i))];
    end
    figure(1)
    plot(Dimension, eigenvalues_arr)
    hold on
    xlabel 'Dimension'
    ylabel 'Eigenvalue'
    

end

