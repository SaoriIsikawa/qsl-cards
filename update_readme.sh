#!/bin/bash

# 设置目标目录
TARGET_DIR="$HOME/dev/qsl-cards"
README="$TARGET_DIR/README.md"

# 进入目标目录
cd "$TARGET_DIR" || exit

# 备份原来的 README.md
cp "$README" "${README}.bak"

# 开始更新 README.md
echo "# QSL Cards" > "$README"
echo "" >> "$README"

# 遍历所有图片文件
for img in *.png *.jpg *.jpeg; do
    # 确保文件存在
    [ -f "$img" ] || continue
    # 生成 Markdown 格式的图片链接
    echo "![${img}](${img})" >> "$README"
    echo "" >> "$README"
done

echo "README.md 更新完成！"

git add README.md
