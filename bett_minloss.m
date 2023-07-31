bet = 1000;
%odds = [3.5, 5.5, 6.5, 7, 9, 13, 15, 34, 67, 67, 101, 176];
odds = [1.02 16 23];

n = length(odds);
A = diag(odds-1)-(~eye(n,n));
Atilde = [A, zeros(n,n)];

b = [ones(1,n), zeros(1,n)];
B = [b; eye(n,n), -eye(n,n)];
[Q R] = qr(B');
N = Q(:, (rank(B)+1):2*n);

xB = bet/n*ones(1,2*n)';

objfunc = @(x) max(-Atilde*(xB+N*x),[],'all');

bestwins = -1000*ones(n,1);

j = 0;
for i = 1:10000

    guess = 400*rand(size(N,2),1)-200;
    options = optimset('MaxFunEvals',1e14);

    [xN,FVAL,EXITFLAG, data] = fminsearch(objfunc,guess, options);

    xcalc = xB + N*xN;
    calcbet = round(xcalc(1:n),0);
    wins = round(A*calcbet,2);
    
    if min(wins) > min(bestwins)
        bestwins = wins;
        bestbet = calcbet;
        bestguess = xB + N*guess;
        bestguess = round(bestguess(1:n),0);
        fmindata = data;
        j = j+1;
    end
    
end
bestbet
