{
    # 1. 规范自闭合标签
    gsub(/<br[[:space:]]*\/>/, "<br>")
    gsub(/<hr[[:space:]]*\/>/, "<hr>")

    # 2. 规范 <img ... /> 为 <img ...>
    while (match($0, /<img[^>]*[[:space:]]*\/>/)) {
        img_tag = substr($0, RSTART, RLENGTH)
        sub(/[[:space:]]*\/>$/, ">", img_tag)
        $0 = substr($0, 1, RSTART - 1) img_tag substr($0, RSTART + RLENGTH)
    }

    # 3. 暴力且彻底地抹掉任意 HTML 标签内残留的 align="..." 属性（不管它是 th、td 还是其他标签）
    while (match($0, /<[a-zA-Z0-9]+[^>]*\s+align="[^"]*"/)) {
        tag_str = substr($0, RSTART, RLENGTH)
        sub(/\s+align="[^"]*"/, "", tag_str)
        $0 = substr($0, 1, RSTART - 1) tag_str substr($0, RSTART + RLENGTH)
    }

    print
}