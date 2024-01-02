function year = epoch2year(tle_epoch)
  ymd = floor(tle_epoch);
  yr = fix(ymd/1000);
  dofyr = mod(ymd, 1000);

  if (yr < 57)
    year = yr + 2000;
  else
    year = yr + 1900;
  end;

  decidy = round((tle_epoch - ymd) * 10^8) / 10^8;
  year = year + (dofyr + decidy) / 365;
end
