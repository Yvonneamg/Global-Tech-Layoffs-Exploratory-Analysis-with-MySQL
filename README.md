# Global Tech Layoffs — Exploratory Data Analysis with MySQL

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=flat&logo=tableau&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Data%20Analysis-blue?style=flat)
![GitHub](https://img.shields.io/badge/GitHub-Portfolio-181717?style=flat&logo=github)

## 📌 Project Overview

This project analyzes reported technology layoffs across companies, industries, locations, funding stages and time.

The goal is to use **MySQL and SQL** to explore patterns in workforce reductions, identify companies and industries most affected, analyze changes over time and translate the results into meaningful business insights.

Rather than focusing only on writing SQL queries, this project follows an analytical workflow:

> **Data validation → Exploratory analysis → Advanced SQL → Insights → Business interpretation → Visualization**


---

## 🎯 Business Objective

Technology layoffs can vary significantly by company, industry, location, funding stage and period.

This analysis aims to answer questions such as:

- How have reported tech layoffs changed over time?
- Which companies experienced the largest reported layoffs?
- Which industries were most affected?
- Which countries and cities experienced the greatest number of reported layoffs?
- Which funding stages experienced the largest workforce reductions?
- Which companies experienced the largest layoffs in each year?
- How do absolute layoffs compare with the percentage of the workforce affected?
- What patterns can be observed in company funding and reported layoffs?
- What limitations should be considered when interpreting the results?

---

# 📊 Dataset

The dataset contains reported technology layoff events across companies and locations.

### Dataset size

- **Records:** 1,000
- **Columns:** 9
- **Geographic coverage:** Global
- **Time period:** 

The dataset used in this project is a cleaned version of the original technology layoffs dataset.

> **Important:** All key statistics and date ranges presented in this README are being validated directly against the database rather than manually assumed from the source file.

---

# 🗂️ Data Dictionary

| Column | Description |
|---|---|
| `company` | Name of the company reporting the layoff |
| `location` / `city` | Geographic location associated with the layoff |
| `country` | Country associated with the company/event |
| `total_laid_off` | Reported number of employees laid off |
| `date` | Date associated with the reported layoff |
| `percentage_laid_off` | Reported percentage of the workforce affected |
| `industry` | Industry/category of the company |
| `stage` | Company funding/business stage |
| `funds_raised` | Reported funding raised by the company |

> **Note:** Column names and definitions are documented based on the structure of the dataset. Further validation of the dataset's grain and field definitions is performed during the data-quality stage.

---

# 🧰 Tools & Technologies

### Database & SQL
- MySQL
- MySQL Workbench

### Visualization
- Tableau

### Version Control
- Git
- GitHub

---

# 🔍 Analytical Approach

The project follows a structured data-analysis workflow.

## 1. Data Understanding

Before performing analysis, I examine the structure and characteristics of the dataset.

Questions include:

- How many records are available?
- How many unique companies are represented?
- How many countries and industries are represented?
- What is the date range?
- What is the grain of the dataset?
- Which columns contain missing values?
- Are there potential duplicate records?
- Which fields contain zero values?

---

## 2. Data Quality Checks

The dataset is evaluated for:

- Missing values
- Duplicate records
- NULL values
- Zero values
- Invalid or unexpected values
- Date consistency
- Data-type consistency
- Potential inconsistencies in categorical fields

The objective is to understand the quality and limitations of the data before drawing conclusions.

---

## 3. Exploratory Data Analysis

The analysis examines:

### Layoff Distribution

- Minimum reported layoffs
- Maximum reported layoffs
- Average reported layoffs
- Distribution of layoff events

### Company Analysis

- Total reported layoffs by company
- Companies with the highest reported layoffs
- Companies with zero reported layoffs
- Annual company rankings

### Geographic Analysis

- Reported layoffs by country
- Reported layoffs by city
- Geographic concentration of layoffs

### Industry Analysis

- Reported layoffs by industry
- Industry-level trends
- Industries with the highest and lowest reported layoffs

### Time Analysis

- Earliest and latest reported layoff dates
- Layoffs by year
- Layoffs by year-month
- Monthly trends
- Cumulative layoffs over time

### Funding Analysis

- Reported funding by company
- Funding by industry
- Funding by year
- Funding by funding stage
- Companies with no reported funding

---

# 🧠 Advanced SQL Analysis

The project demonstrates progressively more advanced SQL techniques.

### Core SQL

- `SELECT`
- `WHERE`
- `ORDER BY`
- `DISTINCT`
- `LIMIT`
- `GROUP BY`
- `HAVING`

### Aggregate Functions

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

### Conditional Logic

- `CASE`
- Conditional aggregation

### Date Analysis

- `YEAR()`
- `MONTH()`
- `DATE_FORMAT()`
- Date-based grouping

### Advanced SQL

- Common Table Expressions (`CTEs`)
- Subqueries
- Window functions
- `DENSE_RANK()`
- `RANK()`
- `ROW_NUMBER()`
- `LAG()`
- `LEAD()`
- Running totals
- Year-over-year analysis

---

# 📈 Key Analyses

## 1. Layoffs Over Time

I analyze the number of reported layoffs by year and year-month to identify periods of increased or decreased workforce reductions.

The analysis uses MySQL date functions and window functions to calculate cumulative trends.

**Key finding:**



---

## 2. Companies with the Highest Reported Layoffs

Companies are ranked based on the cumulative number of reported layoffs represented in the dataset.

**Key finding:**



---

## 3. Layoffs by Industry

The analysis compares reported layoffs across industries to determine where workforce reductions were most concentrated.

**Key finding:**



---

## 4. Geographic Distribution

Layoffs are analyzed by country and city to identify geographic patterns.

**Key finding:**



---

## 5. Funding Stage Analysis

The analysis examines reported layoffs across different company funding/business stages.

**Key finding:**



---

## 6. Percentage of Workforce Affected

Absolute layoffs do not tell the entire story.

A company laying off 5,000 employees may be very different from a company laying off 5,000 employees out of a much smaller workforce.

Therefore, the analysis also considers:

`percentage_laid_off`

This provides a relative measure of the severity of individual layoff events.

**Key finding:**


---

# 📊 Advanced Analysis: Annual Company Rankings

One of the advanced SQL analyses ranks the companies with the highest reported layoffs for each year.

This is implemented using:

- CTEs
- Aggregation
- `DENSE_RANK()`
- `PARTITION BY`

Example:

```sql
WITH company_year AS (
    SELECT
        company,
        YEAR(date) AS year,
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs
    GROUP BY
        company,
        YEAR(date)
),

ranked_companies AS (
    SELECT
        company,
        year,
        total_laid_off,
        DENSE_RANK() OVER (
            PARTITION BY year
            ORDER BY total_laid_off DESC
        ) AS ranking
    FROM company_year
)

SELECT
    company,
    year,
    total_laid_off,
    ranking
FROM ranked_companies
WHERE ranking <= 5
ORDER BY year, ranking;
