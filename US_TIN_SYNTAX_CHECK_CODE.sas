/*TIN SYTAX CHECK*/

OPTIONS COMPRESS= YES, VALIDVARNAMR=V7;

DATA US_DESRCREPANCY_DATA OTHER_DECRIPANCY_DATA ;
SET &EXTRACT_REC. ;


C_TinVAL = strip (compress(compress (TinVAL,,'s'), '/\-'));

C_TinVAL1= strip (compress (compress (TinVAL1,, 's'), '/\-.'));

C_TinVAL2= strip (compress (compress (TinVAL2,,'s'), '/\-.'));

C_TinVAL3= strip(compress(compress (TinVAL3,,'s'), ' /\-.'));

C_TinVAL4 = strip (compress (compress (TinVAL4,,'s'), '/ \-.');

if (strip (TinlssueCountry)= 'US' and length (C_TinVAL) ne 9)
or (strip (TinlssueCountry)= 'US' and length(compress (C_TinVAL,, 'kd')) ne 9)
or (strip (TinlssueCountry)= 'US' and substr(compress (C_TinVAL,,'kd'), 1,3) eq '000') then tin_US = 1;

if(strip (TinlssueCountry1)= 'US' and length (C_TinVAL1) ne 9)
or (strip (TinlssueCountry 1) = 'US' and length(compress (C_TinVAL1,,'kd')) ne 9)
or (strip(TinlssueCountry1) = 'US' and substr(compress (C_TinVAL1,,'kd'), 1,3) eq '000') then tin_US1 = 1;

if(strip (TinlssueCountry2)='US' and length (C_TinVAL2) ne 9) 
or (strip (TinlssueCountry2) = 'US' andlength(compress (C_TinVAL2,,'kd')) ne 9)
or (strip (TinIssueCountry2)= 'US' and substr(compress (C_TinVAL2,,'kd'), 1,3) eq '000') then tin_US2 = 1;

if(strip (TinlssueCountry3)= 'US' and length(C_TinVAL3) ne 9)
or (strip (TinlssueCountry3) = 'US' and length(compress (C_TinVAL3,,'kd')) ne 9) 
or (strip (TinlssueCountry3) = 'US' and substr(compress (C_TinVAL3,,'kd'), 1,3) eq '000') then tin_US3 = 1;

if (strip (TinlssueCountry4)= 'US' and length (C_TinVAL4) ne 9)
or (strip (TinlssueCountry4) = 'US' and length(compress (C_TinVAL4,,'kd')) ne 9) 
or (strip (TinlssueCountry4) = 'US' and substr(compress (C_TinVAL4,,'kd'), 1,3) eq '000') then tin_US4 = 1;

if sum(tin_US,tin_US1,tin_US2,tin_US3,tin_US4) >= 1 then
output US_DESCRIPENCY_DATA;
