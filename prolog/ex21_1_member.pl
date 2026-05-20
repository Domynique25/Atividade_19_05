% ============================================================
% Exercício 21.1 - Bratko Cap. 21
% Aprender member(X, List) usando HYPER (ILP)
% ============================================================

% Tipos de termos
term(list, [H|T], [H:item, T:list]).
term(list, [],    []).

% Cláusula inicial (hipótese mais geral)
start_clause([member(X, L)] / [X:item, L:list]).

% Literais de background disponíveis
backliteral(member(X, L), [X:item, L:list], []).

% Exemplos positivos
ex(member(a, [a,b,c])).
ex(member(b, [a,b,c])).
ex(member(c, [a,b,c])).
ex(member(a, [a])).
ex(member(b, [b,c])).

% Exemplos negativos
nex(member(d, [a,b,c])).
nex(member(a, [])).
nex(member(b, [a,c])).
nex(member(c, [a,b])).