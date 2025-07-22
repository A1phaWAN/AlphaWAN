function selected = tournamentSelection(population, fitness, tournamentSize)
    % 锦标赛选择函数
    popSize = size(population, 1);
    selected = zeros(size(population));  % 初始化选中种群

    for i = 1:popSize
        % 随机挑选tournamentSize个个体进行锦标赛
        contendersIdx = randsample(popSize, tournamentSize);
        % 找到这些竞争者中适应度最高的个体
        [~, bestIdx] = max(fitness(contendersIdx));
        % 选择胜者进入新的种群
        selected(i, :, :) = population(contendersIdx(bestIdx), :, :);
    end
end








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
% function selected = selection(population, fitness)
%     % 选择函数
%     popSize = size(population, 1);
%     probabilities = exp(fitness - min(fitness)); % 使用指数转换提升选择压力
%     probabilities = probabilities / sum(probabilities);
%     indices = randsample(1:popSize, popSize, true, probabilities);
%     selected = population(indices, :, :);
% end
