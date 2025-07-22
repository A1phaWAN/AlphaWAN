
function displayBagContents(population, itemWeights)
    % population: 当前种群中的一个个体，假设是一个 numBags x numItemsPerBag 的二维数组
    % itemWeights: 各物品的重量数组

    numBags = size(population, 1);
    numItemsPerBag = size(population, 2);
    
    % 初始化用于存储每个背包物品ID和总重量的数据
    bagData = zeros(numBags, numItemsPerBag + 1); % 最后一列用于存储总重量
    
    for j = 1:numBags
        % 提取当前背包中的所有物品ID
        items = population(j, :);
        
        % 计算总重量
        totalWeight = sum(itemWeights(items));
        
        % 存储物品ID和总重量
        bagData(j, 1:numItemsPerBag) = items;
        bagData(j, numItemsPerBag + 1) = totalWeight;
    end
    
    % 创建一个uitable展示每个背包的物品ID和总重量
    f = figure('Name', 'Bag Contents and Total Weights', 'Position', [100, 100, 500, 300]);
    t = uitable('Parent', f, 'Data', bagData, 'ColumnName', [cellstr(strcat('Item ', string(1:numItemsPerBag))), 'Total Weight'], 'Position', [20, 20, 460, 260]);
end