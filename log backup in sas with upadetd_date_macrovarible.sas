/*precode of job, taking log file*/

data _null;
logdt=put(date(),date9.);
logtm=put(time(),timeampm10.);
logtm=tranwrd (logtm,",'_');
logfilenm='D_NIC_C1_TIN_US'||||strip (logdt)||strip (logtm) ||'.|
og';
call symputx('logfilenm',logfilenm);
run;
/*%put &logfilenm;*/
filename logfile
"/WAREH/FACTA/Logs/&logfilenm";
proc printto log=_logfile new;
run;