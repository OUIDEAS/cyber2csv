%% Multi_Log_Plotter
% scans a txt file that contains the output from several logs and plots

clear all
close all
clc


%% OPTIONS

options.rtkon               = 0;
options.pppon               = 1;
options.inspvax             = 1;
options.bestpos             = 1;

options.patchfacealpha      = .25;
freq                        = 10;


%% VAR INIT

% Load File
log_table = Multi_Log_Reader("/home/autobuntu/Documents/08032023/rtk_test_4.txt", [1, Inf]);

% ts_1 = [40, 55, 386, 392] * 10; % Experiment 1 ts
% ts_2 = [80, 95, 420, 428] * 10; % Experiment 2 ts
% ts_3 = [60, 76, 423, 428] * 10; % Experiment 3 ts
% ts_4 = [42, 60, 337, 342] * 10; % Experiment 4 ts
% ts_5 = [60, 300] * 10; % Experiment 5 ts
% ts_6 = [66, 73, 84, 364, 370, 639] * 10; % Experiment 6 ts
% ts_7 = [211, 218, 223, 540, 544, 792] * 10; % Experiment 7 ts
% ts_8 = [176, 191, 210, 486, 490, 812] * 10; % Experiment 8 ts

ts_1 = [55, 392]; % Experiment 1 ts
ts_2 = [95, 428]; % Experiment 2 ts
ts_3 = [76, 428]; % Experiment 3 ts
ts_4 = [60, 342]; % Experiment 4 ts
ts_5 = [60, 300]; % Experiment 5 ts
ts_6 = [66, 84, 370, 639]; % Experiment 6 ts
ts_7 = [211, 223, 544, 792]; % Experiment 7 ts
ts_8 = [176, 210, 490, 812]; % Experiment 8 ts

% Array inits
inspvax_tw                  = [];
inspvax_ts                  = [];
inspvax_solution_status     = [];
inspvax_pos_type            = [];
inspvax_lat                 = [];
inspvax_lon                 = [];
inspvax_hgt                 = [];
inspvax_undulation          = [];
inspvax_nvel                = [];
inspvax_evel                = [];
inspvax_uvel                = [];
inspvax_roll                = [];
inspvax_pitch               = [];
inspvax_azimuth             = [];
inspvax_latstd              = [];
inspvax_lonstd              = [];
inspvax_hgtstd              = [];
inspvax_nvelstd             = [];
inspvax_evelstd             = [];
inspvax_uvelstd             = [];
inspvax_rollstd             = [];
inspvax_pitchstd            = [];
inspvax_azimuthstd          = [];
inspvax_timesinceupdate     = [];
bestpos_tw                  = [];
bestpos_ts                  = [];
bestpos_solution_status     = [];
bestpos_pos_type            = [];
bestpos_lat                 = [];
bestpos_lon                 = [];
bestpos_hgt                 = [];
bestpos_undulation          = [];
bestpos_datumID             = [];
bestpos_latstd              = [];
bestpos_lonstd              = [];
bestpos_hgtstd              = [];
bestpos_basestationID       = [];
bestpos_diffage             = [];
bestpos_solnage             = [];
bestpos_numsats             = [];
bestpos_numsatsinsoln       = [];
bestpos_numsatsl1e1b1       = [];
bestpos_numsatsmulti        = [];
bestpos_extsolnstatus       = [];
bestpos_galbeidousigns      = [];
bestpos_gpsglonas           = [];
rtkpos_tw                   = [];
rtkpos_ts                   = [];
rtkpos_solution_status      = [];
rtkpos_pos_type             = [];
rtkpos_lat                  = [];
rtkpos_lon                  = [];
rtkpos_hgt                  = [];
rtkpos_undulation           = [];
rtkpos_datumID              = [];
rtkpos_latstd               = [];
rtkpos_lonstd               = [];
rtkpos_hgtstd               = [];
rtkpos_basestationID        = [];
rtkpos_diffage              = [];
rtkpos_solnage              = [];
rtkpos_numsats              = [];
rtkpos_numsatsinsoln        = [];
rtkpos_numsatsl1e1b1        = [];
rtkpos_numsatsmulti         = [];
rtkpos_extsolnstatus        = [];
rtkpos_gbsigns              = [];
rtkpos_gpsglonas            = [];
ppppos_tw                   = [];
ppppos_ts                   = [];
ppppos_solution_status      = [];
ppppos_pos_type             = [];
ppppos_lat                  = [];
ppppos_lon                  = [];
ppppos_hgt                  = [];
ppppos_undulation           = [];
ppppos_datumID              = [];
ppppos_latstd               = [];
ppppos_lonstd               = [];
ppppos_hgtstd               = [];
ppppos_basestationID        = [];
ppppos_diffage              = [];
ppppos_solnage              = [];
ppppos_numsats              = [];
ppppos_numsatsinsoln        = [];
ppppos_numsatsl1e1b1        = [];
ppppos_numsatsmulti         = [];
ppppos_extsolnstatus        = [];
ppppos_gbsigns              = [];
ppppos_gpsglonas            = [];
   

