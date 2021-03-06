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

sub_space_dim = length(Sb(1,:));

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


sub_space_dim = 190;

w_test = project_test_eigspace(test_data, x_bar, eigenvectors, sub_space_dim);

[ true_pos_w, false_pos_w ] = nnclassifier(w_test, test_labels, w, training_labels);

acc_w = true_pos_w / (true_pos_w + false_pos_w)

w_test1 = project_test_eigspace(test_data, x_bar, eigenvectors_u, sub_space_dim);

[ true_pos_w1, false_pos_w1 ] = nnclassifier(w_test1, test_labels, wb, training_labels)

acc_w = true_pos_w1 / (true_pos_w1 + false_pos_w1)




%% implement pca on each face class

[ class_PCAs, x_bars] = PCA_per_class(training_data, x_bar);

%%

[ true_pos_pca, false_pos_pca  ] = nn_class_PCA( class_PCAs, x_bars, test_data, test_labels );

acc_w = true_pos_pca / (true_pos_pca + false_pos_pca)


%%
%{
Use the provided face data, and the same data partition into training and
testing as in Q1. Feature vectors x are the raw-intensity vectors 
(obtained by raster-scanning pixel values of face images) or PCA 
coefficients. Try both and compare the results below.

Train and test multi-class SVM using the feature vectors x. You can use any
existing toolbox for two-class (or binary-class) SVMs. Note, write your own
lines of code for the multi-class extensions of SVM (both one-versus-the-
rest and one-versus-one), and provide your code in an appendix of your 
report. Compare the results of the two multi-class extensions of SVM.
%}
config
%%
model_linear = svmtrain(training_labels(1:14)', sparse(training_data(:, 15:28))', kernel_linear);
model_precomputed = svmtrain(training_labels(1:14)', [(1:14)', training_data(:, 1:14)'*training_data(:, 1:14)], kernel_RBF);






%%
train_class_arr = partition_classes( training_data, training_labels );

%% Linear one-v-rest

C = [1*10^(-11) 8.6*10^(-10) 2^(-28) 1 2^(20)];
data = [];
for c = C
    kernel_linear = sprintf('-s 0 -t 0 -c %g -q', c);
    
    [ trained_SVMs, classes ] = SVM_train_one_v_rest( train_class_arr, training_labels, kernel_linear );
    
    [TP, FP] = test_SVM_one_v_rest( trained_SVMs, classes, training_data, training_labels );
    
    data = [data; {sprintf('C = %g, train p = %g', c, TP/(TP + FP))}];
    
    [TP, FP] = test_SVM_one_v_rest( trained_SVMs, classes, test_data, test_labels );
    
    data = [data; {sprintf('C = %g, test p = %g', c, TP/(TP + FP))}]
end
%% Linear one-v-one
C = [2^(-5) 2^(-2) 2^(10)];
data = [];
for c = C
    kernel_linear = sprintf('-s 0 -t 0 -c %g -q', c);
    [ trained_SVMs, classes ] = SVM_train_one_v_one( train_class_arr, training_labels, kernel_linear );

    [ votes, TP, FP ] = test_SVM_one_v_one( trained_SVMs, classes, training_data, training_labels );
    data = [data; {sprintf('C = %g, train p = %g', c, TP/(TP + FP))}];

    [ votes, TP, FP ] = test_SVM_one_v_one( trained_SVMs, classes, test_data, test_labels );
    data = [data; {sprintf('C = %g, test p = %g', c, TP/(TP + FP))}]
end


%% PCA partition
w_less_dim = w(1:190,:);
train_weight_arr = partition_classes( w_less_dim, training_labels );

%% PCA Linear one-v-rest
C = [1*10^(-11) 2^(-28) 1 2^(15)];
data = [];
for c = C
    kernel_linear = sprintf('-s 0 -t 0 -c %g -q', c);
    [ trained_SVMs, classes ] = SVM_train_one_v_rest( train_weight_arr, training_labels, kernel_linear );
    [TP, FP] = test_SVM_one_v_rest( trained_SVMs, classes, w_less_dim, training_labels );
    data = [data; {sprintf('C = %g, train p = %g', c, TP/(TP + FP))}];
    
    [TP, FP] = test_SVM_one_v_rest( trained_SVMs, classes, w_test, test_labels );
    data = [data; {sprintf('C = %g, test p = %g', c, TP/(TP + FP))}]
end
%% PCA Linear one-v-one
C = [8.6*10^(-5) 1 2^(20)];
data = [];
for c = C
    kernel_linear = sprintf('-s 0 -t 0 -c %g -q', c);
    [ trained_SVMs, classes ] = SVM_train_one_v_one( train_weight_arr, training_labels, kernel_linear );
    
    [ votes, TP, FP ] = test_SVM_one_v_one( trained_SVMs, classes, w_less_dim, training_labels );
    data = [data; {sprintf('C = %g, train p = %g', c, TP/(TP + FP))}];

    [ votes, TP, FP ] = test_SVM_one_v_one( trained_SVMs, classes, w_test, test_labels );
    data = [data; {sprintf('C = %g, test p = %g', c, TP/(TP + FP))}]

end







%% Non-linear
sigma_arr = [50000 10000 30000];
C_arr = [2^(-28) 2^(-7)  2^(15)];
data = [];
% Libsvm options
% -s 0 : classification
% -t 2 : RBF kernel
% -g : gamma in the RBF kernel
% sprintf('-s 0 -t 2 -g %g -c %g', gamma, C)
for sigma = sigma_arr
    gamma = (2*sigma^2)^(-1);
    for C = C_arr
        kernel_RBF = sprintf('-s 0 -t 2 -g %g -c %g -q', gamma, C)

        [ trained_SVMs, classes ] = SVM_train_one_v_rest( train_class_arr, training_labels, kernel_RBF );
        
        [TP, FP] = test_SVM_one_v_rest( trained_SVMs, classes, training_data, training_labels );
        
        data = [data; sprintf('train g %g C %g TP %g FP %g', gamma, C, TP, FP)];

        [TP, FP] = test_SVM_one_v_rest( trained_SVMs, classes, test_data, test_labels );
        
        data = [data; sprintf('test g %g C %g TP %g FP %g', gamma, C, TP, FP)];
    end
end
%%

sigma_arr = [50000 10000 30000];
C_arr = [2^(-28) 2^(-7)  2^(15)];
data = [];
% Libsvm options
% -s 0 : classification
% -t 2 : RBF kernel
% -g : gamma in the RBF kernel
% sprintf('-s 0 -t 2 -g %g -c %g', gamma, C)
for sigma = sigma_arr
    gamma = (2*sigma^2)^(-1);
    for C = C_arr
        kernel_RBF = sprintf('-s 0 -t 2 -g %g -c %g -q', gamma, C)

        [ trained_SVMs, classes ] = SVM_train_one_v_one( train_class_arr, training_labels, kernel_RBF );
        
        [TP, FP] = test_SVM_one_v_one( trained_SVMs, classes, training_data, training_labels );
        
        data = [data; sprintf('train g %g C %g TP %g FP %g', gamma, C, TP, FP)];

        [TP, FP] = test_SVM_one_v_one( trained_SVMs, classes, test_data, test_labels );
        
        data = [data; sprintf('test g %g C %g TP %g FP %g', gamma, C, TP, FP)];
    end
end
%% Non-linear PCA
gamma_arr = [2^(-28) 2^(-16) 2^(-11)];
C_arr = [2^(-5) 2^(5) 2^(15)];
data = [];
% Libsvm options
% -s 0 : classification
% -t 2 : RBF kernel
% -g : gamma in the RBF kernel
% sprintf('-s 0 -t 2 -g %g -c %g', gamma, C)
for gamma = gamma_arr
    for C = C_arr
        kernel_RBF = sprintf('-s 0 -t 2 -g %g -c %g -q', gamma, C)

        [ trained_SVMs, classes ] = SVM_train_one_v_rest( train_weight_arr, training_labels, kernel_RBF );
        
        [TP, FP] = test_SVM_one_v_rest( trained_SVMs, classes, w_less_dim, training_labels );

        data = [data; {sprintf('C = %g, train p = %g', C, TP/(TP + FP))}];

        [TP, FP] = test_SVM_one_v_rest( trained_SVMs, classes, w_test, test_labels );
        data = [data; {sprintf('C = %g, test p = %g', C, TP/(TP + FP))}]
    end
end
%%

sigma_arr = [50000 10000 30000];
C_arr = [2^(-28) 2^(-7)  2^(15)];
data = [];
% Libsvm options
% -s 0 : classification
% -t 2 : RBF kernel
% -g : gamma in the RBF kernel
% sprintf('-s 0 -t 2 -g %g -c %g', gamma, C)
for sigma = sigma_arr
    gamma = (2*sigma^2)^(-1);
    for C = C_arr
        kernel_RBF = sprintf('-s 0 -t 2 -g %g -c %g -q', gamma, C)

        [ trained_SVMs, classes ] = SVM_train_one_v_one( train_weight_arr, training_labels, kernel_RBF );

        [ votes, TP, FP ] = test_SVM_one_v_one( trained_SVMs, classes, w_less_dim, training_labels );
        data = [data; {sprintf('C = %g, train p = %g', c, TP/(TP + FP))}];

        [ votes, TP, FP ] = test_SVM_one_v_one( trained_SVMs, classes, w_test, test_labels );
        data = [data; {sprintf('C = %g, test p = %g', c, TP/(TP + FP))}]
    end
end