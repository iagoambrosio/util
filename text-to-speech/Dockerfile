# 1. Imagem base leve com Python 3.10
FROM python:3.12-slim 

# 3. Define diretório de trabalho
WORKDIR /app

# 4. Copia e instala dependências Python
RUN pip install coqui-tts

# 5. Copia todo o código da aplicação
COPY . .

# 6. Comando padrão ao iniciar o contêiner
CMD ["python", "synthesize.py"]
