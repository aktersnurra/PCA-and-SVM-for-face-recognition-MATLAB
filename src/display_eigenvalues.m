function [  ] = display_eigenvalues( eigenvalues, l )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    N = length(eigenvalues(:,1));
    Dimension = 0:length(eigenvalues(:,1))-1;
    eigenvalues_arr = zeros(1,N);
    for i = 1:N
        eigenvalues_arr(i) = real(eigenvalues(i,i));
    end
    
    figure(l)
    plot(Dimension, eigenvalues_arr)
    hold on
    xlabel 'Dimension'
    ylabel 'Eigenvalue'
    hold off
    

end

