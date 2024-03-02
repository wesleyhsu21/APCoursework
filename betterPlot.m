function [] = betterPlot(figure)
    set(0,'CurrentFigure',figure)    
    ax = gca;
    lgd = legend;
    box on;
    grid on;
    ax.FontSize = 16;
    ax.TickLabelInterpreter = "latex";
    ax.XLabel.Interpreter = "latex";
    ax.YLabel.Interpreter = "latex";

    lgd.Interpreter = "latex";
    lgd.FontSize = 13;
    
end

