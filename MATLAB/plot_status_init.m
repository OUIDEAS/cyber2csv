function plotstatusarray = plot_status_init(options)

        plotstatus.INS_RTKFIXED = 0;
        plotstatus.INS_RTKFLOAT = 0;
        plotstatus.NARROW_INT = 0;
        plotstatus.PSRDIFF = 0;
        plotstatus.PSRSP = 0;
        plotstatus.INS_PSRSP = 0;
        plotstatus.INS_PPP = 0;
        plotstatus.INS_PPP_CONVERGING = 0;
        plotstatus.PPP_CONVERGING = 0;
        plotstatus.INS_PSRDIFF = 0;
        
        if options.rtkon
            plotstatus.rtk = 1;
        else
            plotstatus.rtk = 0;
        end
        
        if options.pppon
            plotstatus.ppp = 1;
        else
            plotstatus.ppp = 0;
        end
        
        if options.inspvax
            plotstatus.inspvax = 1;
        else
            plotstatus.inspvax = 0;
        end
        
        if options.bestpos
            plotstatus.bestpos = 1;
        else
            plotstatus.bestpos = 0;
        end
        
        
        
        plotstatusarray = [ plotstatus.inspvax;...
                            plotstatus.bestpos;...
                            plotstatus.rtk;...
                            plotstatus.ppp;...
                            plotstatus.INS_RTKFIXED;...
                            plotstatus.INS_RTKFLOAT;...
                            plotstatus.NARROW_INT;...
                            plotstatus.PSRDIFF;...
                            plotstatus.PSRSP;...
                            plotstatus.INS_PSRSP;...
                            plotstatus.INS_PPP;...
                            plotstatus.INS_PPP_CONVERGING;...
                            plotstatus.PPP_CONVERGING;...
                            plotstatus.INS_PSRDIFF];

end