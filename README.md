# 🚀 Intrusion Detection using Machine Learning

Welcome to the **Intrusion Detection Project**! This project uses various machine learning algorithms like Random Forest, SVM, and XGBoost to detect anomalies in a network traffic dataset. By reducing the dataset size and focusing on key features, we aim to build efficient models that can classify traffic as "normal" or "anomaly."

---

## 📂 Project Overview

The objective of this project is to:

- 📊 Build models to classify network traffic as **normal** or **anomaly**.
- 🧠 Use feature selection with **Mean Decrease Gini Impurity** to focus on the most important features.
- ⚙️ Train models using **Random Forest**, **SVM (Radial Kernel)**, and **XGBoost**, comparing their performance using accuracy, precision, recall, and more.

---

## 📁 Files and Structure

| **File**                      | **Description** |
|-------------------------------|-----------------|
| `KDDTrain.csv`                 | The original dataset containing labeled network traffic records. |
| `15kpointsofeachclassfinal.csv`| A reduced dataset with 15,000 points per class ("normal" and "anomaly"). |
| `50kpointsofeachclassfinal.csv`| A larger version of the reduced dataset with 50,000 points per class. |

---

## ⚙️ Code Breakdown

### 1. 📝 `MakingCSVFileWithLessDataPoints.R`

This script reduces the dataset size by selecting 15,000 records from both the "normal" and "anomaly" classes:

- **Input**: `KDDTrain.csv`.
- **Output**: A shuffled dataset saved as `15kpointsofeachclassfinal.csv`.

### 2. 🌟 `MeanDecreaseGiniImpurityFeatureSelection.R`

This script ranks the features using a Random Forest model based on **Mean Decrease Gini Impurity**:

- **Input**: `15kpointsofeachclassfinal.csv`.
- **Process**: 
  - Feature selection to focus on the most relevant features.
  - Creation of multiple datasets with the top 10, 15, 20, etc., features.
- **Output**: Datasets with reduced feature sets.

### 3. 💻 `AllalgoCP.R`

This script compares three machine learning algorithms—Random Forest, SVM, and XGBoost:

- **Random Forest**: Trained using cross-validation and fine-tuned `mtry` values.
- **SVM**: Trained with a **Radial Kernel**.
- **XGBoost**: Trained with hyperparameter tuning using cross-validation.
  
- **Metrics**: 
  - **Accuracy** 🎯
  - **Precision** ✅
  - **Recall** 🔍
  - **F1-Score** ⚖️
  - **Specificity** 🔑

## 📊 Results

After performing feature selection and training the models, we evaluated their performance on the test dataset. The evalution of each model is present in the pdf `Intrusion Detection.pdf`

---

## 🛠 Setup Instructions

### Install the Required Libraries

Run the following commands to install the necessary R packages:

```r
install.packages(c("randomForest", "caret", "kernlab", "xgboost"))
