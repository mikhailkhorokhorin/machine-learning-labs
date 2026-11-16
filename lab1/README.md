# Lab 1. Regression

## Task

Go through the full cycle of a regression task: from exploratory data analysis and a simple baseline to the comparison of several models and the analysis of the results.

The required level of quality is $\mathrm{RMSE} < 0.70$ on a common hidden test set. With $\mathrm{RMSE} \ge 0.70$ the work gets at most 2 points and has to be improved.

### Data

Study the [Wine Quality](https://archive.ics.uci.edu/dataset/186/wine+quality) dataset from the UCI Machine Learning Repository before training any model. The target is the expert grade `quality`.

The analysis must not stop at tables and plots: every main result is followed by a short meaningful conclusion. For example, it is not enough to write "the correlation of alcohol and quality is ...": explain what the dependency means for the task and whether it should be taken into account in modeling.

### Train/test split

Split the data into a training and a test part. The test part is used only for the final evaluation; every decision about the model, the features and the parameters is made without the answers of the test part. Fix `random_state` so that the experiment can be reproduced.

Explain:

- the chosen sizes of the training and test parts;
- why this way of splitting was chosen;
- what problems arise if models are evaluated many times on the same test part.

### Baseline

Before any machine learning, build a simple baseline that predicts one constant for every object. Choose the constant that is reasonable for the chosen metric and evaluate the baseline on the test part. The baseline answers a simple question: does a trained model really extract useful information from the features, or is it no better than a trivial prediction? The baseline must be in the final table.

### Metrics

The main metric is RMSE, MAE is computed as well, and both are reported for every model:

$$
\mathrm{RMSE} = \sqrt{\frac{1}{n}\sum_{i=1}^{n} (y_i - \hat y_i)^2},
\qquad
\mathrm{MAE} = \frac{1}{n}\sum_{i=1}^{n} \lvert y_i - \hat y_i \rvert .
$$

Answer the questions:

- what MAE shows;
- what RMSE shows;
- why RMSE reacts more strongly to large errors;
- why MAE and RMSE of the same model can differ noticeably.

The leaderboard uses RMSE: the lower, the better.

### Models

- **Linear Regression.** Analyze the result and the coefficients, and find the features with the largest influence on the prediction. Comparing the coefficients of features measured on completely different scales directly can be incorrect: decide whether scaling is needed and how it affects the interpretation of the coefficients.
- **Random Forest Regressor.** Evaluate it by RMSE and MAE, study its feature importance, find the most important features and compare them with the conclusions of the exploratory analysis and of the linear regression.
- **Gradient Boosting Regressor.** Evaluate it by the same metrics, study its feature importance and compare the important features with those of the random forest.

### Fair comparison

All models are compared under the same conditions; different test parts for different models are not allowed. Build the final table:

| Model | RMSE | MAE |
| --- | --- | --- |
| Baseline | ... | ... |
| Linear Regression | ... | ... |
| Random Forest | ... | ... |
| Gradient Boosting | ... | ... |

Find the models that beat the baseline, compare the models with each other and explain the possible reasons of the differences. Writing "Gradient Boosting was better" is not enough: relate the result to the properties of the data and of the algorithms.

### Feature importance

For the models that provide feature importance:

1. get the importance values;
2. visualize them;
3. find the most important features;
4. compare the results of different models;
5. compare them with the results of the exploratory analysis.

Can one claim, based on feature importance, that changing a feature causes a change of the wine quality? Why?

### Error analysis

A good value of the final metric does not mean that the model works equally well on every object. For the best model:

- look at the distribution of the errors;
- find the objects with the largest errors;
- compare the true and the predicted values of `quality`;
- check whether the model works equally well for different values of `quality`.

Pick several objects with especially large errors and try to explain the possible reason. Think about why the model may predict rare values of `quality` worse.

## Solution

The notebook [solution.ipynb](solution.ipynb) uses the red wines only (1599 wines), as the course teacher asked:

- exploratory analysis with conclusions, including the skewness of the features;
- a stratified 80/20 split grouped by duplicate rows: 15% of the rows are exact copies and would otherwise leak into the test part;
- a constant baseline (the training mean, optimal for RMSE), Linear Regression (plain and with a Yeo-Johnson power transform of the skewed features), Random Forest and Gradient Boosting, compared on the same split, with the variants chosen by grouped cross-validation on the training part only;
- feature importance of both tree models compared with the standardized linear coefficients and the correlations;
- error analysis of the best model by grade and on the largest mistakes.

## Build and run

```bash
make run LAB=lab1
```

The notebook takes about two minutes to execute.

## Example

Cross-validation on the training part, RMSE and MAE on the held-out test part (20%):

| Model | CV RMSE | Test RMSE | Test MAE |
| --- | --- | --- | --- |
| Baseline (training mean) | 0.809 | 0.799 | 0.678 |
| Linear Regression | 0.652 | 0.657 | 0.506 |
| Linear Regression + Yeo-Johnson | 0.649 | 0.645 | 0.496 |
| **Random Forest** | **0.633** | **0.634** | **0.491** |
| Gradient Boosting | 0.649 | 0.642 | 0.493 |

Every model passes $\mathrm{RMSE} < 0.70$; the best one, Random Forest, removes about $1 - (0.634 / 0.799)^2 \approx 37\%$ of the squared error of the baseline.

## Notes

Data: [data/winequality-red.csv](data/winequality-red.csv) is the original UCI file (`;`-separated).
