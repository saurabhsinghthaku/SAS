/*mail split duplicate(JOINT ACCOUNTS) & no duplicate(SINGLE ACOONTS) data*/


LIBNAME Facta BASE "/WAREH/FACTA CRS/Target_Tables";

%macro Split_mail(data=);

proc sort data=Facta.&data out= sorted;
by Account Number,
run;

OPTIONS COMPRESS= YES , VALIDMEMNAME = EXTEND;

DATA Split_dup Split_non_dup;
SET sorted;
by Account Number,
if first Account Number & last Account Number then output Split_non_dup;
else output Split_dup;
RUN;

data Split_non_dup1 Split_non_dup2 Split_non_dup3 Split_non_dup4 Split_non_dup5 ;
set Split_non_dup nobs=k;
if _N_ <= 400000 then output Split_non_dup1;
else if _N_> 400000 and _n_<=800000 then output Split_non_dup2;
else if _N_> 800000 and _n_<=1200000 then output Split_non_dup3;
else if _N_> 1200000 and_n_<=1600000 then output Split_non_dup4;
else output Split_non_dup5;

RUN;

DATA NULL;
set Split_non_dup nobs-nobs;
CALL SYMPUTX('C_NO_DUP', nobs);
run;

DATA NULL;
set Split_dup nobs=kobs;
CALL SYMPUTX('C_DUP', kobs);
run;

%macro email();
proc export data=Split_dup
dbms=csv
outfile="/WAREH/whouse/FACTA_CRS/INDV_CRS_FINAL_DUPLICATE/&data._D
UPLICATE.csv"
dbms=dlm replace;
delimiter='|';
run;

%do i=1 %to 5;

proc export data-Split_non_dup&i.
dbms=csv
outfile="/WAREH/whouse/FACTA CRS/INDV_CRS_FINAL_DUPLICATE/&data._N
O_DUP&i..csv"
dbms-dlm replace;
delimiter='I';
run;
%end;

x '@echo off';
x 'cd /WAREH/whouse/FACTA_CRS/INDV_CRS_FINAL_DUPLICATE';
x "zip INDV_CRS_FINAL_DUPLICATE *";
x 'echo bye';

DATA NULL;
FILE SEND EMAIL
FROM = "fatcareporting@icicibank.com"
TO = (''saurabh.thakur@ext.icicibank.com"}
CC = (''saurabh.thakur@ext.icicibank.com')
BCC = ('saurabh.thakur@ext.icicibank.com')
SUBJECT = "&data. Duplicate";
PUT "Dear Team,";
PUT;


PUT;
PUT  "For &data., Count of NON_DUPLICATE records is &C_NO_DUP";

PUT "For &data., Count of DUPLICATE records is &C_DUP";

PUT;
PUT "Please find the below link to download files.";
PUT;

"http://sasebi94M6/whouse/FACTA_CRS/INDV_CRS_FINAL_DUPLICATE/INDV_CRS_FI
NAL_DUPLICATE.zip"

PUT;
PUT;

PUT "Thanks & Regards,";
PUT "FATCA/CRS Overseas Compliance";

PUT "*This is a system generated mail. Please don't reply to it* ";

RUN;

%mend;
%email;
%mend;

%Split_mail(data=INDV_CRS_FINAL);
%Split_mail(data=INDV_FREEZE_FINAL);
%Split_mail(data=INDV_FACTA FINAL);