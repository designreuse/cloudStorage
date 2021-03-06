<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/9/2
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="web/lib/html5shiv.js"></script>
    <script type="text/javascript" src="web/lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="web/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="web/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="web/static/h-ui.admin/css/style.css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="web/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>已删除用户列表</title>
</head>
<body>
  <jsp:include page="menu.jsp"/>
  <jsp:include page="head.jsp"/>
  <section class="Hui-article-box">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户中心 <span class="c-gray en">&gt;</span> 已删除用户 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="text-c"> 输入关键词：
     <%--   <input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}' })" id="datemin" class="input-text Wdate" style="width:120px;">
        -
        <input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d' })" id="datemax" class="input-text Wdate" style="width:120px;">--%>
        <input type="text" class="input-text" style="width:250px" placeholder="输入会员名称、电话、邮箱" id="" name="">
        <button type="submit" class="btn btn-success radius" id="" name=""><i class="Hui-iconfont">&#xe665;</i> 搜用户</button>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l">
            <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
            <a href="javascript:;" onclick="member_add('添加用户','web/back/user-add.jsp','','610')" class="btn btn-primary radius">
                <i class="Hui-iconfont">&#xe600;</i> 添加用户</a>
        </span>
        <span class="r">共有数据：<strong>${totalNum}</strong> 条</span>
    </div>
    <div class="mt-20">

        <form action="batchDeleteUser.action" id="deleteform" method="post">

        <table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="80">ID</th>
                <th width="100">用户名</th>
                <th width="100">真实姓名</th>
                <th width="40">性别</th>
                <th width="110">手机</th>
                <th width="150">邮箱</th>
                <th width="200">会员等级</th>
                <th width="200">注册时间</th>
                <th width="70">状态</th>
                <th width="100">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${userList}" var="user">
            <tr class="text-c">
                <td>${user.userId}</td>
                <td><u style="cursor:pointer" class="text-primary" onclick="member_show('用户信息查看','userDetail.action?userId=${user.userId}','${user.userId}','360','470')">${user.userName}</u></td>
                <td>${user.person.realName}</td>
                <td>${user.person.sex}</td>
                <td>${user.person.phone}</td>
                <td>${user.person.email}</td>
                <td>
                    <c:choose>
                    <c:when test="${user.memberOrder ==1}">普通用户</c:when>
                    <c:when test="${user.memberOrder ==2}">会员</c:when>
                    <c:otherwise>超级会员</c:otherwise>
                     </c:choose>
                </td>
                <td><fmt:formatDate value="${user.person.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                <td class="td-status">
                    <span class="label label-danger radius">已禁用</span>
                <td class="td-manage">
                    <a title="恢复" href="javascript:;" onclick="resumeUser(this,${user.userId})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe66b;</i></a>
                    <a title="编辑" href="javascript:;" onclick="member_edit('编辑','modifyUser.action?userId=${user.userId}','','510')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
                    <a title="销号" href="javascript:;" onclick="deleteUser(this,${user.userId})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
        </form>
        <div class="dataTables_info">每页显示10条 ，共 ${totalPage} 页</div>
        <div id="DataTables_Table_0_wrapper"
             class="dataTables_wrapper no-footer">
            <div class="dataTables_paginate paging_full_numbers" id="tablePage">
                <a class="paginate_button first disabled"
                   aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0"
                   id="firstPage" href="showDeleteUser.action?page=1">第一页</a>
                <c:choose>
                    <c:when test="${page>1}">
                        <a
                                class="paginate_button previous disabled"
                                aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
                                id="previousPage" href="showDeleteUser.action?page=${page-1 }">上一页</a>
                    </c:when>
                    <c:otherwise>
                        <a class="paginate_button previous disabled"
                                aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
                                id="previousPage" href="javascript:(0);">上一页</a>
                    </c:otherwise>
                </c:choose>

                <span>
                    <a class="paginate_button current"
                         aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0">${page}</a></span>
                <c:choose>
                    <c:when test="${page<totalPage}">
                        <a class="paginate_button next disabled"
                           aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0"
                           id="nextPage" href="showDeleteUser.action?page=${page+1 }">下一页</a>
                    </c:when>
                    <c:otherwise>
                        <a class="paginate_button previous disabled"
                                aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0"
                                id="previousPage" href="javascript:(0);">下一页</a>
                    </c:otherwise>
                </c:choose>
                <a class="paginate_button last disabled"
                   aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0"
                   id="lastPage" href="showDeleteUser.action?page=${totalPage}">最后一页</a>
            </div>
        </div>

    </div>
</div>
  </section>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="web/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="web/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="web/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="web/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="web/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="web/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="web/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
    /*$(function(){
        $('.table-sort').dataTable({
            "aaSorting": [[ 1, "desc" ]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
              //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
              {"orderable":false,"aTargets":[0,8,9]}// 制定列不参与排序
            ]
        });

    });*/


    /*用户-添加*/
    function member_add(title,url,w,h){
        layer_show(title,url,w,h);
    }


    /*用户-查看*/
    function member_show(title,url,id,w,h){
        layer_show(title,url,w,h);
    }


    /*用户-编辑*/
    function member_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*密码-修改*/
    function change_password(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

    /*用户恢复*/
    function resumeUser(obj,id){
        layer.confirm('确认要恢复该账号吗？',function(index){
            $.ajax({
                type: 'POST',
                data:{
                    "userId":id
                },
                url: '${pageContext.request.contextPath}/resumeUser.action',
                success: function(data){
                    if(data=="success") {
                        $(obj).parents("tr").remove();
                        layer.msg('已恢复!', {icon: 1, offset: '40%', time: 1000});
                    }else {
                        layer.msg('操作失败！',{icon:2,offset:'40%',time:1000});
                    }
                },
                error:function(data) {
                    console.log(data.msg);
                },
            });
        });
    }

    /*用户-删除*/
    function deleteUser(obj,id){
        layer.confirm('确认要清除该账号吗？',function(index){
            $.ajax({
                type: 'POST',
                data:{
                    "userId":id
                },
                url: '${pageContext.request.contextPath}/resetUser.action',
                success: function(data){
                    if(data=="success") {
                        $(obj).parents("tr").remove();
                        layer.msg('已清除!', {icon: 1, offset: '40%', time: 1000});
                    }else {
                        layer.msg('删除失败！',{icon:2,offset:'40%',time:1000});
                    }
                },
                error:function(data) {
                    console.log(data.msg);
                },
            });
        });
    }
</script>
</body>
</html>
