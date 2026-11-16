# Lab 3. Hyperparameter Optimization

## Task

Learn to tune the hyperparameters of a model correctly with cross-validation, compare search strategies and estimate how the hyperparameters affect the quality of the model.

### Task and model

Use the task of lab 1 or lab 2 and choose one of the models used there. Fix its initial parameters and its quality before the optimization: the initial model is the baseline of this lab.

### Hyperparameters

Choose at least three significant hyperparameters of the algorithm. For each of them:

- explain its meaning;
- define a reasonable range of values;
- assume how changing it can affect the model.

Do not add many parameters only to enlarge the search space: the goal is to understand the influence of the hyperparameters, not to try as many combinations as possible.

### Cross-validation

Choose the hyperparameters with cross-validation; choose the number of folds and justify it. The test part does not take part in the search. Answer the questions:

- why cross-validation is needed;
- why one train/test split is not enough to choose parameters;
- what happens if hyperparameters are chosen by the test score many times.

### Grid Search

Search over a grid fixed in advance. Record the search space, the number of checked combinations, the best set of hyperparameters, the cross-validation score and the run time.

### Random Search

Search with a random choice of combinations under a comparable computational budget. Compare Random Search with Grid Search by the found quality, the number of checked combinations and the run time. Explain in which situations a random search can be preferable to a full grid.

### Influence of hyperparameters

For several chosen hyperparameters, study how the quality of the model depends on their values and visualize the results. Try to find the regions of underfitting, reasonable complexity and overfitting, and explain the observed behavior.

### Final model

After the search, train the model with the chosen hyperparameters and only then evaluate it on the test part. Compare three results: the initial model, the best result of Grid Search and the best result of Random Search, with the CV score and the test score for each. Answer the questions:

- how much the optimization improved the quality;
- whether the improvement on cross-validation matches the result on the test part;
- if not, how this can be explained.

### Stability

Look not only at the mean cross-validation score but also at the results of the individual folds, and estimate their spread. Think about why two models with the same mean quality can differ in the stability of the result.

### Fair experiment

Using the test part to choose hyperparameters is a critical error. Every decision about the parameters is made on the training part with cross-validation; the test part is used only for the final check of the chosen solution.

## Solution

The notebook [solution.ipynb](solution.ipynb) uses the Titanic task from [lab 2](../lab2/) with the same features, preprocessing and split, and tunes its best model, an SVM with the RBF kernel, by F1:

- `C`, `gamma` and `class_weight`: their meaning, ranges and expected effect;
- repeated stratified 5-fold cross-validation (15 folds) on the training part only;
- Grid Search over $11 \times 9 \times 2 = 198$ combinations against Random Search with the same budget;
- validation curves and heatmaps with the regions of underfitting, reasonable complexity and overfitting;
- the final test evaluation with confusion counts, a fold-by-fold comparison with the baseline and the stability of the results.

## Build and run

```bash
make run LAB=lab3
```

The notebook takes about two minutes to execute.

## Example

CV on the training part, F1 on the held-out test part:

| Model | Parameters | CV F1 | CV std | Test F1 |
| --- | --- | --- | --- | --- |
| Baseline | `C=1`, `gamma="scale"`, `class_weight=None` | 0.730 | 0.040 | 0.793 |
| Grid Search | `C=1`, `gamma=0.316`, `class_weight="balanced"` | **0.745** | 0.034 | **0.797** |
| Random Search | $C \approx 0.95$, $\gamma \approx 0.25$, `class_weight="balanced"` | 0.742 | **0.031** | 0.788 |

Tuning gives a small CV gain (+0.015, better on 12 of 15 folds; optimistic, since the winner was chosen on the same folds). On the 179-passenger test part the difference in F1 is within noise, although the tuned model finds more survivors at the cost of more false positives.

## Notes

The data is read from [../lab2/data/train.csv](../lab2/data/train.csv).
