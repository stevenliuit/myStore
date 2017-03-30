<%@page language="java" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品原材料设置</title>
    <link href="${ctxResource}/css/H-ui.css" rel="stylesheet" type="text/css" />
    <link href="${ctxResource}/css/admin.css" rel="stylesheet" type="text/css" />
    <link href="${ctxResource}/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="row cl mb-5">
    <div class="col-4">
        <img src="${goods.imgUrl}" style="width: 145px"/>
    </div>
    <div class="col-8">
        <div class="row cl">
            <label class="form-label col-3">品名 ：</label>
            <div class="formControls col-6">
                <span>${goods.name}</span>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">条码 ： </label>
            <div class="formControls col-6">
                <span>${goods.goodsNo}</span>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">售价 ： </label>
            <div class="formControls col-6">
                <span>${goods.price} 元 <c:if test="${not empty goods.mainUnitName}">/${goods.mainUnitName}</c:if></span>
            </div>
        </div>
    </div>
</div>
<div class="row cl mb-5" style="border-top: 1px;border-top-style: dashed;border-color:#999;">
    <label class="form-label col-3"><input type="checkbox" id="updatePriceByRaw" style="position: absolute;left: 45px;top: 11px;"/></label>
    <div class="formControls col-6">
        <span style="font-size: 12px;color: #999;text-align: left;">使用配方成本价更新成品进货价</span>
    </div>
</div>
<table class="table table-border table-bordered table-bg box-shadow" id="xpjgl">
    <thead>
    <tr class="text-c">
        <th width="100">原材料</th>
        <th width="100">编码</th>
        <th width="170">数量</th>
        <th width="60">单位</th>
        <th width="60">删除</th>
    </tr>
    </thead>
    <tbody id = "rawList">
    </tbody>
</table>
<input type = "hidden" id = "check" value=""/>
<p><a class="btn border-grey block mt-20 mb-40" id="addRaw">+ 添加原材料</a></p>
<div class="cfpdBtnbox">
    <a class="btn btn-primary size-M f-r" id="save">保存</a>
    <a class="btn btn-default size-M f-r" onclick="layer_close()">取消</a>
</div>

<script type="text/javascript" src="${ctxResource}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxResource}/js/layer/layer.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.admin.js"></script>
<script>
    $(function(){
        $.post("<%=request.getContextPath()%>/server/raw/goodsRawItemList", {id : "${id}"}, function(data){
            var initCheck = [];
            for(var n in data){
                $("#rawList").append("<tr class=\"text-c\">" +
                    "<td><span type=\"text\" class=\"rawName\">"+data[n].rawName+"</span></td>" +
                    "<td><span type=\"text\" class=\"rawNo\">"+data[n].rawNo+"</span><input type = 'hidden' value = '"+data[n].rawId+"' class=\"rawId\"/></td>" +
                    "<td><input type='text' class=\"input-text rawNum\" value = \""+data[n].rawNum+"\"/></td>" +
                    "<td><span type='text' class=\"goodsUnitName\">"+data[n].goodsUnitName+"</span><input type='hidden' class='goodsUnitId' value ='"+data[n].goodsUnitId+"'></td>" +
                    "<td><a class=\"btn btn-danger size-MINI radius\" onclick=\"del("+data[n].id+", this)\">删除</a></td>" +
                    "</tr>");
                $(".rawType").eq(n).val(data[n].type);
                initCheck.push(data[n].rawNo);
            }
            $("#check").val(initCheck);
            if("${goods.useRawPrice}" == 1){
                $("#updatePriceByRaw").prop("checked", true);
            }
        });

        //添加配方
        $("#addRaw").click(function(){
            layer.open({
                type: 2,
                area: ['490px', '400px'],
                fix: true, //不固定
                title: false,
                shadeClose: false,
                shade: false,
                closeBtn: 0,
                content: "<%=request.getContextPath()%>/server/raw/rawToGoodsList/${id}"
            });
        });

        //保存
        $("#save").click(function(){
            var len = $(".text-c").length;
            var rawItems = [];
            for(var i = 0; i < len - 1; i++){
                var rawItem = new RawItem(
                    "${id}",
                    $(".rawNum").eq(i).val(),
                    $(".rawId").eq(i).val(),
                    $(".rawName").eq(i).text(),
                    $(".rawNo").eq(i).text(),
                    $(".goodsUnitId").eq(i).val(),
                    $(".goodsUnitName").eq(i).text()
                );
                rawItems.push(rawItem);
            }
            var useRawPrice = 0;
            if($("#updatePriceByRaw").prop("checked")){
                useRawPrice = 1;
            }
            $.post("<%=request.getContextPath()%>/server/raw/addRawItem", {goodsId : "${id}", rawItems:JSON.stringify(rawItems), useRawPrice:useRawPrice}, function (data) {
                if(data.result == 1){
                    window.parent.table.fnDraw();
                    layer.msg(data.msg, {time : 2000, icon : 6}, function () {
                        layer_close();
                    });
                }else{
                    layer.msg(data.msg, {time : 2000, icon : 5});
                }
            });
        });
    });

    //取消
    function layer_close(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }

    //删除
    function del(id, obj){
        layer.msg('确定要删除该原材料？', {
            time: 0 ,//不自动关闭
            btn: ['确定', '取消'],
            yes: function(){
                $(obj).parents("tr").remove();
                var index = layer.alert();
                layer.close(index);
            }
        });
    }

    function RawItem(goodsId, rawNum, rawId, rawName, rawNo, goodsUnitId, goodsUnitName) {
        this.goodsId = goodsId;
        this.rawNum = rawNum;
        this.rawId = rawId;
        this.rawName = rawName;
        this.goodsUnitId = goodsUnitId;
        this.goodsUnitName = goodsUnitName;
        this.rawNo = rawNo;
    }
</script>
</body>
</html>

