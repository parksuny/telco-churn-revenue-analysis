# Telco Churn Revenue Analysis  
# 통신사 고객 이탈 및 매출 손실 분석

## 1. Project Overview

This project analyzes customer churn patterns using the Telco Customer Churn dataset.  
The main goal is to identify customer segments with high churn risk and estimate the potential monthly revenue loss caused by churned customers.

이 프로젝트는 통신사 고객 이탈 데이터를 활용하여 고객 이탈 패턴을 분석한 SQL 기반 데이터 분석 프로젝트입니다.  
주요 목표는 이탈 위험이 높은 고객군을 찾고, 이탈 고객으로 인해 발생할 수 있는 월 매출 손실을 추정하는 것입니다.

---

## 2. Business Questions

This project focuses on the following business questions:

1. What is the overall customer churn rate?
2. Do churned customers have higher monthly charges than retained customers?
3. Which contract types show the highest churn rate?
4. Which customer segments create the largest estimated monthly revenue loss?
5. Which customer groups should be prioritized for retention campaigns?

이 프로젝트에서는 다음과 같은 비즈니스 질문을 중심으로 분석했습니다.

1. 전체 고객 이탈률은 어느 정도인가?
2. 이탈 고객은 유지 고객보다 평균 월 요금이 높은가?
3. 어떤 계약 유형에서 이탈률이 가장 높은가?
4. 어떤 고객군이 가장 큰 월 매출 손실을 발생시키는가?
5. 리텐션 캠페인에서 우선적으로 관리해야 할 고객군은 누구인가?

---

## 3. Dataset

- Dataset: Telco Customer Churn Dataset
- Total records: 7,043 customers
- Target column: `Churn`
- Main revenue-related columns:
  - `MonthlyCharges`
  - `TotalCharges`

데이터셋은 총 7,043명의 통신사 고객 정보를 포함하고 있으며, 주요 타깃 컬럼은 고객 이탈 여부를 나타내는 `Churn`입니다.  
매출 분석에는 월 요금을 나타내는 `MonthlyCharges`와 누적 요금을 나타내는 `TotalCharges`를 활용했습니다.

---

## 4. Dataset Columns

| Column | Description | 설명 |
|---|---|---|
| `customerID` | Unique customer ID | 고객 고유 ID |
| `gender` | Customer gender | 고객 성별 |
| `SeniorCitizen` | Whether the customer is a senior citizen | 고령 고객 여부 |
| `Partner` | Whether the customer has a partner | 배우자 여부 |
| `Dependents` | Whether the customer has dependents | 부양가족 여부 |
| `tenure` | Number of months the customer has stayed with the company | 고객의 가입 유지 기간 |
| `PhoneService` | Whether the customer has phone service | 전화 서비스 이용 여부 |
| `MultipleLines` | Whether the customer has multiple phone lines | 다중 회선 이용 여부 |
| `InternetService` | Type of internet service | 인터넷 서비스 유형 |
| `OnlineSecurity` | Whether the customer has online security service | 온라인 보안 서비스 이용 여부 |
| `OnlineBackup` | Whether the customer has online backup service | 온라인 백업 서비스 이용 여부 |
| `DeviceProtection` | Whether the customer has device protection service | 기기 보호 서비스 이용 여부 |
| `TechSupport` | Whether the customer has tech support service | 기술 지원 서비스 이용 여부 |
| `StreamingTV` | Whether the customer uses Streaming TV | 스트리밍 TV 이용 여부 |
| `StreamingMovies` | Whether the customer uses Streaming Movies | 스트리밍 영화 서비스 이용 여부 |
| `Contract` | Customer contract type | 계약 유형 |
| `PaperlessBilling` | Whether the customer uses paperless billing | 전자 청구서 이용 여부 |
| `PaymentMethod` | Customer payment method | 결제 방식 |
| `MonthlyCharges` | Monthly amount charged to the customer | 월 청구 요금 |
| `TotalCharges` | Total amount charged to the customer | 총 누적 청구 요금 |
| `Churn` | Whether the customer churned | 고객 이탈 여부 |

---

## 5. Tools Used

- MySQL 8.0
- SQL
- Git / GitHub

---

## 6. Analysis Process

The analysis was conducted in the following order:

