function generateTikz(filename, h, width)
    if nargin < 2 || isempty(h)
        h = gca;
    end

    if nargin < 3
        width = 0.95;
    end

    [~, ~, ext] = fileparts(filename);
    if isempty(ext)
        filename = [filename, '.tex'];
    end

    switch h.Type
      case 'axes'
        tikzAxes(filename, h, width);
      % case 'heatmapchart'
      %   tikzHeatmap(h);
      otherwise
        msg = 'Figure Type %s not yet implemented in generateTikz.';
        error('MATLAB:UNKNOWNFIGURETYPE', msg, figureType)
    end
end
