
DATA Resultats_promo ;
  set Note_Finale;
  if note >= 10 then Result = "Valid�";	
else Result = "Non valid�" ;
RUN ; 


DATA Resultats_promo_2 ;
format Result $40.;
  set Note_Finale;
  if note >= 10 then Result = "Valid�";	
else Result = "Non valid�" ;
RUN ; 




DATA Valide_promo ;
  set Note_Finale;
  if note >= 10 then Output ;	
RUN ; 




DATA Resultats_session1 ;
  set Note;
  if note >= 10 then Result = "Valid�";	
else if note >= 8 then Result = "Rattrapage";	
else Result = "Non valid�" ;
RUN ;

DATA Resultats_session1 ;
  set Note;
  if note >= 8 and note < 10 then Result = "Rattrapage";
  if note >= 10 then Result = "Valid�";	
  if note < 8 then Result = "Non valid�" ;
RUN ; 
