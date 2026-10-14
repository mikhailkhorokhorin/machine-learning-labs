# Lab 4. Bayesian network

## Task

Choose an open dataset, propose the structure of a Bayesian network yourself, estimate its parameters and answer questions by probabilistic inference. Full statement: [lab04.pdf](https://github.com/lesopylka/ml_course_mai/blob/main/bayesian/lab04.pdf).

The notebook [lab4.ipynb](lab4.ipynb) builds a network with `pgmpy` on the [Student Performance](https://archive.ics.uci.edu/dataset/320/student+performance) dataset (UCI, Portuguese course, 649 students):

- eight variables: sex, going out, weekend alcohol, mother's education, past failures, wish for higher education, study time and the final grade, discretized into 2–3 states;
- a hand-made DAG (11 edges) with a justification of every edge and its direction;
- parameters estimated with a Bayesian (BDeu) estimator; the model is checked against the data on connected and non-connected pairs, alternative edges are compared by BIC, and the sensitivity to the prior is shown;
- three questions answered by inference, comparing $P(A)$ with $P(A \mid B)$;
- an experiment with sequentially added evidence, the "explaining away" effect, removal of an edge and a discussion of causality.

## Data

[data/student-por.csv](data/student-por.csv) — the original UCI file (`;`-separated).

## Results

| Question | Prior | Posterior |
| --- | --- | --- |
| $P(\text{fail} \mid \text{past failures})$ | 0.157 | 0.490 |
| $P(\text{heavy weekend drinking} \mid \text{male}, \text{study time} < 2\ \text{h})$ | 0.202 | 0.402 |
| $P(\text{no higher-education plans} \mid \text{fail})$ | 0.109 | 0.327 |
| $P(\text{past failures} \mid \text{fail})$ | 0.157 | 0.489 |

## Run

```bash
make run LAB=lab4
```
