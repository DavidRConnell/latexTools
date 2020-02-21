function saveFigure(projectPath, name)
    figureType = latexTools.getCurrentFigureType;
    switch figureType
      case 'Axes'
        latexTools.saveFigForLatex(name, projectPath);
      case 'HeatmapChart'
        saveas(gcf, [projectPath 'figures/' name], 'png')
      otherwise
        msg = 'Figure Type %s not yet implemented in saveFigure.';
        error('MATLAB:UNKNOWNFIGURETYPE', msg, figureType)
    end
end
