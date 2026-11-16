# Lab 4. Bayesian Network

## Task

Learn to represent dependencies between random variables with a Bayesian network, build the structure of the graph yourself and perform probabilistic inference when additional information is available.

### Data

Choose an open dataset with several features between which dependencies can be meaningfully assumed. Using the dataset and the ready network structure of the [example](https://www.kaggle.com/code/ademox02/bayesian-networks) directly is not recommended: find another dataset and propose the graph yourself. The data should not require a long study of a specific domain.

Briefly describe:

- what one object is;
- which variables there are;
- what they mean;
- which dependencies between them can exist.

### Data preparation

Explore the data and prepare it for building a Bayesian network. If continuous features have to be turned into categories, choose the discretization yourself and justify it. Pay attention to missing values, rare categories, the number of possible states of the variables and whether there are enough observations.

### Questions

Before building the network, state at least three questions to answer with the probabilistic model, for example:

- how the probability of an event $A$ changes if $B$ is known;
- what the probability of $A$ is when $B$ and $C$ hold at the same time;
- how additional information changes the distribution of the variable of interest.

The questions must make sense for the chosen dataset.

### Graph

Propose the structure of the network yourself. The graph must be a directed acyclic graph (DAG). For the main edges explain why a dependency is assumed and why this direction is chosen. Do not add an edge only because of a high correlation between the features. Visualize the network: the graph must be readable and contain no vertices or edges without an explanation.

### Conditional probabilities

Estimate the parameters of the network from the data. Study the conditional probability tables of several of the most interesting variables and check how well the values agree with the data and with your expectations. An unusual result must be explained, not just printed.

### Inference

Answer the questions stated at the beginning with the network. For every case compare the probability before and after the additional information, for example $P(A)$ and $P(A \mid B)$. Make at least three different probabilistic queries and interpret the results.

### Experiment with evidence

Choose one variable of interest and add information about other variables step by step, studying how its distribution changes:

1. nothing is known;
2. $B$ is known;
3. $B$ and $C$ are known;
4. $B$, $C$ and $D$ are known.

Present the result as a table or a plot and explain the observed changes through the structure of the network.

### Structure analysis

Remove one edge of the network, repeat one of the queries and compare the results before and after the change. Explain:

- whether the result changed;
- why the structure of the graph affects inference;
- how confidently the direction of edges can be chosen from observed data alone.

### Causality

Can the network be considered a causal model? A directed arrow between variables does not prove a cause-and-effect relation by itself. If some relation is considered causal, explain what the assumption is based on.

### Summary

Briefly state:

- what was learned with the network;
- which dependencies turned out to be the most interesting;
- how evidence affects the probabilities;
- how much the results depend on the chosen structure;
- what limitations the model has.

## Solution

The notebook [solution.ipynb](solution.ipynb) builds a network with `pgmpy` on the [Student Performance](https://archive.ics.uci.edu/dataset/320/student+performance) dataset (UCI, Portuguese language course, 649 students):

- eight variables: sex, going out, weekend alcohol, mother's education, past failures, wish for higher education, study time and the final grade, discretized into 2–3 states;
- a hand-made DAG with 11 edges and a justification of every edge and its direction;
- parameters estimated with a Bayesian (BDeu) estimator; the model is checked against the data, alternative edges are compared by BIC, and the sensitivity to the prior is shown;
- three questions answered by inference, comparing $P(A)$ with $P(A \mid B)$;
- an experiment with sequentially added evidence, the "explaining away" effect, the removal of an edge and a discussion of causality.

## Build and run

```bash
make run LAB=lab4
```

## Example

Answers of the network to the questions, before and after the evidence:

| Question | $P(A)$ | $P(A \mid B)$ |
| --- | --- | --- |
| $P(\text{fail} \mid \text{past failures})$ | 0.157 | 0.490 |
| $P(\text{heavy weekend drinking} \mid \text{male}, \text{study time} < 2\ \text{h a week})$ | 0.202 | 0.402 |
| $P(\text{no higher-education plans} \mid \text{fail})$ | 0.109 | 0.327 |
| $P(\text{past failures} \mid \text{fail})$ | 0.157 | 0.489 |

## Notes

Data: [data/student-por.csv](data/student-por.csv) is the original UCI file (`;`-separated).
