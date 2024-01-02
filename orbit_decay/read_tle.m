
function [names, line1, line2] = read_tle(filename)
  fid = fopen(filename, 'r');

  if fid == -1
      error('Error opening the file.');
  end

  names = {};
  line1 = {};
  line2 = {};

  % Loop through the file
  while ~feof(fid)
    % Read lines
    name = fgetl(fid);

    % EOF
    if ~ischar(name)
      break;
    end

    tle_line1 = fgetl(fid);
    tle_line2 = fgetl(fid);

    % ID, line1, and line2
    names = [names; {name}];
    line1 = [line1; {tle_line1}];
    line2 = [line2; {tle_line2}];
  end

    fclose(fid);
end