1. Created a raw customer churn table
2. Imported the Telco Customer Churn dataset
3. Checked total customer count and churn distribution
4. Calculated the overall churn rate
5. Compared monthly charges between churned and retained customers
6. Estimated monthly revenue loss from churned customers
7. Analyzed churn rate by contract type, internet service, and payment method
8. Analyzed churn rate by streaming service usage
9. Combined contract type and streaming service usage for deeper segmentation
10. Created a retention priority score based on churn rate and estimated revenue loss

분석은 다음 순서로 진행했습니다.

1. 고객 이탈 데이터 테이블 생성
2. Telco Customer Churn 데이터셋 적재
3. 전체 고객 수 및 이탈 여부 분포 확인
4. 전체 이탈률 계산
5. 이탈 고객과 비이탈 고객의 평균 월 요금 비교
6. 이탈 고객으로 인한 월 매출 손실 추정
7. 계약 유형, 인터넷 서비스, 결제 방식별 이탈률 분석
8. 스트리밍 서비스 이용 여부별 이탈률 분석
9. 계약 유형과 스트리밍 서비스 이용 여부를 결합한 세분화 분석
10. 이탈률과 매출 손실을 함께 고려한 리텐션 우선순위 점수 계산

---

## 7. Key Findings

### 7.1 Overall Churn Rate

The overall churn rate was approximately **26.54%**.  
This means that more than one out of four customers had churned.

전체 고객 이탈률은 약 **26.54%**로 나타났습니다.  
이는 고객 4명 중 1명 이상이 서비스를 해지한 것으로 해석할 수 있습니다.

---

### 7.2 Monthly Charges and Churn

Churned customers had a higher average monthly charge than retained customers.

- Average monthly charge of churned customers: **$74.44**
- Average monthly charge of retained customers: **$61.27**

This suggests that customers with higher monthly charges may be more sensitive to pricing and more likely to churn.

이탈 고객의 평균 월 요금은 **74.44달러**로, 비이탈 고객의 평균 월 요금인 **61.27달러**보다 높게 나타났습니다.  
이는 월 요금 부담이 고객 이탈과 관련이 있을 가능성을 보여줍니다.

---

### 7.3 Contract Type and Churn

Month-to-month contract customers showed the highest churn rate.  
This indicates that customers with flexible short-term contracts are more likely to leave the service.

계약 유형별 분석 결과, **Month-to-month 계약 고객의 이탈률이 가장 높게 나타났습니다.**  
이는 월 단위 계약 고객이 장기 계약 고객보다 이탈 가능성이 높다는 것을 의미합니다.

Business implication:

Companies may reduce churn by encouraging month-to-month customers to switch to longer-term contracts through discounts, loyalty rewards, or bundled benefits.

비즈니스적으로는 월 단위 계약 고객에게 장기 계약 전환 할인, 충성 고객 혜택, 번들 혜택 등을 제공하는 전략을 고려할 수 있습니다.

---

### 7.4 Streaming Service Usage and Churn

When only streaming service usage was considered, customers who used neither `StreamingTV` nor `StreamingMovies` showed the highest churn rate among internet service users.

However, this group also had the shortest average tenure.  
Therefore, streaming service usage alone does not fully explain churn.

스트리밍 서비스 이용 여부만 기준으로 분석했을 때는 `StreamingTV`와 `StreamingMovies`를 모두 이용하지 않는 고객군의 이탈률이 가장 높게 나타났습니다.

하지만 이 고객군은 평균 가입 기간도 짧았습니다.  
따라서 스트리밍 서비스 이용 여부만으로 고객 이탈을 단순하게 설명하기는 어렵습니다.

---

### 7.5 Contract Type Changes the Interpretation

After grouping customers by both contract type and streaming service usage, the result changed.

The highest churn rate was found in the following segment:

- Contract: `Month-to-month`
- StreamingTV: `Yes`
- StreamingMovies: `Yes`
- Churn rate: **52.89%**
- Average monthly charge: **$92.65**

This segment has both a high churn rate and a high monthly charge, making it a high-risk and high-value customer group.

계약 유형과 스트리밍 서비스 이용 여부를 함께 고려하자 해석이 달라졌습니다.

가장 높은 이탈률을 보인 고객군은 다음과 같습니다.

- 계약 유형: `Month-to-month`
- StreamingTV: `Yes`
- StreamingMovies: `Yes`
- 이탈률: **52.89%**
- 평균 월 요금: **92.65달러**

