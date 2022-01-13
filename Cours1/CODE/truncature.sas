/*DATA exemple.toto;*/
/*DATA toto;*/
/*DATA work.toto;*/
/*DATA exemple ;*/
DATA work.toto ;
  set sashelp.class;
RUN;

DATA nOUVel_eleve ;
  name = 'Jean-Charles' ;
  Sex = 'M' ;
  Age = 21 ;
  Height = 58.645 ;
  Weight = 102.786 ;	
run ;


DATA class ;
  set toto nouvel_eleve ;
RUN ;


DATA class_ok ;
  set nouvel_eleve toto ;	
RUN ;
