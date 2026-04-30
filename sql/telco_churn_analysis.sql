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
