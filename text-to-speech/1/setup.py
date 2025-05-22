from kokoro import KPipeline

lang_code='pt-br'
voice='pm_santa'
pipeline = KPipeline(lang_code=lang_code)
print(f"Feito setup para voz: {voice} e idioma: {lang_code}")
# Executa o pipeline com o texto e a voz fornecida
generator = pipeline('oi', voice=voice, split_pattern=r'\n+')
audio_chunks = []
for i, (gs, ps, audio) in enumerate(generator):
    print(f"Voz '{voice}' - Etapa {i}: {gs}, {ps}")
    audio_chunks.append(audio)