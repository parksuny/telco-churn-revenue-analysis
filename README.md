## Dataset Columns

Kaggle download site: https://www.kaggle.com/datasets/blastchar/telco-customer-churn

This dataset contains customer information, subscribed services, account details, and churn status from a telecommunications company.

| Column | Description | Example Values |
|---|---|---|
| `customerID` | Unique ID for each customer | `7590-VHVEG` |
| `gender` | Whether the customer is male or female | `Male`, `Female` |
| `SeniorCitizen` | Whether the customer is a senior citizen or not | `1`, `0` |
| `Partner` | Whether the customer has a partner | `Yes`, `No` |
| `Dependents` | Whether the customer has dependents | `Yes`, `No` |
| `tenure` | Number of months the customer has stayed with the company | `0`–`72` |
| `PhoneService` | Whether the customer has phone service | `Yes`, `No` |
| `MultipleLines` | Whether the customer has multiple phone lines | `Yes`, `No`, `No phone service` |
| `InternetService` | Type of internet service used by the customer | `DSL`, `Fiber optic`, `No` |
| `OnlineSecurity` | Whether the customer has online security service | `Yes`, `No`, `No internet service` |

## Dataset Overview

- Total records: 7,043 customers
- Gender distribution: approximately 50% Male and 50% Female
- `SeniorCitizen` is encoded as:
  - `1`: Senior citizen
  - `0`: Not a senior citizen
- `tenure` ranges from 0 to 72 months
- The dataset includes both categorical variables, such as `Contract`, `PaymentMethod`, and `InternetService`, and numerical variables, such as `tenure`, `MonthlyCharges`, and `TotalCharges`.