    numItems = 16;        % 物品总数
    numItemsPerBag = 8;   % 每个背包中的物品数
    numBags = 5;          % 背包数量
    maxWeight = 16;       % 每个背包的最大重量限制
    %itemWeights = randi([1, 4], 1, numItems); % 物品的重量
    %itemWeights = [3,3,3,3,3,3,1,1,1,1,1,1,1,1,3,3];    %30 concurrent packets on 16 CHs
    %itemWeights = [1,5,2,2,1,2,1,3,2,3,4,3,1,3,1,3];    %37 concurrent packets on 16 CHs
    itemWeights = [2,1,3,2,4,1,3,2,5,4,3,3,5,5,5,1];    %49 concurrent packets on 16 CHs 
% 第一步：生成所有连续四物品组合
    validGroups = arrayfun(@(x) x:x+3, 1:(numItems-3), 'UniformOutput', false);

    % 第二步：生成单个背包的所有可能组合
    possibleCombinations = nchoosek(1:length(validGroups), 2);
    validBagCombinations = cell(size(possibleCombinations, 1), 1);

    % 第三步：过滤出不重叠的组合
    for i = 1:size(possibleCombinations, 1)
        group1 = validGroups{possibleCombinations(i, 1)};
        group2 = validGroups{possibleCombinations(i, 2)};
        if max(group1) < min(group2) || max(group2) < min(group1) % 确保不重叠
            validBagCombinations{i} = [group1, group2];
        end
    end
    validBagCombinations = validBagCombinations(~cellfun('isempty', validBagCombinations));
    validBagCombinations = cell2mat(validBagCombinations);
    % 第四步：生成所有可能的五背包组合
    allCombinations = nchoosek(1:length(validBagCombinations), numBags);
    
%[bestCombination,~] = findBestCombination (allBagCombinations, itemWeights, maxWeight)

    % 显示最佳组合和对应的适应度
    % disp(['Best Fitness: ', num2str(bestFitness)]);
    % %disp(['Best Fitness: ', bestCombination]);
    % disp(bestCombination);

%    displayBestCombination(bestCombination, itemWeights);


bestFitness = inf;
for i = 1:size(allCombinations, 1)
    combination = allCombinations(i, :);
    itemPenalties = inf(1, numItems);  % 初始化每种物品的最小超重惩罚为无穷大
    itemChosen = false(numItems, 1);        % 追踪每种物品是否被选择
    
    % 遍历每个背包
    for j = 1:numBags
        items = validBagCombinations(combination(j),:);
        
        weight = sum(itemWeights(items));
        if weight > maxWeight
            excessWeight = weight - maxWeight;
            itemChosen(items) = true;  % 标记物品已被选择
            for k = items
                itemPenalties(k) = min(itemPenalties(k), excessWeight);
                itemPenalties(k) = min(itemPenalties(k), itemWeights(k));
            end
        else
            itemPenalties(items) =  0;  % 如果未超重，则惩罚为0
            itemChosen(items) = true;  % 标记物品已被选择
        end
    end

    % 确保未选择的物品有最高惩罚
    %itemPenalties(isinf(itemPenalties)) = itemWeights(isinf(itemPenalties));


        % 为未选择的物品设置惩罚为其自身重量
        for k = 1:numItems
            if itemChosen(k) == 0
                itemPenalties(k) = itemWeights(k);
            end
        end

        % 将无穷大值（表示未超重的被选择物品）替换为零
        %itemPenalties(isinf(itemPenalties)) = 0;
        % 计算总的最小超重惩罚的和
        totalLoss(i) = sum(itemPenalties);
        % 适应度是负的超重惩罚总和，为了遗传算法优化
        %fitness(i) = -totalLoss(i);




    % 寻找最小的超重惩罚和的组合
    if totalLoss(i) <= bestFitness
        bestFitness = totalLoss(i);
        disp(['Best Fitness: ', num2str(bestFitness)]);
        bestCombination = combination;
    end
end

% 输出最优组合和对应的超重惩罚
disp(['Best Fitness: ', num2str(bestFitness)]);
disp(['Best Combination: ', mat2str(bestCombination)]);
    for j = 1:numBags
        items = validBagCombinations(bestCombination(j),:);
        disp(items)
    end