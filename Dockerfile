FROM python:3.10

# 更换阿里源 sed修改文件中的内容 sed -i "s/原字符串/新字符串/g"
RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list && \
    sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \
    sed -i "s/security.debian.org\/debian-security/mirrors.aliyun.com\/debian-security/g" /etc/apt/sources.list && \
    sed -i "s/httpredir.debian.org\/debian-security/mirrors.aliyun.com\/debian-security/g" /etc/apt/sources.list

# 安装ffmpeg
RUN apt-get update && apt-get install -y ffmpeg

# 安装 Python 依赖，使用清华大学镜像源
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
    requests \
    feedparser \
    pytz \
    aiohttp \
    bs4 \
    tqdm \
    async-timeout \
    Flask \
    m3u8 \
    ffmpeg-python \
    gevent

# 设置工作目录
WORKDIR /app

# 拷贝当前目录所有文件到容器的 /app 目录下
COPY . .

# 暴露端口
EXPOSE 8989

CMD ["python3", "app.py"]
