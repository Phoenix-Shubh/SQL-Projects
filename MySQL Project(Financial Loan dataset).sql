create database Projects;
use Projects;
create table financial(id int, address_state text, application_type text, emp_length text, emp_title text, grade text, home_ownership text, issue_date text, last_credit_pull_date text, last_payment_date text, loan_status text, next_payment_date text, member_id int, purpose text, sub_grade text, term text, verification_status text, annual_income int, dti double, installment double, int_rate double, loan_amount int, total_acc	int, total_payment int)

select * from financial;

select count(id) as total_loan_applications from financial; #15051 customers total loan applications
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial; #amount disbursed in 2021
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial; #amount received back by bank
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM financial; #avg interest rate 
SELECT ROUND(AVG(int_rate),2)*100 AS Avg_Int_Rate FROM financial; #avg interest rate rounded off
SELECT AVG(dti)*100 AS Avg_DTI FROM financial; #debt to income ratio - whether loan should be given or not - financial health of the customer 
#dti should be 30-35% 
select loan_status from financial; #good loan - fully paid loan and current loan - good for bank 
#bad loan - charged off - defaulters bad for bank

SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM financial; #good loan percent 86%

SELECT COUNT(id) AS Good_Loan_Applications FROM financial
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'; #13k people 

SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM financial
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'; #good loan amount given by bank

SELECT SUM(total_payment) AS Good_Loan_amount_received FROM financial
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'; #good loan amount received by bank 

SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM financial; #bad load percent 

SELECT COUNT(id) AS Bad_Loan_Applications FROM financial
WHERE loan_status = 'Charged Off'; #bad loan applications - bank gave 1708 loans which became defaulters 

SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM financial
WHERE loan_status = 'Charged Off'; #this amount given by bank as bad loan investigation required - cibil score 

SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM financial
WHERE loan_status = 'Charged Off'; #only this much amt retreived back

SELECT loan_status, COUNT(id) AS LoanCount, SUM(total_payment) AS Total_Amount_Received, SUM(loan_amount) AS Total_Funded_Amount, AVG(int_rate * 100) AS Interest_Rate, AVG(dti * 100) AS DTI
FROM financial GROUP BY loan_status; 