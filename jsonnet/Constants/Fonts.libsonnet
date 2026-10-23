local settings = import '../Settings.libsonnet';

{
  preeditFontSize: 17,

  floatingKeyboardButtonTextFontSize: 14,
  floatingKeyboardButtonImageFontSize: 20,

  toolbarButtonTextFontSize: 16,
  toolbarButtonImageFontSize: 20,

  candidateStateButtonFontSize: 20,

  t9ButtonTextFontSize: 18,

  // 关闭上下滑提示显示时，小写字母与 iOS 键盘一致；显示提示时略小给提示小字留空间
  standardButtonTextFontSize:
    if settings.swipeUpTextCenter == 'hide' && settings.swipeDownTextCenter == 'hide'
    then 25.3
    else 22.5,
  standardButtonUppercasedTextFontSize: 21.5,
  standardButtonImageFontSize: 20,

  numericButtonTextFontSize: 22.5,

  systemButtonTextFontSize: 18,
  systemButtonImageFontSize: 20,

  // 键盘上的辅助文字，例如上划和下划提示
  alternativeTextFontSize: 10,
  alternativeImageFontSize: 9,

  hintTextFontSize: 22.5,
  hintImageFontSize: 20,

  candidateIndexFontSize: 12,
  candidateTextFontSize: 16,
  candidateCommentFontSize: 14,
}
