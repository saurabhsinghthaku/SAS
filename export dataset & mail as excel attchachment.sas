
/*post code to export as excel & mail sent*/

PROC EXPORT DATA=Facta.D_NIC_C1_TIN_US
OUTFILE='/WAREHO/FACTA/Output_Fil/Defeiles/D_NIC_C1_TIN_US.xlsx'
DBMS XLSX
replace;

run;

DATA NULL;
FILE SEND EMAIL
FROM = "saurabh.thakur@gmail.conm"
TO = "saurabh.thakur@gmail.conm"
SUBJECT = "C1 (entity with substantial owners outside India and US) instead of
F2 (entity with substantial US owners)"
ATTACH=
("/WAREHO/FACTA/Output_Fil/Defeiles/Discrepant_DATA/NONINDIVIDUAL/NONINDV_C1_TIN_US.xlsx" CONTENT_TYPE="application/excel" ext="xlsx");
PUT "Dear Team,";
PUT "Thanks & Regards,
PUT "FATCA/CRS Compliance Team";
RUN;