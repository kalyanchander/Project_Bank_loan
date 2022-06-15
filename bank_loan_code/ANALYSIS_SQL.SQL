--1.Calculate the total loan amount for gender = 'female' and loan limit='cf'.
select sum(loan_amount) as Total_loan_amount from loan where GENDER='Female' and LOAN_LIMIT='cf';

-----------------------------------------------------------------------------------------------------------------------------

--2. What is the difference in percentage for the number of loans between different valid genders.
SELECT gender, count(ID) * 100.0 / sum(count(ID)) Over() as Percentage
FROM Loan
GROUP BY gender;

-----------------------------------------------------------------------------------------------------------------------------

--3. What is the difference in percentage of approval in advance between business and commercial loan.
SELECT BUSINESS_OR_COMMERCIAL, count(APPROV_IN_ADV) * 100.0 / sum(count(APPROV_IN_ADV)) Over() as Percentage
FROM Loan
GROUP BY BUSINESS_OR_COMMERCIAL;

-----------------------------------------------------------------------------------------------------------------------------

--4. Is there any lumpsum pay for business loan?
Select count(LUMP_SUM_PAYMENT) from loan where LUMP_SUM_PAYMENT='lpsm' and BUSINESS_OR_COMMERCIAL='b/c';

-----------------------------------------------------------------------------------------------------------------------------

--5. average credit score for various age groups?
select age,avg(credit_score) from loan group by Age order by age;

-----------------------------------------------------------------------------------------------------------------------------