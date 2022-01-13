%let dir = "P:\magistereBFA";
%let annee = "P:\magistereBFA\cours2021\datalib";
%let nomlibname = myLN;

/*Libname exemple  'C:\Users\overjay\Documents\CoursEXSAMA\Sas\cours+TP\Cours1\data1';*/

Libname &nomlibname. &annee.;
/*
data test;
run;

data &nomlibname.test;
run;


data &nomlibname..test;
run;
*/
