local settings = import '../Settings.libsonnet';

// 本文件中的颜色使用 #rrggbb 或 #rrggbbaa 格式的十六进制字符串表示
// 其中 rr、gg、bb 分别表示红、绿、蓝三种颜色的强度，范围是 00 到 FF（十六进制）
// aa 表示 alpha 通道的值，范围也是 00 到 FF，00 表示完全透明，FF 表示完全不透明（此时可以省略 alpha 通道）
// 注意：aa 为 00 时颜色完全透明，会使按键不可点击，建议至少使用 01

// 标签颜色常量定义
local labelColor = {
  primary: {
    light: '#000000',
    dark: '#FFFFFF',
  },
  secondary: {
    light: '#8E8E93',
    dark: '#AEAEB2',
  },
  tertiary: {
    light: '#C7C7CC',
    dark: '#48484A',
  },
  quaternary: {
    light: '#E5E5EA',
    dark: '#3A3A3C',
  },
};

// 分割线颜色
local separatorColor = {
  light: '#C6C6C8',
  dark: '#38383A',
};

// 键盘背景色
local keyboardBackgroundColor = {
  light: '#ffffff03',
  dark: '#00000003',
};

// 标准按键背景色（如字母按键、空格键等）
local standardButtonBackgroundColor = {
  light: '#FFFFFFD9',
  dark: '#FFFFFF29',
};

// 标准按键按下时的背景色
local standardButtonHighlightedBackgroundColor = {
  light: '#00000026',
  dark: '#FFFFFF52',
};

// 标准按键前景色（如字母按键、空格键等），用于按键的字体，图片等
local standardButtonForegroundColor = labelColor.primary;

local standardButtonHighlightedForegroundColor = standardButtonForegroundColor;

// 标准按键备用色，用于显示上下划提示等
local alternativeForegroundColor = labelColor.secondary;
local alternativeHighlightedForegroundColor = alternativeForegroundColor;

// 标准按键阴影颜色
local standardButtonShadowColor = {
  light: '#00000014',
  dark: '#000000',
};

// 系统按键（如回车、删除等）背景颜色
local systemButtonBackgroundColor = {
  light: '#FFFFFFD9',
  dark: '#FFFFFF29',
};

local systemButtonHighlightedBackgroundColor = {
  light: '#00000026',
  dark: '#FFFFFF52',
};

// 系统按键（如回车、删除等）前景颜色
local systemButtonForegroundColor = labelColor.primary;

local systemButtonHighlightedForegroundColor = systemButtonForegroundColor;

// MARK: 一定要与 Settings.libsonnet 中的 accentColor 编号对应
local accentColors = [
  // 在这里检查一下对比度 https://webaim.org/resources/contrastchecker/
  // 确保前景色和背景色的对比度足够高（至少大于 3）以保证可读性
  { // red
    background: '#FF3B30D9',
    foreground: '#ffffff',
  },
  { // green
    background: '#34C759D9',
    foreground: '#ffffff',
  },
  { // orange
    background: '#FF9500D9',
    foreground: '#ffffff',
  },
  { // blue
    background: '#007AFFD9',
    foreground: '#ffffff',
  },
  { // purple
    background: '#AF52DED9',
    foreground: '#ffffff',
  },
];

local colorButtonBackgroundColor = if settings.accentColor == 0 then systemButtonBackgroundColor else
  local color = accentColors[settings.accentColor - 1].background;
  if std.type(color) == 'object' && std.objectHas(color, 'light') && std.objectHas(color, 'dark') then
    color
  else
    {
      light: color,
      dark: color,
    };
local colorButtonForegroundColor = if settings.accentColor == 0 then systemButtonForegroundColor else
  local color = accentColors[settings.accentColor - 1].foreground;
  if std.type(color) == 'object' && std.objectHas(color, 'light') && std.objectHas(color, 'dark') then
    color
  else
    {
      light: color,
      dark: color,
    };

local colorButtonHighlightedBackgroundColor = systemButtonHighlightedBackgroundColor;
local colorButtonHighlightedForegroundColor = labelColor.primary;

