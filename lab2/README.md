# Lab 2. Classification

## Task

Predict whether a Titanic passenger survived, using the files of the course Kaggle competition built from the [Titanic Dataset](https://www.kaggle.com/datasets/yasserh/titanic-dataset): 891 labeled passengers and 1000 passengers for the leaderboard, seven features (`Pclass`, `Sex`, `Age`, `SibSp`, `Parch`, `Fare`, `Embarked`). The main metric is F1 for `Survived = 1` with the required level $F_1 > 0.70$; accuracy, precision and recall are reported as well. Full statement: [lab02.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/classification/lab02.pdf).

The notebook [lab2.ipynb](lab2.ipynb) covers:

- exploratory analysis: missing values, duplicates, the identifying `Id` column and the main survival factors;
- imputation, one-hot encoding and scaling inside pipelines fitted on the training part only;
- a stratified 80/20 split, a most-frequent-class baseline and five models (Decision Tree, Random Forest, Gradient Boosting, SVM, KNN) compared by 5-fold CV;
- a decision threshold for the best model chosen on out-of-fold predictions (so its CV F1 is slightly optimistic), then a single evaluation on the test part with confusion matrices;
- feature importance of the tree models, error analysis by passenger group and checks for identifying features (`Id`, `Fare`);
- the Kaggle submission [submission.csv](submission.csv), made by the chosen model retrained on all 891 passengers.

## Build and run

```bash
make run LAB=lab2
```

## Example

CV F1 on the training part, the other metrics on the held-out test part (20%):

| Model | CV F1 | Test accuracy | Test precision | Test recall | Test F1 |
| --- | --- | --- | --- | --- | --- |
| Baseline | 0.000 | 0.615 | 0.000 | 0.000 | 0.000 |
| Decision Tree | 0.670 | 0.810 | 0.769 | 0.725 | 0.746 |
| Random Forest | 0.711 | 0.838 | 0.812 | 0.754 | 0.782 |
| Gradient Boosting | 0.716 | 0.866 | 0.959 | 0.681 | 0.797 |
| SVM | 0.736 | 0.860 | 0.923 | 0.696 | 0.793 |
| KNN | 0.701 | 0.832 | 0.855 | 0.681 | 0.758 |
| **SVM, threshold −0.2** | **0.748** | **0.866** | 0.925 | **0.710** | **0.803** |

## Notes

Data: [data/train.csv](data/train.csv) and [data/test.csv](data/test.csv) are the competition files (`test.csv` has no answers). `Id` only matches the rows and is not used as a feature.
