%let anneesq = P:\magistereBFA\cours2021;
%include "&anneesq.\cours+TP\Cours1\prog\2-libname1.sas";


/*sans macro variables*/
PROC IMPORT
  OUT= Myln.data_importee /*nom_de_la_librairie.nom_de_ma_table*/
  DATAFILE= 'P:\magistereBFA\cours2021\cours+TP\Cours1\data\PIB_1990_2015_regions_diffusion.xls'
  DBMS=XLS REPLACE; /*Dans le cas d’un fichier xls*/
  SHEET= 'PIB en valeur 1990-2015' /*'nom_de_la_feuille_Excel_à_importer$' */;
  GETNAMES=YES ; /*Conserve les noms de colonnes stockés dans la première ligne du fichier Excel*/
RUN ; /*Instruction qui exécute les instructions qui précèdent*/


/*avec des macro variables*/
%let table_imp = data_importee;
%let xls_name = PIB_1990_2015_regions_diffusion.xls;
%let sheet_name = 'PIB en valeur 1990-2015';

PROC IMPORT
  OUT= &NOMLIBNAME..&table_imp. /*nom_de_la_librairie.nom_de_ma_table*/
  DATAFILE= "&ANNEESQ.\Cours+TP\Cours1\data\&xls_file."
  DBMS=XLS REPLACE; /*Dans le cas d’un fichier xls*/
  SHEET= &sheet_name. /*'nom_de_la_feuille_Excel_à_importer$' */;
  GETNAMES=YES ; /*Conserve les noms de colonnes stockés dans la première ligne du fichier Excel*/
RUN ; /*Instruction qui exécute les instructions qui précèdent*/


/*
%put _all_;
%put _user_;
*/
