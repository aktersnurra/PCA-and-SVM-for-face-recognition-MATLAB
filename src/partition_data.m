function  [training_data, labeled_training, test_data, labeled_test] = partition_data(X,l)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
training_data = [];
test_data = [];
labeled_training = [];
labeled_test = [];
start = 1;
stop = length(l);
counter = 1;
amount_of_training = 1:5;
for i = start:stop
    if any(counter==amount_of_training)
        training_data = [training_data X(:,i)];
        labeled_training = [labeled_training l(i)];
        counter = counter + 1;
    else
        test_data = [test_data X(:,i)];
        labeled_test = [labeled_test l(i)];
        counter = counter + 1;
        if counter == 10
           counter = 1;
        end
    end
    
end
   
end

