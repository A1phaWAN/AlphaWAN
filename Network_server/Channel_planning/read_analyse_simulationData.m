function read_analyse_simulationData(total_pkts_range, GW_range, step_pkt, step_gw)
% ============================================================================ %
%    本函数基于sim_GeneticAlgorithm_self.m data to analyze
% read Pkt_xx_GWx.csv   saved in folder /Sim_data/Pktxx
% analyze and plot loss packet number.
%
% Established by Ruonan  2024.09.13
% Modified    by Ziyue   2024.09.23

% ============================================================================ %

% total_pkts = 40;
% 
% GW_vary    = [2:8];
% 
% %Pkt_vary   = [35:50];
% Pkt_vary   = [35:5:50];
% dir =  [pwd,'\Sim_data\Pkt',num2str(total_pkts),'\'];
% 
% for n_gw = 1: length(GW_vary)
%     numGW = GW_vary(n_gw);
%     filename = ['Pkt',num2str(total_pkts),'_GW',num2str(numGW)];
%     file_info= [dir, filename,'.csv'];
%     temp = dlmread(file_info);
%     Loss_num(n_gw) = mean(mean(temp));
% 
% end
% %Loss_num

% GW_vary  = 3:2:9;           %网关数量变化
% Pkt_vary = 40:10:140;

    total_pkts_range = [40 140];
    GW_range = [3 9];
    step_pkt = 10; 
    step_gw = 2;

    % 初始化数据存储
    mean_loss = [];
    var_loss = [];

    % 遍历每个数据包总数
    for total_pkts = total_pkts_range(1):step_pkt:total_pkts_range(2)
        % 文件夹路径
        dir =  [pwd, '\Sim_data\Pkt', num2str(total_pkts), '\'];
        
        % 遍历每个网关数量
        temp_mean = [];
        temp_var = [];
        
        for numGW = GW_range(1):step_gw:GW_range(2)
            % 构建文件名
            filename = ['Pkt', num2str(total_pkts), '_GW', num2str(numGW)];
            file_info = [dir, filename, '.csv'];
            
            % 读取CSV文件并计算均值和方差
            if isfile(file_info)
                temp = dlmread(file_info);
                avg_loss = mean(temp(:)); % 计算丢包数的平均值
                var_loss_val = var(temp(:)); % 计算丢包数的方差
                temp_mean = [temp_mean, avg_loss];
                temp_var = [temp_var, var_loss_val];
            else
                warning(['文件未找到: ', file_info]);
            end
        end
        
        % 存储当前Pkt的结果
        mean_loss = [mean_loss; temp_mean];
        var_loss = [var_loss; temp_var];
    end

    % 将均值和方差结果保存用于后续绘图
    save('loss_data.mat', 'mean_loss', 'var_loss');

    % 你可以在这里调用绘图函数，比如 errorbar
    % figure;
    % errorbar(mean_loss, sqrt(var_loss));
end