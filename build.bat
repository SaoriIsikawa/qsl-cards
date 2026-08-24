@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

set MD=README.md
set CSS=css\style.css
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

echo [1/5] 渲染 Markdown...
rem cmark-gfm -t html --github-pre-lang --unsafe -e table -e autolink -e strikethrough -e tasklist -e footnotes -e tagfilter "%MD%" > "%TMP_HTML%"
comrak --gfm --unsafe -e footnotes "%MD%" > "%TMP_HTML%"

echo [2/5] 生成 HTML 头 + 内联 CSS...
(
  type tmpl\header.html
  type "%CSS%"
  echo /* === INLINE CSS END === */
  type tmpl\footer.html
  type "%TMP_HTML%"
  type tmpl\end.html
) > "%OUT%"

del "%TMP_HTML%"

rem echo [3/5] 验证 HTML...
rem npx html-validate "%OUT%"

echo [4/5] 修复html锚点...
awk -f prog.awk "%OUT%" > index.tmp
rem 检查上一步是否成功（避免报错时误删原文件）
if %ERRORLEVEL% EQU 0 (
    move /y index.tmp "%OUT%"
)



echo [5/5] 完成：%OUT%

pause