﻿<%@page language="java" pageEncoding="utf-8"%>
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
<script type="text/javascript" src="${ctxResource}/js/html5.js"></script>
<script type="text/javascript" src="${ctxResource}/js/respond.min.js"></script>
<![endif]-->
<link href="${ctxResource}/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${ctxResource}/css/admin.css" rel="stylesheet" type="text/css" />
<link href="${ctxResource}/css/style.css" rel="stylesheet" type="text/css" />
<link href="${ctxResource}/css/1.0.8/iconfont.css" rel="stylesheet" type="text/css" />

<title>商品列表</title>
</head>
<body class="pos-r">
<div>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 货流 <span class="c-gray en">&gt;</span> 门店订货 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="clearfix">
        <div class="text-r cl pl-20 pt-10 pb-10 box-shadow">
            <span class="l">
                <a href="javascript:void(0);" onclick="add();" class="btn btn-primary radius">进货</a>
            </span>
            <c:if test="${store.multiple eq 1}">
                <span class="select-box" style="width: 100px;">
                    <select class="select" id="traffic_store">
                        <option value="0">全部门店</option>
                    </select>
                </span>
            </c:if>
            <span class="select-box" style="width: 120px;">
                <select class="select" id="traffic_static">
                    <option value="-1">全部货单</option>
                    <option value = "0">门店进货单</option>
                    <option value = "1">门店退货单</option>
                </select>
            </span>
            <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'startTafficDate\')||\'%y-%M-%d\'}'})" id="startTafficDate" class="input-text Wdate radius" style="width:120px;"/> 至
            <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTafficDate\')||\'%y-%M-%d\'}'})" id="endTafficDate" class="input-text Wdate radius" style="width:120px;"/>
            <input type="text" id="trafficNo" placeholder="货单编号" style="width:160px" class="input-text radius">
            <button id="trafficManage_search" class="btn btn-success"><i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <div class="pd-20 clearfix">
            <table class="table table-border table-bordered table-bg table-hover table-striped box-shadow" id="trafficManage_table">
                <thead>
                    <tr class="text-c">
                        <th width="50">序号</th>
                        <th width="30"><input type="checkbox" name="selectAll" id="selectAll"></th>
                        <th width="50">操作</th>
                        <th width="100">货流单号</th>
                        <th width="100">下单时间</th>
                        <th width="50">货单类型</th>
                        <th width="50">出货门店</th>
                        <th width="50">进货门店</th>
                        <th width="50">状态</th>
                        <th width="50">货流量</th>
                        <th width="50">总价</th>
                        <th width="50">预付款</th>
                        <th width="50">备注</th>
                    </tr>
                </thead>
                <tbody id="table_tr"></tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript" src="${ctxResource}/js/jquery.min.js"></script> 
<script type="text/javascript" src="${ctxResource}/js/layer/layer.js"></script>
<script type="text/javascript" src="${ctxResource}/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctxResource}/js/myself.js"></script>
<script type="text/javascript" src="${ctxResource}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
//搜索
$(function(){
	$("#trafficManage_search").click(function(){
		table.fnDraw();
	});

    $("#selectAll").click(function () {
        if(this.checked){
            $("input[name=ids]").prop("checked",true);
        } else{
            $("input[name=ids]").prop("checked",false);
        }
    });

    if(${store.multiple eq 1}) {
        $.post("<%=request.getContextPath()%>/server/store/allStore/0", function (data) {
            for (var n in data) {
                $("#traffic_store").append("<option value = '" + data[n].id + "'>" + data[n].name + "</option>");
            }
        });
    }
});

