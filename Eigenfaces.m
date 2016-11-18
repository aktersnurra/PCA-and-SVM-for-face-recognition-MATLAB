clear all, close all, clc;


%%
load face.mat

[ training_data, labeled_training, test_data, labeled_test ] = partition_data(X, l);
x_bar = compute_avg_face_vector(training_data);
[ A, S ] = compute_covariance_matrix(training_data, x_bar);
[ eigenvectors, eigenvalues ] = compute_eigenvectors(S);
display_eigenvalues( eigenvectors, eigenvalues )
%%
sub_space_dim = 200;
w = faces_onto_eigenfaces( A, eigenvectors, sub_space_dim );
x_tilde = reconstruct_face( x_bar, w, eigenvectors );
B = reshape(real(x_tilde),[56,46]);
%B = reshape(real(eigenvectors(:,2)),[56,46]); 
%B = reshape(real(training_data(:,10)),[56,46]);

imshow(B,[])

