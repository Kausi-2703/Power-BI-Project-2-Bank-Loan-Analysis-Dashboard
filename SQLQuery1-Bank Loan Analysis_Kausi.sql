select *from bank_loan_data

---- Count of Total Loan Application
select count(id) as Total_Loan_Applications from bank_loan_data

----- Count of MTD for Total Loan Application

select count(id) as MTD_Total_Loan_Applications from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021

----- Count of PMTD for Total Loan Application

select count(id) as PMTD_Total_Loan_Applications from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021

---(MTD-PMTD)/PMTD=MOM(MONTH ON MONTH)

---- Total Funded amount (Loan provided to the customers on entire year)
select sum(loan_amount) as Total_Funded_Amount from bank_loan_data

-----Total Funded Amount(MTD-Latest month)

select sum(loan_amount) as MTD_Total_Funded_Amount from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021

------Total Funded amount(PMTD-Previous month)

select sum(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021

----- Total Payment Received

select sum(total_payment) as Total_Amount_Received from bank_loan_data

-----Total payement received(MTD)

select sum(total_payment) as MTD_Total_Amount_Received from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021

-----Total payement received(PMTD)

select sum(total_payment) as PMTD_Total_Amount_Received from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021

----- Average Interest Rate

select round (avg (int_rate),4) *100 as Avg_Interest_Rate from bank_loan_data

----- Average Interest Rate(MTD)

select round (avg (int_rate),4) *100 as MTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date)=12 and year(issue_date)=2021

----- Average Interest Rate(PMTD)

select round (avg (int_rate),4) *100 as PMTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date)=11 and year(issue_date)=2021

----- DBI

select round(avg(dti),4) *100 as Avg_DTI from bank_loan_data

---- DBI(MTD)

select round(avg(dti),4) *100 as MTD_Avg_DTI from bank_loan_data
where month (issue_date)=12 and year(issue_date)=2021

---- DBI(PMTD)

select round(avg(dti),4) *100 as PMTD_Avg_DTI from bank_loan_data
where month (issue_date)=11 and year(issue_date)=2021

----Good Loan Percentage

select
(count(case when loan_status= 'Fully paid' or loan_status ='Current' then id end)*100)
/
count(id) as Good_Loan_Percentage
from bank_loan_data

----Good Loan Applications

select count(id) as Good_Loan_Applications from bank_loan_data
where loan_status='Fully paid' or loan_status='Current'

-----Good loan funded Applications

select sum(loan_amount) as Good_Loan_Funded_Amount from bank_loan_data
where loan_status='Fully paid' or loan_status='Current'

----- Good loan total amount Received

select sum(total_payment) as Good_loan_Received_amount from bank_loan_data
where loan_status='Fully paid' or loan_status='Current'

---- Bad loan percentage
select
(count(case when loan_status= 'Charged Off' then id end )*100.0)
/
count(id) as Bad_Loan_Percentage
from bank_loan_data

---- Bad loan application

select count(id) as Bad_Loan_Applications from bank_loan_data
where loan_status='Charged Off'

----- Bad loan funded amount

select sum(loan_amount) as Bad_Loan_Funded_Amount from bank_loan_data
where loan_status='Charged Off'

----- Bad loan Total Amount Received

select sum(total_payment) as Bad_Loan_Amount_Received from bank_loan_data
where loan_status='Charged Off'

----Loan Status Grid Query

select
 loan_status,
 count(id) as Total_Loan_Applications,
 sum(total_payment) as Total_Amount_Received,
 sum(loan_amount) as Total_Funded_Amount,
 avg(int_rate* 100) as Interest_Rate,
 avg(dti*100) as DTI

 from bank_loan_data
 group by loan_status

 ----Loan Status Grid Query over MTD

 select
 loan_status,
 sum(total_payment) as MTD_Total_Amount_Received,
 sum(loan_amount) as MTD_Total_Funded_Amount
 from bank_loan_data

 where month(issue_date)=12
 group by loan_status

 ---- Montly Trend by Issue Data Query

 select
   month(issue_date) as month_number,
   datename (month,issue_date) as month_name,
   count(id) as Total_Loan_Applications,
   sum(loan_amount) as Total_Funded_Amount,
   sum(total_payment) as Total_Received_Amount

from bank_loan_data
group by month(issue_date) ,datename(month,issue_date)
order by month(issue_date)

-----Regional Analysis by State Query

select
address_state,
count(id) as Total_Loan_Applications,
   sum(loan_amount) as Total_Funded_Amount,
   sum(total_payment) as Total_Received_Amount
   from bank_loan_data
group by address_state
order by address_state

-----Loan Term Query

select
term,
count(id) as Total_Loan_Applications,
   sum(loan_amount) as Total_Funded_Amount,
   sum(total_payment) as Total_Received_Amount
   from bank_loan_data
group by term
order by term

----- Employee length

select
emp_length,
count(id) as Total_Loan_Applications,
   sum(loan_amount) as Total_Funded_Amount,
   sum(total_payment) as Total_Received_Amount
   from bank_loan_data
group by emp_length
order by emp_length

---Loan Purpose Query

select
purpose,
count(id) as Total_Loan_Applications,
   sum(loan_amount) as Total_Funded_Amount,
   sum(total_payment) as Total_Received_Amount
   from bank_loan_data
group by purpose
order by purpose

-----Home Ownership Analysis Query
select
home_ownership,
count(id) as Total_Loan_Applications,
   sum(loan_amount) as Total_Funded_Amount,
   sum(total_payment) as Total_Received_Amount
   from bank_loan_data
group by home_ownership
order by home_ownership


