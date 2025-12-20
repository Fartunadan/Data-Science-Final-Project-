# Data-Science-Final-Project: Predincting Rent Burden in Florida

## Authors: Fartun Adan, Kaela Girod, Daija Yisrael

## **Objective:** 

To determine whether we can develop a model that adequately predicts a household's rent burden status using socioeconomic and demographic characteristics and to learn which variables are the most important in predicting the extent to which a household is rent burdened.

## Steps for Running the Project:

1.  Run final_project_cleaning.qmd to load the ACS data and perform the necessary data cleaning and preprocessing on the extracted ACS dataset, preparing the final sample for predictive modeling.
2.  Run final_project.qmd to estimate predictive models for rent burden in Florida using the cleaned 2023 ACS data:
3.  Read final_project_writeup.qmd, which contains the project motivation, problem statement, research question, model interpretation, conclusions, and policy recommendations.

## Files Directory

1.   **final_project_cleaning.qmd:** This quarto file includes the data cleaning steps of the ACS extracted data to prepare our sample for predictive modeling.

2.  **final_project.qmd:** This quarto file includes the code for each predictive model to predict rent-burden in Flordida using 2023 ACS data. Model 1 is a decision tree with a binary rent-burden variable. Model 2 is a decision tree with a three level factor rent-burden variable (rent burdened, not rent burdened, extremely rent burdened). Model 3 is an elastic net with factor variables.

3.  **final_project_writeup.qmd:** This quarto file includes our project motivation, problem statement, research question, model interpretation, conclusion, and recommendation.

4.  **image01.avif:** Image of rent burden for write-up

5.  **model1dt.png:** Image of Model 1 decision tree

6.   **model1matrix.png:**Image of Model 1 matrix

7.   **model2dt.png:** Image of Model 1 decision tree

8.   **model2matrix.png:** Image of Model 2 matrix

9.   **model3matrix.png:** Image of Model 3 matrix

10. **README.md:** project documentation
