# Lab 1. Regression

## Task

Predict the expert grade `quality` of a wine from its physicochemical tests on the [Wine Quality](https://archive.ics.uci.edu/dataset/186/wine+quality) dataset (UCI, red wines only, 1599 wines). The main metric is RMSE with the required level $\mathrm{RMSE} < 0.70$, MAE is reported as well. Full statement: [lab01.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/regression/lab01.pdf).

The notebook [lab1.ipynb](lab1.ipynb) covers:

- exploratory analysis with conclusions;
- a stratified 80/20 split grouped by duplicate rows (15% of the rows are exact copies and would otherwise leak into the test);
- a constant baseline, Linear Regression (plain and with a Yeo-Johnson power transform of the skewed features), Random Forest and Gradient Boosting compared on the same split, with hyperparameters chosen by grouped cross-validation on the training part only;
- feature importance of both tree models compared with the standardized linear coefficients and the correlations;
- error analysis of the best model by grade and on the largest mistakes.

## Build and run

```bash
make run LAB=lab1
```

The notebook takes about two minutes to execute.

## Example

Results of the notebook on the held-out test part (20%):

| Model | CV RMSE (train) | Test RMSE | Test MAE |
| --- | --- | --- | --- |
| Baseline (train mean) | 0.809 | 0.799 | 0.678 |
| Linear Regression | 0.652 | 0.657 | 0.506 |
| Linear Regression + Yeo-Johnson | 0.649 | 0.645 | 0.496 |
| **Random Forest** | **0.633** | **0.634** | **0.491** |
| Gradient Boosting | 0.649 | 0.642 | 0.493 |

## Notes

Data: [data/winequality-red.csv](data/winequality-red.csv) is the original UCI file (`;`-separated); the white-wine file is kept in `data/` but not used.
