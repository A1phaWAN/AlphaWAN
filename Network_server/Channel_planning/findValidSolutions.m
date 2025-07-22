function validIndividuals = findValidSolutions(population, numBags, numItemsPerBag)
    % population 是一个三维数组: popSize x numBags x numItemsPerBag
    % numBags 是每个个体中背包的数量
    % numItemsPerBag 是每个背包中的物品数量
    
    popSize = size(population, 1);
    validIndividuals = [];

    for i = 1:popSize
        isValid = true;  % 假设当前个体是有效的
        for j = 1:numBags
            items = squeeze(population(i, j, :));
            group1 = sort(items(1:numItemsPerBag/2));
            group2 = sort(items(numItemsPerBag/2+1:end));

            % 检查两组物品是否连续
            if ~all(diff(group1) == 1) || ~all(diff(group2) == 1)
                isValid = false;  % 如果任何一组物品不连续，则标记为无效
                break;
            end
        end
        
        if isValid
            validIndividuals = [validIndividuals; population(i, :, :)];  % 如果个体有效，添加到输出列表中
        end
    end
end
