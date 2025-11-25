<h1>🏦 Bank Loan Report – SQL Project</h1>

<p>
  This project focuses on <strong>SQL-based analysis</strong> of bank loan data to uncover insights about loan applications, funding, repayments, and borrower characteristics.
  It includes a full set of queries to calculate KPIs, analyze performance, and summarize results for visualization.
</p>

<hr/>

<h2>📘 Table of Contents</h2>
<ol>
  <li>Project Overview</li>
  <li>Database Details</li>
  <li>KPI Queries</li>
  <li>Loan Performance Analysis</li>
  <li>Loan Status Summary</li>
  <li>Report Overview</li>
  <li>Filters & Custom Queries</li>
  <li>Output Snapshots</li>
  <li>Key Insights</li>
  <li>Tools Used</li>
</ol>

<hr/>

<h2 id="project-overview">🧾 Project Overview</h2>

<p><strong>Goal:</strong> To analyze and monitor the performance of bank loans using SQL queries that calculate:</p>
<ul>
  <li>Loan KPIs (applications, funding, repayments)</li>
  <li>Average interest rate and DTI ratios</li>
  <li>Good vs bad loan performance</li>
  <li>Loan distribution across states, purposes, and terms</li>
</ul>

<hr/>

<h2 id="database-details">🗃️ Database Details</h2>

<p><strong>Table Name:</strong> <code>bank_loan_data</code></p>

<table>
  <thead>
    <tr><th>Column</th><th>Description</th></tr>
  </thead>
  <tbody>
    <tr><td>id</td><td>Unique Loan ID</td></tr>
    <tr><td>issue_date</td><td>Date of Loan Issuance</td></tr>
    <tr><td>loan_amount</td><td>Total loan amount</td></tr>
    <tr><td>total_payment</td><td>Total payment received</td></tr>
    <tr><td>int_rate</td><td>Interest rate</td></tr>
    <tr><td>dti</td><td>Debt-to-Income ratio</td></tr>
    <tr><td>loan_status</td><td>Loan status (Fully Paid, Charged Off, etc.)</td></tr>
    <tr><td>address_state</td><td>Borrower’s state</td></tr>
    <tr><td>emp_length</td><td>Employment length</td></tr>
    <tr><td>term</td><td>Loan term (e.g., 36 or 60 months)</td></tr>
    <tr><td>purpose</td><td>Loan purpose</td></tr>
    <tr><td>grade</td><td>Loan grade</td></tr>
    <tr><td>home_ownership</td><td>Home ownership type</td></tr>
  </tbody>
</table>

<hr/>

<h2 id="kpi-queries">📊 KPI Queries</h2>

<h3>Total Funded Amount</h3>
<pre><code class="language-sql">SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data;
</code></pre>
<img class="img" src="./images/Total Funded Amount.png" alt="Total Funded Amount"/>

<h3>Total Amount Received</h3>
<pre><code class="language-sql">SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data;
</code></pre>
<img class="img" src="./images/Total Amount Received.png" alt="Total Amount Received"/>

<h3>MTD Loan Applications</h3>
<pre><code class="language-sql">SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;
</code></pre>
<img class="img" src="./images/MTD Loan Applications.png" alt="MTD Loan Applications"/>

<h3>PMTD Loan Applications</h3>
<pre><code class="language-sql">SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;
</code></pre>
<img class="img" src="./images/PMTD Loan Applications.png" alt="PMTD Loan Applications"/>

<h3>MTD Total Funded Amount</h3>
<pre><code class="language-sql">SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;
</code></pre>
<img class="img" src="./images/MTD Total Funded Amount.png" alt="MTD Total Funded Amount"/>

<h3>PMTD Total Funded Amount</h3>
<pre><code class="language-sql">SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;
</code></pre>
<img class="img" src="./images/PMTD Total Funded Amount.png" alt="PMTD Total Funded Amount"/>

<h3>MTD Total Amount Received</h3>
<pre><code class="language-sql">SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;
</code></pre>
<img class="img" src="./images/MTD Total Amount Received.png" alt="MTD Total Amount Received"/>

<h3>Average Interest Rate</h3>
<pre><code class="language-sql">SELECT AVG(int_rate)*100 AS Avg_Int_Rate 
FROM bank_loan_data;
</code></pre>
<img class="img" src="./images/Average Interest Rate.png" alt="Average Interest Rate"/>

<h3>Average DTI</h3>
<pre><code class="language-sql">SELECT AVG(dti)*100 AS Avg_DTI 
FROM bank_loan_data;
</code></pre>
<img class="img" src="./images/Avg DTI.png" alt="Avg DTI"/>

