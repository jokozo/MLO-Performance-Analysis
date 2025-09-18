function saveToCSV(filename, rowStruct)
    
    %wywolanie:
    %data = struct( ...
    %    'name1', value, ...
    %    'name2', value, ...
    %    'name3', value ...
    %);

    %saveToCSV('folder/file.csv', data);

    % create folder 
    folder = fileparts(filename);
    if ~isempty(folder) && ~exist(folder, 'dir')
        mkdir(folder);
    end

    writeHeader = ~isfile(filename);  

    fid = fopen(filename, 'a');
    if fid == -1
        error('cant open the file %s', filename);
    end

    keys = fieldnames(rowStruct);
    values = struct2cell(rowStruct);

    %create title
    if writeHeader
        for i = 1:numel(keys)
            fprintf(fid, '%s', keys{i});
            if i < numel(keys), fprintf(fid, ','); else, fprintf(fid, '\n'); end
        end
    end

    % append row
    for i = 1:numel(values)
        val = values{i};
        if ischar(val)
            fprintf(fid, '"%s"', val);  
        elseif isnumeric(val) && isscalar(val)
            fprintf(fid, '%.6f', val);
        else
            flat = sprintf('%.4f ', val(:));
            fprintf(fid, '"%s"', strtrim(flat));
        end
        if i < numel(values), fprintf(fid, ','); else, fprintf(fid, '\n'); end
    end

    fclose(fid);
end
