 DATA Class_5 ;
  set sashelp.Class (firstobs = 2 obs = 4 ) ;	
RUN ;


	DATA Class_yngM ;
  set sashelp.Class ; 	
   where Age < 15 ;	
	  where Sex = "M" ;
RUN ; 

 DATA Class2;
  set Class_5 ;
un = 1;
n = _N_;
Nom = Name;
RUN ;	
