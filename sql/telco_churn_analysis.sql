-- Telco Customer Churn Analysis
-- Project: Revenue Loss Estimation and Customer Retention Strategy
-- DBMS: MySQL 8.0+

CREATE DATABASE IF NOT EXISTS telco_churn_db;
USE telco_churn_db;

DROP TABLE IF EXISTS telco_churn_raw;

CREATE TABLE telco_churn_raw (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen TINYINT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(20),
    Churn VARCHAR(5)
);

Select count(*) AS total_customers from telco_churn_raw;

-- 데이터 10개 미리보기
Select *
From telco_churn_raw
Limit 10;

-- churn 값은 고객이 이탈했는지 여부를 나타낸다.
Select Churn, COUNT(*) AS customer_count
From telco_churn_raw
Group By Churn;

-- No가 5174명, Yes가 1869명으로 나타난다. 

-- 전체 이탈률 계산
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent
FROM telco_churn_raw;

-- 약 26.54퍼센트의 고객이 이탈한 것으로 나타난다.
-- 고객 4명 중 1명 이상이 이탈한 것으로 해석할 수 있다.

-- MonthlyCharges = 월 요금
--TotalCharges = 총 누적 요금

-- 평균 월 요금 보기

SELECT 
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_churn_raw; -- 64.76달러

-- 이탈 고객과 이탈하지 않은 고객의 평균 월 요금 비교
SELECT 
    Churn,
    COUNT(*) AS customer_count,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_churn_raw
GROUP BY Churn;

-- COMMENT: 이탈한 고객의 평균 월 요금은 74.44달러로, 이탈하지 않은 고객의 평균 월 요금인 61.27달러보다 높다.
-- 이는 월 요금이 높은 고객이 이탈할 가능성이 더 높다는 것을 시사할 수 있다.    
-- 이는 높은 요금 부담이 고객 이탈에 영향을 줄 수 있음을 시사한다. 고객이 높은 요금에 불만을 느끼거나 더 저렴한 대안을 찾는 경우 이탈할 가능성이 높아질 수 있다. 
-- 따라서, 고객 유지 전략을 수립할 때 요금 구조를 재검토하거나 할인 혜택을 제공하는 등의 방안을 고려할 필요가 있다.

-- 이탈로 인한 월 매출 손실 계산
SELECT 
    COUNT(*) AS churn_customers,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge,
    ROUND(SUM(MonthlyCharges), 2) AS estimated_monthly_revenue_loss
FROM telco_churn_raw
WHERE Churn = 'Yes';

-- 계약 유형별 이탈률 분석
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent
FROM telco_churn_raw
GROUP BY Contract
ORDER BY churn_rate_percent DESC;

-- COMMENT: 계약 유형별 이탈률 분석 결과, Month-to-month 계약이 가장 높은 이탈률을 보이는 것으로 나타난다.
-- 이는 월 단위 계약이 고객에게 더 유연하지만, 동시에 더 높은 이탈률을 초래할 수 있음을 시사한다. 고객 유지 전략을 수립할 때 계약 유형에 따른 맞춤형 접근이 필요할 수 있다. 
-- 예를 들어, 월 단위 계약 고객에게는 장기 계약으로의 전환을 유도하는 할인 혜택을 제공하거나, 장기 계약 고객에게는 추가 혜택을 제공하여 이탈을 방지하는 전략을 고려할 수 있다.

-- 인터넷 서비스 유형별 이탈률 분석
SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent
FROM telco_churn_raw
GROUP BY InternetService
ORDER BY churn_rate_percent DESC;

-- COMMENT: 인터넷 서비스 유형별 이탈률 분석 결과, Fiber optic 서비스를 이용하는 고객이 가장 높은 이탈률을 보이는 것으로 나타난다. 
--이는 Fiber optic 서비스가 다른 유형에 비해 더 높은 요금을 부과할 수 있기 때문일 수 있다. 
--고객 유지 전략을 수립할 때, Fiber optic 서비스를 이용하는 고객에게는 요금 할인이나 추가 혜택을 제공하여 이탈을 방지하는 방안을 고려할 수 있다. 
--또한, 고객이 다른 인터넷 서비스 유형으로 전환할 수 있도록 유도하는 전략도 검토할 필요가 있다.    

