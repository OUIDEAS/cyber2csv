function [color, plotstatusarray] = get_color(soln_type, plotstatusarray, color_array)

    %% Var Init

    %% Get the things
    
    % color stuff here
    if soln_type == 'INS_RTKFIXED'
        
        color = color_array(1,:); % []
        plotstatusarray(5) = 1;
        
    elseif soln_type == 'INS_RTKFLOAT'
        
        color = color_array(2,:); % []
        plotstatusarray(6) = 1;
        
    elseif soln_type == 'NARROW_INT'
        
        color = color_array(3,:); % []
        plotstatusarray(7) = 1;
        
    elseif soln_type == 'PSRDIFF'
        
        color = color_array(4,:); % []
        plotstatusarray(8) = 1;
        
    elseif soln_type == 'PSRSP'
        
        color = color_array(5,:); % []
        plotstatusarray(9) = 1;
        
    elseif soln_type == 'INS_PSRSP'
        
        color = color_array(6,:);
        plotstatusarray(10) = 1;
        
    elseif soln_type == 'INS_PPP'
                
        color = color_array(7,:);
        plotstatusarray(11) = 1;
        
    elseif soln_type == 'INS_PPP_CONVERGING'
                
        color = color_array(8,:);
        plotstatusarray(12) = 1;
        
    elseif soln_type == 'PPP_CONVERGING'
        
        color = color_array(9,:);
        plotstatusarray(13) = 1;
        
    elseif soln_type == 'INS_PSRDIFF'
        
        color = color_array(10,:);
        plotstatusarray(14) = 1;
        
    end
    
end