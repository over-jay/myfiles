*copie de la table de base;
DATA class ;
  set sashelp.class;
RUN ;

*ajout d'un nouvel élève;
DATA nouvel_eleve ;
  name = 'Jean-Charles' ;
  Sex = 'M' ;
  Age = 21 ;
  Height = 58.645 ;
  Weight = 102.786 ;
run ;

*fusion des tables (KO);
DATA KO_class_plus ;
  set class nouvel_eleve ;
RUN ;

*tri de la table (KO);
proc sort data = KO_class_plus ;
  by name;
RUN ;

*génération d'une variable(KO);
data KO_class_plus;
CALL STREAMINIT(12345);
set  KO_class_plus ;
note= floor(rand("Uniform")*20);
run;

*fusion des tables (Ok);
DATA OK_class_plus ;
  set nouvel_eleve class  ;
RUN ;

*tri de la table (Ok);
proc sort data =  OK_class_plus ;
  by name;
RUN ;

*génération d'une variable(KO);
data OK_class_plus;
CALL STREAMINIT(12345);
set  OK_class_plus;
note= floor(rand("Uniform")*20);
run;