// 按键底部边缘颜色
local lowerEdgeOfButtonNormalColor = {
  light: '#00000012',
  dark: '#00000040',
};

// 按下状态下，按键底部边缘颜色
local lowerEdgeOfButtonHighlightColor = {
  light: '#00000012',
  dark: '#00000040',
};

// 标准按键 Hint 背景色(包含长按符号列表的背景色)
local standardCalloutBackgroundColor = {
  light: '#F2F2F7',
  dark: '#2C2C2E',
};

// 标准按键 Hint 前景色，用于按键的字体，图片等
local standardCalloutForegroundColor = standardButtonForegroundColor;

local standardCalloutHighlightedForegroundColor = colorButtonForegroundColor;

// 标准按键 Hint 选中背景色，如长按符号列表中选中的符号背景色
local standardCalloutSelectedBackgroundColor = colorButtonBackgroundColor;

// 标准按键 Hint 边框颜色
local standardCalloutBorderColor = {
  light: '#C6C6C8',
  dark: '#48484A',
};

// 预编辑区文字颜色
local preeditForegroundColor = standardButtonForegroundColor;

// 工具栏按钮前景色
local toolbarButtonForegroundColor = standardButtonForegroundColor;

// 工具栏按钮高亮前景色（按下时变淡，与键盘按键的按压反馈呼应）
local toolbarButtonHighlightedForegroundColor = labelColor.secondary;

// 候选字亮候选字背景颜色
local candidateHighlightColor = standardButtonBackgroundColor;
local candidateForegroundColor = standardButtonForegroundColor;

// 候选字分隔线颜色
local candidateSeparatorColor = separatorColor;


{
  labelColor: labelColor,
  separatorColor: separatorColor,
  keyboardBackgroundColor: keyboardBackgroundColor,
  standardButtonBackgroundColor: standardButtonBackgroundColor,
  standardButtonHighlightedBackgroundColor: standardButtonHighlightedBackgroundColor,
  standardButtonForegroundColor: standardButtonForegroundColor,
  standardButtonHighlightedForegroundColor: standardButtonHighlightedForegroundColor,
  alternativeForegroundColor: alternativeForegroundColor,
  alternativeHighlightedForegroundColor: alternativeHighlightedForegroundColor,
  standardButtonShadowColor: standardButtonShadowColor,
  systemButtonBackgroundColor: systemButtonBackgroundColor,
  systemButtonHighlightedBackgroundColor: systemButtonHighlightedBackgroundColor,
  systemButtonForegroundColor: systemButtonForegroundColor,
  systemButtonHighlightedForegroundColor: systemButtonHighlightedForegroundColor,
  colorButtonBackgroundColor: colorButtonBackgroundColor,
  colorButtonHighlightedBackgroundColor: colorButtonHighlightedBackgroundColor,
  colorButtonForegroundColor: colorButtonForegroundColor,
  colorButtonHighlightedForegroundColor: colorButtonHighlightedForegroundColor,
  lowerEdgeOfButtonNormalColor: lowerEdgeOfButtonNormalColor,
  lowerEdgeOfButtonHighlightColor: lowerEdgeOfButtonHighlightColor,
  standardCalloutBackgroundColor: standardCalloutBackgroundColor,
  standardCalloutForegroundColor: standardCalloutForegroundColor,
  standardCalloutHighlightedForegroundColor: standardCalloutHighlightedForegroundColor,
  standardCalloutSelectedBackgroundColor: standardCalloutSelectedBackgroundColor,
  standardCalloutBorderColor: standardCalloutBorderColor,
  preeditForegroundColor: preeditForegroundColor,
  toolbarButtonForegroundColor: toolbarButtonForegroundColor,
  toolbarButtonHighlightedForegroundColor: toolbarButtonHighlightedForegroundColor,
  candidateHighlightColor: candidateHighlightColor,
  candidateForegroundColor: candidateForegroundColor,
  candidateSeparatorColor: candidateSeparatorColor,
}
