function prob = algorithm(q)

% plot and return the probability
load sp500;
price_move(price_move == -1) = 2;

transition = [0.8,0.2;0.2,0.8];

emission = [q, 1-q;1-q,q];

pi = [0.2, 0.8];

pstates = calc_probs(price_move', transition, emission, pi);

figure;
plot((1:39), pstates(1, :));
legend(['q= ', num2str(q)])
title('Probability of good economic in 39 weeks');

prob = pstates(1, 39);
end

function probs = calc_probs(obs_seq, trans, emission, p)

[num_states, num_states] = size(trans);
obs_size = size(obs_seq);
num  = obs_size(2);

probs = zeros(num_states, num);
forward = zeros(num_states, num);
backward = ones(num_states, num);
forward(:, 1) = p .* emission(:, obs_seq(1))';
backward = calcBackwards(num,num_states,trans,backward,emission,obs_seq);
forward = calcForwards(num,num_states,trans,forward,emission,obs_seq);
probs = calcProbs(num,probs,forward,backward);
end

function backward = calcBackwards(num,num_states,trans,backward,emission,obs_seq)   
    for obs = num-1:-1:1
        for state = 1:num_states
            backward(state, obs) = sum( trans(state,:)'.* backward(:,obs+1) .* emission(:,obs_seq(obs+1))); 
        end
    end
end

function forward = calcForwards(num,num_states,trans,forward,emission,obs_seq)
    for obs = 2:num
        for state = 1 : num_states
            forward(state, obs) = emission(state, obs_seq(obs)) .* sum((forward(:, obs-1) .* trans(:, state)));
        end
    end
end

function probs = calcProbs(num,probs,forward,backward)
    for obs = 1:num
        probs(:, obs) = forward(:, obs) .* backward(:, obs);
        probs(:, obs) = probs(:, obs) / sum(probs(:, obs));
    end

end

