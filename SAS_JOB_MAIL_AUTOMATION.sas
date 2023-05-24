LIBNAME Facto BASE "/WAREH/FACTA_CRS/Target_Tables";
data new;
set FACTA INDV_DOB;
WHERE CustomerSegment in (GB','PB', 'GS','TS') OR (CustomerSegment in ('NFC',
'NS','Z','CE') and NR flag = 'N');
run;

options mprint mlogic symbolgen;

proc sql;
select count(*)/75000 into: cut point from new;
quit;

%macro driopper;
data INDV INCORRECT_FRMT_US_TIN_demo;
set new nobs=nobs;
pivot_flag-ceil(_n/(nobs/&cut_point));
RUN;

%mend;

%driopper;

proc sql;
select distinct pivot flag, count(distinct pivot_flag) into: fig1-,: flg_cnt from
INDV_INCORRECT_FRMT_US_TIN_demo;
quit;

%macro email;

%do i=1 %to &flg_cnt;

data INDV_INCORRECT_FRMT_US_TIN_&&flg&i;
set INDV_INCORRECT FRMT_US_TIN_demo;
where pivot_flag=&&flg&i;
run;

proc export data=INDV_INCORRECT_FRMT_US_TIN_&&flg&i
outfile="/WAREH/FACTA CRS/Output_Files/Discrepant_DATA/INDIVIDUAL/INDV
_DOB/Condition_2/INDV_DOB&&flg&i...xlsx"
dbms=xlsx 
replace;
run;
%end;

x'@echo off';
x 'cd
/WAREH/FACTA CRS/Output_Files/Discrepant_DATA/INDIVIDUAL/INDV_DOB/C
ondition_2';
x "zip -P fatca2022 -r INDV_DOB.zip *";
x 'echo bye';

%do j= 1 %to &flg_ant;

DATA NULL;

FILE SEND EMAIL

FROM = " saurabh.thakur@ext.icicibank.com"
TO="saurabh.thakur@ext.icicibank.com"

CC = ("saurabh.thakur@ext.icicibank.com")

BCC=" saurabh.thakur@ext icicibank.com

SUBJECT = "Savings Product Team - DOB is 1905 or earlier"
ATTACH=
("/WAREH/FACTA_CRS/Output Files/Discrepant_DATA/INDIVIDUAL/INDV_DOB/
Condition_2/INDV_DOB.zip");

PUT "Dear Team,";
PUT "Thanks & Regards,";
PUT "Compliance Team";
RUN;
%END;

%mend;

%email;
