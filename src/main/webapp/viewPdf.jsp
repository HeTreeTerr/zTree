<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>pdf预览</title>
</head>
<body>
    <div>
        <span>
            在线预览pdf,并没有非常完美的解决方案。<br/>
            建议使用工具将文件转为图片显示！！！
        </span>
    </div>
    <%--<div>
        <iframe src="/static/pdf/htmlView.pdf" width="800" height="600"></iframe>
    </div>--%>
    <div style="width:800px;">
        <img src="/static/img/121310134693_0htmlView_1.Jpeg" width="100%" height="100%">
    </div>
</body>
</html>