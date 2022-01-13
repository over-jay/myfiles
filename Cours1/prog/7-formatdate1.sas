
DATA DATETEST;
x="29JAN1980"d; y="29JAN1980"d;
z=y;
t=z;
FORMAT x WORDDATX20.;
FORMAT y DATE9.;
format z DDMMYY8.;
format t DDMMYY10.;
PUT x= y= z= t=;
RUN;
	