//table start here
table = $('#trafficManage_table').dataTable({
	   "bProcessing": true,//DataTables载入数据时，是否显示‘进度’提示  
       "bPaginate": true,//是否显示（应用）分页器  
       "bLengthChange": false,
       "bAutoWidth" : true,
       "bScrollCollapse" : true,//是否开启DataTables的高度自适应，当数据条数不够分页数据条数的时候，插件高度是否随数据条数而改变  
       "bDestroy" : true,
       "bInfo" : true,//是否显示页脚信息，DataTables插件左下角显示记录数 
       "bFilter" : false,//是否启动过滤、搜索功能
       "aoColumns" : [
        {"mData" : null, "sDefaultContent" : "", "sClass":"center", "bSortable":false},
        {
           "mData": "", "sDefaultContent": "", "mRender": function (data, type, full) {
               return "<input type='checkbox' name = 'ids' value='" + full.id + "'/>";
            }, "bSortable": false
        },
	  	{"mData" : "", "sDefaultContent" : "", "sClass":"center", "bSortable":false, "mRender":function(data, type, full){
            return "<a style='text-decoration:none' onclick='detail(\"" + full.storeName + "\", \"" + full.trafficType + "\", \"" + full.id + "\")'>详情</a>";
        }},
        {"mData" : "trafficNo", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "orderDate", "sDefaultContent" : "", "bSortable":false, "mRender" : function (data, type, full) {
            return format(data);
        }},
        {"mData" : "trafficType", "sDefaultContent" : "", "bSortable":false, "mRender" : function (data, type, full) {
            return data == 0 ? "退货单" : data == 1 ? "进货单" : "调货单";
        }},
        {"mData" : "outStoreName", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "storeName", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "status", "sDefaultContent" : "", "bSortable":false, "mRender" : function (data, type, full) {
            return data == 0 ? "<span class='c-success'>待确认进货</span>" : data == 1 ? "<span class='c-999'>已完成进货  " + format(full.optTime) + "</span>" : "<span class='c-danger'>已拒绝进货  " + format(full.optTime) + "</span>";
        }},
        {"mData" : "goodsNum", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "totalPrice", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "imprest", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "description", "sDefaultContent" : "", "bSortable":false}
    ],
    "language":{
       "oPaginate": {
           "sFirst": "首页",
           "sPrevious": "上一页",
           "sNext": "下一页",
           "sLast": "末页"
       },
       "sLoadingRecords": "载入中...",
        "sEmptyTable": "表中数据为空",
        "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
        "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
        "sProcessing": "处理中..."
   	},
   	//"deferRender": true, //当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
       "order" : [[1, "desc"]],
       "iDisplayLength" : 20, //每页显示条数
       //"iDisplayStart": 0,
       "bServerSide": true,
       "fnFormatNumber": function(iIn){
       	    return iIn;//格式化数字显示方式
       },
       "sAjaxSource" : "<%=request.getContextPath()%>/server/goodsTrafficManage/list",
       //服务器端，数据回调处理  
       "fnServerData" : function(sSource, aDataSet, fnCallback) {
           $.ajax({
               "dataType" : 'json',
               "type" : "post",
               "url" : sSource,
               "data": {
               	    aDataSet : JSON.stringify(aDataSet)
               },
               "success" : fnCallback
           });  
       },
    "fnServerParams" : function(aoData){  //那个函数是判断字符串中是否含有数字
      	var status = $("#traffic_static").val();
      	var trafficNo = $("#trafficNo").val();
      	var startTime = $("#startTafficDate").val();
      	var endTime = $("#endTafficDate").val();
        var storeId = $("#traffic_store").val();
      	if(!trafficNo){
      	    trafficNo = "";
        }
        if(!storeId){
            storeId = 0;
        }
        aoData.push({"name":"status","value":status});
        aoData.push({"name":"trafficNo","value":trafficNo});
        aoData.push({"name":"startTime","value":startTime});
        aoData.push({"name":"endTime","value":endTime});
        aoData.push({"name":"storeId","value":storeId});
    },
    "fnDrawCallback" : function () {
        $('#redirect').keyup(function(e){
            var redirect = 0;
            if(e.keyCode==13){
                if($(this).val() && $(this).val()>0){
                    redirect = $(this).val()-1;
                }
                table.fnPageChange(redirect);
            }
        });
        //序号
        var api = this.api();
        var startIndex= api.context[0]._iDisplayStart;//获取到本页开始的条数
        api.column(0).nodes().each(function(cell, i) {
            cell.innerHTML = startIndex + i + 1;
        });
    }
});

//操作
function detail(title, type, id) {
    var typeText = "进货单";
    if(type == 0){
        typeText = "退货单";
    }else if(type == 2){
        typeText = "调货单";
    }
    layer.open({
        type: 2,
        title: "<i class=\"Hui-iconfont c-primary mr-5\">&#xe619;</i> " + typeText + "：" + title,
        shadeClose: true,
        shade: false,
        maxmin: true, //开启最大化最小化按钮
        area: ['950px', '350px'],
        content: '<%=request.getContextPath()%>/server/goodsTrafficManage/prepare/'+id
    });
}

//进货
function add(){
    layer.open({
        type: 2,
        title: "<i class=\"Hui-iconfont c-primary mr-5\">&#xe619;</i> 进货门店：${store.name}",
        shadeClose: true,
        shade: false,
        maxmin: true, //开启最大化最小化按钮
        area: ['950px', '350px'],
        content: '<%=request.getContextPath()%>/server/goodsTrafficManage/prepare/'+id
    });
}
</script>
</body>
</html>