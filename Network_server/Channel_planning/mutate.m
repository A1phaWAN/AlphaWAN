function mutated = mutate(offspring, mutationRate, numBags, numItems, numItemsPerBag)
    % 变异操作
    popSize = size(offspring, 1);
    %numBags = size(offspring, 2);
    for i = 1:popSize
        for j = 1:numBags
            if rand() < mutationRate
                % 随机选择是变异前四个还是后四个物品
                currentItems = offspring(i, j, :);   % 这8个是物品的种类号   从1~16
                currentIndices = find(currentItems); % 这8个是背包位置的序号 从第一个位置到第八个位置的位置号
                if rand() < 0.5
                    indices = 1:4;  % 前四个物品
                    other_indices = numItemsPerBag-3:numItemsPerBag; % 另外后四个物品的索引
                else
                    indices = numItemsPerBag-3:numItemsPerBag;  % 后四个物品
                    other_indices = 1:4; % 另外后四个物品的索引
                end

                %currentItems = offspring(i, j, :);   % 这8个是物品的种类号   从1~16
                %currentIndices = find(currentItems); % 这8个是背包位置的序号 从第一个位置到第八个位置的位置号
                %TODO: 前四个或者后四个变异移动该怎么移动

                % 确定移动方向并检查边界条件
                if indices(1) == 1 && currentItems(1) == 1
                    shift = 1;  % 如果第一个物品已是1，只能向后移动
                elseif indices(end) == numItemsPerBag && currentItems(end) == numItems
                    shift = -1;  % 如果最后一个物品已是最大值，只能向前移动
                else
                    % 如果不在边界，随机选择移动方向
                    shift = randi([0 1])*2 - 1;  % 产生-1或1
                end

                % 循环移动物品序号
                newItems = mod(currentItems-1 + shift, numItems) + 1;

                % 确保没有重复的物品序号
                allItems = squeeze(offspring(i, j, :));
                isValidMove = true;
                for k = 1:length(newItems)
                    if any(allItems == newItems(k)) && newItems(k) ~= currentItems(k)
                        isValidMove = false;
                        break;
                    end
                end

                % 如果移动有效，则应用变异
                if isValidMove
                    offspring(i, j, indices) = newItems;
                end
            end
        end
    end
    mutated = offspring;
end
