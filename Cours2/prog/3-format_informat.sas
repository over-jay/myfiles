data new;
input jdate: DDMMYY10. ldate: date9.  mdate : monyy7.  ;/*lecture */
format jdate DDMMYY10. ldate worddate18. mdate ddmmyy10. ; /* presentation*/
cards;
11/02/1989 22jan2004 apr2011
run;

data new;
set new;
format dtdate datetime18.;
dtdate=dhms(jdate,0,0,0);
run;

proc print new;
run;

data amount;
input nombre: best8. salaire comma8. quantity dollar10.;
format nombre salaire  quantity dollar12.4;
cards;
123 23,333 $2,23,000.66
124 30,000 $5,55,000.78
;
run;
proc print;
run;

