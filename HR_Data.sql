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

COPY hr_Data
FROM 'G:\PD\HR_Employee_Attrition.csv'
DELIMITER ','
CSV HEADER;

select * from hr_Data
limit 5;

-- Rank Employees by Salary Within Each Department --

select employee_number, department, monthly_income, rank() over
(partition by department order by monthly_income Desc) as rank 
from hr_Data

-- Find Top 3 Highest Paid Employees Per Job Role --

select * from
(select employee_number, job_role, monthly_income, row_number() over 
(partition by job_role order by monthly_income desc) as rank from hr_Data ) e
where rank <= 3;

-- Running Total of Employees by Years at Company --
SELECT
    years_at_company,
    COUNT(*) AS employees,
    SUM(COUNT(*)) OVER (
        ORDER BY years_at_company
    ) AS running_total
FROM hr_Data
GROUP BY years_at_company
ORDER BY years_at_company;

-- Compare Employee Salary to Department Average --

select employee_number, department, monthly_income, 
       Round(avg(monthly_income) over (partition by department),2),
	   monthly_income - Round(avg(monthly_income) over (partition by department),2) as salary_diff
from hr_Data

--Identify Attrition Rate by Department (Window %)--

select distinct department, 
     count(employee_number) over (partition by department) as dept_total,
	 sum(case when attrition = 'Yes' then 1 else 0 END) over (partition by department) as dept_attrition_count,
	 round(100.0 * 
	        sum(case when attrition = 'Yes' then 1 else 0 END) over (partition by department)
			/
			count(employee_number) over (partition by department),2) as attrition_rate
from hr_data;
 -- Find Employees with Salary Above Company Average --

SELECT employee_number, monthly_income from hr_Data
Where monthly_income > ( select AVG(monthly_income) from hr_Data);

-- Dense Rank Job Levels by Average Salary --

select job_role, round(avg(monthly_income),2), dense_rank() over 
 (order by avg(monthly_income) desc) as rank
from hr_Data
group by job_role;

-- Find Employees Who Earn More Than Previous Employee (by Employee Number) --

with emp_lag as (
      select employee_number, monthly_income, lag(monthly_income) over (order by employee_number) as prev_salary
	  from hr_Data)
select * from emp_lag
where monthly_income > prev_salary;

-- Tenure Risk Bands

SELECT years_at_company, COUNT(*) AS employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS leavers,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)* 100.0 / COUNT(*),2) AS attrition_rate
FROM hr_Data
GROUP BY years_at_company ORDER BY years_at_company;
