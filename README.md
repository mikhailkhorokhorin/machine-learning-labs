# Machine Learning Labs

Jupyter notebooks for the Machine Learning Concepts course (MAI), built with scikit-learn and pgmpy. Tasks and materials: [lesopylka/ml_course_mai](https://github.com/lesopylka/ml_course_mai).

| No. | Topic | Task |
| --- | --- | --- |
| 1 | [Regression](lab1/) | [lab01.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/regression/lab01.pdf) |
| 2 | [Classification](lab2/) | [lab02.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/classification/lab02.pdf) |
| 3 | [Hyperparameter optimization](lab3/) | [lab03.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/hyperparameters/lab03.pdf) |
| 4 | [Bayesian network](lab4/) | [lab04.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/bayesian/lab04.pdf) |

## Run

The devcontainer installs the pinned dependencies from `requirements.txt`. Outside of it:

```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
make run LAB=lab1
make test
```

Notebooks are committed without outputs (the `nbstripout` pre-commit hook strips them): open one in Jupyter and run all cells, or execute it with `make run LAB=labN` (`make test` runs all of them). The executed copies go to `build/artifacts/notebooks/`.
