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

echo [1/5] 渲染 Markdown...
cmark-gfm -t html --github-pre-lang --unsafe -e table -e autolink -e strikethrough -e tasklist -e footnotes -e tagfilter "%MD%" > "%TMP_HTML%"

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

echo [3/5] tidy 美化 HTML...
tidy.exe ^
  -quiet ^
  -indent ^
  --indent-spaces 2 ^
  -wrap 0 ^
  -utf8 ^
  -modify ^
  "%OUT%"

rem echo [4/5] 原生懒加载...
rem python add_lazy.py index.html

rem echo [4/5] 修复html锚点...
rem 执行转换，输出到临时文件
rem C:\cmdtool32\awk.exe -f fix_anchors.awk index.html > index.tmp

rem 检查上一步是否成功（避免报错时误删原文件）
rem if %ERRORLEVEL% EQU 0 (
rem     move /y index.tmp index.html
rem )

echo [5/5] 完成：%OUT%
pause
