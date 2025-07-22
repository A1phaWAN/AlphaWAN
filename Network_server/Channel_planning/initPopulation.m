function population = initPopulation(popSize, numItemsPerBag, numBags, numItems)
    % 初始化种群函数
    population = zeros(popSize, numBags, numItemsPerBag);
    possibleStarts = 1:8:numItems; % 生成1, 9, 17,...这样的序列，直到最大物品数

    for i = 1:popSize
        for j = 1:numBags
            % 随机选择一个起始索引
            idx = randi(length(possibleStarts));
            startIdx = possibleStarts(idx);
            % 从选定的起始点连续选择8个物品
            % 确保不超出物品数量
            indices = startIdx:(startIdx + numItemsPerBag - 1);
            if indices(end) > numItems % 如果超出范围，就从物品列表开始处继续
                exceed = indices(end) - numItems;
                indices = [startIdx:numItems 1:exceed];
            end
            population(i, j, :) = indices;
        end
    end
end