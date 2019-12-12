<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>树形编辑</title>
    <link rel="stylesheet" href="/static/zTree/css/demo.css" type="text/css">
    <link rel="stylesheet" href="/static/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
<h1>用 zTree 方法 增 / 删 / 改 节点</h1>
<h6>[ jojojojo ]</h6>
<div class="content_wrap">
    <div class="zTreeDemoBackground left">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
    <div class="right">
        <ul class="info">
            <li><p>对节点进行 增 / 删 / 改，试试看：<br/>
                &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="callbackTrigger" checked /> removeNode 方法是否触发 callback<br/>
                &nbsp;&nbsp;&nbsp;&nbsp;[ <a id="addParent" href="#" title="增加父节点" onclick="return false;">增加父节点</a> ]
                &nbsp;&nbsp;&nbsp;&nbsp;[ <a id="addLeaf" href="#" title="增加叶子节点" onclick="return false;">增加叶子节点</a> ]
                &nbsp;&nbsp;&nbsp;&nbsp;[ <a id="edit" href="#" title="编辑名称" onclick="return false;">编辑名称</a> ]<br/>
                &nbsp;&nbsp;&nbsp;&nbsp;[ <a id="remove" href="#" title="删除节点" onclick="return false;">删除节点</a> ]
                &nbsp;&nbsp;&nbsp;&nbsp;[ <a id="clearChildren" href="#" title="清空子节点" onclick="return false;">清空子节点</a> ]<br/>
                remove log:<br/>
                <ul id="log" class="log"></ul></p>
            </li>
        </ul>
    </div>
</div>
</body>
<script type="text/javascript" src="/static/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="/static/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="/static/zTree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="/static/zTree/js/jquery.ztree.exedit.js"></script>
<SCRIPT type="text/javascript">

    $(function () {
        //发送ajax请求获取节点信息
        $.ajax({
            url: "/tree/findTreeType",
            dataType: "json",
            type: "POST",
            success: function (result) {
                if(result.code == 100){
                    console.log("请求成功");
                    var zNodes = result.extend.treeTypeList;
                    //初始化树
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                }else{
                    console.log("请求出错");
                }
            },
            error:function () {
                console.log("请求失败");
            }
        });

        $("#addParent").bind("click", {isParent:true}, add);
        $("#addLeaf").bind("click", {isParent:false}, add);
        //$("#edit").bind("click", edit);
        //$("#remove").bind("click", remove);
        //$("#clearChildren").bind("click", clearChildren);
    });

    //树的属性配置
    var setting = {
        view: {
            selectedMulti: false
        },
        edit: {
            enable: true,
            showRemoveBtn: false,
            showRenameBtn: false
        },
        data: {
            keep: {
                parent:true,
                leaf:true
            },
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeDrag: beforeDrag,
            beforeRemove: beforeRemove,
            beforeRename: beforeRename,
            onRemove: onRemove
        }
    };

    function beforeDrag(treeId, treeNodes) {
        return false;
    }

    function beforeRemove(treeId, treeNode) {
        className = (className === "dark" ? "":"dark");
        showLog("[ "+getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
        return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
    }

    function beforeRename(treeId, treeNode, newName) {
        if (newName.length == 0) {
            alert("节点名称不能为空.");
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            setTimeout(function(){zTree.editName(treeNode)}, 10);
            return false;
        }
        return true;
    }

    function onRemove(e, treeId, treeNode) {
        return false;
    }
    var newCount = 1;
    function add(e) {
        debugger;
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            isParent = e.data.isParent,
            nodes = zTree.getSelectedNodes(),
            treeNode = nodes[0];
        if (treeNode) {
            treeNode = zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, isParent:isParent, name:"new node" + (newCount++)});
        } else {
            treeNode = zTree.addNodes(null, {id:(100 + newCount), pId:0, isParent:isParent, name:"new node" + (newCount++)});
        }
        if (treeNode) {
            zTree.editName(treeNode[0]);
        } else {
            alert("叶子节点被锁定，无法增加子节点");
        }
    };
</SCRIPT>
</html>