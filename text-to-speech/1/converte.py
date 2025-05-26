import sys
from pydub import AudioSegment

pasta = "output"
voice = sys.argv[1] if len(sys.argv) > 1 else 'pm_santa'

def wav_para_mp3_vbr(input_wav, output_mp3, quality=9):
    audio = AudioSegment.from_wav(input_wav)
    audio.export(
        output_mp3,
        format="mp3",
        parameters=["-q:a", str(quality)]
    )
wav_para_mp3_vbr(f"{pasta}/{voice}.wav", f"{pasta}/{voice}.mp3")