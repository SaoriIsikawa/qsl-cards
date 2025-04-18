#!/bin/bash

# 定义 HTML 头部和样式
HTML_HEADER="<!DOCTYPE html>
<html lang=\"zh-CN\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>QSL 卡片存档</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
            color: #333;
        }
        h1, h2, h3 {
            color: #2c3e50;
        }
        a {
            color: #3498db;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 10px auto;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        code {
            background-color: #f5f5f5;
            padding: 2px 4px;
            border-radius: 3px;
            font-family: Consolas, monospace;
        }
        pre {
            background-color: #f5f5f5;
            padding: 10px;
            border-radius: 4px;
            overflow-x: auto;
        }
        blockquote {
            border-left: 4px solid #3498db;
            padding-left: 15px;
            color: #555;
            margin-left: 0;
        }
    </style>
</head>
<body>"

HTML_FOOTER="</body>
</html>"

# 处理主 README.md
{
    echo "$HTML_HEADER"
    /c/cmdtool64/cmark-gfm.exe -t html --hardbreaks --smart README.md
    echo "$HTML_FOOTER"
} > README.html

# 处理 archive/README.md
{
    echo "$HTML_HEADER"
    /c/cmdtool64/cmark-gfm.exe -t html --hardbreaks --smart ./archive/README.md
    echo "$HTML_FOOTER"
} > ./archive/README.html

echo "HTML 文件生成完成。"

# 定义 HTML 头部和样式
HTML_HEADER="<!DOCTYPE html>
<html lang=\"zh-CN\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>QSL 卡片存档</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
            color: #333;
        }
        h1, h2, h3 {
            color: #2c3e50;
        }
        a {
            color: #3498db;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 10px auto;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        code {
            background-color: #f5f5f5;
            padding: 2px 4px;
            border-radius: 3px;
            font-family: Consolas, monospace;
        }
        pre {
            background-color: #f5f5f5;
            padding: 10px;
            border-radius: 4px;
            overflow-x: auto;
        }
        blockquote {
            border-left: 4px solid #3498db;
            padding-left: 15px;
            color: #555;
            margin-left: 0;
        }
    </style>
</head>
<body>"

HTML_FOOTER="</body>
</html>"

# 处理主 README.md
{
    echo "$HTML_HEADER"
    /c/cmdtool64/cmark-gfm.exe -t html --hardbreaks --smart README.md
    echo "$HTML_FOOTER"
} > README.html

# 处理 archive/README.md
{
    echo "$HTML_HEADER"
    /c/cmdtool64/cmark-gfm.exe -t html --hardbreaks --smart ./archive/README.md
    echo "$HTML_FOOTER"
} > ./archive/README.html

# 创建 ZIP 存档
git archive --format=zip --output=/c/Users/Saori/backup/业余无线电/qsl-cards.zip HEAD

echo "HTML 文件生成完成，ZIP 存档已创建。"


# 一步完成
#magick nhk01.png nhk02.png -append -blur 0x1 -unsharp 0x1+1+0.05 -resize 1200 -quality 85 -format jpg  result_final.jpg
# 一步完成拼合+去网格
# magick s1.png s2.png -append -blur 0x0.8 -unsharp 0x0.8+1.2+0.03 result_final.png
# 消除网格图案（去网纹）：
# magick result_combined.png -blur 0x1 -unsharp 0x1+1+0.05 result_clean.png
# 建议操作：
# 对于PNG文件，可以使用ImageMagick转换为JPG格式：
# mogrify -format jpg *.png
# 或者调整尺寸并转换（例如限制宽度为1200像素）：
# mogrify -resize 1200 -quality 85 -format jpg *.png
# 对于已经较大的JPG文件，可以只调整尺寸或优化质量：
# mogrify -resize 1200 -quality 85 *.jpg