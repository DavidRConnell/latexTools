function figureType = getCurrentFigureType
    figureType = split(class(gca), '.');
    figureType = figureType{end};
end
