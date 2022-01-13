Libname Prelim 'C:\Users\overjay\Documents\magistereBFA\Passation GG\base\Application 1\SAS FILES';
PROC IMPORT
  OUT = Prelim.PIB_REG
  DATAFILE = 'C:\Users\overjay\Documents\magistereBFA\Passation GG\base\Application 1\produit-interieur-brut-reg-1990-2011 formaté.xls'
  DBMS = EXCEL2000 REPLACE;
SHEET = 'PIB en valeur 1990-2011$';
GETNAMES = YES;
RUN;
