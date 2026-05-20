% ============================================================
% Projeto SRL - Rede Social de Risco de Crédito
% Prof. Edjard Mota - ICC260
% ============================================================

% Fatos: transações diretas entre clientes
transacao_entre(joao,   ana,    1500).
transacao_entre(ana,    carlos, 800).
transacao_entre(carlos, daniel, 50).

% Histórico de inadimplência
inadimplente(daniel).

% Propagação recursiva de risco por grau de conexão
risco_conexao(X, Y, 1) :-
    transacao_entre(X, Y, _).
risco_conexao(X, Y, 1) :-
    transacao_entre(Y, X, _).
risco_conexao(X, Y, Grau) :-
    transacao_entre(X, Z, _),
    Z \= Y,
    risco_conexao(Z, Y, GrauAnterior),
    Grau is GrauAnterior + 1.

% Regra probabilística estilo ProbLog (anotação manual)
% 0.74: risco(X) :- conectado_a(X, Y), inadimplente(Y).
risco_alto(X) :-
    risco_conexao(X, Y, Grau),
    inadimplente(Y),
    Grau =< 2.