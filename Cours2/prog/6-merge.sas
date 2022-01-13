data Note;
set classe_entiere (keep= Name weight);
call streaminit(123456); 
Note  = rand("Integer", 1, 20);
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

data Note_rattrapage (drop=Note  rename=(Note_rattrapage=Note)) ;
set note   (keep= Name  Note);
call streaminit(999999); 
Note_rattrapage  = rand("Integer", 1, 20);
if Note<10;
run;

proc means data= Note mean;
var Note;
run;

DATA note_finale ;
  update Note note_Rattrapage ;
  by Name ;
RUN ; 

proc means data= note_finale mean;
var Note;
run;
