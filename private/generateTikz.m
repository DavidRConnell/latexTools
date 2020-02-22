function generateTikz(filename, h, width)
    children = get(h, 'Children');

    fid = fopen(filename, 'w');
    fprintf(fid, '%s\n', '\begin{tikzpicture}');
    fprintf(fid, '\t%s\n', '\begin{axis}[%');
    addAxisOptions(fid, h, width);

    for childNumber = 0:(length(h.Children) - 1)
        addChild(fid, h.Children(length(h.Children) - childNumber), ...
                 childNumber + 1, width)
    end

    fprintf(fid, '\t%s\n', '\end{axis}');
    fprintf(fid, '%s', '\end{tikzpicture}%');
    fclose(fid);
end
