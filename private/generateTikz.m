function generateTikz(filename, h, width)
    children = get(h, 'Children');

    fid = fopen(filename, 'w');
    fprintf(fid, '%s\n', '\begin{tikzpicture}');
    fprintf(fid, '\t%s\n', '\begin{axis}[%');
    addAxisOptions(fid, h, width);

    for child = children'
        addChild(fid, child, width)
    end

    fprintf(fid, '\t%s\n', '\end{axis}');
    fprintf(fid, '%s', '\end{tikzpicture}%');
    fclose(fid);
end
