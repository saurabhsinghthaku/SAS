/*NPOs or charities receiving funds from India or abroad and trasnsferring the same to a*/
/*number of domestic and foreign beneficiaries*/
/**/
/*Rule Details:-*/
/*to identity NPOs and Charities use NPOs cust type (tac = NPOs)*/
/**/
/*Level1: First check if the NPOs or charities are deposit over a certain frequency and*/
/*sum of amount over the last 4 days is more than threshold amount*/
/**/
/*Level2:- then if these account are withdrawing 80%-95% of this amount in the last 4*/
/*days*/
/**/
/*Thresholds:-*/
/*Frequency of deposit:- 20-30*/
/*sum of deposit amount in last 4 days:- 2500000-3200000*/
/**/
/*QUERY IN MS SQL---*/

with ctel as (
Select tbl_transac. acctno,
count(*) as frequency,
where tbl transac.transactiondatetime
between '28-JUN-22' and '01-JUL-22
and tbl transac.depositorwithdra = 'D' and tbl_transac.custtype in
10
(A5,B5,C5,D5','E5,F5, G5','H5','15','15','K5',
'M5','N5,05,'P5, Q5','R5','S5, T5,'U5','A6','B6','C6','D6','E6','F6','G6')
group by tbl_transac.acctno
having count(*) >= 25
and sum(tbl_transac.amount) >= 2500000
),
cte2 as (
Select cte1.acctno,
cte1.frequency,
cte1.DepositAmt,
sum(tbl_transac.amount)
sum(tbl_transac.amount) as Withdrawal Amount
from cte1
join tbl_transac
on ctelacctno = tbl_transac.acctno
as DepositArt from tbl_transac
where tbl_transac.transacdatetime between '28-JUN-22' and'01-JUL-22¹
and tbl transac.depositorwithdra = "W"
group by cte1.acctno,
cte1.frequency,
cte1.DepositAmt
)

Select count(*) as alertCount
from cte2
where WithdraAmount/DepositAmt >= .85


 