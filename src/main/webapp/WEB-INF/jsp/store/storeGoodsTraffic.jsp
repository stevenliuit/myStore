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
    <form class="form form-horizontal" id="form-storeGoodsTrafficInfo-edit" action="<%=request.getContextPath()%>/server/store/addGoodsTraffic" method = "post">
        <div class="row cl mb-30">
            <div class="row cl">
                <label class="form-label col-3">门店名称：</label>
                <div class="formControls col-6">
                    <span>${storeGoodsTraffic.storeName}</span>
                    <input type="hidden" name = "storeId" value = "${storeGoodsTraffic.storeId}">
                    <input type="hidden" name = "id" value = "${storeGoodsTraffic.id}">
                </div>
                <div class="col-3"> </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">指定配货门店：</label>
                <div class="formControls col-6">
                    <span class="select-box radius">
                        <select id="prepareStoreId" name = "prepareStoreId" class="select">
                            <option value = "0">- 无 -</option>
                        </select>
                    </span>
                </div>
                <div class="col-3"> </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">配货价格：</label>
                <div class="formControls col-6">
                    <span class="select-box radius">
                        <select id="preparePriceType" name = "preparePriceType" class="select">
                            <option value = "0">- 无 -</option>
                            <option value = "1">- 配货门店销售价 -</option>
                            <option value = "2">- 配货门店进货价 -</option>
                        </select>
                    </span>
                </div>
                <div class="col-3"> </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">是否开启在线支付：</label>
                <div class="formControls col-6">
                    <span class="select-box radius">
                        <select id="payOnline" name = "payOnline" class="select">
                            <option value = "0">- 关闭 -</option>
                            <option value = "1">- 开启 -</option>
                        </select>
                    </span>
                </div>
                <div class="col-3"> </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">调货差异操作：</label>
                <div class="formControls col-6">
                    <span class="select-box radius">
                        <select id="differentOpt" name = "differentOpt" class="select">
                            <option value = "0">- 不允许编辑数量 -</option>
                            <option value = "1">- 允许编辑数量，直接完成进货 -</option>
                            <option value = "2">- 允许编辑数量，需出货方确认 -</option>
                        </select>
                    </span>
                </div>
                <div class="col-3"> </div>
            </div>
        </div>
        <div class="row cl">
            <div class="col-10 col-offset-5 mt-20">
                <input class="btn btn-primary radius" type="submit" id="storeGoodsTrafficBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="${ctxResource}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxResource}/js/layer/layer.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctxResource}/js/myself.js"></script>
<script type="text/javascript" src="${ctxResource}/js/Validform_v5.3.2_min.js"></script>
<script>
    $(function(){
        $.post("<%=request.getContextPath()%>/server/store/allStore/" + ${id}, function (data) {
            for(var n in data){
                $("#prepareStoreId").append("<option value = '"+data[n].id+"'>"+data[n].name+"</option>");
            }
            $("#prepareStoreId").val(${storeGoodsTraffic.prepareStoreId});
        });
        $("#differentOpt").val(${storeGoodsTraffic.differentOpt});
        $("#payOnline").val(${storeGoodsTraffic.payOnline});
        $("#preparePriceType").val(${storeGoodsTraffic.preparePriceType});

        var  validtor = $("#form-storeGoodsTrafficInfo-edit").Validform({
            tiptype:4,
            showAllError:true,
            ajaxPost: true,
            ignoreHidden:true, //可选项 true | false 默认为false，当为true时对:hidden的表单元素将不做验证;
            tipSweep:true,//可选项 true | false 默认为false，只在表单提交时触发检测，blur事件将不会触发检测
            btnSubmit:"#storeGoodsTrafficBtn",
            callback:function (data) {
                if(data.result == 1){
                    window.parent.table.fnDraw();
                    layer.msg(data.msg, {time : 2000, icon : 6}, function () {
                        layer_close();
                    });
                }else{
                    layer.msg(data.msg, {time : 2000, icon : 5});
                }
            }
        });
    })
</script>
</body>
</html>