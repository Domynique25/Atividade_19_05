% ============================================================
% Exercício 21.2 - Bratko Cap. 21
% Aprender even/1 e odd/1 (definições mutuamente recursivas)
% ============================================================

% Tipos de termos
term(list, [H|T], [H:item, T:list]).
term(list, [],    []).

% Cláusulas iniciais
start_clause([even(L)] / [L:list]).
start_clause([odd(L)]  / [L:list]).

% Literais de background
backliteral(even(L), [L:list], []).
backliteral(odd(L),  [L:list], []).

% Exemplos positivos
ex(even([])).
ex(even([a,b])).
ex(even([a,b,c,d])).
ex(odd([a])).
ex(odd([b,c,d])).
ex(odd([a,b,c,d,e])).

% Exemplos negativos
nex(even([a])).
nex(even([a,b,c])).
nex(odd([])).
nex(odd([a,b])).
nex(odd([a,b,c,d])).