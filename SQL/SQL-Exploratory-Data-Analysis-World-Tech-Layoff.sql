-- Exploratory-Data-Analysis-World-Tech-Layoff
-- Call the cleaned dataset
select * from layoff_staging2;

-- Determine the maximum,minimum,average total laid off
select max(total_laid_off) as maximum_laid_off,
min(total_laid_off) as minimum_laidoff,
avg(total_laid_off) as average_laidoff
from layoff_staging2;

-- Determine the maximum,minimum,average total laid off by country
select country, 
max(total_laid_off) as maximum_laid_off,
min(total_laid_off) as minimum_laidoff,
avg(total_laid_off) as average_laidoff
from layoff_staging2
group by country;

-- Determine the maximum,minimum,average total laid off by state City in the united states
select country,
CITY,
max(total_laid_off) as maximum_laidoff,
min(total_laid_off) as minimum_laidoff,
avg(total_laid_off) as average_laidoff
from layoff_staging2
where country='United States'
group by country, CITY
order by maximum_laidoff desc;

-- Determine the total laid off by company
select company,
sum(total_laid_off) total_laidoff
from layoff_staging2
group by company
order by total_laidoff Desc;

-- Determine the total laid off by company in USA only
select company,
sum(total_laid_off) total_laidoff
from layoff_staging2
where country='United States'
group by company
order by total_laidoff Desc;

-- Determine the Companies with zero layoffs
select company,
sum(total_laid_off) total_laidoff
from layoff_staging2
where total_laid_off=0
group by company
order by total_laidoff Desc;

-- Select top 5 companies by fundsraised
select Country,
CITY,
company,
sum(total_laid_off) as Total_laid_off,
sum(Fundsraised2) as Total_funds_raised
from layoff_staging2
group by country,CITY,company
order by Total_funds_raised desc limit 5;

-- Select top 5 companies by fundsraised in USA only
select Country,
CITY,
company,
sum(total_laid_off) as Total_laid_off,
sum(Fundsraised2) as Total_funds_raised
from layoff_staging2
where country='United States'
group by country,CITY,company
order by Total_funds_raised desc limit 5;

-- Select top 5 industry by Total laid off 
select country,
CITY,
company, 
industry,
sum(total_laid_off) as Total_Laid_Off,
sum(Fundsraised2) as Total_Fundsraised
from layoff_staging2
group by country,CITY,company,industry
order by Total_Laid_Off desc;

-- Determine date range
select min(`date`) min_date,max(`date`) max_date
from layoff_staging2;

-- Determine the total laid off by year
select substring(`date`,1,4) as year,
sum(total_laid_off) Total_Laid_Off
from layoff_staging2
group by `year`
order by 1;

-- Determine the total laid off by month
select substring(`date`,6,2) as `month`,
sum(total_laid_off) as Total_Laid_Off
from layoff_staging2
group by `month`
order by 2 desc;

-- Add columns Year month and date
Alter table layoff_staging2
add column Month date;
Alter table layoff_staging2
add column Year date;
Alter table layoff_staging2
add column day date;
alter table layoff_staging2
modify column `Year`date
after `date`;
alter table layoff_staging2
modify column `Month`date
after `Year`;
alter table layoff_staging2
modify column `day`date
after `Month`;
ALTER TABLE layoff_staging2
MODIFY column `Year` int;
update layoff_staging2
set `Year`=substring(`date`,1,4);
ALTER TABLE layoff_staging2
MODIFY column `Month` int;
update layoff_staging2
set `Month`=substring(`date`,6,2);
ALTER TABLE layoff_staging2
MODIFY column `day` int;
update layoff_staging2
set `day`=substring(`date`,9,2);

-- Determine the fundsraised by month, by industry,by company and by year
select `Year`,
sum(Fundsraised2) Total_Funds_Raised
from layoff_staging2
group by `Year`
order by 2 desc;

select `Month`,
sum(Fundsraised2) Total_Funds_Raised
from layoff_staging2
group by `Month`
order by 2 desc;

select industry,
sum(Fundsraised2) Total_Funds_Raised
from layoff_staging2
group by industry
order by 2 desc;

select company,
sum(Fundsraised2) Total_Funds_Raised
from layoff_staging2
group by company
order by 2 asc;
-- Companies that did not raise any funds
select company,
sum(Fundsraised2) Total_Funds_Raised
from layoff_staging2
WHERE Fundsraised2=0
group by company;

-- Companies in the transport industry
select company,
sum(Fundsraised2) Total_Funds_Raised
from layoff_staging2
WHERE industry='Transportation'
group by company
order by 2 desc;

-- Determine the total laid off by stage
select stage,
sum(total_laid_off) Total_Laid_Off
from layoff_staging2
group by stage
order by Total_Laid_Off desc;

-- Determine the company in the Post IPO stage with the highest number of layoffs
select company,
stage,
sum(total_laid_off) Total_Laid_Off
from layoff_staging2
where stage='Post-IPO'
group by company,stage
order by Total_Laid_Off desc;

-- Create a rolling sum month by month using a CTE
with Rolling_Total as(
select substring(`date`,1,7) Month2,
sum(total_laid_off) total_laid_off
from layoff_staging2
group by Month2)
select Month2,
total_laid_off,
sum(total_laid_off) OVER (order by Month2) as Rolling_Sum
from Rolling_Total;

-- Determine the top 5 total laid off per company per year 
with company_year(company,years,totallayoff) as(
select company,
year(`date`),
sum(total_laid_off) 
from layoff_staging2
group by company, year(`date`)
), company_rank as(
select *, dense_rank() over (partition by years order by totallayoff desc) Ranking
from company_year
)
select * from company_rank
where ranking<=5;





