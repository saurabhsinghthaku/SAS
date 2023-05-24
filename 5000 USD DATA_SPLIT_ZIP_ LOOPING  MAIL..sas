/*5000 USD, ZIP, LOOP IN MAIL.*/

LIBNAME Facta BASE "/WAREHOUSE/FACTA_CRS/Target_Tables";


%let target_tbl_int=Facta.fatca_50k;

%let target_tbl = FACTA.INDV_FATCA_50K_SEG;

data &target tbl.;

set &target_tbl_int.;
ReportSerial Number = _N_;
drop Remark1 Remark2 Remark3 Untitled95 Untitled 96 AccountOpening Date CustomerSegm
ConstitutionSegment NRIFlag unique concate pivot flag
last year_rec_inc
;
run;

options mprint mlogic symbolgen;

proc sql;
select count(*)/75000 into: cut_point from &target_tbl.;
quit;

%macro driopper;
data_50_K_DATA:
set &target_tbl. nobs=nobs;
pivot flag=ceil(_n/(nobs/&cut_point));
RUN;
%mend;
%driopper;

proc sql;
select distinct
pivot_flag,
count(distinct pivot_flag) into: flg1-,: flg_cnt from 50_K_DATA_;
quit;

%macro email;

%do j=1 %to &fig_cnt. ;

data_50_K_DATA_&&flg&j ;
set_50_K_DATA;
where pivot_flag=&&flg&j ;
run;

proc export data=_50_K_DATA_&&flg&j (drop=pivot_flag)
dbms=csv
outfile="/WAREHOUSE/FACTA_CRS/Output Files/Final Reporting_Month/INDV_FATCA/INDV_FATCA_50K_&&flg&j...csv"

dbms=dlm replace;
delimiter='|';
run;

x"zip
WAREHOUSE/FACTA CRS/Output_Files/Final Reporting_Month/INDV_FATCA/INDV_FATCA_5
OK_&&flg&j..  WAREHOUSE/FACTA CRS/Output_Files/Final Reporting Month/INDV_FATCA/INDV_FATCA_5OK_&&flg&j...csv";

%end;

%do m=1 %to &flg_cnt ;
FILENAME
SENDING&&flg&m.. EMAIL;
DATA NULL;
FILE SENDING&&flg&m..
FROM = ("reporting@icicibank.com")
TO = ('saurabh.thakur@ext.icicibank.com')
CC= ('saurabh.thakur@ext.icicibank.com')
/*TO = ('saurabh.thakur@ext.icicibank.com')*/
BCC = ('saurabh.thakur@ext.icicibank.com')
SUBJECT = "US 50000 Data &&flg&m.."

ATTACH=
("/WAREHOUSE/FACTA CRS/Output_Files/Final Reporting_Month/INDV_FATC
A/INDV_FATCA 50K &&flg&m...zip" CONTENT_TYPE="application/zip"
ext="zip");

PUT "Dear Team,";

PUT "We have analyzed the US 50000 Data.Request you to kindly look
into it and rectify the same.";

PUT "Thanks & Regards,";

PUT "FATCA/CRS Cor liance Team";

RUN;

%end;

%mend;

%email;