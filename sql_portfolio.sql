select * from customer_churn;
#Query 1: Considering the top 5 groups with the highest
#average monthly charges among churned customers,
#how can personalized offers be tailored based on age,
#gender, and contract type to potentially improve
#customer retention rates?

select
    case
        when `Age` < 25 then 'Young Adults'
        when `Age` >= 25 and `Age` <= 54 then 'Adults'
        else 'Senior Citizens'
    end as Age_Group,
    case
        when `Gender` = 'Male' then 'Males'
        when `Gender` = 'Female' then 'Females'
    end as Gender_Type,
    `Contract`,
    avg(`Monthly_Charge`) as Average_Monthly_Charges,
     100-MAX(`Churn_Score`) as Retention_Score,
    GROUP_CONCAT(distinct `Churn_Reason`) as Churn_Reasons
from 
    customer_churn
where 
    `Churn_Label` = 'Yes'
group by 
    case
        when `Age` < 25 then 'Young Adults'
        when `Age` >= 25 and `Age` <= 54 then 'Adults'
        else 'Senior Citizens'
    end,
    case
        when `Gender` = 'Male' then'Males'
        when `Gender` = 'Female' then 'Females'
    end,
    `Contract`
order by 
    Average_Monthly_Charges desc
limit 5;

# Query 2: What are the feedback or complaints from those churned customers

select 
    `Churn_Reason` as Compliant,
    COUNT(*) as Frequency
from 
    customer_churn
where 
    `Churn_Label` = 'Yes'
group by 
    `Churn_Reason`
order by 
    Frequency desc;

# Query 3: How does the payment method influence churn behavior?

select 
    `Payment_Method`,
    COUNT(*) as Frequency,
    SUM(case when `Churn_Label` = 'Yes' then 1 else 0 end) / COUNT(*) * 100 as Churn_Rate
from 
    customer_churn
group by 
    `Payment_Method`
order by 
    Churn_Rate desc;


#select distinct(Churn_Category) from customer_churn;