function date = year2date(decimal_year)
  y2d = 365.25;
  d2h = 24;
  h2m = 60;
  m2s = 60;

  y = floor(decimal_year);
  rem = decimal_year - y;

  total_days = floor(rem*y2d);
  available_days = total_days;

  for i = 1 : 12
      days_in_month = eomday(y, i);

      if days_in_month >= available_days
        m = i;
        break;
      end

      available_days = available_days - days_in_month;
  end

  d = available_days;
  rem = rem - d/y2d;


  hh = floor(rem*y2d*d2h);
  rem = rem - hh / (y2d*d2h);

  mm = floor(rem*y2d*d2h*h2m);
  rem = rem - mm / (y2d*d2h*h2m);

  ss = round(rem*y2d*d2h*h2m*m2s);
  date = [y, m, d, hh, mm, ss];
end
