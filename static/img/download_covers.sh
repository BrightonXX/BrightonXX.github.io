#!/bin/bash

# 下载函数
download_cover() {
    local search_term="$1"
    local output_file="$2"
    
    echo "正在下载: $search_term -> $output_file"
    
    # 使用 iTunes Search API
    url=$(curl -s "https://itunes.apple.com/search?term=$(echo "$search_term" | sed 's/ /+/g')&entity=album&limit=1" | \
          grep -o '"artworkUrl100":"[^"]*"' | \
          cut -d'"' -f4 | \
          sed 's/100x100/1000x1000/g')
    
    if [ -n "$url" ]; then
        curl -s "$url" -o "$output_file"
        if [ -f "$output_file" ] && [ $(stat -f%z "$output_file" 2>/dev/null || stat -c%s "$output_file" 2>/dev/null) -gt 1000 ]; then
            echo "✓ 成功下载: $output_file"
        else
            echo "✗ 下载失败或文件过小: $output_file"
            rm -f "$output_file"
        fi
    else
        echo "✗ 未找到封面: $search_term"
    fi
}

# 下载所有封面
download_cover "My Beautiful Dark Twisted Fantasy Kanye West" "mbdtf.jpg"
download_cover "The Life of Pablo Kanye West" "the-life-of-pablo.jpg"
download_cover "Graduation Kanye West" "graduation.jpg"
download_cover "Late Registration Kanye West" "late-registration.jpg"
download_cover "IGOR Tyler the Creator" "igor.jpg"
download_cover "In the Court of the Crimson King" "in-the-court-of-the-crimson-king.jpg"
download_cover "Gemini Rights Steve Lacy" "gemini-rights.jpg"
download_cover "Ants From Up There Black Country New Road" "ants-from-up-there.jpg"
download_cover "Norman Fucking Rockwell Lana Del Rey" "norman-fucking-rockwell.jpg"
download_cover "Imaginal Disk Magdalena Bay" "imaginal-disk.jpg"

echo ""
echo "下载完成！"