-- 결제 방식별 이탈률 분석
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent
FROM telco_churn_raw
GROUP BY PaymentMethod
ORDER BY churn_rate_percent DESC;

-- COMMENT: 결제 방식별 이탈률 분석 결과, Electronic check를 이용하는 고객이 가장 높은 이탈률을 보이는 것으로 나타난다. 
--이는 전자 수표 결제 방식이 다른 결제 방식에 비해 더 불편하거나 신뢰성이 낮다고 인식될 수 있기 때문일 수 있다. 
--고객 유지 전략을 수립할 때, 전자 수표 결제 방식을 이용하는 고객에게는 다른 결제 방식으로의 전환을 유도하는 할인 혜택을 제공하거나, 
--전자 수표 결제 방식의 편의성과 신뢰성을 개선하는 방안을 고려할 필요가 있다.


-- 자식 및 배우자 유무에 따른 이탈률 분석
SELECT 
    Partner,
    Dependents,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent
FROM telco_churn_raw
GROUP BY Partner, Dependents
ORDER BY churn_rate_percent DESC;

-- COMMENT: 자식 및 배우자 유무에 따른 이탈률 분석 결과, 배우자가 없고 자녀가 없는 고객이 가장 높은 이탈률을 보이는 것으로 나타난다.
-- 이는 가족이 없는 고객이 더 높은 이탈률을 보이는 경향이 있을 수 있음을 시사한다. 
-- 고객 유지 전략을 수립할 때, 가족이 없는 고객에게는 개인 맞춤형 혜택이나 서비스를 제공하여 이탈을 방지하는 방안을 고려할 필요가 있다. 
-- 예를 들어, 개인 맞춤형 요금제나 특별 할인 혜택을 제공하여 가족이 없는 고객의 만족도를 높이는 전략을 검토할 수 있다.


-- 스트리밍 서비스 이용 여부에 따른 이탈률 분석
SELECT 
    StreamingTV,
    StreamingMovies,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent
FROM telco_churn_raw
GROUP BY StreamingTV, StreamingMovies
ORDER BY churn_rate_percent DESC;

-- COMMENT: 스트리밍 서비스 이용 여부에 따른 이탈률 분석 결과, 스트리밍 TV와 영화 서비스를 모두 이용하는 고객이 가장 높은 이탈률을 보이는 것으로 나타난다.
-- 이는 스트리밍 서비스를 이용하는 고객이 더 높은 요금 부담을 느낄 수 있기 때문일 수 있다. 
-- 고객 유지 전략을 수립할 때, 스트리밍 서비스를 이용하는 고객에게는 요금 할인이나 추가 혜택을 제공하여 이탈을 방지하는 방안을 고려할 필요가 있다. 
-- 또한, 스트리밍 서비스를 이용하는 고객이 다른 서비스로 전환할 수 있도록 유도하는 전략도 검토할 필요가 있다.       

-- 스트리밍 서비스 이용자와 청구 요금과 이탈률 간의 관계 분석
SELECT 
    StreamingTV,
    StreamingMovies,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100, 2) AS avg_churn_rate
FROM telco_churn_raw
GROUP BY StreamingTV, StreamingMovies
ORDER BY avg_monthly_charges DESC;          

-- COMMENT: ⭐스트리밍 서비스를 모두 이용하지 않는 고객이 오히려 가장 높은 이탈률을 보였다.
-- 인터넷은 쓰지만 스트리밍 서비스는 둘 다 안 쓰는 고객군이 가장 높은 이탈률을 보인다

-- 좀 더 자세히 알아보기
SELECT 
    StreamingTV,
    StreamingMovies,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate_percent,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(tenure), 2) AS avg_tenure
FROM telco_churn_raw
GROUP BY StreamingTV, StreamingMovies
ORDER BY churn_rate_percent DESC;

-- COMMENT: 스트리밍 서비스 이용 여부별 이탈률 분석 결과, StreamingTV와 StreamingMovies를 모두 이용하지 않는 고객군의 이탈률이 34.44%로 가장 높게 나타났다. 
-- 반면 두 서비스를 모두 이용하는 고객군의 이탈률은 29.43%로 더 낮았다. 이는 스트리밍 서비스 이용 자체가 이탈률을 높인다기보다, 
-- 스트리밍 서비스를 함께 이용하는 고객은 평균 가입 기간이 길고 서비스 이용 범위가 넓어 상대적으로 이탈률이 낮게 나타났을 가능성을 시사한다. 
-- 따라서 스트리밍 여부는 단독으로 해석하기보다 tenure, 계약 유형, 인터넷 서비스 유형과 함께 분석할 필요가 있다.


