# -*- coding: utf-8 -*-
# 空山素影预览图：一个键盘从中线分割左浅右深（iOS 化配色），4 倍超采样
from PIL import Image, ImageDraw, ImageFont

W, H = 996, 770
FONT = '/System/Library/Fonts/Hiragino Sans GB.ttc'

def font(sz):
    return ImageFont.truetype(FONT, sz)

def render_keyboard(kw, dark):
    scale = kw / 390
    if dark:
        panel = (28, 28, 30, 255)      # 黑色 App 背景（底板透明）
        key_fill = (64, 64, 66, 255)   # #FFFFFF29 叠黑底
        text = (252, 252, 254, 255)
        hint = (185, 185, 192, 255)
        ret_fill = (0, 122, 255, 255)
        tag = 'A'
    else:
        panel = (226, 228, 232, 255)
        key_fill = (255, 255, 255, 255)
        text = (0, 0, 0, 255)
        hint = (120, 120, 128, 255)
        ret_fill = (0, 122, 255, 255)
        tag = '拼'

    row_h = round(scale * 54)
    key_h = row_h - round(scale * 11)
    radius = round(scale * 8)
    gap = round(scale * 3)
    pad = round(scale * 5)
    pad_h = round(scale * 5)
    kh = row_h * 4 + pad * 2

    im = Image.new('RGBA', (kw, kh), (0, 0, 0, 0))
    od = ImageDraw.Draw(im)
    od.rounded_rectangle([0, 0, kw - 1, kh - 1], round(scale * 14), fill=panel)

    f_main, f_hint, f_key = font(round(scale * 24)), font(round(scale * 9)), font(round(scale * 15))

    def key(cx, cy, w, label=None, face=False, fill=key_fill, tc=text, corner_label=None):
        x, y = cx - w / 2, cy - key_h / 2
        od.rounded_rectangle([x, y, x + w, y + key_h], radius, fill=fill)
        if face:
            r = key_h * 0.28
            od.ellipse([cx - r, cy - r, cx + r, cy + r], fill=(255, 214, 10, 255))
            er = r * 0.16
            for ex in (cx - r * 0.42, cx + r * 0.42):
                od.ellipse([ex - er, cy - r * 0.3 - er, ex + er, cy - r * 0.3 + er], fill=(60, 40, 10, 255))
            od.arc([cx - r * 0.5, cy - r * 0.25, cx + r * 0.5, cy + r * 0.55], 20, 160,
                   fill=(60, 40, 10, 255), width=max(2, round(r * 0.14)))
        if label:
            is_letter = len(label) == 1 and label.isascii() and label.isalpha()
            f = f_main if is_letter else f_key
            bb = od.textbbox((0, 0), label, font=f)
            od.text((cx - (bb[2] - bb[0]) / 2 - bb[0], cy + key_h * 0.10 - (bb[3] - bb[1]) / 2 - bb[1]),
                    label, font=f, fill=tc)
        if corner_label:
            bb = od.textbbox((0, 0), corner_label, font=f_hint)
            od.text((cx - (bb[2] - bb[0]) / 2 - bb[0], y + max(1, round(key_h * 0.05)) - bb[1]),
                    corner_label, font=f_hint, fill=hint)

    xL, xR = pad_h, kw - pad_h
    unit = (xR - xL) / 10
    yc = lambda r: pad + r * row_h + row_h / 2

    for ri, row in enumerate(['qwertyuiop', 'asdfghjkl']):
        off = unit / 2 if ri == 1 else 0
        for i, ch in enumerate(row):
            key(xL + off + i * unit + unit / 2, yc(ri), unit - gap * 2, ch)

    # 第三行 shift zxcvbnm delete
    cy = yc(2)
    w_shift = unit * 1.45
    key(xL + w_shift / 2, cy, w_shift)
    ax, ar, ah = xL + w_shift / 2, key_h * 0.22, key_h * 0.3
    od.polygon([(ax, cy - ah * 0.7), (ax - ar, cy + ah * 0.1), (ax - ar * 0.45, cy + ah * 0.1),
                (ax - ar * 0.45, cy + ah * 0.8), (ax + ar * 0.45, cy + ah * 0.8),
                (ax + ar * 0.45, cy + ah * 0.1), (ax + ar, cy + ah * 0.1)], fill=text)
    for i, ch in enumerate('zxcvbnm'):
        key(xL + w_shift + gap + i * unit + unit / 2, cy, unit - gap * 2, ch)
    x_del = xL + w_shift + gap + 7 * unit + gap
    w_del = xR - x_del
    key(x_del + w_del / 2, cy, w_del)
    bx, by, bw, bh = x_del + w_del / 2, cy, key_h * 0.62, key_h * 0.42
    lw = max(2, round(scale * 1.6))
    od.rounded_rectangle([bx - bw / 2, by - bh / 2, bx + bw / 2, by + bh / 2], round(bh * 0.25), outline=text, width=lw)
    xr = bh * 0.22
    od.line([(bx - xr, by - xr), (bx + xr, by + xr)], fill=text, width=lw)
    od.line([(bx - xr, by + xr), (bx + xr, by - xr)], fill=text, width=lw)

    # 第四行（空山布局）：123 、逗号、空格(右下 拼/A)、中/En、换行
    cy = yc(3)
    w_fn = unit * 1.2
    key(xL + w_fn / 2, cy, w_fn, '123')
    x2 = xL + w_fn + gap
    key(x2 + w_fn / 2, cy, w_fn, '，')
    x_ret = xR - w_fn - gap
    key(x_ret + w_fn / 2, cy, w_fn, '换行', fill=ret_fill, tc=(255, 255, 255, 255))
    x4 = x_ret - gap - w_fn
    key(x4 + w_fn / 2, cy, w_fn, '中/En')
    x_sp = x2 + w_fn + gap
    w_sp = x4 - gap - x_sp
    key(x_sp + w_sp / 2, cy, w_sp)
    bb = od.textbbox((0, 0), tag, font=f_hint)
    od.text((x_sp + w_sp - (bb[2] - bb[0]) - gap * 2 - bb[0],
             cy + key_h / 2 - (bb[3] - bb[1]) - round(gap * 0.4) - bb[1]), tag, font=f_hint, fill=hint)
    return im

SS = 4
margin = 42
kw = (W - margin * 2) * SS
light_kb = render_keyboard(kw, dark=False)
dark_kb = render_keyboard(kw, dark=True)
mid = kw // 2

big = Image.new('RGBA', (W * SS, H * SS), (255, 255, 255, 255))
ky = round((H * SS - light_kb.height - 70 * SS) / 2)
big.alpha_composite(light_kb.crop((0, 0, mid, light_kb.height)), (margin * SS, ky))
big.alpha_composite(dark_kb.crop((mid, 0, kw, dark_kb.height)), (margin * SS + mid, ky))

draw = ImageDraw.Draw(big)
f_sign = font(20 * SS)
draw.text((28 * SS, 20 * SS), '空山素影 · by Zen10199', font=f_sign, fill=(150, 150, 158, 255))

big.resize((W, H), Image.LANCZOS).convert('RGB').save(
    '/Users/zhudewei/Documents/必备软件/输入法/元书皮肤/kongshan-suying/demo.png', 'PNG')
print('生成完成', (W, H))
