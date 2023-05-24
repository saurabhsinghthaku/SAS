/*INDIAN PAN SYNTAX CHECK*/


(LENGTH("PAN"n)=10 & prxmatch('/^[A-Z]{5}[0-9]{4}([A-Z]{1})\s*$/', STRIP("PAN"n))) | (LENGTH("PAN"n)=10 & prxmatch('/^[a-z]{5}[0-9]{4}([a-z]{1})\s*$/', STRIP("PAN"n))) |
"PAN"n= "FORM 60" | "PAN"n="FORM60" | "PAN"n = "DUMMY" | "PAN"n=''