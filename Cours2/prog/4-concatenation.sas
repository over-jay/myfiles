data Class_Filles Class_Garcons;
set sashelp.class;
if sex = 'M' then output Class_Garcons;
if sex = 'F' then output Class_Filles;
run;

DATA Classe_entiere ; 
	set Class_Filles Class_Garcons ;
run;

		PROC SORT data =Classe_entiere;
	by Sex Age; RUN ;


	DATA Classe_entiere_lim ; 
set Class_Garcons ( where =(height >= 160/2.54))
  Class_filles ( where =(Age>=15));
Taille_en_m = height * 2.54; 
run;

DATA Classe_entiere_lim_2 ; 
set Class_Garcons (
rename =(Height=Taille_en_m) where =(Taille_en_m >= 160/2.54))
  Class_filles (
rename =(Height=Taille_en_m) where =(Age>=15));
Taille_en_m = Taille_en_m * 2.54; 
run;




DATA Classe_entiere ;
  set Class_Garcons ( In = Type)  Class_filles ;
If Type = 1 then table_origine = "Garcons" ;
else table_origine = "Filles" ;
RUN ; 
