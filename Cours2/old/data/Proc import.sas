PROC IMPORT OUT= APP2.Report_DE 
            DATAFILE= "D:\Dauphine\Cours\base\Application 2\Cars et repo
rt.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="'report_de inc$'"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
