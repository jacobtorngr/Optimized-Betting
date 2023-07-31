 % Monetary units to bet, this is the (equality) constraint
bet = 1000;

% Top 12 lowest odds from World Cup 2022
%odds = [3.5, 5.5, 6.5, 7, 9, 13, 15, 34, 67, 67, 101, 176]; 

% Same set of odds, but with the lowest odds omitted, enabling potential
% profit for team betted on
odds = [5.5, 6.5, 7, 9, 13, 15, 34, 67, 67, 101, 176];

% Construct objective function with built-in constraint using nullspace
% method
n = length(odds);
A = diag(odds-1)-(~eye(n,n));
Atilde = [A, zeros(n,n)];

b = [ones(1,n), zeros(1,n)];
B = [b; eye(n,n), -eye(n,n)];
[Q R] = qr(B');
N = Q(:, (rank(B)+1):2*n);

xB = bet/n*ones(1,2*n)';

% Object or cost function to minimize, the maximum element of the loss vector
objfunc = @(x) max(-Atilde*(xB+N*x),[],'all');

% Initialize best winnings
bestwins = -1000*ones(n,1);

% Use fminsearch (Nelder-Mead) a couple of times with random initial
% guesses to increase the search space.
j = 0;
for i = 1:1000

    guess = 400*rand(size(N,2),1)-200;
    options = optimset('MaxFunEvals',1e16);

    [xN,FVAL,EXITFLAG, data] = fminsearch(objfunc,guess, options);

    xcalc = xB + N*xN;
    calcbet = round(xcalc(1:n),0);
    wins = round(A*calcbet,2);
    
    % Save the best bet so far
    if min(wins) > min(bestwins)
        bestwins = wins;
        bestbets = calcbet;
        bestguess = xB + N*guess;
        bestguess = round(bestguess(1:n),0);
        fmindata = data;
        j = j+1;
    end
    
end
disp("Optimized bets:")
bestbets
disp("Which would yield:")
bestwins
disp("If either those teams won")

