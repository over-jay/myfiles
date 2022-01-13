DATA TABLE;
FORMAT y comma9.4;
FORMAT x 4.2;
format z 5.0;
format t DOLLAR18.7;
x="10000.123456";
y=x;
z=y;
t=z;
PUT x= y= z= t=;
run;



data fr_en;
format eg_english comma9.2
eg_semifrench commax9.2
eg_french   nlnum12.2;
eg_english=100987.24;
eg_semifrench=100987.24;
eg_french=100987.24;
put eg_french eg_semifrench eg_english;
run;
