-- =============================================
-- Bank Loan Analysis System
-- File 3: Analysis Queries (10 Business Questions)
-- Author: Abdul Rehan
-- =============================================

USE bank_loan_db;

-- Q1: INNER JOIN - Customer loan details
SELECT 
    c.customer_name,
    c.city,
    c.credit_score,
    l.loan_type,
    l.loan_amount,
    l.status
FROM customers c
INNER JOIN loans l ON c.customer_id = l.customer_id
ORDER BY l.loan_amount DESC;

-- Q2: LEFT JOIN - Customers with no loans
SELECT 
    c.customer_name,
    c.city,
    c.occupation,
    l.loan_type
FROM customers c
LEFT JOIN loans l ON c.customer_id = l.customer_id
WHERE l.loan_id IS NULL;

-- Q3: GROUP BY + HAVING - City wise loan summary
SELECT 
    c.city,
    COUNT(l.loan_id)     AS total_loans,
    SUM(l.loan_amount)   AS total_amount,
    AVG(l.interest_rate) AS avg_interest
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id
GROUP BY c.city
HAVING total_loans >= 1
ORDER BY total_amount DESC;

-- Q4: SUBQUERY - Above average credit score customers
SELECT 
    customer_name,
    credit_score,
    annual_income
FROM customers
WHERE credit_score > (
    SELECT AVG(credit_score) FROM customers
)
ORDER BY credit_score DESC;

-- Q5: CTE - Loan type wise approval summary
WITH loan_summary AS (
    SELECT 
        loan_type,
        COUNT(*)           AS total_applications,
        SUM(loan_amount)   AS total_amount,
        AVG(interest_rate) AS avg_rate,
        SUM(CASE WHEN status = 'Approved' THEN 1 ELSE 0 END) AS approved_count,
        SUM(CASE WHEN status = 'Rejected' THEN 1 ELSE 0 END) AS rejected_count
    FROM loans
    GROUP BY loan_type
)
SELECT *,
    ROUND((approved_count / total_applications) * 100, 1) AS approval_rate
FROM loan_summary
ORDER BY total_amount DESC;

-- Q6: RANK - Top 3 highest loan customers
SELECT 
    c.customer_name,
    l.loan_type,
    l.loan_amount,
    RANK() OVER (ORDER BY l.loan_amount DESC) AS loan_rank
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id
WHERE l.status = 'Approved';

-- Q7: ROW_NUMBER - Highest loan per category
WITH ranked_loans AS (
    SELECT 
        c.customer_name,
        l.loan_type,
        l.loan_amount,
        l.interest_rate,
        ROW_NUMBER() OVER (
            PARTITION BY l.loan_type 
            ORDER BY l.loan_amount DESC
        ) AS row_num
    FROM customers c
    JOIN loans l ON c.customer_id = l.customer_id
)
SELECT * FROM ranked_loans 
WHERE row_num = 1;

-- Q8: CTE + JOIN - Officer performance report
WITH officer_performance AS (
    SELECT 
        lo.officer_name,
        lo.branch,
        COUNT(la.application_id) AS total_reviewed,
        SUM(CASE WHEN l.status = 'Approved' THEN 1 ELSE 0 END) AS approved,
        SUM(CASE WHEN l.status = 'Rejected' THEN 1 ELSE 0 END) AS rejected
    FROM loan_officers lo
    JOIN loan_applications la ON lo.officer_id = la.officer_id
    JOIN loans l               ON la.loan_id    = l.loan_id
    GROUP BY lo.officer_name, lo.branch
)
SELECT *,
    ROUND((approved / total_reviewed) * 100, 1) AS approval_rate
FROM officer_performance
ORDER BY approval_rate DESC;

-- Q9: Repayment behavior analysis
SELECT 
    c.customer_name,
    l.loan_type,
    l.loan_amount,
    COUNT(r.repayment_id) AS total_payments,
    SUM(CASE WHEN r.payment_status = 'OnTime' THEN 1 ELSE 0 END) AS ontime,
    SUM(CASE WHEN r.payment_status = 'Late'   THEN 1 ELSE 0 END) AS late,
    SUM(CASE WHEN r.payment_status = 'Missed' THEN 1 ELSE 0 END) AS missed
FROM customers c
JOIN loans l      ON c.customer_id = l.customer_id
JOIN repayments r ON l.loan_id     = r.loan_id
GROUP BY c.customer_name, l.loan_type, l.loan_amount
ORDER BY missed DESC, late DESC;

-- Q10: Complete Customer Risk Report
WITH repayment_health AS (
    SELECT 
        l.customer_id,
        COUNT(r.repayment_id) AS total_payments,
        SUM(CASE WHEN r.payment_status = 'Missed' 
            THEN 1 ELSE 0 END) AS missed_payments
    FROM loans l
    LEFT JOIN repayments r ON l.loan_id = r.loan_id
    GROUP BY l.customer_id
),
customer_risk AS (
    SELECT 
        c.customer_name,
        c.credit_score,
        c.annual_income,
        l.loan_amount,
        l.loan_type,
        l.status,
        COALESCE(rh.missed_payments, 0) AS missed_payments,
        CASE 
            WHEN c.credit_score >= 750 
             AND COALESCE(rh.missed_payments, 0) = 0 
             THEN 'LOW RISK'
            WHEN c.credit_score >= 650 
             AND COALESCE(rh.missed_payments, 0) <= 1 
             THEN 'MEDIUM RISK'
            ELSE 'HIGH RISK'
        END AS risk_category
    FROM customers c
    JOIN loans l ON c.customer_id = l.customer_id
    LEFT JOIN repayment_health rh ON c.customer_id = rh.customer_id
)
SELECT * FROM customer_risk
ORDER BY 
    CASE risk_category 
        WHEN 'HIGH RISK'   THEN 1 
        WHEN 'MEDIUM RISK' THEN 2 
        ELSE 3 
    END;
