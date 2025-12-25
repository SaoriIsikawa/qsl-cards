@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

set MD=README.md
set CSS=css\github-markdown.css
set OUT=index.html
set TMP_HTML=content.html

if not exist "%MD%" (
  echo 错误：README.md 不存在
  pause
  exit /b 1
)

if not exist "%CSS%" (
  echo 错误：%CSS% 不存在
  pause
  exit /b 1
)

echo [1/4] 渲染 Markdown...
cmark-gfm --to html --github-pre-lang --unsafe "%MD%" > "%TMP_HTML%"

echo [2/4] 生成 HTML 头 + 内联 CSS...
(
  type tmpl\header.html
  type "%CSS%"
  echo /* === INLINE CSS END === */
  type tmpl\footer.html
  type "%TMP_HTML%"
  type tmpl\end.html
) > "%OUT%"

del "%TMP_HTML%"

echo [3/4] tidy 美化 HTML...
tidy.exe ^
  -quiet ^
  -indent ^
  --indent-spaces 2 ^
  -wrap 0 ^
  -utf8 ^
  -modify ^
  "%OUT%"

echo [4/4] 完成：%OUT%
pause
