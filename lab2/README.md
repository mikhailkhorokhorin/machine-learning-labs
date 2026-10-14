# Lab 2. Classification

## Task

Predict whether a Titanic passenger survived on the [Titanic Dataset](https://www.kaggle.com/datasets/yasserh/titanic-dataset) (891 passengers). The main metric is F1 for `Survived = 1` with the required level $F_1 > 0.70$; accuracy, precision and recall are reported as well. Full statement: [lab02.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/classification/lab02.pdf).

The notebook [lab2.ipynb](lab2.ipynb) covers:

- exploratory analysis and the choice of features: identifying columns (`PassengerId`, `Name`, `Ticket`, `Cabin`) are excluded, and the title is extracted from the name;
- imputation, one-hot encoding and scaling inside pipelines fitted on the training part only;
- a stratified 80/20 split, a most-frequent-class baseline and five models compared on the same split, with confusion matrices;
- feature importance of the tree models and error analysis by passenger group;
- leakage checks: with `PassengerId` added, without `Fare`, and with CV folds grouped by ticket. The deep trees partly memorize families (CV F1 drops by 0.03–0.05), the chosen SVM does not.

## Data

[data/titanic.csv](data/titanic.csv) — the original 891-row passenger list.

## Results

| Model | CV F1 | Test accuracy | Test precision | Test recall | Test F1 |
| --- | --- | --- | --- | --- | --- |
| Baseline | 0.000 | 0.615 | 0.000 | 0.000 | 0.000 |
| Decision Tree | 0.728 | 0.804 | 0.750 | 0.739 | 0.745 |
| Random Forest | 0.732 | 0.804 | 0.758 | 0.725 | 0.741 |
| Gradient Boosting | 0.747 | 0.810 | 0.787 | 0.696 | 0.738 |
| **SVM** | **0.749** | **0.827** | **0.839** | 0.681 | **0.752** |
| KNN | 0.718 | 0.804 | 0.804 | 0.652 | 0.720 |

## Run

```bash
make run LAB=lab2
```
