# 🏦 Bank Loan Analysis System

## Project Overview
A complete Bank Loan Analysis System built using MySQL that analyzes 
loan approvals, customer risk profiles, and repayment behavior 
of a fictional bank with 10 customers and 4 loan officers.

## Author
**Abdul Rehan** | Data Analytics & Automation Specialist
- Email: abdulrehan867@gmail.com
- Location: Amravati, Maharashtra, India

## Database Structure
5 tables were designed to store and analyze banking data:

- **customers** — Customer personal details and credit scores
- **loans** — Loan applications, amounts, and approval status
- **repayments** — Monthly payment history and behavior
- ** loan_officers ** — Officer details and branch information
- ** loan_applications ** — Application review records

## SQL Concepts Used
- JOINS — INNER JOIN, LEFT JOIN for combining tables
- CTEs — WITH clause for readable complex queries
- Window Functions — RANK, ROW_NUMBER for rankings
- Subqueries — Nested queries for comparisons
- GROUP BY + HAVING — Aggregation and filtering
- CASE WHEN — Conditional logic for risk profiling

## 10 Business Questions Solved

| # | Question | Concept Used |
|---|----------|-------------|
| 1 | Customer wise loan details | INNER JOIN |
| 2 | Customers with no loans | LEFT JOIN |
| 3 | City wise loan distribution | GROUP BY + HAVING |
| 4 | Above average credit score customers | SUBQUERY |
| 5 | Loan type wise approval rates | CTE |
| 6 | Top 3 highest loan customers | RANK |
| 7 | Highest loan per category | ROW_NUMBER |
| 8 | Officer performance report | CTE + JOIN |
| 9 | Late payment analysis | JOINS + CASE WHEN |
| 10 | Complete customer risk profiling | CTE + CASE WHEN |

## Key Business Insights
- Home loans have the highest total value
- Customers with credit score below 650 are HIGH RISK
- Mr. Patil has the highest loan approval rate
- 2 out of 10 customers have missed payments

## Tools Used
- MySQL Workbench 8.0
- SQL (Advanced Queries)

## Files
- schema.sql — Database and table creation
- data_insert.sql — Sample data insertion  
- analysis_queries.sql — 10 business analysis queries

## How to Use
Run files in this order:
1. schema.sql
2. data_insert.sql
3. analysis_queries.sql