<%@page language="java" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="lib/html5.js"></script>
    <script type="text/javascript" src="lib/respond.min.js"></script>
    <script type="text/javascript" src="lib/PIE_IE678.js"></script>
    <![endif]-->
    <link href="${ctxResource}/css/H-ui.css" rel="stylesheet" type="text/css" />
    <link href="${ctxResource}/css/admin.css" rel="stylesheet" type="text/css" />
    <link href="${ctxResource}/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${ctxResource}/css/1.0.8/iconfont.css" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<body>
<div class="pd-20 minwidth">
    <form class="form form-horizontal" id="form-role-add" method="post" action="<%=request.getContextPath()%>/role/addRole">
        <div class="row cl">
            <label class="form-label col-3">是否启用：</label>
            <div class="formControls col-6">
                <div class="radio-box">
                    <input type="radio" id="role_using-1" name="status" value = "1" checked>
                    <label for="role_using-1">是</label>
                </div>
                <div class="radio-box">
                    <input type="radio" id="role_using-2" name="status" value = "0">
                    <label for="role_using-2">否</label>
                </div>
            </div>
            <div class="col-3"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">* </span>角色名称：</label>
            <div class="formControls col-6">
                <input type="text" class="input-text radius" value="" id="roleName" name="roleName">
            </div>
            <div class="col-3"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">角色权限：</label>
            <div class="formControls col-6">
                <div class="mb-40 pd-20 clearfixs" id="perBox">
                    <input type="hidden" name = "permissions" id="permissions"/>
                    <br clear="all" />
                </div>
            </div>
            <div class="col-3"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">备注：</label>
            <div class="formControls col-6">
                <textarea rows="2" maxlength="200" class="edit_txt textarea radius" id="role_desc" name="description"></textarea>
            </div>
            <div class="col-3"> </div>
        </div>
        <div class="row cl" style="display: none;">
            <div class="row cl">
                <label class="form-label col-3">是否同步相应收银员的权限：</label>
                <div class="formControls col-6">
                    <div class="radio-box">
                        <input type="radio" id="isAsync-1" name="isAsync" value = "1" checked>
                        <label for="isAsync-1">是</label>
                    </div>
                    <div class="radio-box">
                        <input type="radio" id="isAsync-2" name="isAsync" value = "0">
                        <label for="isAsync-2">否</label>
                    </div>
                </div>
                <div class="col-3"></div>
            </div>
        </div>
        <div class="row cl">
            <div class="col-10 col-offset-5 mt-20">
                <input class="btn btn-primary radius" type="button" id="roleAddBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="${ctxResource}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxResource}/js/layer/layer.js"></script>
<script type="text/javascript" src="${ctxResource}/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctxResource}/js/myself.js"></script>
<script type="text/javascript" src="${ctxResource}/js/Validform_v5.3.2_min.js"></script>
<script>
    $(function () {
        var  validtor = $("#form-role-add").Validform({
            tiptype:3,
            showAllError:true,
            ajaxPost: true,
            ignoreHidden:true, //可选项 true | false 默认为false，当为true时对:hidden的表单元素将不做验证;
            tipSweep:true,//可选项 true | false 默认为false，只在表单提交时触发检测，blur事件将不会触发检测
            btnSubmit:"#roleAddBtn",
            callback:function (data) {
                window.parent.table.fnDraw();
            }
        });

        validtor.addRule([
            {
                ele:"#role_name",
                datatype:"*",
                nullmsg:"角色名称必填"
            }
        ]);

        $.post("<%=request.getContextPath()%>/permission/findAllPermission", {type : 0}, function(data){
            for(var n in data){
                $("#perBox").append(
                    "<label><input type=\"checkbox\" name=\"ck1\" value = '"+data[n].id+"'/>"+data[n].name+"</label>"
                );
            }
            $("#perBox").append("<br clear=\"all\"/>");
        })

        $("input[type='checkbox']").change(function() {
            var ids = [];
            $("input[type='checkbox']:checked").forEach(function (i) {
                ids.push($(this).val());
            })
            $("#permissions").val(ids);
            alert($("#permissions").val());
        });
    })
</script>
</body>
</html>