-- =============================================
-- Bank Loan Analysis System
-- File 1: Schema (Database + Tables)
-- Author: Abdul Rehan
-- =============================================

CREATE DATABASE IF NOT EXISTS bank_loan_db;
USE bank_loan_db;

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    age INT,
    city VARCHAR(50),
    occupation VARCHAR(50),
    annual_income DECIMAL(12,2),
    credit_score INT
);

CREATE TABLE IF NOT EXISTS loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    loan_type VARCHAR(50),
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    apply_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS repayments (
    repayment_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT,
    payment_date DATE,
    amount_paid DECIMAL(12,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

CREATE TABLE IF NOT EXISTS loan_officers (
    officer_id INT PRIMARY KEY AUTO_INCREMENT,
    officer_name VARCHAR(100),
    branch VARCHAR(50),
    experience_years INT
);

CREATE TABLE IF NOT EXISTS loan_applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT,
    officer_id INT,
    review_date DATE,
    remarks TEXT,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
    FOREIGN KEY (officer_id) REFERENCES loan_officers(officer_id)
);
