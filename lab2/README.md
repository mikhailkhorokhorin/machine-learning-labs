# Lab 2. Classification

## Task

Go through the full cycle of a classification task: from data analysis and a baseline to the comparison of several algorithms and the analysis of metrics, errors and feature importance.

### Data

Use the [Titanic Dataset](https://www.kaggle.com/datasets/yasserh/titanic-dataset). The target is `Survived`: predict whether a passenger survived (1) or not (0).

Make an exploratory analysis: study the features, their types, missing values, duplicates and the distribution of the target. Pay attention to the features that need special processing and to the features that can cause leakage or a meaningless memorization of objects. Every main result is followed by a short meaningful conclusion.

### Data preparation and split

Prepare the data for training: process the missing values and the categorical features, and briefly justify the chosen ways of processing.

Split the data into a training and a test part keeping the class ratio. Fix `random_state`. All models are trained and evaluated on the same split. The test part is used only for the final evaluation, and every transformation whose parameters are computed from data is fitted on the training part only.

Think about which of the algorithms below need feature scaling and why.

### Baseline and leaderboard

Before training the models, build a dummy baseline that always predicts the most frequent class, and compute the same metrics for it as for the other models.

The main metric of the lab and of the leaderboard is the F1-score for the class `Survived = 1`. It takes both precision and recall into account and shows the quality of a binary classifier better than accuracy alone when the classes are not equally represented.

The required level of quality is $F_1 > 0.70$ on a test set common to the whole group. The leaderboard ranks by F1: the higher, the better. Tuning the solution directly on the test set is forbidden.

### Metrics

Evaluate every model by accuracy, precision, recall and F1, and build a confusion matrix for each one. With $TP$, $FP$, $FN$, $TN$ the cells of the confusion matrix:

$$
\mathrm{Accuracy} = \frac{TP + TN}{TP + FP + FN + TN},
\qquad
\mathrm{Precision} = \frac{TP}{TP + FP},
\qquad
\mathrm{Recall} = \frac{TP}{TP + FN},
\qquad
F_1 = \frac{2 \cdot \mathrm{Precision} \cdot \mathrm{Recall}}{\mathrm{Precision} + \mathrm{Recall}} .
$$

Do not stop at the values of the metrics: explain which errors the model makes and how a false positive differs from a false negative in this task.

### Models

- **Decision Tree.** Evaluate the model and study its feature importance. Compare the quality on the training and the test part and conclude whether there are signs of overfitting.
- **Random Forest.** Evaluate it by the same metrics, study its feature importance and compare the most important features with those of the decision tree.
- **Gradient Boosting.** Evaluate it, study its feature importance and compare the result with the random forest.
- **Support Vector Machine.** Decide whether feature scaling is needed for this algorithm and why. Evaluate the model by the same metrics.
- **K-Nearest Neighbors.** Explain why the scale of the features is especially important for an algorithm based on the distance between objects. Evaluate the model by the same metrics.

### Fair comparison

All models are compared under the same conditions. Build the final table with accuracy, precision, recall and F1 for the baseline and all five models, find the models that passed the required level and explain the possible reasons of the differences between them.

### Feature importance

For the models that provide it:

1. visualize the feature importance;
2. find the most important features;
3. compare the results of Decision Tree, Random Forest and Gradient Boosting;
4. compare the importance with the conclusions of the exploratory analysis.

Can one claim that a feature important for the model is a cause of survival? Explain.

### Error analysis

For the best model study the confusion matrix in detail: which types of errors are more frequent and for which groups of passengers the model makes the most noticeable mistakes. Pick several misclassified objects and try to explain the possible reasons of the errors. Separately check that the high quality of the model is not caused by features that in fact identify a particular passenger or carry undesirable information.

## Solution

The group test set is a Kaggle competition built from the dataset: `train.csv` has 891 labeled passengers and `test.csv` 1000 passengers without answers, with seven features (`Pclass`, `Sex`, `Age`, `SibSp`, `Parch`, `Fare`, `Embarked`) and an `Id` column that only matches the rows. The notebook [solution.ipynb](solution.ipynb) covers:

- exploratory analysis: missing values, duplicates, the identifying `Id` column and the main survival factors;
- imputation, one-hot encoding and scaling inside pipelines fitted on the training part only;
- a stratified 80/20 split of `train.csv`, a most-frequent-class baseline and the five models compared by 5-fold cross-validation;
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

Data: [data/train.csv](data/train.csv) and [data/test.csv](data/test.csv) are the competition files (`test.csv` has no answers). The metric of the competition is binary F1 with the positive class `Survived = 1`.
