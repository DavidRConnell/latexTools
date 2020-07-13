function addAxisOptions(fid, h, width)
    height = h.PlotBoxAspectRatio(2) * width / h.PlotBoxAspectRatio(1);
    fprintf(fid, '\t\t%s%0.8g%s,\n', 'width=', width, '\columnwidth');
    fprintf(fid, '\t\t%s%0.8g%s,\n', 'height=', height, '\columnwidth');
    fprintf(fid, '\t\t%s%s,\n', 'xmode=', h.XScale);
    fprintf(fid, '\t\t%s%0.8g,\n', 'xmin=', h.XLim(1));
    fprintf(fid, '\t\t%s%0.8g,\n', 'xmax=', h.XLim(2));
    fprintf(fid, '\t\t%s%s,\n', 'ymode=', h.YScale);
    fprintf(fid, '\t\t%s%0.8g,\n', 'ymin=', h.YLim(1));
    fprintf(fid, '\t\t%s%0.8g,\n', 'ymax=', h.YLim(2));

    if ~isempty(h.XLabel.String)
        fprintf(fid, '\t\t%s%s%s,\n', 'xlabel={', h.XLabel.String, '}');
    end

    if ~isempty(h.YLabel.String)
        fprintf(fid, '\t\t%s%s%s,\n', 'ylabel={', h.YLabel.String, '}');
    end

    if strcmp(h.Box, 'off')
        fprintf(fid, '\t\t%s,\n', 'axis x line*=bottom');
        fprintf(fid, '\t\t%s,\n', 'axis y line*=left');
    end

    if ~isempty(h.Legend)
        legendPos = regexp(h.Legend.Location, ...
                           '(north|south)*(east|west)*(outside)*', 'tokens', 'once');
        legendPos = strip(join(legendPos([3 1 2]), ' '));
        fprintf(fid, '\t\t%s%s,\n', 'legend pos=', legendPos{1});
        fprintf(fid, '\t\t%s,\n', ...
                'legend style={nodes={scale=0.75},draw=none}');
    end

    fprintf(fid, '\t%s\n', ']');
end
