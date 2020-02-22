function addAxisOptions(fid, h, width)
    height = h.PlotBoxAspectRatio(2) * width;
    fprintf(fid, '\t\t%s%0.8g%s,\n', 'width=', width, '\columnwidth');
    fprintf(fid, '\t\t%s%0.8g%s,\n', 'height=', height, '\columnwidth');
    fprintf(fid, '\t\t%s%s,\n', 'xmode=', h.XScale);
    fprintf(fid, '\t\t%s%0.8g,\n', 'xmin=', h.XLim(1));
    fprintf(fid, '\t\t%s%0.8g,\n', 'xmax=', h.XLim(2));
    fprintf(fid, '\t\t%s%s%s,\n', 'xlabel={$', h.XLabel.String, '$}');
    fprintf(fid, '\t\t%s%s,\n', 'ymode=', h.YScale);
    fprintf(fid, '\t\t%s%0.8g,\n', 'ymin=', h.YLim(1));
    fprintf(fid, '\t\t%s%0.8g,\n', 'ymax=', h.YLim(2));
    fprintf(fid, '\t\t%s%s%s\n', 'ylabel={$', h.YLabel.String, '$},');

    if strcmp(h.Box, 'off')
        fprintf(fid, '\t\t%s\n', 'axis x line*=bottom,');
        fprintf(fid, '\t\t%s\n', 'axis y line*=left,');
    end

    fprintf(fid, '\t%s\n', ']');
end
