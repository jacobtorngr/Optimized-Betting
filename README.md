# Optimized Betting
Have you ever wondered if you could bet on multiple teams in a sports event to guarantee a profit? This MATLAB script lets you set a
budget, and uses constrained optimization to find the optimum set of bets in the sense of minimum potential loss.
Or rather, minimum maximum negative profit.

## Example
In the football World Cup 2022, the odds for the top 12 ranked teams were,
```matlab
odds = [3.5, 5.5, 6.5, 7, 9, 13, 15, 34, 67, 67, 101, 176];
```
meaning a bet on Brazil would yield a profit of 2.5 times the money if they won, France 4.5 times the money and so on. If we omit Brazil
with the lowest odds and bet $1000 according to:

```matlab
bets = [222, 170, 163, 123, 86, 74, 33, 19, 23,  46, 41];
```
A win from either of those countries would yield a profit of:

```matlab
profit = [221, 105, 141, 107, 118, 110, 122, 273, 541, 3646, 6216];
```
Thus greatly increasing the probability of winning compared to only betting on only one team.
