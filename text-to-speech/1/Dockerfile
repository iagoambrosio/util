# 1. Imagem base leve com Python 3.10
FROM python:3.12-slim 
# Usamos uma imagem slim do Python
WORKDIR /app

RUN pip3 install torch==2.7.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
# Atualiza o pip e instala as dependências necessárias: kokoro e soundfile
RUN pip install kokoro soundfile pydub

RUN apt update -y && apt install ffmpeg -y

# Copia o script de inferência para dentro da imagem
COPY synthesize.py /app/synthesize.py

COPY setup.py /app/setup.py

RUN python setup.py

COPY  converte.py  /app/converte.py

# Quando o container iniciar, executa o script de inferência
CMD ["python", "synthesize.py"]