<hr/>

<h2 id="good-loan-analysis">✅ Good Loan Analysis</h2>

<h3>Good Loan Percentage</h3>
<pre><code class="language-sql">
SELECT
  (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
  COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;
</code></pre>
<img class="img" src="./images/Good Loan Percentage.png" alt="Good Loan Percentage"/>

<h3>Good Loan Funded Amount</h3>
<pre><code class="language-sql">
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
</code></pre>
<img class="img" src="./images/Good Loan Funded Amount.png" alt="Good Loan Funded Amount"/>

<h3>Good Loan Amount Received</h3>
<pre><code class="language-sql">
SELECT SUM(total_payment) AS Good_Loan_Amount_Received 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
</code></pre>
<img class="img" src="./images/Good Loan Amount Received.png" alt="Good Loan Amount Received"/>

<hr/>

<h2 id="bad-loan-analysis">❌ Bad Loan Analysis</h2>

<h3>Bad Loan Percentage</h3>
<pre><code class="language-sql">
SELECT
  (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
  COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;
</code></pre>
<img class="img" src="./images/Bad Loan Percentage.png" alt="Bad Loan Percentage"/>

<h3>Bad Loan Funded Amount</h3>
<pre><code class="language-sql">
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';
</code></pre>
<img class="img" src="./images/Bad Loan Funded Amount.png" alt="Bad Loan Funded Amount"/>

<h3>Bad Loan Amount Received</h3>
<pre><code class="language-sql">
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';
</code></pre>
<img class="img" src="./images/Bad Loan Amount Received.png" alt="Bad Loan Amount Received"/>

<hr/>

<h2 id="loan-status-summary">🧮 Loan Status Summary</h2>

<pre><code class="language-sql">
SELECT
  loan_status,
  COUNT(id) AS LoanCount,
  SUM(total_payment) AS Total_Amount_Received,
  SUM(loan_amount) AS Total_Funded_Amount,
  AVG(int_rate * 100) AS Interest_Rate,
  AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status;
</code></pre>

<img class="img" src="./images/Loan Status Summary 1.png" alt="Loan Status Summary 1"/>
<img class="img" src="./images/Loan Status Summary 2.png" alt="Loan Status Summary 2"/>

<hr/>

<h2 id="report-overview">🗓️ Report Overview</h2>

<h3>By Month</h3>
<pre><code class="language-sql">
SELECT 
  MONTH(issue_date) AS Month_Number, 
  DATENAME(MONTH, issue_date) AS Month_Name, 
  COUNT(id) AS Total_Loan_Applications,
  SUM(loan_amount) AS Total_Funded_Amount,
  SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);
</code></pre>
<img class="img" src="./images/By Month.png" alt="By Month"/>

<h3>By Purpose</h3>
<pre><code class="language-sql">
SELECT 
  purpose AS PURPOSE, 
  COUNT(id) AS Total_Loan_Applications,
  SUM(loan_amount) AS Total_Funded_Amount,
  SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;
</code></pre>
<img class="img" src="./images/By Purpose.png" alt="By Purpose"/>

<h3>By Home Ownership</h3>
<pre><code class="language-sql">
SELECT 
  home_ownership AS Home_Ownership, 
  COUNT(id) AS Total_Loan_Applications,
  SUM(loan_amount) AS Total_Funded_Amount,
  SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;
</code></pre>
<img class="img" src="./images/HOME OWNERSHIP.png" alt="Home Ownership"/>

<hr/>

<h2 id="filters-custom">🎛️ Filters & Custom Queries</h2>

<p><strong>Example:</strong> Filter loans with <code>grade = 'A'</code></p>

<pre><code class="language-sql">
SELECT 
  purpose AS PURPOSE, 
  COUNT(id) AS Total_Loan_Applications,
  SUM(loan_amount) AS Total_Funded_Amount,
  SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;
</code></pre>

<hr/>

<h2 id="key-insights">🧠 Key Insights</h2>
<ul>
  <li>Tracks total and monthly loan performance metrics</li>
  <li>Highlights good vs bad loan proportions</li>
  <li>Analyzes funding and repayment patterns</li>
  <li>Identifies borrower and purpose-based trends</li>
</ul>

<h2 id="tools-used">⚙️ Tools Used</h2>
<ul>
  <li><strong>SQL</strong> – Data querying and analysis</li>
  <li><strong>Excel / Power BI / Tableau</strong> – For visualization</li>
  <li><strong>GitHub</strong> – Documentation and version control</li>
</ul>

</body>
</html>
