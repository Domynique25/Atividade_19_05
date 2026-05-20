# ============================================================
# Projeto SRL - Pipeline Híbrido Prolog + Python
# Prof. Edjard Mota - ICC260
# ============================================================

from pyswip import Prolog
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report
import os

# --- 1. Conectar ao Prolog ---
prolog = Prolog()
prolog.consult(os.path.join(os.path.dirname(__file__), "../prolog/rede_social.pl"))

# --- 2. Carregar dados financeiros ---
df = pd.read_csv(os.path.join(os.path.dirname(__file__), "dados_financeiros.csv"))

# --- 3. Extrair feature relacional via Prolog ---
def obter_grau_risco(cliente):
    """Consulta o grau de risco de conexão com inadimplentes via Prolog."""
    query = list(prolog.query(f"risco_conexao({cliente}, daniel, Grau)"))
    if query:
        # Retorna o menor grau encontrado
        return min(r["Grau"] for r in query)
    return 999  # Sem conexão identificada

df["grau_risco_rede"] = df["cliente_id"].apply(obter_grau_risco)
print("\n=== Dataset com Feature Relacional ===")
print(df.to_string(index=False))

# --- 4. Treinar classificador ---
X = df[["renda_mensal", "score_classico", "grau_risco_rede"]]
y = df["inadimplente_historico"]

modelo = LogisticRegression(max_iter=1000)
modelo.fit(X, y)

print("\n=== Coeficientes Aprendidos ===")
for feat, coef in zip(X.columns, modelo.coef_[0]):
    print(f"  {feat:25s}: {coef:.4f}")

# --- 5. Inferência em novo cliente ---
novo_cliente = pd.DataFrame([{
    "renda_mensal": 2500,
    "score_classico": 500,
    "grau_risco_rede": obter_grau_risco("ana")
}])

prob = modelo.predict_proba(novo_cliente)[0][1]
print(f"\n=== Resultado Estilo ProbLog ===")
print(f"{prob:.2f}: risco(cliente_novo) :- conectado_a(cliente_novo, daniel, {novo_cliente['grau_risco_rede'][0]}).")

# --- 6. Relatório ---
print("\n=== Relatório de Classificação ===")
y_pred = modelo.predict(X)
print(classification_report(y, y_pred, zero_division=0))