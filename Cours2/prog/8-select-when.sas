 DATA reclassification ;
  set sashelp.Class;
  select (Sex) ;
    when ('F') cat='Female';	
    when ('M') cat='Male';	
  otherwise cat='Indefini' ;
end;
RUN ; 

 DATA reclassification ;
  set sashelp.Class;
  select ;
    when (Sex = 'F' and Age >= 15) Cat='Female';	
    when (Sex = 'F' and Age < 15) Cat='Young Female';	
    when (Sex = 'M' and Age >= 15) Cat='Male';	
    when (Sex = 'M' and Age < 15) Cat='Young Male';	
end;
RUN ; 

 DATA reclassification ;
  set sashelp.Class;
  select ;
    when (Sex = 'F' and Age < 15) Cat='Young Female';
	when (Sex = 'F' and Age >= 15) Cat='Female';	
    when (Sex = 'M' and Age >= 15) Cat='Male';	
    when (Sex = 'M' and Age < 15) Cat='Young Male';	
end;
RUN ; 
