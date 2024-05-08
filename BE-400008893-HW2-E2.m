clc; clear; close all;

% loading data
my_dataset = importdata("ESL.arff");
A = my_dataset.data(:, 1:4);
y = my_dataset.data(:, 5);
n = size(A, 2);

% backward elimination
selected_regressors = 1:n; theta_hat = [];

while numel(selected_regressors) > 0
    X_selected = A(:, selected_regressors);
    theta = pinv(X_selected) * y;
    y_fit = X_selected * theta;
    rss = sum((y - y_fit) .^ 2);
    theta_hat = [theta_hat; theta'];
    regressor_to_remove = [];
    best_rss = rss;

    for i = 1:numel(selected_regressors)

        temp_selected_regressors = selected_regressors(selected_regressors);
        temp_X_selected = A(:, temp_selected_regressors);
        temp_theta = pinv(temp_X_selected) * y;
        temp_y_fit = temp_X_selected * temp_theta;
        temp_rss = sum((y-temp_y_fit) .^ 2);
        
        if temp_rss < best_rss
            best_rss = temp_rss;
            regressor_to_remove = selected_regressors(i);
        end
    end

    if ~isempty(regressor_to_remove)
        selected_regressors = selected_regressors(selected_regressors);
    else
        break;
    end
end

fprintf('Selected Regressor: %s\n', num2str(selected_regressors));
fprintf('Corresponding Parameters: \n')
disp(theta_hat);


     