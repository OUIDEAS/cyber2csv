 function [h, legendLabels] = getlegend(plotstatusarray, color_array)
    
    %% VAR INIT
    
    legendLabels = {};
    plot_idx = 1;
    
    
    %% function
    
    if plotstatusarray(1)
        h(plot_idx) = plot(NaN, NaN, 'ks', 'MarkerSize', 20);
        legendLabels = [legendLabels, '\color{black} INSPVAX'];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(2)
        h(plot_idx) = plot(NaN, NaN, 'ro', 'MarkerSize', 20);
        legendLabels = [legendLabels, '\color{red} BESTPOS'];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(3)
        h(plot_idx) = plot(NaN, NaN, 'go', 'MarkerSize', 20);
        legendLabels = [legendLabels, '\color{green} RTKPOS'];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(4)
        h(plot_idx) = plot(NaN, NaN, 'bo', 'MarkerSize', 20);
        legendLabels = [legendLabels, '\color{blue} PPPPOS'];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(5)
        h(plot_idx) = plot(NaN, NaN, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [color_array(1,:)], 'MarkerSize', 20);
        legendLabels = [legendLabels, sprintf('\\color[rgb]{%f,%f,%f} INS RTKFIXED', color_array(1,1), color_array(1,2), color_array(1,3))];
        plot_idx = plot_idx + 1;
        
    end
    
    if plotstatusarray(6)
        h(plot_idx) = plot(NaN, NaN, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [color_array(2,:)], 'MarkerSize', 20);
        legendLabels = [legendLabels, sprintf('\\color[rgb]{%f,%f,%f} INS RTKFLOAT', color_array(2,1), color_array(2,2), color_array(2,3))];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(7)
        h(plot_idx) = plot(NaN, NaN, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [color_array(3,:)], 'MarkerSize', 20);
        legendLabels = [legendLabels, sprintf('\\color[rgb]{%f,%f,%f} NARROW INT', color_array(3,1), color_array(3,2), color_array(3,3))];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(8)
        h(plot_idx) = plot(NaN, NaN, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [color_array(4,:)], 'MarkerSize', 20);
        legendLabels = [legendLabels, sprintf('\\color[rgb]{%f,%f,%f} PSRDIFF', color_array(4,1), color_array(4,2), color_array(4,3))];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(9)
        h(plot_idx) = plot(NaN, NaN, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [color_array(5,:)], 'MarkerSize', 20);
        legendLabels = [legendLabels, sprintf('\\color[rgb]{%f,%f,%f} PSRSP', color_array(5,1), color_array(5,2), color_array(5,3))];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(10)
        h(plot_idx) = plot(NaN, NaN, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [color_array(6,:)], 'MarkerSize', 20);
        legendLabels = [legendLabels, sprintf('\\color[rgb]{%f,%f,%f} INS PSRSP', color_array(6,1), color_array(6,2), color_array(6,3))];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(11)
        h(plot_idx) = plot(NaN, NaN, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [color_array(7,:)], 'MarkerSize', 20);
        legendLabels = [legendLabels, sprintf('\\color[rgb]{%f,%f,%f} INS PPP', color_array(7,1), color_array(7,2), color_array(7,3))];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(12)
        h(plot_idx) = plot(NaN, NaN, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [color_array(8,:)], 'MarkerSize', 20);
        legendLabels = [legendLabels, sprintf('\\color[rgb]{%f,%f,%f} INS PPP CONVERGING', color_array(8,1), color_array(8,2), color_array(8,3))];
        plot_idx = plot_idx + 1;
    end
    
    if plotstatusarray(13)
        h(plot_idx) = plot(NaN, NaN, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [color_array(9,:)], 'MarkerSize', 20);
        legendLabels = [legendLabels, sprintf('\\color[rgb]{%f,%f,%f} PPP CONVERGING', color_array(9,1), color_array(9,2), color_array(9,3))];
        plot_idx = plot_idx + 1;
    end
    
    
    
    
    
 end