DATA Classe_entiere;
set prelim.Class_all;
run;


data Note;
set classe_entiere (keep= Name weight);
call streaminit(123456); /*setseed - raproduire le hasard des ordre suivants*/
Note  = rand("Integer", 1, 20); /**/
run;

proc sort data = Note ;
by weight;
run;

DATA Notes_classe ;
  merge Classe_entiere Note ;
  by Name ;
RUN ; 

proc sort data = Note ;
by Name;
run;
proc sort data = Classe_entiere ;
by Name;
run;
DATA Notes_classe ;
  merge Classe_entiere Note ;
  by Name ;
RUN ; 

proc sort data = Class_garcons ;
by Name;
run;

data Class_garcons;
set classe_entiere (where =(table_origine = 'Garcons'));
run;


proc sort data = Class_garcons ;
by Name;
run;


DATA Notes_classe_g ;
  merge  Class_garcons Note ;/*l'ordre importe ... */
  by Name ;
RUN ;


DATA Notes_classe_g ;
  merge Note Class_garcons  ;/*l'ordre importe ... */
  by Name ;
RUN ; 

DATA Notes_classe_g ;
  merge Note Class_garcons (in = G) ;
  by Name ;
  if G;
RUN ; 



/*rattrapage*/

data Note_rattrapage;
set note   (keep= Name weight Note);
call streaminit(999999); 
Note_rattrapage  = rand("Integer", 1, 20);
if Note<10;
run;



DATA note_finale ;
  update Note note_Rattrapage ;
  by Name ;
RUN ; 


DATA Resultats_promo ;
 set Note_Finale;
 format result $10.;
  if note >= 10 then Result = "Validé";
	else Result = "Non validé" ;
RUN ;	


DATA LAUREAT ;
  set Note_Finale;
  if note >= 10 then Output ;
RUN ;

DATA Resultats_session1 ;
  set Note_finale;
  format result $10.;
  if note >= 10 then Result = "Validé";
      else if note >= 8 then Result = "Rattrapage";
         else Result = "Non validé" ;
RUN ;

DATA Resultats_session2 ;
  set Note;
  if note >= 8 and note < 10 then Result = "Rattrapage";
  if note >= 10 then Result = "Validé";
  if note < 8 then Result = "Non validé" ;
RUN ;

DATA Classe_entiere ;
set Classe_entiere ;
Poids = Weight * 0.454545;
Taille = (Height * 2.54)/100;
IMC = Poids / Taille**2;
Conclusion = cat('L étudiant a un IMC de ', round(IMC,0.1));
RUN;

DATA nouveaux_eleves ;
input Name : $12. Sex $ Age Height Weight ;
Cards;
Jean-Charles M 21 58.645 102.786
Mathilde F 19 52.5 100
;
RUN;

DATA loi_normale  ;
	Do i = 1 to 100 ;
	x = rannor(0);
	End ;

	/*   ****   */
RUN;


DATA cumul_table ;
set sashelp.Class ;
retain cumul 0 ;
cumul = cumul + 1 ;
RUN;
