function offspring = crossover_random(selected, crossoverRate, numBags, numItemsPerBag, numItems)
    % 交叉操作
    offspring = selected;
    popSize = size(selected, 1);

    for i = 1:popSize
        if rand() < crossoverRate
            for j = 1:numBags
                if numItemsPerBag > 3
                    % 随机选择是移动背包中的前四个还是后四个物品
                    if rand() < 0.5
                        indices = 1:4;  % 要变化种类的前四个物品的索引
                        other_indices = numItemsPerBag-3:numItemsPerBag; % 另外后四个物品的索引
                    else
                        indices = numItemsPerBag-3:numItemsPerBag;  % 要变化种类的后四个物品的索引
                        other_indices = 1:4; % 另外前四个物品的索引
                    end
                else
                    indices = 1:numItemsPerBag;  % 要变化种类的前四个物品的索引
                    other_indices = 1:numItemsPerBag; % 另外后四个物品的索引
                end

                % 获取当前背包中所有物品的索引
                %currentItems = squeeze(offspring(i, j, :));
                currentItems = offspring(i, j, :);   % 这8个是物品的种类号   从1~16
                currentIndices = find(currentItems); % 这8个是背包位置的序号 从第一个位置到第八个位置的位置号
                validStarts = 1 : (numItems-3);      % 这里选的是可能的物品的种类号，不超过边界
                % % % % % flag = 0;
                % % % % % while flag == 0                       %这里选择不与另外四个物品种类号重叠的四个连续物品种类号。
                    realStarts = randi (length(validStarts));   
                % % % %     % 从另一个开始的前三个开始到另一个的最后一个都不行
                % % % % %     if (realStarts >= (currentItems(other_indices(1))-3 )) && (realStarts <= currentItems(other_indices(4)))
                % % % % %         flag = 0;
                % % % % %     else
                % % % % %         flag = 1;
                % % % % %     end
                % % % % % end
                % % % % % 

                % % 确定所有不会与现有物品重叠的新起始位置
                % validStarts = [];
                % for start = 1:(numItemsPerBag - 3)  % 确保新位置+3不超出物品种类总数
                %     if all(~ismember(start:(start + 3), currentIndices))
                %         validStarts = [validStarts start];
                %     end
                % end
                % 
                % if isempty(validStarts)
                %     % 如果没有有效的起始位置，跳过当前背包的这次操作
                %     continue;
                % end

                % % 从有效的起始位置中随机选择一个新的起始位置
                % newStart = validStarts(randi(length(validStarts)));
                % newIndices = realStarts:(realStarts + 3);
                % 
                % 执行移动
                
                % itemsToMove = currentItems(indices);
                % currentItems(i:j:indices) = realStarts:realStarts+3;     % 清空原位置 背包就8个位置
                if numItemsPerBag > 3
                    for k = 1:4
                        currentItems(indices(k)) = realStarts+k-1;  % 移动到新位置
                    end
                else
                    for k = 1:numItemsPerBag
                        currentItems(indices(k)) = realStarts+k-1;  % 移动到新位置
                    end
                offspring(i, j, :) = currentItems;
            end
        end
    end
end
