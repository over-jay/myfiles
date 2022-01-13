PROC IMPORT OUT= WORK.TEST 
            DATAFILE= "C:\Users\overjay\Documents\magistereBFA\cours2020
\cours+TP\Cours1\data1\PIB_1990_2015_regions_diffusion _95.xls" 
            DBMS=EXCEL4 REPLACE;
     GETNAMES=YES;
RUN;
