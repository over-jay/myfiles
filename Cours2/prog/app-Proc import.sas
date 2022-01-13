/* PARTIE 1 */

Libname app2 'P:\magistereBFA\cours2021\datalib';

PROC IMPORT
  OUT = app2.CARS
  DATAFILE = 'P:\magistereBFA\cours2021\cours+TP\data\Application 2\Cars et report.xls'
  DBMS = XLS REPLACE;
SHEET = 'CARS';
GETNAMES = YES;
RUN;



PROC IMPORT
  OUT = app2.CARS2
  DATAFILE = 'C:\Users\overjay\Documents\CoursEXSAMA\Sas\cours+TP\Cours2\data\Cars et report.xls'
  DBMS = XLS REPLACE;
SHEET = 'CARS';
GETNAMES = YES;
RUN;









/* PARTIE 2A */


/*Création de CARCAR dans la librairie APP2*/
DATA app2.CARCAR;
  SET app2.CARS(KEEP=Make Model Type Origin DriveTrain);
RUN;

 /*Création de CARNUM dans la librairie APP2*/
DATA app2.CARNUM;
  SET app2.CARS(DROP=Make Model Type Origin DriveTrain);
RUN;

 
/*Création de sup_50 dans la librairie app2 qui contiendra les modèles dont le prix de vente conseillé est supérieur à 50 000$*/
DATA app2.sup_50;
  SET app2.CARS(WHERE=(MSRP > 50000));
RUN;













/* PARTIE 2B */


/*Création de 3 tables dans la librairie app2 qui contiendront les modèles selon les 3 origines géographiques*/

DATA app2.Asia app2.Europe app2.US;
  SET app2.CARS;
  if Origin = 'Asia' then output app2.Asia;
  if Origin = 'Europe' then output app2.Europe;
  if Origin = 'USA' then output app2.US;
RUN;












/*PARTIE 3A */


/*Création d'une table CARS_TRANS dans la librairie app2 qui contiendra les informations traduites de la variable DriveTrain*/
DATA app2.Cars_trans;
  SET app2.CARS;
  Format trans $25.;
  Label trans = 'Transmission de la voiture';
  if DriveTrain = 'Rear' then trans = 'Arrière';
  if DriveTrain = 'Front' then trans = 'Avant';
  if DriveTrain = 'ALL' then trans = 'Toutes';
  Drop DriveTrain;
RUN;


/*Création d'une table CARS_TRANS dans la librairie app2 qui contiendra les informations traduites de la variable DriveTrain*/
DATA app2.Cars_trans;
  SET app2.CARS;
  Format trans $25.;
  Label trans = 'Transmission de la voiture';
  if DriveTrain = 'Rear' then trans = 'Arrière';
  if DriveTrain = 'Front' then trans = 'Avant';
  if DriveTrain = 'All' then trans = 'Toutes';
  Drop DriveTrain;
RUN;





/*PARTIE 3B*/


/*Création de city_code et city_num*/
DATA app2.Cars_trans;
  SET app2.Cars_trans;
  Format City_code $2.;
  City_code = put(MPG_City,$2.);
  City_num = input(City_code,8.);
RUN;






/*Partie 4*/


/*Import des 3 reports FR, DE et UK*/

PROC IMPORT
  OUT = app2.Report_FR
  DATAFILE = 'P:\magistereBFA\cours2021\cours+TP\data\Application 2\Cars et report.xls'
  DBMS = XLS REPLACE;
SHEET = 'Report_FR inc';
GETNAMES = YES;
RUN;

PROC IMPORT
  OUT = app2.Report_DE
  DATAFILE = 'P:\magistereBFA\cours2021\cours+TP\data\Application 2\Cars et report.xls'
  DBMS = XLS REPLACE;
SHEET = 'Report_DE inc';
GETNAMES = YES;
RUN;


PROC IMPORT
  OUT = app2.Report_UK
  DATAFILE = 'P:\magistereBFA\cours2021\cours+TP\data\Application 2\Cars et report.xls'
  DBMS = XLS REPLACE;
SHEET = 'Report_UK inc';
GETNAMES = YES;
RUN;

/*Création de report_mond qui est la concaténation des 3 reporting avec une nouvelle Variable Country qui identifiera de quel bureau provient l'information*/
DATA app2.report_mond;
  SET app2.Report_FR  app2.Report_DE app2.Report_UK;
RUN;






DATA app2.report_mond;
  SET app2.Report_FR (in=fr) app2.Report_DE (in=de) app2.Report_UK;
  if fr = 1 then Country = 'FR';
  else if de = 1 then Country = 'DE';
  else Country = 'UK';
RUN;




/*Modification et tri du rapport français*/

DATA report_fr;
  SET app2.Report_FR;
  rename
   Constructeur = make
   Modele = Model
   nb_vente = sales_fr
   Stock = stock_fr
