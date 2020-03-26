function addChild(fid, child, number, width)
    switch child.Type
      case 'line'
        addPlotOptionsLine(fid, child, number);
      case 'bar'
        addPlotOptionsBar(fid, child, number, width);
      case 'text'
        addPlotOptionsText(fid, child, number);
        fprintf(fid, '\n');
        return
      otherwise
        error('LATEXTOOLS:UnknownLineStyle', ...
              'Child type %s has not been handled yet', child.type);
    end

    fprintf(fid, ' %s\n', 'table {%');
    fprintf(fid, '\t\t%0.8g\t%0.8g\n', [child.XData; child.YData]);
    fprintf(fid, '\t%s\n', '};');

    if ~isempty(child.DisplayName)
        fprintf(fid, '\t%s\n', ['\addlegendentry{' child.DisplayName '}']);
    end
    fprintf(fid, '\n');
end

function addPlotOptionsLine(fid, child, number)
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

    markscaler = 0.78 / 6;
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

    lineColor = defineColor(fid, child.Color, 'lineColor', number);
    fprintf(fid, '\t%s[%s=%s, %s=%0.8g%s%s%s%s%s', ...
            '\addplot', ...
            'color', lineColor, ...
            'line width', child.LineWidth, 'pt', ...
            linestyle, ...
            marker, ']');
end

function colorName = defineColor(fid, rgb, name, number)
    colorName = [name, num2str(number)];
    colorstr = sprintf('%0.4g,%0.4g,%0.4g', rgb);
    fprintf(fid, '\t%s{%s}{%s}{%0.4g,%0.4g,%0.4g}\n', ...
            '\definecolor', colorName, 'rgb', rgb);
end

function addPlotOptionsBar(fid, child, number)
    barColor = defineColor(fid, child.FaceColor, 'barColor', number);
    edgeColor = defineColor(fid, child.EdgeColor, 'edgeColor', number);
    fprintf(fid, '\t%s[%s, %s=%s, %s=%s%s', ...
            '\addplot', 'ybar', ...
            'fill', barColor, ...
            'draw', edgeColor, ']');
end

function addPlotOptionsText(fid, child, number)
    textColor = defineColor(fid, child.Color, 'textColor', number);
    xpos = child.Position(1);
    ypos = child.Position(2);
    node = sprintf('\\node[text=%s]', textColor);
    position = sprintf('at (%0.3g,%0.3g)', xpos, ypos);
    fprintf(fid, '%s\n%s {%s};', ...
            node, ...
            position, ...
            child.String);
end
