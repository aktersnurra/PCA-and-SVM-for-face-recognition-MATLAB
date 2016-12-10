function  [training_data, labeled_training, test_data, labeled_test] = partition_data(X,l)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    training_data = [];
    test_data = [];
    labeled_training = [];
    labeled_test = [];
    step = 0;
    train_ints = [];
    test_ints = [];
    
    for i = 1:52
        start = 1 + step;
        stop = 7 + step;
        train_ints = [train_ints start:stop];

        start_test = 8 + step;
        stop_test = 10 + step;
        test_ints = [test_ints start_test:stop_test];

        step = step + 10;
    end

    for j = train_ints
        training_data = [training_data X(:,j)];
        labeled_training = [labeled_training l(j)];
    end

    for k = test_ints
       test_data = [test_data X(:,k)];
       labeled_test = [labeled_test l(k)]; 
    end

   
end

