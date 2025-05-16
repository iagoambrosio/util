# 1. Imagem base leve com Python 3.10
FROM python:3.12-slim 
# Usamos uma imagem slim do Python
WORKDIR /app

# Instala pacotes do sistema necessários (nesse exemplo, apenas o espeak-ng para suporte básico)
RUN apt-get update && apt-get install -y espeak-ng && rm -rf /var/lib/apt/lists/*

# Atualiza o pip e instala as dependências necessárias: kokoro e soundfile
RUN pip install --upgrade pip && \
    pip install kokoro soundfile

# Copia o script de inferência para dentro da imagem
COPY . .

# Quando o container iniciar, executa o script de inferência
CMD ["python", "synthesize.py"]
