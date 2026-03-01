HR Employee Attrition Analysis (SQL Project)

This project analyzes HR employee attrition data using SQL. 
It demonstrates advanced SQL concepts such as window functions, ranking, aggregation, and common table expressions (CTEs) to extract meaningful workforce insights.

Project Overview:

The goal of this project is to:
Analyze employee attrition patterns
Identify salary trends across departments and roles
Evaluate tenure-based risk
Practice advanced SQL analytical functions


Dataset:

File: HR_Employee_Attrition.csv
The dataset includes fields such as:
Employee demographics (age, gender, marital status)
Job details (department, role, job level)
Compensation (monthly income, hourly rate)
Performance metrics
Attrition status

Database Schema:


CREATE TABLE hr_Data (
    age INT,
    attrition VARCHAR(10),
    business_travel VARCHAR(50),
    daily_rate INT,
    department VARCHAR(50),
    distance_from_home INT,
    education INT,
    education_field VARCHAR(50),
    employee_count INT,
    employee_number INT PRIMARY KEY,
    environment_satisfaction INT,
    gender VARCHAR(10),
    hourly_rate INT,
    job_involvement INT,
    job_level INT,
    job_role VARCHAR(50),
    job_satisfaction INT,
    marital_status VARCHAR(20),
    monthly_income INT,
    monthly_rate INT,
    num_companies_worked INT,
    over18 CHAR(1),
    over_time VARCHAR(10),
    percent_salary_hike INT,
    performance_rating INT,
    relationship_satisfaction INT,
    standard_hours INT,
    stock_option_level INT,
    total_working_years INT,
    training_times_last_year INT,
    work_life_balance INT,
    years_at_company INT,
    years_in_current_role INT,
    years_since_last_promotion INT,
    years_with_curr_manager INT
);

Data Import:

COPY hr_Data
FROM 'G:\PD\HR_Employee_Attrition.csv'
DELIMITER ','
CSV HEADER;

Key SQL Analyses
1️.Rank Employees by Salary Within Department
Uses RANK() window function
Identifies salary hierarchy inside each department

2️.Top 3 Highest Paid Employees per Job Role
Uses ROW_NUMBER()
Filters top earners by role

3️.Running Total by Years at Company
Demonstrates cumulative aggregation
Useful for tenure distribution analysis

4️.Salary vs Department Average
Compares individual salary to department mean
Highlights overpaid/underpaid employees

5️.Attrition Rate by Department
Calculates percentage attrition
Uses window aggregation

6️.Employees Above Company Average Salary
Uses subquery with AVG()
Identifies high earners

7️.Dense Rank Job Roles by Average Salary
Uses DENSE_RANK()
Compares role-level compensation

8️.Employees Earning More Than Previous Employee
Uses LAG()
Demonstrates sequential comparison

9️.Tenure Risk Bands
Attrition rate grouped by years at company
Helps identify high-risk tenure periods

Skills Demonstrated:

Window Functions (RANK, ROW_NUMBER, DENSE_RANK, LAG)
Aggregations and Grouping
Common Table Expressions (CTEs)
Subqueries
Analytical SQL thinking
HR analytics concepts

Tools Used:

SQL (PostgreSQL / compatible RDBMS)
CSV dataset
GitHub for version control

How to Run:

Create the table using the provided SQL.
Update the CSV file path.
Run the COPY command to load data.
Execute analysis queries.

Author:

Pranita

If you found this project helpful, consider ⭐ starring the repo!
