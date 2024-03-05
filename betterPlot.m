function [] = betterPlot(figure)
% Function to ensure continuity between all plots despite the coder.
% e.g:
% f1 = figure
% hold on
% plot(x,y)
% plot(a,b)
% xlabel('asdf')
% ylabel('ghjk')
% betterplot(f1)
% legend off

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