/*data session;*/
/*infile "C:\Users\saurabh singh thakur\OneDrive\Desktop\session (2).txt" delimiter="09"x;*/
/*input userid$1. date@   ;*/
/*run;*/

/*PROBLEM*/
/*Calculate each user's average session time.*/
/*A session is defined as the time difference between a page_load and page_exit. */
/*For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, */
/*consider only the latest page_load and earliest page_exit. Output the user_id and their average session time.*/



proc import datafile='C:\Users\saurabh singh thakur\Downloads\session2.txt'
     out=sessions
     dbms=dlm
     replace;
     delimiter='09'x;
     datarow=5;
run;

DATA page_load page_exit;
set sessions;
if remarks = 'page_load' then output page_load;
if remarks = 'page_exit' then output page_exit;

run;

proc sql;
/*select * from sessions order by USERID;*/
create table x1 as 
select distinct USERID,remarks,datepart(datetime,'anydtdtm19.') as date_page_load format date9.,
max(datetime) as max_d_load format anydtdtm16. 
from page_load 
group by USERID,  date_page_load  order by USERID,date_page_load;

create table x2 as 
select distinct USERID,remarks,datepart(datetime,'anydtdtm19.') as date_page_exit format date9.,
min(datetime) as max_d_exit format anydtdtm16. 
from page_exit 
group by USERID,  date_page_exit  order by USERID,date_page_exit;

QUIT;





proc sql;
select * from x1;
select * from x2;
quit;


proc sql;
select x1.userid, intck('second',x1.max_d_load,x2.max_d_exit ) as duration , mean(calculated duration) as average_duration
from x1  
inner join
x2  on x1.userid=x2.userid and x1.date_page_load=x2.date_page_exit
group by x1.userid
;
quit;


/**** check all content of floder & extract csv ********/

%let mydir=D:\SAS\;                                                                                                          
   

 
%macro mymac(fname,dsname);                                                                                                   
                                                                                                                                        
proc import datafile="&mydir\&fname" out=&dsname                                                                                        
dbms=csv replace;                                                                                                                       
getnames=yes;                                                                                                                           
run;                                                                                                                                    
                                                                                                                                        
%mend;                                                                                                                                  
                                                                                                                                        
filename myfiles pipe "dir &mydir /T:C";                                                                                                 
/*filename myfiles pipe "dir &mydir /b/s";*/
/*filename myfiles pipe "dir &mydir |  '.csv' /T:C";*/

 
data _null_;                                                                                                                            
  infile myfiles truncover;   
/*  infile Unix_com pipe "ps -e|grep 'sas'";*/
  input;                                                                                                                               
/*  if index(lowcase(_infile_),'.csv') then do;                                                                                        */
/*  date=substr(_infile_,1,10);                                                                                    */
/*    fname=substr(_infile_,37);                                                                                                                   */
/*    dsname=compress(tranwrd(strip(scan(fname,1,'.')),'_',' '),,'p');                                                                */
/*    dsname=tranwrd(strip(dsname),' ','_');                                                                                              */
/*    if intck('year',date,today(),’c’)<1 then do;                                                                                          */
/*      call=cats('%mymac(',fname,',',dsname,')');                                                                                        */
/*      call execute(call);                        (10)                                                                                       */
/*    end;                                                                                                                                */
/*  end;*/
  put _infile_;
/*  put date =;*/
/*  put fname =;*/
run;

/*********************check only csv files in folder*****************/

%let mydir=D:\SAS\*.csv;                                                                                                          
   

 
%macro mymac(fname,dsname);                                                                                                   
                                                                                                                                        
proc import datafile="&mydir\&fname" out=&dsname                                                                                        
dbms=csv replace;                                                                                                                       
getnames=yes;                                                                                                                           
run;                                                                                                                                    
                                                                                                                                        
%mend;                                                                                                                                  
                                                                                                                                        
filename myfiles pipe "dir &mydir /T:C";                                                                                                 
/*filename myfiles pipe "dir &mydir /b/s";*/
/*filename myfiles pipe "dir &mydir |  '.csv' /T:C";*/

 
data _null_;                                                                                                                            
  infile myfiles truncover;   
/*  infile Unix_com pipe "ps -e|grep 'sas'";*/
  input;                                                                                                                               
/*  if index(lowcase(_infile_),'.csv') then do;                                                                                        */
/*  date=substr(_infile_,1,10);                                                                                    */
/*    fname=substr(_infile_,37);                                                                                                                   */
/*    dsname=compress(tranwrd(strip(scan(fname,1,'.')),'_',' '),,'p');                                                                */
/*    dsname=tranwrd(strip(dsname),' ','_');                                                                                              */
/*    if intck('year',date,today(),’c’)<1 then do;                                                                                          */
/*      call=cats('%mymac(',fname,',',dsname,')');                                                                                        */
/*      call execute(call);                        (10)                                                                                       */
/*    end;                                                                                                                                */
/*  end;*/
  put _infile_;
/*  put date =;*/
/*  put fname =;*/
run;

















