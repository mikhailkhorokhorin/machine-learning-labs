# Lab 3. Hyperparameter optimization

## Task

Tune one model from a previous lab with cross-validation, compare Grid Search with Random Search and study how hyperparameters affect the model. Full statement: [lab03.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/hyperparameters/lab03.pdf).

The notebook [lab3.ipynb](lab3.ipynb) uses the Titanic task from [lab 2](../lab2/) with the same features and split, and tunes `GradientBoostingClassifier` by F1:

- `n_estimators`, `learning_rate` and `max_depth`: their meaning, ranges and expected effect;
- repeated stratified 5-fold CV (15 folds) on the training part only;
- Grid Search over 96 combinations vs Random Search with the same budget;
- validation curves with regions of underfitting, reasonable complexity and overfitting;
- final test evaluation, a fold-by-fold comparison with the baseline and the stability of the results.

Tuning gives a small but consistent CV gain (+0.016, better on 10–11 of 15 folds) that does not show on the 179-passenger test: the difference there is within noise.

The data is read from [../lab2/data/titanic.csv](../lab2/data/titanic.csv).

## Results

| Model | Parameters | CV F1 | CV std | Test F1 |
| --- | --- | --- | --- | --- |
| Baseline | 100 trees, lr 0.1, depth 3 | 0.757 | 0.039 | **0.738** |
| Grid Search | 400 trees, lr 0.01, depth 4 | 0.773 | 0.043 | 0.734 |
| Random Search | 93 trees, lr 0.047, depth 4 | **0.774** | 0.045 | 0.719 |

## Run

```bash
make run LAB=lab3
```

The notebook takes about two minutes to execute.
