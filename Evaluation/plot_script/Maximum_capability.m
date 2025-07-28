function Maximum_capability_AE_loading()
%clear all;
%close all
fontsize = 13;
figureWidth = 9;
figureHeight = 6.7;


figure; hold on;
legendNames = {['LoRaWAN',newline,'(Oracle)'], ['AlphaWAN',newline,'(Full version)'], ['LoRaWAN', newline, '(Random CP)'] , ['AlphaWAN',newline,'(    disabled)'], ['LoRaWAN',newline,'(Standard)']};      %
positions = (1:10) + [-0.25 0 0.25].';    
colors_line = [ [0 0 0 ]/1.5 ; [68 133 199]  ;  [177 34 34 ];   [217 83 25]    ;   ]/255;   %[165 165 165]  ]/255;
linewidth = 1.5;
markers_cots = ['o', '>', 'd'];


%%%%%%%%%%%%%%% LoRaWAN %%%%%%%%%%
load("LoRaWAN_data.mat");

h1 = errorbar(positions(2,:), LoRaWAN_data.y, LoRaWAN_data.err, 'Marker', markers_cots(1), 'MarkerFaceColor', 'w','Color', colors_line(1,:) ...
    , 'LineWidth', linewidth, 'LineStyle', '--');  


%%%%%%%%%%%%%%% FedWAN #1 %%%%%%%%%%
load("AlphaWAN_data.mat");

h2 = errorbar(positions(2,:), alphawan_data.y, alphawan_data.err, 'Marker', markers_cots(2), 'MarkerFaceColor', 'w','Color', colors_line(2,:) ...
    , 'LineWidth', linewidth, 'LineStyle', '-.');  


%%%%%%%%%%%%%%% random %%%%%%%%%%

load("random_data.mat");

h2_r = errorbar(positions(2,1:1:8), random_data.y, random_data.err, 'Marker', 'v', 'MarkerFaceColor', 'w','Color', [33 158 188]/255 ...
    , 'LineWidth', linewidth+0.3, 'LineStyle', ':');  

%%%%%%%%%%%%%%% FedWAN #2 %%%%%%%%%%

load("AlphaWAN2_data.mat");

h3 = errorbar(positions(2,:), alphawan2_data.y, alphawan2_data.err, 'Marker', markers_cots(3), 'MarkerFaceColor', 'w','Color', colors_line(4,:) ...
    , 'LineWidth', linewidth, 'LineStyle', '-');  

%%%%%%%%%%%%%%% Oracle %%%%%%%%%%

load("oracle_data.mat")

h4 = line(positions(2,:), oracle_data.y, 'Marker', 'x', 'MarkerFaceColor', 'w','Color', 'k' ...
    , 'LineWidth', linewidth, 'LineStyle', '--');  



xlabel('# of gateways', 'FontName', 'Arial', 'FontSize', fontsize);
ylabel('Max. # of concur. users', 'FontName', 'Arial', 'FontSize', fontsize);
xlim([1 8]);
ylim([0, 150]); 

set(gca, 'XTick', 1:10, 'XTickLabel', arrayfun(@num2str, 1:2:19, 'UniformOutput', false), 'fontsize', fontsize);
xtickangle(0); 



orange_gradients = [[143, 185, 209]; [143, 185, 209]; [143, 185, 209]] / 255;  
blue_color = [0, 0.4470, 0.7410];  




hold on;

lgd = legend([h4, h3, h2_r, h2, h1], legendNames, 'Location', 'best', 'Interpreter', 'none', 'FontSize', fontsize-3, 'FontName', 'Arial');
lgd.ItemTokenSize = [12, 11];


set(lgd, 'NumColumns', 1, 'Orientation', 'horizontal', 'Position',[0.646458333333333 0.009645522388059 0.328114787581701 0.96873963515754]); %'vertical');  %

lgd.Box = 'off';


leftMargin = 0.20;
rightMargin = 0.39;
botMargin = 0.22;
topMargin = 0.07;
set(gca, 'Position', [leftMargin, botMargin, 1-leftMargin-rightMargin, 1-botMargin-topMargin]);
ax = gca;
ax.LineWidth = 2;
set(gca, 'FontSize', fontsize, 'FontName', 'Arial','FontWeight','Bold');
grid on;
box on;
set(gca, 'YGrid', 'on', 'XGrid', 'on', 'GridLineStyle', '--', 'GridColor', [0.4, 0.4, 0.4], 'LineWidth', 1.5); 

set(lgd, 'FontName', 'Arial', 'FontWeight', 'bold');


annotation('textbox',...
    [0.701739379084968 0.272383477350091 0.0499567901234577 0.0579187396351571],...
    'String','①',...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FitBoxToText','off' ,...
    'FontSize', 12);


annotation('textbox',[0.0 0.0735301562363619 0.0982187500000001 0.0816127694859034],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontWeight','bold',...
    'FontSize',16,...
    'FitBoxToText','off');




set(gcf, 'Units', 'centimeters', 'Position', [20 5 figureWidth figureHeight]);


dir = pwd;
set(gcf, 'Renderer', 'Painters');
% print('-depsc2', fullfile(dir, 'Sec7_Maximum_capability'), '-r600');

hold off;
end

