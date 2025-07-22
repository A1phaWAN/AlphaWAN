function genetic_algorithm
% 主遗传算法函数

% 参数设置
popSize = 100;        % 种群大小
numItems = 16;        % 物品总数
numItemsPerBag = 8;   % 每个背包中的物品数
numBags = 5;          % 背包数量
maxGenerations = 1000; % 最大迭代次数
mutationRate = 0.1;   % 变异率
crossoverRate = 0.7;  % 交叉率
maxWeight = 16;       % 每个背包的最大重量限制

% 初始化种群
population = initPopulation(popSize, numItemsPerBag, numBags, numItems);

% 适应度评估
fitness = evaluateFitness(population, numBags, numItemsPerBag, maxWeight, numItems);

% 遗传算法主循环
for gen = 1:maxGenerations
    % 选择
    selected = selection(population, fitness);
    
    % 交叉
    offspring = crossover(selected, crossoverRate, numBags, numItemsPerBag);
    
    % 变异
    offspring = mutate(offspring, mutationRate, numItems);
    
    % 更新种群
    population = offspring;
    
    % 评估新的种群
    fitness = evaluateFitness(population, numBags, numItemsPerBag, maxWeight, numItems);
    
    % 输出当前最佳解
    [maxFitness, idx] = max(fitness);
    disp(['Generation ', num2str(gen), ': Best Fitness = ', num2str(maxFitness)]);
end

end

function population = initPopulation(popSize, numItemsPerBag, numBags, numItems)
% 初始化种群函数，生成遵守问题约束的初始种群
    population = zeros(popSize, numBags, numItemsPerBag);
    for i = 1:popSize
        for j = 1:numBags
            % 为每个背包生成两组连续的四个物品，确保随机性
            startIdx = randi([1, numItems - numItemsPerBag + 1]);
            population(i, j, :) = startIdx:(startIdx + numItemsPerBag - 1);
        end
    end
end

function fitness = evaluateFitness(population, numBags, numItemsPerBag, maxWeight, numItems)
% 适应度评估函数，根据超重罚款和最小丢失价值之和计算适应度
    % 创建物品重量，随机值在0到6之间
    itemWeights = randi([0, 6], 1, numItems);
    [popSize, ~, ~] = size(population);
    fitness = zeros(popSize, 1);
    for i = 1:popSize
        totalMinLoss = 0;
        for j = 1:numBags
            items = squeeze(population(i, j, :));
            weight = sum(itemWeights(items));
            if weight > maxWeight
                loss = weight - maxWeight; % 计算丢失值
            else
                loss = 0;
            end
            totalMinLoss = totalMinLoss + loss; % 累积每个背包的最小丢失值
        end
        fitness(i) = -totalMinLoss; % 适应度为丢失值的负数，以最小化适应度
    end
end

function selected = selection(population, fitness)
% 选择函数，使用轮盘赌选择法基于适应度进行选择
    weights = exp(fitness - min(fitness));  % 使用指数转换提升选择压力
    probabilities = weights / sum(weights);
    indices = randsample(1:size(population, 1), size(population, 1), true, probabilities);
    selected = population(indices, :, :);
end

function offspring = crossover(selected, crossoverRate, numBags, numItemsPerBag)
% 交叉函数，通过单点交叉产生子代
    offspring = selected;
    [popSize, ~, ~] = size(selected);
    for i = 1:2:popSize-1
        if rand() < crossoverRate
            % 随机选择交叉点并交换基因
            crossPoint = randi([1, numItemsPerBag - 1]);
            offspring(i, :, crossPoint+1:end) = selected(i+1, :, crossPoint+1:end);
            offspring(i+1, :, crossPoint+1:end) = selected(i, :, crossPoint+1:end);
        end
    end
end

function mutated = mutate(offspring, mutationRate, numItems)
% 变异函数，随机调整某个背包的连续物品序列
    [popSize, numBags, numItemsPerBag] = size(offspring);
    for i = 1:popSize
        for j = 1:numBags
            if rand() < mutationRate
                % 随机选择新的起始点并保持物品序列的连续性
                startIdx = randi([1, numItems - numItemsPerBag + 1]);
                offspring(i, j, :) = startIdx:(startIdx + numItemsPerBag - 1);
            end
        end
    end
    mutated = offspring;
end
