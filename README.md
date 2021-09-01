# zTree
## 1.简介
>ztree树形结构学习  
实现树的前端到数据库编辑同步（增、删、改、查）  
使用ssm+jsp页面作为基础，进行代码编写

## 2.环境准备
* jdk8
* mysql数据库
* maven jar包仓库
* idea代码编辑器
* tomcat8

## 3.代码启动
### 3.1拉取代码
git clone xxx.git  
或者在github上直接点击下载

### 3.1导入数据库
1. 创建数据库，数据库名称：ztree
2. 在项目目录中找sql/ztree.sql，使用navicat数据库连接工具导入sql语句至数据库

### 3.2项目启动
1. 打开idea，配置maven仓库，配置tomcat启动项
2. 观察控制台日志，成功启动后，浏览器访问，http://localhost:8080/

### 3.3代码内容
1. 实现页面树基本交互（增删改查），没有持久化至数据库。
http://localhost:8080/index.jsp
2. 实现页面树基本交互（增删改查），并持久化数据至数据库。
http://localhost:8080/index2.jsp
3. 实现页面树基本交互（增删改查），持久化数据至数据库，并对默认树样式进行自定义
优化。http://localhost:8080/index3.jsp
4. jsp页面浏览pdf文件（和tree无关）
http://localhost:8080/viewPdf.jsp