이 고객군은 이탈률이 높을 뿐만 아니라 평균 월 요금도 높기 때문에, 이탈 위험이 큰 동시에 매출 기여도도 높은 고객군으로 볼 수 있습니다.

---

### 7.6 Revenue Loss Analysis

The largest estimated monthly revenue loss came from the following segment:

- Contract: `Month-to-month`
- StreamingTV: `No`
- StreamingMovies: `No`
- Estimated monthly revenue loss: **$42,524.30**

Although this group did not have the highest churn rate, it had the largest number of churned customers.  
This shows that the segment with the highest churn rate is not always the segment with the largest revenue loss.

추정 월 매출 손실이 가장 큰 고객군은 다음과 같습니다.

- 계약 유형: `Month-to-month`
- StreamingTV: `No`
- StreamingMovies: `No`
- 추정 월 매출 손실: **42,524.30달러**

이 고객군은 이탈률이 가장 높은 고객군은 아니었지만, 이탈 고객 수가 많아 전체 매출 손실 규모가 가장 크게 나타났습니다.

이를 통해 **이탈률이 가장 높은 고객군과 실제 매출 손실이 가장 큰 고객군은 다를 수 있음**을 확인했습니다.

---

### 7.7 Retention Priority Score

To identify the most important retention target, a retention priority score was calculated using both churn rate and estimated monthly revenue loss.

The highest priority segment was:

- Contract: `Month-to-month`
- StreamingTV: `Yes`
- StreamingMovies: `Yes`
- Churn rate: **52.89%**
- Estimated monthly revenue loss: **$40,499.55**
- Retention priority score: **2142.04**

This group should be prioritized because it has both a very high churn rate and a large revenue impact.

이탈률과 추정 월 매출 손실을 함께 고려하기 위해 Retention Priority Score를 계산했습니다.

가장 높은 우선순위를 보인 고객군은 다음과 같습니다.

- 계약 유형: `Month-to-month`
- StreamingTV: `Yes`
- StreamingMovies: `Yes`
- 이탈률: **52.89%**
- 추정 월 매출 손실: **40,499.55달러**
- Retention Priority Score: **2142.04**

이 고객군은 이탈률이 가장 높고 매출 손실 규모도 크기 때문에, 리텐션 캠페인에서 가장 우선적으로 관리해야 할 고객군으로 볼 수 있습니다.

---

## 8. Business Recommendations

Based on the analysis, the following retention strategies are recommended:

1. Prioritize month-to-month customers with high monthly charges.
2. Offer annual contract upgrade discounts to high-risk customers.
3. Provide loyalty rewards or bundled benefits for customers using multiple services.
4. Monitor customers with short tenure, as they may be more likely to churn.
5. Use both churn rate and revenue impact when deciding retention priorities.

분석 결과를 바탕으로 다음과 같은 고객 유지 전략을 제안할 수 있습니다.

1. 월 단위 계약이면서 월 요금이 높은 고객을 우선 관리합니다.
2. 이탈 위험이 높은 고객에게 연간 계약 전환 할인 혜택을 제공합니다.
3. 여러 서비스를 함께 이용하는 고객에게 번들 혜택이나 충성 고객 리워드를 제공합니다.
4. 가입 기간이 짧은 고객은 이탈 가능성이 높을 수 있으므로 초기 관리가 필요합니다.
5. 리텐션 우선순위를 정할 때 단순 이탈률뿐만 아니라 매출 손실 규모도 함께 고려합니다.

---

## 9. Key Takeaway

The most important insight from this project is that churn analysis should not rely on churn rate alone.

A customer segment with the highest churn rate may not always create the largest revenue loss.  
Therefore, customer retention strategies should consider both churn probability and revenue impact.

이 프로젝트의 핵심 인사이트는 **고객 이탈 분석에서 이탈률만 보는 것은 충분하지 않다**는 점입니다.

이탈률이 가장 높은 고객군과 실제 매출 손실이 가장 큰 고객군은 다를 수 있습니다.  
따라서 고객 유지 전략을 수립할 때는 이탈 가능성과 매출 영향도를 함께 고려해야 합니다.

---

## 10. Project Structure

```text
telco-churn-revenue-analysis/
├── README.md
├── sql/
│   └── 01_telco_churn_analysis.sql
└── data/
    └── WA_Fn-UseC_-Telco-Customer-Churn.csv