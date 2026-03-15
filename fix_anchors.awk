{
    # 匹配包含特定模式的行
    if ($0 ~ /<p><a name="[^"]+" id="[^"]+">/) {
        
        # 1. 先定位整个 id="..." 的部分
        if (match($0, /id="[^"]+"/)) {
            # 提取出 id="value" 字符串
            full_id = substr($0, RSTART, RLENGTH);
            # 2. 剥离掉前后的 id=" 和 " (前 4 后 1)
            id_val = substr(full_id, 5, length(full_id) - 5);
            
            # 执行替换
            sub(/<p><a name="[^"]+" id="[^"]+"><\/a> /, "<p id=\"" id_val "\">", $0);
        }
        print $0;
    } else {
        print $0;
    }
}