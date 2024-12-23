主要说明
#基于Flask实现后端图片、视频上传、下载、查询、分享、删除等功能的后台管理系统

基于Python的Flask WEB框架实现后台管理系统，
内容包含：用户管理、角色管理、图片视频管理等模块功能。

主要功能包括：用户的创建、角色的创建、权限的分配、用户的修改、角色的修改、权限的修改、用户的删除、
角色的删除、权限的删除等功能。
图片、视频上传下载功能视频、图片查询、分享、删除等功能。

**系统环境python版本为Python 3，Flask版本为0.12.2，mysql版本为5.7.22，python 3.7.0下测试的，
理论上Python 3版本应该都是可以运行的。**
技术关键点说明：
1、使用docker可以灵活修改以及部署后台服务。
2、使用Flask-SQLAlchemy可以方便的进行数据库操作。
3、使用Flask-Login可以方便的进行用户登录。
4、使用Flask-Migrate可以方便的进行数据库迁移。
5、使用Flask-Script可以方便的进行命令行操作。
6、使用blueprint可以方便的进行模块化开发。
6、使用AWS S3可以方便的进行文件存储。
7、使用gunicorn可以方便的进行后台服务的并行处理， 提高后台服务的响应速度和并发能力。
8、使用ninix作为服务器可以进行反向代理同样可以提升后端服务的性能可以方便的进行后台服务的部署。

**使用方法**
1. 导入根目录下db.sql数据库脚本到mysql数据库
2. pip install -r requirements.txt。本项目下的flask是下载好的依赖，在python环境下可以直接运行。
3. python sharemanager.py runserver
4. 打开浏览器，输入http://localhost:6000/admin/，登录系统。
5. 进入后台管理系统，进行相关操作。

后台服务部署：
1、将项目代码上传到服务器本项目提供了Dockerfile文件，可以直接使用docker部署后台服务。
2、修改配置文件config.py中的数据库连接信息。
3、执行docker build -t sharemanager .
4、执行docker run -p 6000:6000 sharemanager
5、打开浏览器，输入http://服务器ip:6000/admin/，登录系统。
6、进入后台管理系统，进行相关操作。

**后端依赖插件**

 1. Flask
 2. Flask-Migrate
 3. Flask-Script
 4. Flask-SQLAlchemy
 5. Flask-Login
 6. itsdangerous
 7. Jinja2
 8. Werkzeug
 9. mysql-python

**注意事项**
1. 系统默认使用本地文件存储，如需使用AWS S3，请修改config.py文件中的UPLOAD_FOLDER和S3_BUCKET_NAME。
2. 系统默认使用本地数据库，如需使用远程数据库，请修改config.py文件中的SQLALCHEMY_DATABASE_URI。
3. 系统默认使用本地用户登录，如需使用第三方登录，请修改login.html文件中的登录方式。
4. 系统默认使用本地图片上传，如需使用第三方图片上传，请修改upload.html文件中的图片上传方式。
5. 系统默认使用本地视频上传，如需使用第三方视频上传，请修改upload.html文件中的视频上传方式。
6. 系统默认使用本地图片查询，如需使用第三方图片查询，请修改query.html文件中的图片查询方式。
7. 系统默认使用本地图片分享，如需使用第三方图片分享，请修改share.html文件中的图片分享方式。
8. 系统默认使用本地图片删除，如需使用第三方图片删除，请修改delete.html文件中的图片删除方式。    
9. 系统默认使用本地视频删除，如需使用第三方视频删除，请修改delete.html文件中的视频删除方式。
10. 系统默认使用本地图片下载，如需使用第三方图片下载，请修改download.html文件中的图片下载方式。
11. 系统默认使用本地视频下载，如需使用第三方视频下载，请修改download.html文件中的视频下载方式。
12. 系统默认使用本地图片查询，如需使用第三方图片查询，请修改query.html文件中的图片查询方式。
13. 系统默认使用本地图片分享，如需使用第三方图片分享，请修改share.html文件中的图片分享方式。
14. 系统默认使用本地图片删除，如需使用第三方图片删除，请修改delete.html文件中的图片删除方式。    
15. 系统默认使用本地视频删除，如需使用第三方视频删除，请修改delete.html文件中的视频删除方式。
16. 系统默认使用本地图片下载，如需使用第三方图片下载，请修改download.html文件中的图片下载方式。
17. 系统默认使用本地视频下载，如需使用第三方视频下载，请修改download.html文件中的视频下载方式。