%%


plotstatusarray = plot_status_init(options);

legend_string = {};
n = 15;
% color_array = [linspace(0, 1, n)', linspace(1, 0, n)', 0.5 * (1 + sin(2 * pi * freq * (1:n) / n))'];
color_array = rand(n, 3);

%% Line Scanning

h = waitbar(0, "Grabbing the dataz...");

for line_idx = 1:height(log_table)
    
    if log_table.Msg(line_idx) == 'INSPVAX'
        
        %         disp('INSPVAX')
        
        % Min%CPUIdleTime, GPS Reference Time Status, Time: Week, Time: Seconds, Receiver Status, Receiver S/W Version
        %         header_inspvax = [header_inspvax; table2cell(log_table(line_idx, [5:9, 11]))];
        
        %INS Status	Pos Type	Lat	Long	Height	Undulation	North Vel East Vel	Up Vel	Roll, Pitch	Azimuth	Lat σ,...	
        % Long σ	Height σ	North Vel σ	East Vel σ	Up Vel σ	Roll σ	Pitch σ	Azimuth σ Time Since Update
        %         data_inspvax = [data_inspvax; table2cell(log_table(line_idx, [5:9, 11])), table2cell(log_table(line_idx+1, [7:27, 29]))];
        
        inspvax_tw                  = [inspvax_tw;                          log_table(line_idx,7)];
        inspvax_ts                  = [inspvax_ts;                          log_table(line_idx,8)];
        
        inspvax_solution_status     = [inspvax_solution_status;             log_table(line_idx+1,7)];
        inspvax_pos_type            = [inspvax_pos_type;                    log_table(line_idx+1,8)];
        inspvax_lat                 = [inspvax_lat;                         log_table(line_idx+1,9)];
        inspvax_lon                 = [inspvax_lon;                         log_table(line_idx+1,10)];
        inspvax_hgt                 = [inspvax_hgt;                         log_table(line_idx+1,11)];
        inspvax_undulation          = [inspvax_undulation;                  log_table(line_idx+1,12)];
        inspvax_nvel                = [inspvax_nvel;                        log_table(line_idx+1,13)];
        inspvax_evel                = [inspvax_evel;                        log_table(line_idx+1,14)];
        inspvax_uvel                = [inspvax_uvel;                        log_table(line_idx+1,15)];
        inspvax_roll                = [inspvax_roll;                        log_table(line_idx+1,16)];
        inspvax_pitch               = [inspvax_pitch;                       log_table(line_idx+1,17)];
        inspvax_azimuth             = [inspvax_azimuth;                     log_table(line_idx+1,18)];
        inspvax_latstd              = [inspvax_latstd;                      log_table(line_idx+1,19)];
        inspvax_lonstd              = [inspvax_lonstd;                      log_table(line_idx+1,20)];
        inspvax_hgtstd              = [inspvax_hgtstd;                      log_table(line_idx+1,21)];
        inspvax_nvelstd             = [inspvax_nvelstd;                     log_table(line_idx+1,22)];
        inspvax_evelstd             = [inspvax_evelstd;                     log_table(line_idx+1,23)];
        inspvax_uvelstd             = [inspvax_uvelstd;                     log_table(line_idx+1,24)];
        inspvax_rollstd             = [inspvax_rollstd;                     log_table(line_idx+1,25)];
        inspvax_pitchstd            = [inspvax_pitchstd;                    log_table(line_idx+1,26)];
        inspvax_azimuthstd          = [inspvax_azimuthstd;                  log_table(line_idx+1,27)];
        inspvax_timesinceupdate     = [inspvax_timesinceupdate;             log_table(line_idx+1,29)];
        
        line_idx = line_idx + 1;
        
    elseif log_table.Msg(line_idx) == 'BESTPOS'
        
        % Min%CPUIdleTime GPS Reference Time Status, Time: Week, Time: Seconds, Receiver Status, Receiver S/W Version
        %         header_bestpos = [header_bestpos; table2cell(log_table(line_idx, [5, 6, 7, 8, 9, 11]))];
        
        % Solution Status, Position Type, Latitude (deg), Longitude (deg), Alt (m), Undulation (m), Datum id#, lat σ, lon σ,  hgt σ,... 
        % Base Station ID, Differential age (s), Solution age (s), Number of satellites, Number of Sattelites used in solution,... 
        % Number of satellites with L1/E1/B1 signals used in solution, Number of Satellites with multi-frequency signals used in solution, Reserved,
        %Extended Solution Status, Galileo and BeiDou Signals used , GPS and GLONASS signals used
        %         data_bestpos = [data_bestpos; table2cell(log_table(line_idx, [5, 6, 7, 8, 9, 11])), table2cell(log_table(line_idx+1, [7:23, 25:27]))];
        
        bestpos_tw                  = [bestpos_tw;                         log_table(line_idx,7)];
        bestpos_ts                  = [bestpos_ts;                         log_table(line_idx,8)];
        
        bestpos_solution_status     = [bestpos_solution_status;            log_table(line_idx+1,7)];
        bestpos_pos_type            = [bestpos_pos_type;                   log_table(line_idx+1,8)];
        bestpos_lat                 = [bestpos_lat;                        log_table(line_idx+1,9)];
        bestpos_lon                 = [bestpos_lon;                        log_table(line_idx+1,10)];
        bestpos_hgt                 = [bestpos_hgt;                        log_table(line_idx+1,11)];
        bestpos_undulation          = [bestpos_undulation;                 log_table(line_idx+1,12)];
        bestpos_datumID             = [bestpos_datumID;                    log_table(line_idx+1,13)];
        bestpos_latstd              = [bestpos_latstd;                     log_table(line_idx+1,14)];
        bestpos_lonstd              = [bestpos_lonstd;                     log_table(line_idx+1,15)];
        bestpos_hgtstd              = [bestpos_hgtstd;                     log_table(line_idx+1,16)];
        bestpos_basestationID       = [bestpos_basestationID;              log_table(line_idx+1,17)];
        bestpos_diffage             = [bestpos_diffage;                    log_table(line_idx+1,18)];
        bestpos_solnage             = [bestpos_solnage;                    log_table(line_idx+1,19)];
        bestpos_numsats             = [bestpos_numsats;                    log_table(line_idx+1,20)];
        bestpos_numsatsinsoln       = [bestpos_numsatsinsoln;              log_table(line_idx+1,21)];
        bestpos_numsatsl1e1b1       = [bestpos_numsatsl1e1b1;              log_table(line_idx+1,22)];
        bestpos_numsatsmulti        = [bestpos_numsatsmulti;               log_table(line_idx+1,23)];
        bestpos_extsolnstatus       = [bestpos_extsolnstatus;              log_table(line_idx+1,25)];
        bestpos_galbeidousigns      = [bestpos_galbeidousigns;             log_table(line_idx+1,26)];
        bestpos_gpsglonas           = [bestpos_gpsglonas;                  log_table(line_idx+1,27)];
        
        
        
        line_idx = line_idx + 1;
        
    elseif log_table.Msg(line_idx) == 'PPPPOS'
        
        % Min%CPUIdleTime GPS Reference Time Status, Time: Week, Time: Seconds, Receiver Status, Receiver S/W Version
        %         header_ppppos = [header_ppppos; table2cell(log_table(line_idx, [5, 6, 7, 8, 9, 11]))];
        
        % Status, Type, lat, lon, hgt, undulation, datum id#, lat σ, lon σ, hgt σ, stn id, diff_age, sol_age, #SVs, #solnSVs, #ggL1, #solnMultiSVs, ext sol stat, GPS and GLONASS sig mask
        %         data_ppppos = [data_ppppos; table2cell(log_table(line_idx, [5, 6, 7, 8, 9, 11])), table2cell(log_table(line_idx+1, [7:23, 25, 27]))];
        
        ppppos_tw                  = [ppppos_tw;                            log_table(line_idx,7)];
        ppppos_ts                  = [ppppos_ts;                            log_table(line_idx,8)];
        
        ppppos_solution_status     = [ppppos_solution_status;               log_table(line_idx+1,7)];
        ppppos_pos_type            = [ppppos_pos_type;                      log_table(line_idx+1,8)];
        ppppos_lat                 = [ppppos_lat;                           log_table(line_idx+1,9)];
        ppppos_lon                 = [ppppos_lon;                           log_table(line_idx+1,10)];
        ppppos_hgt                 = [ppppos_hgt;                           log_table(line_idx+1,11)];
        ppppos_undulation          = [ppppos_undulation;                    log_table(line_idx+1,12)];
        ppppos_datumID             = [ppppos_datumID;                       log_table(line_idx+1,13)];
        ppppos_latstd              = [ppppos_latstd;                        log_table(line_idx+1,14)];
        ppppos_lonstd              = [ppppos_lonstd;                        log_table(line_idx+1,15)];
        ppppos_hgtstd              = [ppppos_hgtstd;                        log_table(line_idx+1,16)];
        ppppos_basestationID       = [ppppos_basestationID;                 log_table(line_idx+1,17)];
        ppppos_diffage             = [ppppos_diffage;                       log_table(line_idx+1,18)];
        ppppos_solnage             = [ppppos_solnage;                       log_table(line_idx+1,19)];
        ppppos_numsats             = [ppppos_numsats;                       log_table(line_idx+1,20)];
        ppppos_numsatsinsoln       = [ppppos_numsatsinsoln;                 log_table(line_idx+1,21)];
        ppppos_numsatsl1e1b1       = [ppppos_numsatsl1e1b1;                 log_table(line_idx+1,22)];
        ppppos_numsatsmulti        = [ppppos_numsatsmulti;                  log_table(line_idx+1,23)];
        ppppos_extsolnstatus       = [ppppos_extsolnstatus;                 log_table(line_idx+1,25)];
        ppppos_gpsglonas           = [ppppos_gpsglonas;                     log_table(line_idx+1,27)];
        
        
        line_idx = line_idx + 1;
        
    elseif log_table.Msg(line_idx) == 'RTKPOS'
        
        % Min%CPUIdleTime GPS Reference Time Status, Time: Week, Time: Seconds, Receiver Status, Receiver S/W Version
        %         header_rtkpos = [header_rtkpos; table2cell(log_table(line_idx, [5, 6, 7, 8, 9, 11]))];
        
        % Solution Status, Position Type, Latitude (deg), Longitude (deg), Alt (m), Undulation (m), Datum id#, lat σ, lon σ,  hgt σ, Base Station ID, Differential age (s), Solution age (s), Number of satellites, Number of Sattelites used in solution,
        % Number of satellites with L1/E1/B1 signals used in solution, Number of Satellites with multi-frequency signals used in solution, Reserved, Extended Solution Status, Galileo and BeiDou Signals used , GPS and GLONASS signals used
        %         data_rtkpos = [data_rtkpos; table2cell(log_table(line_idx, [5, 6, 7, 8, 9, 11])), table2cell(log_table(line_idx+1, [7:23, 25:27]))];
        
        rtkpos_tw                  = [rtkpos_tw;                         log_table(line_idx,7)];
        rtkpos_ts                  = [rtkpos_ts;                         log_table(line_idx,8)];
        
        rtkpos_solution_status     = [rtkpos_solution_status;            log_table(line_idx+1,7)];
        rtkpos_pos_type            = [rtkpos_pos_type;                   log_table(line_idx+1,8)];
        rtkpos_lat                 = [rtkpos_lat;                        log_table(line_idx+1,9)];
        rtkpos_lon                 = [rtkpos_lon;                        log_table(line_idx+1,10)];
        rtkpos_hgt                 = [rtkpos_hgt;                        log_table(line_idx+1,11)];
        rtkpos_undulation          = [rtkpos_undulation;                 log_table(line_idx+1,12)];
        rtkpos_datumID             = [rtkpos_datumID;                    log_table(line_idx+1,13)];
        rtkpos_latstd              = [rtkpos_latstd;                     log_table(line_idx+1,14)];
        rtkpos_lonstd              = [rtkpos_lonstd;                     log_table(line_idx+1,15)];
        rtkpos_hgtstd              = [rtkpos_hgtstd;                     log_table(line_idx+1,16)];
        rtkpos_basestationID       = [rtkpos_basestationID;              log_table(line_idx+1,17)];
        rtkpos_diffage             = [rtkpos_diffage;                    log_table(line_idx+1,18)];
        rtkpos_solnage             = [rtkpos_solnage;                    log_table(line_idx+1,19)];
        rtkpos_numsats             = [rtkpos_numsats;                    log_table(line_idx+1,20)];
        rtkpos_numsatsinsoln       = [rtkpos_numsatsinsoln;              log_table(line_idx+1,21)];
        rtkpos_numsatsl1e1b1       = [rtkpos_numsatsl1e1b1;              log_table(line_idx+1,22)];
        rtkpos_numsatsmulti        = [rtkpos_numsatsmulti;               log_table(line_idx+1,23)];
        rtkpos_extsolnstatus       = [rtkpos_extsolnstatus;              log_table(line_idx+1,25)];
        rtkpos_gbsigns             = [rtkpos_gbsigns;                    log_table(line_idx+1,26)];
        rtkpos_gpsglonas           = [rtkpos_gpsglonas;                  log_table(line_idx+1,27)];
        
        line_idx = line_idx + 1;
        
    end
    
    %% Weightbar
    
    waitbar(line_idx/height(log_table),h,sprintf('%0.3f',(line_idx/height(log_table)*100)))
    
end

close(h)


%% To Array as needed

inspvax_latstd = table2array(inspvax_latstd);
bestpos_latstd = table2array(bestpos_latstd);

if options.rtkon
    rtkpos_latstd = table2array(rtkpos_latstd);
end

if options.pppon
    ppppos_latstd = table2array(ppppos_latstd);
end

inspvax_lonstd = table2array(inspvax_lonstd);
bestpos_lonstd = table2array(bestpos_lonstd);

if options.rtkon
    rtkpos_lonstd = table2array(rtkpos_lonstd);
end

if options.pppon
    ppppos_lonstd = table2array(ppppos_lonstd);
end

inspvax_ts = str2double(table2array(inspvax_ts));
ppppos_ts = str2double(table2array(ppppos_ts));

if options.rtkon
    rtkpos_ts = str2double(table2array(rtkpos_ts));
end

if options.pppon
    bestpos_ts = str2double(table2array(bestpos_ts));
end

bp_pos_type = categorical(table2array(bestpos_pos_type));



%% Convert second array to local time

inspvax_ts  = inspvax_ts - inspvax_ts(1);
bestpos_ts  = bestpos_ts - bestpos_ts(1);

if options.rtkon
    rtkpos_ts   = rtkpos_ts - rtkpos_ts(1);
end

if options.pppon
    ppppos_ts   = ppppos_ts - ppppos_ts(1);
end


%% Calc std

inspvax_latlonstdmag    = sqrt((inspvax_latstd).^2 + (inspvax_lonstd).^2);
bestpos_latlonstdmag    = sqrt((bestpos_latstd).^2 + (bestpos_lonstd).^2);

if options.rtkon
    rtkpos_latlonstdmag     = sqrt((rtkpos_latstd).^2 + (rtkpos_lonstd).^2);
end

if options.pppon
    ppppos_latlonstdmag     = sqrt((ppppos_latstd).^2 + (ppppos_lonstd).^2);
end


%% BestPos Solution Type Breaks

bp_unique_categories    = unique(bp_pos_type);
bp_numeric_values       = double(bp_pos_type);
bp_category_changes     = find(diff(bp_numeric_values) ~= 0);

if isempty(bp_category_changes)
    
    bp_category_changes = [length(bp_pos_type)];
    
end


%% Plot the things

% Plot Setup
if options.rtkon && options.pppon
    area_y_max = max([inspvax_latlonstdmag', bestpos_latlonstdmag', rtkpos_latlonstdmag', ppppos_latlonstdmag']);
elseif options.rtkon
    area_y_max = max([inspvax_latlonstdmag', bestpos_latlonstdmag', rtkpos_latlonstdmag']);
elseif options.pppon
    area_y_max = max([inspvax_latlonstdmag', bestpos_latlonstdmag', ppppos_latlonstdmag']);
end

stdcompfig = figure('DefaultAxesFontSize', 24);

hold on

scatter(inspvax_ts, inspvax_latlonstdmag, 100, 'ks')
scatter(bestpos_ts, bestpos_latlonstdmag, 'r', 'Filled')

if options.rtkon
    scatter(rtkpos_ts, rtkpos_latlonstdmag, 'g', 'Filled')
end

if options.pppon
    scatter(ppppos_ts, ppppos_latlonstdmag, 'b', 'Filled')
end

hold all

temp_x_array = [];
for change_idx = 1:length(bp_category_changes)
    
    if change_idx == 1
        
        [color, plotstatusarray] = get_color(bp_pos_type(bp_category_changes(change_idx)-1), plotstatusarray, color_array);
        
        patch_x = [inspvax_ts(1), inspvax_ts(bp_category_changes(change_idx)), inspvax_ts(bp_category_changes(change_idx)), inspvax_ts(1)];
        patch_y = [0, 0, area_y_max, area_y_max];
        patch(patch_x, patch_y, color, 'FaceAlpha', options.patchfacealpha);
        temp_x_array = [temp_x_array; patch_x];
        
    elseif change_idx == length(bp_category_changes)

        [color, plotstatusarray] = get_color(bp_pos_type(bp_category_changes(change_idx)-1), plotstatusarray, color_array);
        
        patch_x = [inspvax_ts(bp_category_changes(change_idx-1)+1), inspvax_ts(bp_category_changes(change_idx)-1), inspvax_ts(bp_category_changes(change_idx)-1), inspvax_ts(bp_category_changes(change_idx-1)+1)];
        patch_y = [0, 0, area_y_max, area_y_max];
        patch(patch_x, patch_y, color, 'FaceAlpha', options.patchfacealpha);
        temp_x_array = [temp_x_array; patch_x];

        [color, plotstatusarray] = get_color(bp_pos_type(bp_category_changes(change_idx)+1), plotstatusarray, color_array);
        
        patch_x = [inspvax_ts(bp_category_changes(change_idx)), inspvax_ts(end), inspvax_ts(end), inspvax_ts(bp_category_changes(change_idx))];
        patch_y = [0, 0, area_y_max, area_y_max];
        patch(patch_x, patch_y, color, 'FaceAlpha', options.patchfacealpha);
        temp_x_array = [temp_x_array; patch_x];
        
    else
        
        [color, plotstatusarray] = get_color(bp_pos_type(bp_category_changes(change_idx)-1), plotstatusarray, color_array);
        
        patch_x = [inspvax_ts(bp_category_changes(change_idx-1)+1), inspvax_ts(bp_category_changes(change_idx)), inspvax_ts(bp_category_changes(change_idx)), inspvax_ts(bp_category_changes(change_idx-1)+1)];
        patch_y = [0, 0, area_y_max, area_y_max];
        patch(patch_x, patch_y, color, 'FaceAlpha', options.patchfacealpha);
        temp_x_array = [temp_x_array; patch_x];
        
    end
     
end


for ts_idx = 1:length(ts_3)
    
    % Do Something
    plot([ts_2(ts_idx), ts_2(ts_idx)], [0, area_y_max + 1], 'r--', 'LineWidth', .5)
    text(ts_2(ts_idx), area_y_max + 1, num2str(ts_idx), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 24)
    
    
end


[h, legendLabels] = getlegend(plotstatusarray, color_array);

l = legend(h, legendLabels,...
    'FontSize', 24,...
    'FontWeight',...
    'bold',...
    'LineWidth', 4);
l.Interpreter = 'tex';

xlabel('time (s)')
ylabel('std (m)')
xlim([inspvax_ts(1), inspvax_ts(end)])










