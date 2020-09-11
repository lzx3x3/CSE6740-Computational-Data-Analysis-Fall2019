function [ class ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!

%num_clusters = K;
num_doc = size(bow,1);
num_word = size(bow,2);
T_ij = bow;
max_iteration = 1000;
it = 0;

% initiation of parameters
pi_c = [0.25,0.25,0.25,0.25];  
mu = rand(num_word, K);
mu_jc = mu ./ repmat(sum(mu), num_word, 1);

    

% Threshold
% eplison = 10^-5;

while it < max_iteration 
    % Expectation
    for i = 1:num_doc
        y(i,:) = pi_c .* prod(mu_jc .^ repmat(T_ij(i, :)', 1, K), 1);
        y_ic(i,:) = y(i,:) ./ sum(y(i,:));
    end
    
    % Maximization
    mu = (y_ic' * T_ij)';
    mu_jc = mu ./ repmat(sum(mu), num_word, 1);
    pi_c = sum(y_ic) / num_doc ;
    
    it = it + 1;
end

[~, class] = max(y_ic, [], 2);


end

 