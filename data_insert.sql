-- =============================================
-- Bank Loan Analysis System
-- File 2: Data Insert
-- Author: Abdul Rehan
-- =============================================

USE bank_loan_db;

-- Insert Customers
INSERT INTO customers 
(customer_name, age, city, occupation, annual_income, credit_score) 
VALUES
('Rahul Sharma',  35, 'Mumbai',    'Engineer',        850000,  750),
('Priya Patel',   28, 'Pune',      'Doctor',         1200000,  820),
('Abdul Rehan',   26, 'Amravati',  'Data Analyst',    650000,  700),
('Sneha Desai',   32, 'Nashik',    'Teacher',         450000,  650),
('Vikram Singh',  45, 'Delhi',     'Business',       2000000,  780),
('Anjali Mehta',  29, 'Bangalore', 'IT Professional', 950000,  760),
('Ravi Kumar',    38, 'Chennai',   'Accountant',      600000,  620),
('Meena Joshi',   52, 'Hyderabad', 'Government Job',  700000,  690),
('Arjun Nair',    31, 'Kochi',     'Sales Manager',   800000,  710),
('Pooja Gupta',   27, 'Jaipur',    'Freelancer',      400000,  580);

-- Insert Loan Officers
INSERT INTO loan_officers 
(officer_name, branch, experience_years) 
VALUES
('Mr. Patil',  'Mumbai Branch',    10),
('Ms. Sharma', 'Pune Branch',       7),
('Mr. Khan',   'Delhi Branch',     12),
('Ms. Rao',    'Bangalore Branch',  5);

-- Insert Loans
INSERT INTO loans 
(customer_id, loan_type, loan_amount, interest_rate, 
 tenure_months, apply_date, status) 
VALUES
(1,  'Home',      5000000, 8.5,  240, '2024-01-15', 'Approved'),
(2,  'Car',        800000, 9.2,   60, '2024-02-20', 'Approved'),
(3,  'Personal',   300000, 12.5,  36, '2024-03-10', 'Approved'),
(4,  'Education',  600000, 7.8,   84, '2024-03-25', 'Pending'),
(5,  'Home',      8000000, 8.2,  300, '2024-04-05', 'Approved'),
(6,  'Car',       1200000, 9.5,   72, '2024-04-18', 'Approved'),
(7,  'Personal',   200000, 13.0,  24, '2024-05-01', 'Rejected'),
(8,  'Home',      3000000, 8.8,  180, '2024-05-15', 'Approved'),
(9,  'Education',  400000, 7.5,   60, '2024-06-01', 'Pending'),
(10, 'Personal',   150000, 14.0,  12, '2024-06-20', 'Rejected');

-- Insert Repayments
INSERT INTO repayments 
(loan_id, payment_date, amount_paid, payment_status) 
VALUES
(1, '2024-02-15', 43000, 'OnTime'),
(1, '2024-03-15', 43000, 'OnTime'),
(1, '2024-04-15', 43000, 'Late'),
(2, '2024-03-20', 16500, 'OnTime'),
(2, '2024-04-20', 16500, 'OnTime'),
(3, '2024-04-10', 10000, 'OnTime'),
(3, '2024-05-10', 10000, 'Missed'),
(5, '2024-05-05', 61000, 'OnTime'),
(6, '2024-05-18', 22000, 'OnTime'),
(8, '2024-06-15', 30000, 'Late');

-- Insert Loan Applications
INSERT INTO loan_applications 
(loan_id, officer_id, review_date, remarks) 
VALUES
(1,  1, '2024-01-20', 'Good credit score, approved'),
(2,  2, '2024-02-25', 'Stable income, approved'),
(3,  2, '2024-03-15', 'Approved with conditions'),
(4,  3, '2024-03-30', 'Documents pending'),
(5,  1, '2024-04-10', 'High value loan, approved'),
(6,  4, '2024-04-22', 'Approved'),
(7,  3, '2024-05-05', 'Low credit score, rejected'),
(8,  1, '2024-05-20', 'Approved'),
(9,  4, '2024-06-05', 'Under review'),
(10, 3, '2024-06-25', 'High risk, rejected');