-- 스트리밍 조합 + 계약 유형 살펴보기
SELECT 
    Contract,
    StreamingTV,
    StreamingMovies,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate_percent,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(tenure), 2) AS avg_tenure
FROM telco_churn_raw
GROUP BY Contract, StreamingTV, StreamingMovies
ORDER BY churn_rate_percent DESC;

-- COMMENT: Month-to-month 계약 고객은 스트리밍 이용 여부와 상관없이 이탈률이 높다.
-- Month-to-month + StreamingTV Yes + StreamingMovies Yes 고객군이 52.89%로 가장 높은 이탈률을 보인다.

-- 계약 유형을 함께 고려한 결과, Month-to-month 계약이면서 StreamingTV와 StreamingMovies를 모두 이용하는 고객군의 이탈률이 52.89%로 가장 높게 나타났다.
--  이 그룹은 평균 월 요금도 92.65달러로 높기 때문에, 단순히 이탈 위험이 높은 고객군일 뿐만 아니라 매출 기여도가 큰 고객군으로 볼 수 있다.
--  따라서 고객 유지 전략에서는 월 단위 계약을 사용하면서 스트리밍 서비스를 함께 이용하는 고객을 우선 관리 대상으로 설정할 필요가 있다.



-- 매출 손실 계산

SELECT 
    Contract,
    StreamingTV,
    StreamingMovies,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS churn_rate_percent,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS estimated_monthly_revenue_loss
FROM telco_churn_raw
GROUP BY Contract, StreamingTV, StreamingMovies
HAVING total_customers >= 100
ORDER BY estimated_monthly_revenue_loss DESC;

-- COMMENT: ⭐⭐ 이탈률이 가장 높은 고객군과 실제 매출 손실이 가장 큰 고객군은 다르다.
-- 이탈률이 가장 높은 고객군은 Month-to-month 계약이면서 StreamingTV와 StreamingMovies를 모두 이용하는 고객군이었다. 
-- 그러나 추정 월 매출 손실이 가장 큰 고객군은 Month-to-month 계약이면서 두 스트리밍 서비스를 모두 이용하지 않는 고객군이었다. 
--이는 고객 유지 전략을 세울 때 단순히 이탈률만 볼 것이 아니라, 고객 수와 매출 손실 규모를 함께 고려해야 함을 보여준다.


-- 이탈률도 높고 매출 손실도 큰 고객군을 위로 올리는 점수
SELECT 
    Contract,
    StreamingTV,
    StreamingMovies,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate_percent,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS estimated_monthly_revenue_loss,
    ROUND(
        (SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100)
        * SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) / 1000,
        2
    ) AS retention_priority_score
FROM telco_churn_raw
GROUP BY Contract, StreamingTV, StreamingMovies
HAVING total_customers >= 100
ORDER BY retention_priority_score DESC;

-- COMMENT: Retention Priority Score는 이탈률과 추정 월 매출 손실을 함께 고려한 점수이다.
-- 이를 통해 이탈 위험이 높고 매출 영향도 큰 고객군을 우선적으로 찾을 수 있다.
-- 분석 결과, Month-to-month 계약이면서 두 스트리밍 서비스를 모두 이용하는 고객군의 우선순위 점수가 가장 높게 나타났다.
-- 두 스트리밍 서비스를 모두 이용하지 않는 고객군의 매출 손실액이 가장 컸지만,
-- 두 스트리밍 서비스를 모두 이용하는 고객군은 이탈률이 가장 높고 매출 영향도 커서 최우선 리텐션 타깃으로 볼 수 있다.

-- ✅✅ COMMENT: 이 결과를 바탕으로 기업은 Month-to-month 계약이면서 두 스트리밍 서비스를 모두 이용하는 고객을 우선 리텐션 캠페인 대상으로 설정할 수 있다. 
-- 예를 들어 연간 계약 전환 할인, 스트리밍 번들 혜택, 장기 이용 리워드 등을 제공하여 고가치 고객의 이탈을 줄이는 전략을 고려할 수 있다.