# Lab 1. Regression

## Task

Predict the expert grade `quality` of a wine from its physicochemical tests on the [Wine Quality](https://archive.ics.uci.edu/dataset/186/wine+quality) dataset (UCI, red and white parts merged, 6497 wines). The main metric is RMSE with the required level $\mathrm{RMSE} < 0.70$, MAE is reported as well. Full statement: [lab01.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/regression/lab01.pdf).

The notebook [lab1.ipynb](lab1.ipynb) covers:

- exploratory analysis with conclusions;
- a stratified 80/20 split grouped by duplicate rows (18% of the rows are exact copies and would otherwise leak into the test);
- a constant baseline, Linear Regression, Random Forest and Gradient Boosting compared on the same split, with hyperparameters chosen by grouped cross-validation on the training part only;
- feature importance of both tree models compared with the standardized linear coefficients and the correlations;
- error analysis of the best model by grade and on the largest mistakes.

## Data

[data/winequality-red.csv](data/winequality-red.csv) and [data/winequality-white.csv](data/winequality-white.csv) are the original UCI files (`;`-separated).

## Results

| Model | CV RMSE (train) | Test RMSE | Test MAE |
| --- | --- | --- | --- |
| Baseline (train mean) | 0.873 | 0.873 | 0.686 |
| Linear Regression | 0.736 | 0.731 | 0.563 |
| **Random Forest** | **0.685** | **0.670** | **0.516** |
| Gradient Boosting | 0.697 | 0.685 | 0.525 |

## Run

```bash
make run LAB=lab1
```

The notebook takes about two minutes to execute.
