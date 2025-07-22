function [packet_loss_number] = sim_GeneticAlgorithm_self(numCH,numGW,itemWeights,Display_on);
% ============================================================================ %
% This function calculates the gain by changing the arrival time weight and the number of gateways.
% Input:
% numCH      : number of channel              Defualt: 16
% numGW      : number of Gateway within area  (>=1)
% itemWeights: packets weight in 16 CHs.      Size:(1,numCH)
%                   -->pkts loss num per CH   RANDOM
% Display_on : if show the figure.            0: not   1: show the images
%
% Output:
% Channel configurations
% Established by Ziyue  2024.08.17
% Modified    by Ruonan 2024.08.30


% Parameter
popSize     = 100;    
numSelectCH = 8;      
maxGenerations = 300; 
mutationRate   = 0.0; 
crossoverRate  = 0.8; 
maxWeight   = 16;     
numCH = 24; 
%numGW = ;
Display_on  = 0;



%%%%%%%%%%%% for maximum capability of this system
GW_vary  = 14:2:19;           
Pkt_vary = 40:10:140;      
recursivetimes = 3;   
total_time  = 50;         

% Pkt_vary = 37;           
for n_pkt = 1:length(Pkt_vary)     
    total_pkts = Pkt_vary(n_pkt);     
    for nGW = 1:length(GW_vary)         
        numGW = GW_vary(nGW);
        for id = 1:recursivetimes
            for times = 1:total_time    
                [numCH,numGW,itemWeights] = generate_input_data(total_pkts,numGW,numCH);
                Weight(times,:) = itemWeights;
                population = initPopulation(popSize, numSelectCH, numGW, numCH);
                fitness = evaluateFitness(population, numGW, numSelectCH, maxWeight, itemWeights);

                   [~, initialTotalLoss] = evaluateFitness(population, numGW, numSelectCH, maxWeight, itemWeights);


                if Display_on == 1
                    figure('Name', 'Item Weights', 'Position', [100, 100, 800, 400]);
                    t1 = uitable('Data', [1:numCH; itemWeights]', 'ColumnName', {'Item ID', 'Weight'}, 'RowName', [], 'Position', [20 20 760 500], 'FontSize', 14);
                    figure('Name', 'Initial Population Total Loss', 'Position', [200, 400, 700, 300]);
                    uitable('Data', initialTotalLoss, 'ColumnName', {'Total Loss'}, 'Position', [20 20 560 160], 'FontSize', 14);
                end


                bagData = zeros(numGW, numSelectCH + 1); 
                initialPenalties = zeros(1, numCH);
                for k = 1:numCH
                    initialPenalties(k) = itemWeights(k); 
                end


                for j = 1:numGW
                    bagWeight = sum(itemWeights(population(1, j, :)));
                    for k = 1:numSelectCH
                        bagData(j, k) = population(1, j, k);
                        if bagWeight > maxWeight
                            if initialPenalties(population(1, j, k)) >= min(itemWeights(population(1, j, k)), bagWeight - maxWeight)
                                initialPenalties(population(1, j, k)) = min(itemWeights(population(1, j, k)), bagWeight - maxWeight);
                            end
                        else                 
                            initialPenalties(population(1, j, k)) = 0;
                        end
                    end
                    bagData(j, end) = bagWeight; 
                end
                initialTotalPenalty = sum(initialPenalties);
                if Display_on == 1
                    figure('Name', 'Initial Population Bag Choices and Weights', 'Position', [200, 400, 1300, 700]);
                    
                    t2 = uitable('Data', bagData, 'ColumnName', [cellstr(strcat('Item ', string(1:numSelectCH))), 'Total Weight'], 'RowName', strcat('Bag ', string(1:numGW)), 'Position', [20 320 1160 260]);
                    
                    t2a = uitable('Data', [1:numCH; initialPenalties]', 'ColumnName', {'Item ID', 'Penalty'}, 'RowName', [], 'Position', [20 20 1160 400]);
                end

tic;  

               
                for gen = 1:maxGenerations
                    selected = selection(population, fitness);
                    offspring = crossover(selected, crossoverRate, numGW, numSelectCH, numCH);
                    offspring = mutate(offspring, mutationRate, numGW, numCH, numSelectCH);
                    population = offspring;
                    [fitness, totalLoss] = evaluateFitness(population, numGW, numSelectCH, maxWeight, itemWeights);
                end


elapsedTime = toc;  
elapsedTime_ms = elapsedTime * 1000;  
disp(['Elapsed time in milliseconds: ', num2str(elapsedTime_ms)]);



                finalPopulation = population;

                finalData = zeros(numGW, numSelectCH + 1); 
                finalPenalties = inf(1, numCH); 



                [~, finalTotalLoss] = evaluateFitness(finalPopulation, numGW, numSelectCH, maxWeight, itemWeights);
                if Display_on == 1
                    figure('Name', 'Final Population Best Individual Total Loss', 'Position', [100, 500, 600, 200]);
                    uitable('Data', finalTotalLoss, 'ColumnName', {'Total Loss'}, 'Position', [20 20 560 400], 'FontSize', 14);
                end


                [~, bestIdx] = max(fitness);
                bestIndividual = population(bestIdx, :, :);

                expandedWeights = [];
                expandedPriorities = [];
                itemIndex = 1;
                priorityLevels = randperm(sum(itemWeights));

                for i = 1:numCH
                    for w = 1:itemWeights(i)
                        expandedWeights = [expandedWeights, i]; 
                        expandedPriorities = [expandedPriorities, priorityLevels(itemIndex)]; 
                        itemIndex = itemIndex + 1;
                    end
                end



                packettag = inf(1,sum(itemWeights)); 

                for j = 1:numGW           
                    bagWeight = sum(itemWeights(bestIndividual(1, j, :)));   

                    bagpriorities = 1:bagWeight; 
                    for k = 1:numSelectCH 
                        finalData(j, k) = bestIndividual(1, j, k);   
                    end

                    if (bagWeight > maxWeight) 
                        potential_loss_packet_index = [];
                        for aindex = 1:sum(itemWeights)      
                            if ismember(expandedWeights(aindex),finalData(j,:))   
                                potential_loss_packet_index(end+1) = aindex;
                                
                            end
                        end

                        priorities_to_sort = expandedPriorities(potential_loss_packet_index);


                        [~, sortIdx] = sort(priorities_to_sort, 'descend');

                        sorted_expandedIndex = potential_loss_packet_index(sortIdx);

                        for loss_index = 1:(bagWeight - maxWeight)
                            if packettag(sorted_expandedIndex(loss_index)) ~= 0      
                                packettag(sorted_expandedIndex(loss_index)) = 1;        
                            end
                        end
                        for receive_index = (bagWeight - maxWeight + 1): bagWeight
                            packettag(sorted_expandedIndex(receive_index)) = 0;
                        end


                    else    
                        for aindex = 1:sum(itemWeights)   
                            if ismember(expandedWeights(aindex),finalData(j,:))
                                packettag(aindex) = 0;
                            end
                        end
                    end

                    % for aindex = 1:sum(itemWeights)
                    %     if ismember(packettag(aindex), 1)
                    %
                    %     end
                    % end

                    finalData(j, end) = bagWeight; 
                end

                packet_loss_number = 0;
                for aindex = 1:sum(itemWeights)
                    if ismember(packettag(aindex), [1, inf])
                        packet_loss_number = packet_loss_number + 1;
                    end
                end
                Loss_number(id,times) = packet_loss_number;

                finalTotalPenalty = finalPenalties;
            end

            t3 = uitable('Data', finalData, 'ColumnName', [cellstr(strcat('Item ', string(1:numSelectCH))), 'Total Weight'], 'RowName', strcat('Bag ', string(1:numGW)), 'Position', [20 320 1160 260]);

            t3a = uitable('Data', [1:numCH; finalPenalties]', 'ColumnName', {'Item ID', 'Penalty'}, 'RowName', [], 'Position', [20 20 1160 400]);

            max_lossn = max(Loss_number(id,:));
            vary = 0:max_lossn;
            disp(['%==========PKT: ',num2str(total_pkts),' GW: ',num2str(numGW),' Interg: ', num2str(id),'==========%'])

            for ii = 1:max_lossn+1
                loss_n(ii) = length(find(Loss_number(id,:) == vary(ii)));
                disp(['Loss ',num2str(vary(ii)), ' packet: ', num2str(loss_n(ii)), ' ... Percent: ', num2str(loss_n(ii)/total_time),' ...'])
            end


        end

    end
end







if Display_on == 1
    f = figure('Name', 'Genetic Algorithm Visualization', 'Position', [100, 100, 1200, 800]);


    subplot(2,1,1);
    plot(1:numCH, itemWeights, 'b-o', 'LineWidth', 2, 'MarkerSize', 6);
    ylabel('Weight');
    xlabel('Item ID');
    title('Item Weights');
    grid on;
end
% [~, bestIdx] = max(fitness);
% finalPopulation = population(bestIdx, :, :);
% displayBagContents(squeeze(finalPopulation), itemWeights);

end
%==============================================================================================%

%==============================================================================================%
%                           Sub Function
%-------------------------------------------------------------------------------%
function [numCH, numGW, itemWeights] = generate_input_data(total_pkts, numGW, numCH)
    itemWeights = zeros(1, numCH);

    remaining_pkts = total_pkts;

    
    while remaining_pkts > 0
        
        random_order = randperm(numCH);

        
        for i = 1:numCH
            ch = random_order(i);  


            max_pkts = min(6 - itemWeights(ch), remaining_pkts);
            if max_pkts > 0
                %allocated_pkts = randi([0, max_pkts]);
                % allocated_pkts = randi([0, 1]);
                allocated_pkts = 1;
                itemWeights(ch) = itemWeights(ch) + allocated_pkts;
                remaining_pkts = remaining_pkts - allocated_pkts;
            end

            if remaining_pkts <= 0
                break;
            end
        end
    end


    if sum(itemWeights) ~= total_pkts
        error('err');
    end
end


