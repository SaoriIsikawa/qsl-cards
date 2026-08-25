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

    print
}