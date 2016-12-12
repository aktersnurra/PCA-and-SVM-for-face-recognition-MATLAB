clear all, close all, clc;
%%
load('/Users/Gustaf/Dropbox KTH/Dropbox/KTH/Imperial College London/kurser/autumn/pattern recognition/cw/PCA and SVM for face recognition MATLAB/lib/face.mat')

%%
[ training_data, training_labels, test_data, test_labels ] = partition_data(X, l);


%%
x_bar = compute_avg_face_vector(training_data);

A = compute_A(training_data, x_bar);
S = compute_covariance_matrix(A);
[ eigenvectors, eigenvalues ] = compute_eigenvectors(S);

[ Sb ] = compute_data_matrix_b( A, training_data );
[ eigenvectors_v, eigenvalues_v ] = compute_eigenvectors(Sb);
eigenvectors_u = compute_eigenvectors_u( A, eigenvectors_v );

%%

fignr = 1;
display_eigenvalues( eigenvalues, fignr );

fignr = fignr + 1;
display_eigenvalues( eigenvalues_v, fignr );

sub_space_dim = 289;

w = faces_onto_eigenfaces( A, eigenvectors, sub_space_dim );

wb = faces_onto_eigenfaces( A, eigenvectors_u,  sub_space_dim);
%%

face = 1;

x_tilde = reconstruct_face( x_bar, w, eigenvectors, face );
B = reshape(real(x_tilde),[56,46]);

fignr = fignr + 1;
figure(fignr)
imshow(B,[])
hold off


x_tilde = reconstruct_face( x_bar, wb, eigenvectors_u, face );
B = reshape(real(x_tilde),[56,46]);

fignr = fignr + 1;
figure(fignr)
imshow(B,[])
hold off
%% Classify test data

fignr = 1;
face = 100;
sub_space_dim = 220;
%{
for face = test_data
    phi = face - x_bar;
    A = [A phi];
end

total_data = [training_data test_data];

[ Sc ] = compute_data_matrix_b( A, total_data );
[ eigenvectors_v1, eigenvalues_v1 ] = compute_eigenvectors(Sc);
eigenvectors_u1 = compute_eigenvectors_u( A, eigenvectors_v1 );

w_test = project_test_eigspace(test_data, x_bar, eigenvectors_u1, sub_space_dim);

wc = faces_onto_eigenfaces( A, eigenvectors_u1,  sub_space_dim);
%}

w_test = project_test_eigspace(test_data, x_bar, eigenvectors, sub_space_dim);

x_tilde = reconstruct_face( x_bar, w_test, eigenvectors, face );
B = reshape(real(x_tilde),[56,46]);

fignr = fignr + 1;
figure(fignr)
imshow(B,[])
hold off

[ true_pos, false_pos ] = nnclassifier(w_test, test_labels, w, training_labels)





%% implement pca on each face class
[ class_PCAs, x_bars] = PCA_per_class(training_data, x_bar);

%%

[ true_pos, correct, false_pos, false  ] = nn_class_PCA( class_PCAs, x_bars, test_data, test_labels )



%%

config






