<%@page language="java" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>配货</title>
	<link href="${resources}/css/H-ui.css" rel="stylesheet" type="text/css" />
    <link href="${resources}/css/admin.css" rel="stylesheet" type="text/css" />
    <link href="${resources}/css/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<nav class="clearfix navbar">
	<div class="f-l mr-10"><i class="Hui-iconfont mr-5 f-16">&#xe619;</i>审核</div>
	<div class="f-l">&gt;</div>
	<div class="c-success f-l ml-10 mr-10"><i class="Hui-iconfont mr-5">&#xe601;</i>配货</div>
	<div class="f-l">&gt;</div>
	<div class="f-l ml-10"><i class="Hui-iconfont mr-5">&#xe619;</i>完成</div>
</nav>
<table class="table table-border table-bordered table-bg" id="xpjgl">
	<thead>
		<tr class="text-c">
			<th>商品名称</th>
			<th>条码</th>
			<th>请求量</th>
			<th>单位</th>
			<th width="120">配货量</th>
			<th width="120">配货价(元/单位)</th>
			<th>小计(元)</th>
			<th>备注</th>
		</tr>
	</thead>
	<tbody id = "orderGoodsInfos">
		<tr>
           	<td>奶茶粉</td>
            <td>10001</td>
            <td>3</td>
            <td>无</td>
            <td><input type="text" class="input-text text-r" class="num" value="5" /></td>
            <td><input type="text" class="input-text text-r" class="price" value="300" /></td>
            <td id="total">300.00</td>
            <td>-</td>
       </tr>
	</tbody>
</table>

<div class="cfpdBtnbox">
	<div class="f-l ml-20">共 <b class="c-primary" id="categoriesNum">1</b> 种商品， <b class="c-primary" id="goodsNum">5</b> 件， 总计 <b class="c-primary" id="priceTotal">1000.00</b> 元。</div>
	<a class="btn btn-primary size-M f-r" id="pgoods">配货</a>
</div>
<script type="text/javascript" src="${resources}/js/jquery.min.js"></script>
<script type="text/javascript" src="${resources}/js/jquery.min.js"></script>
<script type="text/javascript" src="${resources}/js/layer/layer.js"></script>
<script>
$(function(){
    $.post("<%=request.getContextPath()%>/goodsTraffic/findOrderGoodsInfosByGoodsTrafficId",
        {"id" : ${goodsTrafficId}},
        function(data){
            var categoriesArr = [];
            for(var n in data){
                if($.inArray(data[n].catetoriesId, categoriesArr) != -1){
                    categoriesArr.push(data[n].categoriesId);
                }
                $("#orderGoodsInfos").append(
                    "<tr>" +
                    "<td>"+data[n].goodsName+"</td>" +
                    "<td>"+data[n].goodsNo+"</td>" +
                    "<td>"+data[n].orderNum+"</td>" +
                    "<td>"+ (data[n].mainUnit == null || data[n].mainUnit == "" ? "无" : data[n].mainUnit) +"</td>" +
                    "<td><input type=\"text\" class=\"input-text text-r num\"  value=\""+data[n].orderNum+"\" /></td>" +
                    "<td><input type=\"text\" class=\"input-text text-r price\"  value=\""+data[n].price+"\" /></td>" +
                    "<td class=\"total\">"+data[n].priceSum+"</td>" +
                    "<td>"+ (data[n].description == null || data[n].description == "" ? "-" : data[n].description) +"</td>" +
                    "</tr>"
                );
            }
            var priceTotal = 0, goodsNum = 0;
            $(".total").each(function () {
                priceTotal += Number($(this).text());
            });
            $(".num").each(function(){
                goodsNum += Number($(this).text());
            });
            $("#categoriesNum").text(categoriesArr.length); //类别总计
            $("#goodsNum").text(goodsNum); //商品数量总计
            $("#priceTotal").text(priceTotal); //价格总计
        }
    );
	//配货
	$("#pgoods").click(function(){
	    function orderGoodsInfo(distributeNum, price, priceSum){
            this.distributeNum = distributeNum;
            this.price = price;
            this.priceSum = priceSum;
        }
        var orderGoodsInfoArr = [];

        $.post("<%=request.getContextPath()%>/goodsTraffic/prepare", {"id": ${goodsTrafficId}, "orderGoodsInfos" : 1}, function (data) {
            $("body").html(data.msg);
        });
		/*layer.msg('已配货!',{time:1000});
		setTimeout(function(){
			$.get("step3.html",function(html){
				$("body").html(html);
			},"html");
		},500);*/
	});

	$("#num,#price").blur(function(){
		var total = $("#num").val()*$("#price").val();
		$("#total").html(total);
		$("#num2").html($("#num").val());
		$("#total2").html(total);
	});
});

</script>

</body>
</html>