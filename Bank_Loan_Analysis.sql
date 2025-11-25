/*
-------------------------------------------------------------------------
PROJECT: Bank Loan Data Analysis
DATABASE: Bank Loan DB
AUTHOR: [Your Name]
TOOL: SQL Server (T-SQL)
-------------------------------------------------------------------------
*/

-------------------------------------------------------------------------
-- SECTION 1: KEY PERFORMANCE INDICATORS (KPIs)
-------------------------------------------------------------------------

-- 1. Total Loan Applications
SELECT COUNT(id) AS Total_Loan_Applications 
FROM bank_loan_data;

-- 2. MTD (Month-to-Date) Loan Applications (Assuming Dec is current month)
SELECT COUNT(id) AS MTD_Total_Loan_Applications 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- 3. PMTD (Previous Month-to-Date) Loan Applications (Nov)
SELECT COUNT(id) AS PMTD_Total_Loan_Applications 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- 4. Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data;

-- 5. MTD Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- 6. Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data;

-- 7. MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Collected 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- 8. Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate 
FROM bank_loan_data;

-- 9. MTD Average Interest Rate
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- 10. Average DTI (Debt-to-Income Ratio)
SELECT AVG(dti)*100 AS Avg_DTI 
FROM bank_loan_data;

-- 11. MTD Average DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;


-------------------------------------------------------------------------
-- SECTION 2: GOOD LOAN VS BAD LOAN ANALYSIS
-------------------------------------------------------------------------

-- A. GOOD LOANS (Fully Paid or Current)

-- 1. Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
    COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- 2. Good Loan Applications Count
SELECT COUNT(id) AS Good_Loan_Applications 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- 3. Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- 4. Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_Amount_Received 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


-- B. BAD LOANS (Charged Off)

-- 1. Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- 2. Bad Loan Applications Count
SELECT COUNT(id) AS Bad_Loan_Applications 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 3. Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 4. Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';


-------------------------------------------------------------------------
-- SECTION 3: LOAN STATUS GRID VIEW
-------------------------------------------------------------------------

SELECT
    loan_status,
    COUNT(id) AS LoanCount,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status;


-------------------------------------------------------------------------
-- SECTION 4: CHARTS & OVERVIEW (TRENDS)
-------------------------------------------------------------------------

-- 1. Monthly Trends (Issue Date)
SELECT 
    MONTH(issue_date) AS Month_Number, 
    DATENAME(MONTH, issue_date) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

-- 2. Regional Analysis (By State)
SELECT 
    address_state AS State, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;

-- 3. Loan Term Analysis
SELECT 
    term AS Term, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- 4. Employee Length Analysis
SELECT 
    emp_length AS Employee_Length, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC;

-- 5. Loan Purpose Breakdown
SELECT 
    purpose AS PURPOSE, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;

-- 6. Home Ownership Analysis
SELECT 
    home_ownership AS Home_Ownership, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;