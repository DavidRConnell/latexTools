function addChild(fid, child, width)
    switch child.Type
      case 'line'
        addPlotOptionsLine(fid, child);
      case 'bar'
        addPlotOptionsBar(fid, child, width);
      otherwise
        error('LATEXTOOLS:UnknownLineStyle', ...
              'Child type %s has not been handled yet', child.type);
    end

    fprintf(fid, ' %s\n', 'table {%');
    fprintf(fid, '\t\t%0.8g\t%0.8g\n', [child.XData; child.YData]);
    fprintf(fid, '\t%s\n', '};');

    if ~isempty(child.DisplayName)
        fprintf(fid, '\t%s\n', ['\\addlegendentry{' child.DisplayName '}']);
    end
    fprintf(fid, '\n');
end

function addPlotOptionsLine(fid, child)
    switch child.LineStyle
      case 'none'
        linestyle = ', only marks';
      case '-'
        linestyle = '';
      case '--'
        linestyle = ', dashed';
      case '-.'
        linestyle = ', dashdotted';
      otherwise
        error('LATEXTOOLS:UnknownLineStyle', ...
              'Marker type %s has not been handled yet', child.LineStyle);
    end

    markscaler = 1.3 / 6;
    switch child.Marker
      case 'none'
        marker = '';
      case '.'
        marker = [', mark=*, mark size=', ...
                  num2str(child.MarkerSize * markscaler), 'pt'];
      case '*'
        marker = [', mark=astrix, mark size=', ...
                  num2str(child.MarkerSize * markscaler), 'pt'];
      otherwise
        error('LATEXTOOLS:UnknownMarker', ...
              'Marker type %s has not been handled yet', child.Marker);
    end

    fprintf(fid, '\t%s%s%s\n\t%s, %s%0.8g%s%s%s%s', ...
            '\definecolor{childColor}{rgb}{', parseColor(child.Color), '}', ...
            '\addplot[color=childColor', ...
            'line width=', child.LineWidth, 'pt', ...
            linestyle, ...
            marker, ']');
end

function colorstr = parseColor(rgb)
    colorstr = sprintf('%0.4g,%0.4g,%0.4g', rgb);
end

function addPlotOptionsBar(fid, child, width)
    widthScaler = width * 12 / 0.8;
    fprintf(fid, '\t%s%s%s\n\t%s%s%s\n\t%s%0.8g%s, %s, %s', ...
            '\definecolor{barColor}{rgb}{', parseColor(child.FaceColor), '}', ...
            '\definecolor{edgeColor}{rgb}{', parseColor(child.EdgeColor), '}', ...
            '\addplot[ybar, bar width=', child.BarWidth * widthScaler, 'pt', ...
            'fill=barColor', ...
            'draw=edgeColor]');
end
