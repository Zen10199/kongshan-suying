# -*- coding: utf-8 -*-
# 合成三枚干净的按键音 wav（元书皮肤 keySound 仅支持 wav/aiff）
# input: 短促高频 tick；system: 略低频 tock；delete: 双击感
import math
import os
import struct
import wave

SR = 44100

def tick(freq, dur_ms, amp=0.6):
    n = int(SR * dur_ms / 1000)
    out = []
    for i in range(n):
        t = i / SR
        env = math.exp(-t / (dur_ms / 1000 / 4))
        out.append(amp * env * math.sin(2 * math.pi * freq * t))
    return out

def write_wav(path, samples):
    with wave.open(path, 'w') as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SR)
        frames = b''.join(struct.pack('<h', max(-32767, min(32767, int(x * 32767)))) for x in samples)
        w.writeframes(frames)

def silence(ms):
    return [0.0] * int(SR * ms / 1000)

os.makedirs(os.path.join(os.path.dirname(__file__), '..', 'sound'), exist_ok=True)
base = os.path.join(os.path.dirname(__file__), '..', 'sound')

# 输入键：明亮的短 tick
write_wav(os.path.join(base, 'input.wav'), tick(4200, 14, 0.55))
# 系统键：稍低沉的 tock
write_wav(os.path.join(base, 'system.wav'), tick(2600, 18, 0.5))
# 删除键：紧凑双击
write_wav(os.path.join(base, 'delete.wav'), tick(3600, 10, 0.5) + silence(30) + tick(3000, 12, 0.45))

print('三枚音效已生成到 sound/')
