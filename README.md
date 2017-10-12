# docker-php-5.2.17-fpm
PHP-5.2.17 的 Docker 镜像，基于 CentOS6 + PHP-5.2.17 + Zend Optimizer +  FastCGI(PHP-FPM) + Nginx 构建

## 1. 镜像说明
由于 PHP 官方已经不再维护 5.2.17，各个 Linux 发行版不再提供该版本的安装包。如果要使用该版本，则必须从源代码编译。

`docker-php-5.2.17-fpm` 的存在，降低了老旧 PHP 项目的部署和维护成本。

## 2. 使用方法

### 2.1 启动一个实例很简单

    docker run -d --name some-php-5.2.17 fifilyu/php-5.2.17-fpm:tag

此时访问 http://容器IP:8080 能看到 PHP 版本信息。

### 2.2 使用 Hosting 数据目录启动一个实例

    docker run -d --name some-php-5.2.17 -v /some/content:/data/web/:ro fifilyu/php-5.2.17-fpm:tag

### 2.3 启动容器时暴露端口

    docker run -d --name some-php-5.2.17 -p 8080:8080 fifilyu/php-5.2.17-fpm:tag

此时访问 http://localhost:8080 能看到 PHP 版本信息。

## 3. 镜像说明

镜像启动入口:

`/usr/local/bin/docker-entrypoint.sh`


docker-entrypoint.sh:

    #!/bin/sh

    /sbin/service php-fpm start
    /usr/sbin/nginx

    # 保持前台运行，不退出
    while true
    do
        sleep 100
    done

## 4. PHP 环境配置说明

### 4.1 配置文件

#### 4.1.1 PHP

PHP 安装目录:

`/usr/local/php-5.2.17/`

PHP 主配置文件:

`/usr/local/php-5.2.17/etc/php.ini`

PHP 模块配置文件:

`/usr/local/php-5.2.17/etc/php.d`

[NOTE]
如果要启用或禁用模块，请直接修改 `php.d` 下的 `.ini` 文件。

PHP-FPM 配置文件:

`/usr/local/php-5.2.17/etc/php-fpm.conf`

#### 4.1.2 Nginx

Nginx 主配置文件:

`/etc/nginx/nginx.conf`

Nginx Host 配置文件:

`/etc/nginx/conf.d`

[NOTE]
`/etc/nginx/conf.d/example.com.conf` 是默认创建的 Host ，监听 `8080` 端口。

Web 目录:

`/data/web`

[NOTE]
`/data/web/example.com` 目录是默认站点的文件目录。

**[NOTE]目前，没有时间做更多工作实现环境变量和数据容器相关设置的简化。每次更新容器数据，需要执行 `docker exec -it 容器名称 bash` 进入正在运行的容器操作。**

### 4.2 运行目录

PHP-FPM 日志目录:

`/usr/local/php-5.2.17/var/log`

Session 目录:

`/usr/local/php-5.2.17/var/lib/session`

### 4.3 模块

#### 4.3.1 默认启用

* bcmath
* curl
* exif
* gd
* mbstring
* mcrypt
* mhash
* mysqli
* mysql
* pdo_mysql
* xmlrpc
* xml
* Zend Optimizer

#### 4.3.2 默认禁用
* calendar
* ftp
* gettext
* iconv
* openssl
* snmp
* sockets
* zip

[NOTE]
除 `snmp` 模块外，其它模块可以随意启用，已经不再需要安装依赖。

[NOTE]
启用 `snmp` 模块，需要安装依赖 `yum install -y net-snmp-libs`。
