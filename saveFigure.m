function saveFigure(name, projectPath, h, width)
    if nargin < 2 || isempty(projectPath)
        projectPath = '.';
    end

    if nargin < 3 || isempty(h)
        h = gca;
    end

    if nargin < 4 || isempty(width)
        width = 0.95;
    end

    validateattributes(width, {'numeric'}, {'>', 0, '<=', 1});
    filepath = utils.pathjoin(projectPath, 'figures', name);
    [~, ~, ext] = fileparts(filepath);
    if isempty(ext) && ~strcmp(h.Type, 'heatmap')
        filepath = [filepath, '.tex'];
    end

    switch h.Type
      case 'axes'
        generateTikz(filepath, h, width);
      case 'heatmap'
        saveas(gcf, filepath, 'png')
      otherwise
        msg = 'Figure Type %s not yet handled in saveFigure.';
        error('LATEXTOOLS:UnknownFigureType', msg, h.Type);
    end
end
