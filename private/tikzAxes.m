function tikzAxes(filename, h, width)
    children = get(h, 'Children');

    fid = fopen(filename, 'w');
    fprintf(fid, '%s\n', '\begin{tikzpicture}');
    fprintf(fid, '\t%s\n', '\begin{axis}[%');
    addAxisOptions(fid, h, width);
    for child = children'
        addChild(fid, child)
    end
    fprintf(fid, '\t%s\n', '\end{axis}');
    fprintf(fid, '%s', '\end{tikzpicture}%');
    fclose(fid);

    function addAxisOptions(fid, h, width)
        height = h.PlotBoxAspectRatio(2) * width;
        fprintf(fid, '\t\t%s%0.8g%s,\n', 'width=', width, '\columnwidth');
        fprintf(fid, '\t\t%s%0.8g%s,\n', 'height=', height, '\columnwidth');
        fprintf(fid, '\t\t%s%s,\n', 'xmode=', h.XScale);
        fprintf(fid, '\t\t%s%0.8g,\n', 'xmin=', h.XLim(1));
        fprintf(fid, '\t\t%s%0.8g,\n', 'xmax=', h.XLim(2));
        fprintf(fid, '\t\t%s%s%s,\n', 'xlabel={', h.XLabel.String, '}');
        fprintf(fid, '\t\t%s%s,\n', 'ymode=', h.YScale);
        fprintf(fid, '\t\t%s%0.8g,\n', 'ymin=', h.YLim(1));
        fprintf(fid, '\t\t%s%0.8g,\n', 'ymax=', h.YLim(2));
        fprintf(fid, '\t\t%s%s%s\n', 'ylabel={', h.YLabel.String, '},');

        if strcmp(h.Box, 'off')
            fprintf(fid, '\t\t%s\n', 'axis x line*=bottom,');
            fprintf(fid, '\t\t%s\n', 'axis y line*=left,');
        end

        fprintf(fid, '\t%s\n', ']');
    end

    function addChild(fid, child)
        switch child.Type
          case 'line'
            addPlotOptionsLine(fid, child);
          case 'bar'
            addPlotOptionsBar(fid, child);
          otherwise
            error('LATEXTOOLS:UnknownLineStyle', ...
                  'Child type %s has not been handled yet', child.type);
        end

        fprintf(fid, ' %s\n', 'table[row sep=crcr] {%');
        fprintf(fid, '\t\t%0.8g\t%0.8g\\\\\n', [child.XData; child.YData]);
        fprintf(fid, '\t%s\n\n', '};');
    end

    function addPlotOptionsLine(fid, child)
        switch child.LineStyle
          case 'none'
            linestyle = ', draw=none';
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

        fprintf(fid, '\t%s%s, %s%0.8g%s%s%s%s', ...
                '\addplot[color=', parseColor(child.Color), ...
                'line width=', child.LineWidth, 'pt', ...
                linestyle, ...
                marker, ']');
    end

    function colorstr = parseColor(rgb)
        if isequal(rgb, [0 0 0])
            colorstr='black';
        else
            colorstr = ['{rgb:red,', num2str(rgb(1)), ...
                        ';green,', num2str(rgb(2)), ...
                        ';blue,', num2str(rgb(3)), '}'];
        end
    end

    function addPlotOptionsBar(fid, child)
        widthScaler = 24 / 0.8;
        fprintf(fid, '\t%s%0.8g%s, %s%s, %s%s', ...
                '\addplot[ybar, bar width=', child.BarWidth * widthScaler, 'pt', ...
                'fill=', parseColor(child.FaceColor), ...
                'draw=', parseColor(child.EdgeColor), ']');
    end
end
