proc import
  out= MATABLE
  DATAFILE= 'P:\magistereBFA\cours2021\data\liste.xls'
  DBMS=XLS REPLACE;
  SHEET= 'Feuil1';
  GETNAMES=YES;
run;

proc import
  out= Exemple.MATABLE
  DATAFILE= 'P:\magistereBFA\cours2021\data\liste.xls'
  DBMS=XLS REPLACE;
  SHEET= 'Feuil1';
  GETNAMES=YES;
run;
