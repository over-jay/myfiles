
DATA Resultats_promo ;
  set Note_Finale;
  if note >= 10 then Result = "Validé";	
else Result = "Non validé" ;
RUN ; 


DATA Resultats_promo_2 ;
format Result $40.;
  set Note_Finale;
  if note >= 10 then Result = "Validé";	
else Result = "Non validé" ;
RUN ; 




DATA Valide_promo ;
  set Note_Finale;
  if note >= 10 then Output ;	
RUN ; 




DATA Resultats_session1 ;
  set Note;
  if note >= 10 then Result = "Validé";	
else if note >= 8 then Result = "Rattrapage";	
else Result = "Non validé" ;
RUN ;

DATA Resultats_session1 ;
  set Note;
  if note >= 8 and note < 10 then Result = "Rattrapage";
  if note >= 10 then Result = "Validé";	
  if note < 8 then Result = "Non validé" ;
RUN ; 
