from kokoro import KPipeline
import soundfile as sf
import numpy as np
import requests
import re

# URL da página que contém a lista de vozes
url = "https://huggingface.co/hexgrad/Kokoro-82M/blob/main/VOICES.md"

# Faz a requisição HTTP
response = requests.get(url)

# Verifica se a requisição foi bem-sucedida
if response.status_code == 200:
    # Expressão regular para capturar os nomes das vozes
    pattern = re.findall(r"\b[a-z]{2}_[a-z]+\b", response.text)
    
    # Remove duplicatas e ordena a lista
    voices = sorted(set(pattern))
    
    print("Lista de vozes disponíveis:")
    print(voices)
else:
    print("Erro ao acessar a página:", response.status_code)

def ler_e_formatar_arquivo(arquivo):
    try:
        with open(arquivo, 'r', encoding='utf-8') as f:
            linhas = f.readlines()

        texto_formatado = ""
        for i, linha in enumerate(linhas):
            linha = linha.strip()  # Remove espaços extras no início e fim
            
            if linha:  # Se a linha não estiver vazia
                if texto_formatado and texto_formatado[-1] == ".":
                    texto_formatado += "\n"  # Quebra de linha após ponto final
                elif i > 0 and not linhas[i - 1].strip():  
                    texto_formatado += "\n"  # Mantém quebra de linha quando há espaços entre parágrafos
                else:
                    texto_formatado += " "  # Junta frases mantendo espaçamento natural
                
                texto_formatado += linha
        
        return texto_formatado.strip()

    except FileNotFoundError:
        return "Erro: O arquivo especificado não foi encontrado."
    except Exception as e:
        return f"Erro ao tentar ler o arquivo: {e}, usando texto padrão."

# Exemplo de uso
arquivo = "1-teste.txt"
texto_formatado = ler_e_formatar_arquivo(arquivo)
print(texto_formatado)


# Inicializa o pipeline para síntese em Português Brasileiro
pipeline = KPipeline(lang_code='pt-br')


voices = ['pm_santa']
# Lista com os nomes das vozes desejadas

# Para cada voz na lista, gera a síntese e salva o áudio com o nome da voz
for voice in voices:
    print(f"Iniciando síntese para a voz: {voice}")
    
    # Executa o pipeline com o texto e a voz atual
    generator = pipeline(texto_formatado, voice=voice, split_pattern=r'\n+')
    
    # Armazena os pedaços de áudio (caso a síntese seja feita em partes)
    audio_chunks = []
    
    for i, (gs, ps, audio) in enumerate(generator):
        print(f"Voz '{voice}' - Etapa {i}: {gs}, {ps}")
        audio_chunks.append(audio)
    
    # Concatena todos os pedaços em um único array (se houver mais de um)
    if audio_chunks:
        audio_full = np.concatenate(audio_chunks)
        output_file = f"output/{voice}.wav"
        sf.write(output_file, audio_full, 24000)  # Taxa de amostragem definida para 24000 Hz
        print(f"Áudio salvo em {output_file}")
    else:
        print(f"Não foi gerado áudio para a voz {voice}.")
