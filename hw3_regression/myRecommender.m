function [ U, V ] = myRecommender( rateMatrix, lowRank )
    % Please type your name here:
    name = 'Siying, Cen';
    disp(name); % Do not delete this line.

    % Parameters
    maxIter = 1000; % Choose your own.
    learningRate = 0.0002; % Choose your own.
    regularizer = 0.02; % Choose your own.
    
    % Random initialization:
    [n1, n2] = size(rateMatrix);
    U = rand(n1, lowRank) / lowRank;
    V = rand(n2, lowRank) / lowRank;

    % Gradient Descent:
       it = 0;
    threshold = 0.001;
    d = 10;
    while it < maxIter & d > threshold
        U_temp = U + 2 * learningRate * (rateMatrix - U * V' .* (rateMatrix > 0)) * V - 2 * learningRate * regularizer * U;
        V_temp = V + 2 * learningRate * (rateMatrix - U * V' .* (rateMatrix > 0))' * U - 2 * learningRate * regularizer * V;
        U = U_temp;
        V = V_temp;
        d = sum(sum((rateMatrix - U * V' .* (rateMatrix > 0)).^2)) + regularizer * sum(sum(U.^2)) + regularizer * sum(sum(V.^2));  
        display(d);
        it = it + 1;
    end
    
 
      
    % IMPLEMENT YOUR CODE HERE.
end