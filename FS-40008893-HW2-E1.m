clc; clear; close all;

% loading data
my_dataset = importdata("ESL.arff");
A = my_dataset.data(:, 1:4);
y = my_dataset.data(:, 5);
n = size(A, 2);

% forward selection
best_regressors = []; best_theta = []; best_rss = Inf;

for k = 1:n
    combinations = nchoosek(1:n, k);

    for i = 1:size(combinations, 1)
        selected_regressors = combinations(i, :);
        X_selected = A(:, selected_regressors);
        theta = pinv(X_selected) * y; 
        y_fit = X_selected * theta;
        rss = sum((y - y_fit) .^ 2);

        if rss < best_rss
            best_rss = rss;
            best_regressors = selected_regressors;
            best_theta = theta;
        end
    end
end

fprintf('Selcted Regressors: %s\n', num2str(best_regressors));
fprintf('Coresponding Parameters: \n');
disp(best_theta);    