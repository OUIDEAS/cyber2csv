clear all
close all
clc

%% VAR INIT

% Load File
% bestpos_log_table = BESTPOS_Log_Reader("/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp1_Init_PPP_RTK.txt", [1, Inf]);
% bestpos_log_table = BESTPOS_Log_Reader("/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp2_PPP_Only_RTK_Off.txt", [1, Inf]);
% bestpos_log_table = BESTPOS_Log_Reader("/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp3_RTK_BACK_IN.txt", [1, Inf]);
% bestpos_log_table = BESTPOS_Log_Reader("/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp4_PPP_OFF.txt", [1, Inf]);
% bestpos_log_table = BESTPOS_Log_Reader("/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp5_PPP_Back_On_rtk_still_on.txt", [1, Inf]);
% bestpos_log_table = BESTPOS_Log_Reader("/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp6_novatel_cycle.txt", [1, Inf]);
bestpos_log_table = BESTPOS_Log_Reader("/home/autobuntu/Documents/red_route_test/red_route.txt", [1, Inf]);

latlonalt = [];
latlonaltstd = [];
latlonstdmag = [];
numsatsoln = [];


%% Process Data

% Data Grabber
for line_idx = 1:height(bestpos_log_table)
    
    if bestpos_log_table.SolStat(line_idx) == {'SOL_COMPUTED'}
        
        latlonalt       = [latlonalt; bestpos_log_table.Lat(line_idx), bestpos_log_table.Lon(line_idx), bestpos_log_table.Alt(line_idx)];
        latlonaltstd    = [latlonaltstd; bestpos_log_table.LatStd(line_idx), bestpos_log_table.LonStd(line_idx), bestpos_log_table.AltStd(line_idx)];
        latlonstdmag    = [latlonstdmag; sqrt(bestpos_log_table.LatStd(line_idx)^2 + bestpos_log_table.LonStd(line_idx)^2)];
        numsatsoln      = [numsatsoln; bestpos_log_table.NumSatsSoln(line_idx)];
        
    end
    
end


%% Plot Data

latlonfig = figure();

scatter(latlonalt(:,2), latlonalt(:,1));

xlabel('Lat (deg)')
ylabel('Lon (deg)')
grid on
axis equal


latlonstdfig = figure();

scatter(latlonalt(:,2), latlonalt(:,1), [], latlonstdmag, 'filled');

colorbar;
ylabel(colorbar, 'Std (m)')
xlabel('Lat (deg)')
ylabel('Lon (deg)')
grid on
axis equal

%%

geolatlonstdfig = figure();

geoscatter(latlonalt(:,1), latlonalt(:,2), [], latlonstdmag, 'filled');

colorbar;
ylabel(colorbar, 'Std (m)')
% xlabel('Lat (deg)')
% ylabel('Lon (deg)')
% grid on
% axis equal



