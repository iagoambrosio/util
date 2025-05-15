#!/usr/bin/env python3
import sys
import os
from TTS.api import TTS
from datetime import datetime

# Valores padrão ou vindos das variáveis de ambiente
timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')  # Formato: AAAAMMDD_HHMMSS
DEFAULT_MODEL = os.getenv('TTS_MODEL', 'tts_models/multilingual/multi-dataset/xtts_v2')
DEFAULT_TEXT = os.getenv('TTS_TEXT', 'Olá, esta é uma síntese via docker-compose!')
DEFAULT_OUTPUT = os.getenv('TTS_OUTPUT', f'output/speak_{timestamp}.wav')

tts = TTS(DEFAULT_MODEL, gpu=False)

def list_models():
    """
    Lista todos os modelos TTS disponíveis na Coqui TTS.
    """
    print(TTS().list_models())

def list_speakers():
    try:
        if (tts):
           print(tts.speakers)
        else:
            print("Nenhum falante disponível ou SpeakerManager não inicializado.")
    except Exception as e:
        print(f"Erro ao listar falantes: {str(e)}")
        
def synthesize(text=None, output_path=DEFAULT_OUTPUT, speaker="Ana Florence", language="pt", file=None):
    """
    Converte texto em fala usando Coqui TTS localmente.
    """
    if file:
        try:
            with open(file, 'r', encoding='utf-8') as f:
                text = f.read()
        except Exception as e:
            print(f"Erro ao ler o arquivo {file}: {str(e)}")
            return
    elif not text:
        text = DEFAULT_TEXT
    tts.tts_to_file(
        text=text,
        file_path=output_path,
        speaker=speaker,
        language=language,
        split_sentences=True
    )
    print(f"[+] Áudio salvo em: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1].lower() == 'list':
            list_models()
        elif sys.argv[1].lower() == 'list_speakers':
            list_speakers(DEFAULT_MODEL)
        elif sys.argv[1].lower() == 'synthesize':
            file_arg = sys.argv[2] if len(sys.argv) > 2 else None
            synthesize(file=file_arg)
        else:
            synthesize()
    else:
        synthesize()