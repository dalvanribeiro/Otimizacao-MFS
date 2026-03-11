# Pré Processamento
## Gerador de possiveisPatios

Responsável pos analisar cada linha da planilha de distâncias e identificar quais colunas possuem valores **menores que 379.45 metros**. 
O programa registra os índices dessas colunas e exporta o resultado em um formato de lista de conjuntos.

### Estrutura de Processamento
Para garantir a integridade dos dados, o programa realiza automaticamente um pré-processamento na planilha:
1.  **Remove a primeira linha** (cabeçalho/títulos).
2.  **Remove as duas primeiras colunas** (identificadores ou metadados).
3.  As colunas restantes são tratadas como posições possíveis para o cálculo.

---

### Preparação do Ambiente Virtual e execução

Recomenda-se utilizar um ambiente virtual para isolar as dependências do projeto:

1. **Criar o ambiente virtual:**
   ```bash
   python -m venv venv
   .\venv\Scripts\activate
  
2. **Instalação de dependências:**
   ```bash
   pip install -r .\requirements.txt

3. **Execução do pré processamento**
   ```bash
   python pre_processamento_mfs.py <arquivo de entrada>


# Execução da Otimização no CPLEX

Esta seção descreve como utilizar o arquivo `possiveisPatios` gerado pelo script Python como entrada para o modelo de otimização resolvido com o **IBM ILOG CPLEX**.

---

# Pré-requisitos

Para executar o modelo de otimização é necessário ter instalado:

- IBM ILOG CPLEX Optimization Studio
- Arquivo `possiveisPatios` gerado pelo script Python
- Arquivo `matrizDeDistancias.xlsx` 

# Configuração
- Alterar o nome das variáveis de entrada no arquivo `covering.mod` (conforme a instância que será otimizada)
- Alterar o valor da variável `cplex.tilim` para o tempo de execução

# Execução
Iniciar a execução do otimizador no CPLEX e acompanhar o processo.