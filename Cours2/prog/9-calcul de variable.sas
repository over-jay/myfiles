 DATA Classe_entiere ;
set Classe_entiere ;
Poids = Weight * 0.454545;
Taille = (Height * 2.54)/100;
IMC = Poids / Taille**2;
Conclusion = cat('L étudiant a un IMC de ', round(IMC,0.1));
RUN; 





DATA nouveaux_eleves ;
input Name $12. Sex $ Age Height Weight ;
Cards;
Jean-Charles M 21 58.645 102.786
Mathilde     F 19 52.5 100
;
RUN;




DATA loi_normale ;
	Do i = 1 to 100 ;
	x = rannor(0);
	Output ;
	End ;
RUN;


 DATA cumul ;
set sashelp.Class ;
retain cumul 0;
cumul = cumul + 1 ;
RUN; 

