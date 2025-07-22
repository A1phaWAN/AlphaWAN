

% 线性归一化
% function selected = selection(population, fitness)
%     % 选择函数
%     popSize = size(population, 1);
% 
%     % 线性归一化适应度
%     fitness = fitness - min(fitness);  % 使最小适应度为0
%     if max(fitness) > 0
%         probabilities = fitness / sum(fitness);  % 归一化
%     else
%         probabilities = ones(popSize, 1) / popSize;  % 如果所有适应度都相同，则等概率选择
%     end
% 
%     indices = randsample(1:popSize, popSize, true, probabilities);
%     selected = population(indices, :, :);
% end

% 指数
function selected = selection(population, fitness)
    % 选择函数
    popSize = size(population, 1);
    probabilities = exp(fitness - min(fitness)); % 使用指数转换提升选择压力
    probabilities = probabilities / sum(probabilities);
    indices = randsample(1:popSize, popSize, true, probabilities);
    selected = population(indices, :, :);
end
