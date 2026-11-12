# Lab 3. Hyperparameter Optimization

## Task

Tune one model from a previous lab with cross-validation, compare Grid Search with Random Search and study how hyperparameters affect the model. Full statement: [lab03.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/hyperparameters/lab03.pdf).

The notebook [lab3.ipynb](lab3.ipynb) uses the Titanic task from [lab 2](../lab2/) with the same features and split, and tunes its best model, an RBF SVM, by F1:

- `C`, `gamma` and `class_weight`: their meaning, ranges and expected effect;
- repeated stratified 5-fold CV (15 folds) on the training part only;
- Grid Search over 198 combinations vs Random Search with the same budget;
- validation curves and heatmaps with regions of underfitting, reasonable complexity and overfitting;
- final test evaluation with confusion counts, a fold-by-fold comparison with the baseline and the stability of the results.

## Build and run

```bash
make run LAB=lab3
```

The notebook takes about two minutes to execute.

## Example

Results of the notebook (CV on the training part, F1 on the held-out test part):

| Model | Parameters | CV F1 | CV std | Test F1 |
| --- | --- | --- | --- | --- |
| Baseline | `C=1`, `gamma="scale"`, `class_weight=None` | 0.730 | 0.040 | 0.793 |
| Grid Search | `C=1`, `gamma=0.316`, `class_weight="balanced"` | **0.745** | 0.034 | **0.797** |
| Random Search | `C≈0.95`, `gamma≈0.25`, `class_weight="balanced"` | 0.742 | **0.031** | 0.788 |

## Notes

Tuning gives a small CV gain (+0.015, better on 12 of 15 folds; optimistic, since the winner was chosen on the same folds). On the 179-passenger test the difference in F1 is within noise, although the tuned model finds more survivors at the cost of more false positives.

The data is read from [../lab2/data/train.csv](../lab2/data/train.csv).
