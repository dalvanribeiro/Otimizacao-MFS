import pandas as pd
from tqdm import tqdm
import sys

if len(sys.argv) < 2:
    print("Uso: python pre_processamento_mfs.py <arquivo_excel>")
    sys.exit(1)

arquivo_entrada = sys.argv[1]

df = pd.read_excel(arquivo_entrada)

df = df.iloc[1:, 2:]

df.columns = range(1, len(df.columns) + 1)

row_vectors = []

for _, row in tqdm(df.iterrows(), total=len(df), desc="Processando linhas"):
    vector = [col for col in df.columns if row[col] < 379.45]
    row_vectors.append(vector)

with open("patiosPossiveis.dat", "w", encoding="utf-8") as f:

    f.write("possiveisPatios = [")

    first = True
    for v in row_vectors:

        if not first:
            f.write(",")

        first = False

        vetor_formatado = ",".join(map(str, v))
        f.write(f"{{{vetor_formatado}}}")

    f.write("]")