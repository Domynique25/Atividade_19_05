# Projeto: ILP com HYPER + SRL Híbrido (Prolog + Python)
**Disciplina:** ICC260 | **Prof.:** Edjard Mota

## Pré-requisitos

```bash
# SWI-Prolog
sudo apt install swi-prolog        # Linux
brew install swi-prolog            # macOS

# Python 3.8+
pip install pyswip pandas scikit-learn
```

## Obter o hyper.pl
Baixe o arquivo `hyper.pl` do site oficial do Bratko e coloque em `prolog/`:
- https://www.booksites.net/bratko (Capítulo 19)

---

## Exercício 21.1 — Aprender `member/2`

```bash
cd prolog
swipl
```

```prolog
?- [hyper], [ex21_1_member].
?- induce(H), showhyp(H).
```

### Resultado esperado:
```prolog
member(A, [A|B]).
member(A, [B|C]) :- member(A, C).
```

---

## Exercício 21.2 — Aprender `even/1` e `odd/1`

```prolog
?- [hyper], [ex21_2_even_odd].
?- induce(H), showhyp(H).
```

### Resultado esperado:
```prolog
even([]).
even([A,B|C]) :- even(C).
odd([A|B])    :- even(B).
```

Ou versão mutuamente recursiva:
```prolog
even([]).
odd([A|B])  :- even(B).
even([A|B]) :- odd(B).
```

---

## Pipeline SRL (Prolog + Python)

```bash
cd python
python srl_pipeline.py
```

### Resultado esperado:
```
=== Dataset com Feature Relacional ===
 cliente_id  renda_mensal  score_classico  grau_risco_rede  inadimplente_historico
       joao          5200             750                2                       0
        ana          3100             610                1                       0
     carlos          1800             420                1                       1
     daniel           900             300                0                       1

=== Coeficientes Aprendidos ===
  renda_mensal             :  -0.0003
  score_classico           :  -0.0021
  grau_risco_rede          :  -1.2400

=== Resultado Estilo ProbLog ===
0.82: risco(cliente_novo) :- conectado_a(cliente_novo, daniel, 1).
```

---

## Subir no Git

```bash
git init
git add .
git commit -m "feat: ILP HYPER ex21.1 e 21.2 + pipeline SRL hibrido"
git remote add origin https://github.com/SEU_USUARIO/bratko-srl-project.git
git branch -M main
git push -u origin main
```