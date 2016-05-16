####什么是httpd

Apache HTTP Server（简称Apache）是Apache软件基金会的一个开放源代码的网页服务器软件，可以在大多数电脑操作系统中运行，由于其跨平台和安全性。被广泛使用，是最流行的Web服务器软件之一。它快速、可靠并且可通过简单的API扩充，将Perl/Python等解释器编译到服务器中。
####如何使用这个镜像？
此镜像只包含的Apache httpd的默认配置。如果你想运行一个简单的HTML服务器，添加一个简单的Dockerfile到您的项目，其中public-html/是包含所有的HTML目录。

#####在你的工程创建一个Dockerfile
````
FROM index.shurenyun.com/httpd:2.4
COPY ./public-html/ /usr/local/apache2/htdocs/
````
构建和运行镜像的命令如下：

````
$ docker build -t my-apache2 .
$ docker run -it --rm --name my-running-app my-apache2
````
#####不使用Dockerfile
如果你不想在你的工程使用Dockerfile ，最有效的方法如下：

````
$ docker run -it --rm --name my-apache-app -v "$PWD":/usr/local/apache2/htdocs/ index.shurenyun.com/httpd:2.4
````
#####配置
定制化的httpd server配置，只需要复制你的配置到以下文件

    /usr/local/apache2/conf/httpd.conf

````
FROM index.shurenyun.com/httpd:2.4
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
````


#####SSL/HTTPS

如果你想要通过SSL运行web服务，最简单的配置是复制或通过`-v` 参数将`server.crt`和`server.key`到`/usr/local/apache2/conf/` 然后修改 `/usr/local/apache2/conf/httpd.conf`  去掉`#Include conf/extra/httpd-ssl.conf`行的注释。这个配置文件将使用先前添加的证书文件和告诉守护进程还侦听443端口。此外，在你运行的docker务必添加类似`-p 443 :443`进行HTTPS端口转发。

#####支持的Docker版本
这个镜像支持 Docker 1.11.1版本，尽可能支持低于docker1.6docker 版本的支持。




