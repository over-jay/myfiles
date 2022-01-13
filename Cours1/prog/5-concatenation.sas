
DATA exemple ;
  set sashelp.class;
RUN ;


data exemple2;
set exemple;
NOM_ALL = sex||name;
CAT_NOM = CATS(NOM_ALL, put(Height, 10.));
run;

data exemple3;
set exemple2;
format yob year4.  anne_avant year4.;
longueur = length(CAT_NOM);
clef  = upcase(CAT_NOM) ;
yob = mdy(1,1,year(date()) - age);
reste = mod(yob,longueur);
moyenne = mean(yob, reste*longueur);
anne_avant = lag(yob);
diff_reste2 = dif2(reste);
run;

/*
data exemple2;
set ok_class_plus;
NOM_ALL = sex||name;
CAT_NOM = CATS(NOM_ALL, put(Height, 10.));
run;*/
