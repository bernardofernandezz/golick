# 1. Imagem base
# Usamos uma imagem oficial do Python. A versão 'slim' é menor,
# o que resulta em uma imagem final mais leve, e corresponde à versão do seu readme.
FROM python:3.13.5-alpine3.22

# 2. Diretório de trabalho
# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar e instalar dependências
# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar o código da aplicação
# Copia todos os arquivos do projeto para o diretório de trabalho no contêiner.
COPY . .

# 5. Expor a porta
# Informa ao Docker que o contêiner escuta na porta 8000.
EXPOSE 8000

# 6. Comando de execução
# Executa a aplicação com uvicorn. Usar 0.0.0.0 torna a aplicação
# acessível de fora do contêiner. O --reload não é usado em produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]