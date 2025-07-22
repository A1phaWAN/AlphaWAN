function [fitness, totalLoss] = evaluateFitness(population, numBags, numItemsPerBag, maxWeight, itemWeights)
    % 计算适应度和每种物品种类的超重惩罚的最小值的和
    popSize = size(population, 1);
    numItems = length(itemWeights);  % 总物品种类数
    fitness = zeros(popSize, 1);
    totalLoss = zeros(popSize, 1);

    for i = 1:popSize
        itemPenalties = inf(numItems, 1);  % 用于存储每种物品的最小超重惩罚

        % 追踪每种物品是否被选择
        itemChosen = false(numItems, 1);

        for j = 1:numBags
            items = squeeze(population(i, j, :));
            weight = sum(itemWeights(items));  % 计算这个背包的总重量
            if weight > maxWeight
                excessWeight = weight - maxWeight;
                for k = 1:numItemsPerBag
                    itemIndex = items(k);  % 获取物品的索引
                    itemChosen(itemIndex) = true;  % 标记物品已被选择
                    % 比较并存储最小的超重惩罚
                    currentPenalty = min(excessWeight, itemWeights(itemIndex));
                    itemPenalties(itemIndex) = min(itemPenalties(itemIndex), currentPenalty);
                
                end
            else
                for k = 1:numItemsPerBag
                    itemIndex = items(k);  % 获取物品种类的索引
                    itemChosen(itemIndex) = true;  % 标记物品已被选择
                    % 比较并存储最小的超重惩罚
               
                    itemPenalties(itemIndex) = 0;
                
                end
            end
        end
        
        % 为未选择的物品设置惩罚为其自身重量
        for k = 1:numItems
            if ~itemChosen(k)
%                itemPenalties(k) = itemWeights(k);
                % 为未选择的物品设置惩罚为inf?
                itemPenalties(k) = 6;
            end
        end

        % 将无穷大值（表示未超重的被选择物品）替换为零
        itemPenalties(isinf(itemPenalties)) = 0;
        % 计算总的最小超重惩罚的和
        totalLoss(i) = sum(itemPenalties);
        % 适应度是负的超重惩罚总和，为了遗传算法优化
        fitness(i) = -totalLoss(i);
    end
end
