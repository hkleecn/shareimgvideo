# 这个 Dockerfile 用于构建一个基于 Python 的 Flask 项目的镜像，并使用 gunicorn 启动
# 镜像环境，我们要 python 3.8.0
FROM python:3.8.0  

MAINTAINER "<hongkuan@gmail.com>" 
# 配置工作目录
WORKDIR /code  
ADD requirements.txt /code/  
# 拷贝当前目录所有的文件，进入 docker 镜像中
COPY . .

# 执行安装 Python 环境依赖
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple gunicorn gevent
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple flask

# 暴露 6000 端口，给外部使用，因为上面我们开启的是 6000 端口
EXPOSE 6000
# 启动命令，这里我们使用 gunicorn 启动 Flask 项目，gunicorn.conf.py 放在项目根目录下

# 使用 gunicorn 运行 Flask 项目，最后一个命令： app:app  前者对应的是flask 启动 文件，后面不要乱改
CMD gunicorn  -c deployment.conf app:sharemananer -b 0.0.0.0:6000