;
  label
   Constructeur = 'Make FR'
   Modele = 'Model FR'
   nb_vente = 'Sales FR'
   Stock = 'Stock FR'
;
RUN;

DATA report_fr2;
  SET app2.Report_FR;
  rename
   Constructeur = make
   Modele = Model
   nb_vente = sales
   Stock = stock
;
  label
   Constructeur = 'Make FR'
   Modele = 'Model FR'
   nb_vente = 'Sales FR'
   Stock = 'Stock FR'
;
RUN;

/*Tri de la table en vue de la fusion*/
PROC SORT;by make model;RUN;


/*Modification et tri du rapport allemand*/

DATA report_de;
  SET app2.Report_DE;
  rename
   Baumeister = make
   Modell = Model
   Verkauf = sales_de
   Stock = stock_de
;
  label
   Baumeister = 'Make DE'
   Modell = 'Model DE'
   Verkauf = 'Sales DE'
   Stock = 'Stock DE'
;
RUN;


DATA report_de2;
  SET app2.Report_DE;
  rename
   Baumeister = make
   Modell = Model
   Verkauf = sales
   Stock = stock
;
  label
   Baumeister = 'Make DE'
   Modell = 'Model DE'
   Verkauf = 'Sales DE'
   Stock = 'Stock DE'
;
RUN;

/*Tri de la table en vue de la fusion*/
PROC SORT;by make model;RUN;




/*Modification et tri du rapport anglais*/

DATA report_UK;
  SET app2.Report_UK;
  rename
   sales = sales_uk
   Stock = stock_uk
;
  label
   Make = 'Make UK'
   Modell = 'Model UK'
   Verkauf = 'Sales UK'
   Stock = 'Stock UK'
;

DATA report_UK2;
  SET app2.Report_UK;
  rename
   sales = sales
   Stock = stock
;
  label
   Make = 'Make UK'
   Modell = 'Model UK'
   Verkauf = 'Sales UK'
   Stock = 'Stock UK'
;


DATA report_mond;
  SET Report_FR2 (in=fr) Report_DE2 (in=de) Report_UK2;
  if fr = 1 then Country = 'FR';
  else if de = 1 then Country = 'DE';
  else Country = 'UK';
RUN;



RUN;
/*Tri de la table en vue de la fusion*/
PROC SORT data=report_mond;
by make model;
RUN;




RUN;
/*Tri de la table en vue de la fusion*/
PROC SORT;by make model;RUN;

/*Tri de la MASTER table en vue de la fusion*/
PROC SORT data=app2.Cars;by make model;RUN;







/*Tri de la table en vue de la fusion*/
PROC SORT data = report_FR;by make model;RUN;
PROC SORT data = report_DE;by make model;RUN;
PROC SORT data = report_UK;by make model;RUN;

/*FUSION des rapports avec la master table CARS*/
DATA app2.Report_Monde_Final;
  MERGE app2.CARS report_FR report_DE report_UK;
  by make model;
RUN;












/*PARTIE 6 */


/*Calcul des variables et identifications des valeurs manquantes*/

DATA app2.Report_Monde_Final_rich2;
  SET app2.Report_Monde_Final;
  if (sales_fr ne . and sales_de ne . and sales_uk ne .)
  then do;
   sales_euro_cont = put((sales_fr + sales_de), $20.);
   sales_world = put((sales_fr + sales_de + sales_uk), $20.);
  end;
  else do;
   sales_euro_cont = 'Données incomplètes';
   sales_world = 'Données incomplètes';
  end;
RUN;


DATA app2.Report_Monde_Final_rich;
  SET app2.Report_Monde_Final;
  if (sales_fr eq .) then sales_fr = 0;
  if (sales_de eq .) then sales_de = 0;
  if (sales_uk eq .) then sales_uk = 0;
  sales_euro_cont = sales_fr + sales_de;
  sales_world = sales_fr + sales_de + sales_uk;
RUN;




/*ETAPE 7 */


/*Création de 3 nouveaux modèles*/

DATA app2.NEW_CARS ;
format Make Origin $13.;
format Model $40.;
format Type $6.;
format DriveTrain $5.;
format MSRP Invoice DOLLAR21.2;
input Make $ Model $ Type $ Origin $ DriveTrain $ MSRP Invoice EngineSize Cylinders Horsepower MPG_City MPG_Highway Weight Wheelbase Length;
Cards;
Mercedes CL550_2dr Sedan Europe Rear 104820.00 93324.00 5 8 302 16 24 4085 114 196
Mercury Mountaineer_Road_2 SUV USA Front 39995.00 32317.00 4 6 210 16 21 4374 114 190
Scion xZ_4dr_hatch_core Sedan Asia Front 10000.00 8500.00 1.5 4 108 32 38 2340 93 154
;
RUN;





/*Concaténation des fichiers*/
DATA app2.Resume_NEW;
  SET app2.CARS app2.NEW_CARS;
RUN;
