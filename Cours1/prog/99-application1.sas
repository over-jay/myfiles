
Libname Prelim 'P:\magistereBFA\cours2021\cours+TP\Cours1\STOCKAGE';


PROC IMPORT
  OUT = Prelim.PIB_REG
  DATAFILE = 'P:\magistereBFA\cours2021\cours+TP\Cours1\app-data\produit-interieur-brut-reg-1990-2015 formaté.xls'
  DBMS = XLS REPLACE;
SHEET = 'PIB en valeur 1990-2015';
GETNAMES = YES;
RUN;


proc sort data= prelim.Class;
by weight descending height;
run;

proc sort data= prelim.Class;
by age height;
run;




DATA prelim.Classe_garcons; 
set prelim.Class (where=  (Sex = 'M'));
run;


DATA prelim.Classe_filles; 
set prelim.Class (where=  (Sex = 'F'));
run;


DATA prelim.Classe_entiere ;
set prelim.Classe_Garcons (rename =(Height=Taille_en_m) where =(Taille_en_m >= 160/2.54))
    prelim.Classe_filles (rename =(Height=Taille_en_m) where =(Age>=15));
Taille_en_m = Taille_en_m * 2.54;
RUN ;


DATA prelim.Classe_entiere (drop = Height)  ;
set prelim.Classe_Garcons
    prelim.Classe_filles; 
Taille_en_m = Height * 2.54;
RUN ;


proc sort data=prelim.Classe_Garcons;
by height age sex;
run;

proc sort data=prelim.Classe_filles;
by height age sex;
run;



data prelim.class_tri;
set prelim.Classe_Garcons
    prelim.Classe_filles;
run; 

data prelim.Classe_filles;
set prelim.Classe_filles (drop = sex); 
run;


data prelim.Classe_garcons;
set prelim.Classe_garcons (drop = sex); 
run;

data prelim.class_all;
set prelim.Classe_Garcons (In = genre)
    prelim.Classe_filles;
If genre = 1 then table_origine = "Garcons" ;
	else table_origine = "Filles" ;
run; 
