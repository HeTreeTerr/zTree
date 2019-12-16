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
            &nbsp;&nbsp;&nbsp;&nbsp;[ <a id="addParent" href="javascript:;" title="新增一级菜单" onclick="return false;">新增一级菜单</a> ]
            &nbsp;&nbsp;&nbsp;&nbsp;[ <a id="edit" href="javascript:;" title="修改菜单名" onclick="return false;">修改菜单名</a> ]
        </ul>
    </div>
</div>
</body>
<script type="text/javascript" src="/static/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="/static/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="/static/zTree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="/static/zTree/js/jquery.ztree.exedit.js"></script>
<SCRIPT type="text/javascript">

    var zTree;
    //是否是父节点
    var isParent;

    var fromZTree="";
    //新建是默认名（++）
    var newCount = 1;

    var setting = {
        treeId:"treeDemo",
        edit: {
            enable: true,
            showRemoveBtn: true,
            showRenameBtn: true,
            renameTitle: "编辑节点名称",
            removeTitle: "删除节点",
            showAddNodeBtn:true,
            drag: {
                inner: true
            }
        },
        view : {
            dblClickExpand : true,
            selectedMulti:false,
            addHoverDom: addHoverDom,        //添加按钮
            removeHoverDom: removeHoverDom
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId",
                rootPId: 0
            }
        },
        callback: {
            beforeRename: zTreeBeforeRename,
            beforeRemove: zTreeBeforeRemove,
            beforeDrag: beforeDrag,
            beforeDrop: beforeDrop,
            onClick:function(event, treeId, treeNode, clickFlag){
                $(".tip-yellowsimple").remove();
                showDataList(treeNode);
            }
        }
    };

    function beforeDrag(treeId, treeNodes) {
        fromZTree = treeId;
        for (var i=0,l=treeNodes.length; i<l; i++) {
            if (treeNodes[i].drag === false) {
                return false;
            }
        }
        return true;
    }

    function beforeDrop(treeId, treeNodes, targetNode, moveType) {
        var treeNodeIndex = $.fn.zTree.getZTreeObj(fromZTree).getNodeIndex(treeNodes[0]);
        var targetNodeIndex  = $.fn.zTree.getZTreeObj(treeId).getNodeIndex(targetNode);
        var moveType = moveType;
        if(moveType!='inner'){
            if(treeNodeIndex>targetNodeIndex){
                moveType ='prev';
            }else{
                moveType = 'next';
            }
        }
        return targetNode ? targetNode.drop !== false : true;
    }

    //修改节点名称
    function zTreeBeforeRename(treeId, treeNode, newName, isCancel) {
        if(newName==""||newName.length <2){
            return false;
        }
        //编辑名称 /tree/updateTreeType?id=1&name=jojo2
        $.ajax({
            datatype: "json",
            url:encodeURI('/tree/updateTreeType?id='+treeNode.id+'&name='+newName),
            success:function(data){
                if(data.code!=100){
                    console.log("修改节点失败");
                    return;
                }
            }
        });
        return true;
    }

    //删除节点
    function zTreeBeforeRemove(treeId, treeNodes){

        if(confirm("确定删除该节点?")){
            //点击确定后操作
            //删除
            $.ajax({
                async:false,
                url:'/tree/deleteTreeType?id='+treeNodes.id,
                success:function(data){
                    if(data.code!=100){
                        console.log("删除失败");
                        return;
                    }
                }
                });
            console.log("删除成功");
            return true;
        }
        return false;
    }
    //添加节点
    function addHoverDom(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span"); //获取删除修改span
        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='添加节点' onfocus='this.blur();'></span>";  //添加add  span
        sObj.after(addStr);          // 把删除修改 span 放到 add 后面
        var btn = $("#addBtn_"+treeNode.tId);
        if (btn) btn.bind("click", function(){

            //添加节点
            $.ajax({    //后端添加！！！！   必须有，要不数据库还是没添加，否则刷新页面后节点就会消失！
                url:"/tree/addTreeType",
                data : {pId:treeNode.id,name:"新菜单节点"+(newCount++)},  //传给后台当前节点的父Id和名称
                async:false,
                type:'post',
                dataType: "json",
                type: "POST",
                success: function(result){
                    if(result.code == 100){
                        console.log("添加成功");
                        var nodes = zTree.addNodes(treeNode, {id:result.extend.treeType.id,pId:result.extend.treeType.pId, name:result.extend.treeType.name});//前端添加成功
                        zTree.editName(nodes[0]);
                    }else{
                        console.log("添加失败");
                    }
                }
            });
            return false;
        });
    };

    function removeHoverDom(treeId, treeNode) {   // 去除
        $("#addBtn_"+treeNode.tId).unbind().remove();
    };

    //新建一级节点菜单
    function add() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        var parentNode=null;
        var url ='/tree/addTreeType';
        nodes = zTree.getSelectedNodes();
        var treeNode = nodes[0];
        //添加节点
        $.ajax({
            url:url,
            data:'name=新菜单节点'+(newCount++),
            success:function(result){
                if(result.code == 100){
                    console.log("添加成功");
                    treeNode = zTree.addNodes(parentNode, {id:result.extend.treeType.id, name:result.extend.treeType.name,pId:0});//前端添加成功
                    zTree.editName(treeNode[0]);
                }else{
                    console.log("添加失败");
                }
            }
        });

    }

    //修改菜单节点名称
    function edit() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = zTree.getSelectedNodes(),
            treeNode = nodes[0];
        if (nodes.length == 0) {
            alert("请选择一个菜单进行修改名称！");
            return;
        }
        zTree.editName(treeNode);
    };

    //点击节点的触发事件
    function showDataList(treeNode){
        console.log("节点编号："+treeNode.id);
    }

    $(function () {
        //发送ajax请求获取节点信息
        $.ajax({
            url: "/tree/findTreeType",
            dataType: "json",
            type: "POST",
            async:false,
            success: function (result) {
                if(result.code == 100){
                    console.log("请求成功");
                    var zNodes = result.extend.treeTypeList;
                    zTree = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                }else{
                    console.log("请求出错");
                }
            },
            error:function () {
                console.log("请求失败");
            }
        });

        //点击添加按钮
        $("#addParent").click(function () {
            add();
        });
        //点击修改按钮
        $("#edit").bind("click", edit);

    });
</SCRIPT>
</html>