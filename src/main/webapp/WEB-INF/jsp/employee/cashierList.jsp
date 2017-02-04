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

<title>收银员列表</title>
</head>
<body class="pos-r">
<div>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 员工 <span class="c-gray en">&gt;</span> 收银员 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="clearfix">
        <div class="text-r cl pl-20 pt-10 pb-10 box-shadow">
            <span class="l">
                <a href="javascript:void(0);" onclick="add();" class="btn btn-primary radius">新增收银员</a>
                <a href="javascript:void(0);" onclick="roleManager();" class="btn btn-primary radius">员工角色管理</a>
            </span>
            <span class="select-box" style="width: 100px;">
                <select class="select radius" id="cashier_static">
                    <option value = "1">启用</option>
                    <option value = "0">禁用</option>
                </select>
            </span>
            <input type="text" id="cashier_info" placeholder="工号/姓名/电话" style="width:260px" class="input-text radius">
            <button id="cashier_search" class="btn btn-success"><i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <div class="pd-20 clearfix">
            <table class="table table-border table-bordered table-bg table-hover table-striped box-shadow" id="cashier_table">
                <thead>
                    <tr class="text-c">
                        <th width="50">序号</th>
                        <th width="50">操作</th>
                        <th width="100">所属门店</th>
                        <th width="50">编号</th>
                        <th width="50">姓名</th>
                        <th width="50">角色</th>
                        <th width="50">密码</th>
                        <th width="50">电话</th>
                        <th width="50">状态</th>
                    </tr>
                </thead>
                <tbody id="table_tr"></tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript" src="${ctxResource}/js/jquery.min.js"></script> 
<script type="text/javascript" src="${ctxResource}/js/layer/layer.js"></script>
<script type="text/javascript" src="${ctxResource}/js/jquery.dragsort-0.5.2.min.js"></script> 
<script type="text/javascript" src="${ctxResource}/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctxResource}/js/myself.js"></script>
<script type="text/javascript">
//搜索
$(function(){
	$("#cashier_search").click(function(){
		table.fnDraw();
	});
});

//table start here
table = $('#cashier_table').dataTable({
	   "bProcessing": true,//DataTables载入数据时，是否显示‘进度’提示  
       "bPaginate": true,//是否显示（应用）分页器  
       "bLengthChange": false,
       "bAutoWidth" : true,
       "bScrollCollapse" : true,//是否开启DataTables的高度自适应，当数据条数不够分页数据条数的时候，插件高度是否随数据条数而改变  
       "bDestroy" : true,
       "bInfo" : true,//是否显示页脚信息，DataTables插件左下角显示记录数 
       "bFilter" : false,//是否启动过滤、搜索功能
       "aoColumns" : [
        {"mData" : null, "sDefaultContent" : "", "bSortable":false},
	  	{"mData" : "", "sDefaultContent" : "", "sClass":"center", "bSortable":false, "mRender":function(data, type, full){
            return "<a style='text-decoration:none' onclick='edit(full.id)'>编辑</a>";
        }},
        {"mData" : "storeName", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "cashierNo", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "name", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "role", "sDefaultContent" : "", "bSortable":false, "mRender" : function (data, type, full) {
            return data.name ;
        }},
        {"mData" : "password", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "phone", "sDefaultContent" : ""},
        {"mData" : "status", "sDefaultContent" : "", "mRender" : function (data, type, full) {
            return data == 0 ? "停用" : "启用" ;
        }}
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
       "sAjaxSource" : "<%=request.getContextPath()%>/employee/cashierList",
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
      	aoData.push({"name":"bNeedPaging", "value":true});
      	var static = $("#cashier_static").val();
      	var cashierInfo = $("#cashier_info").val();
        var iDisplayStart = $("#news_tableStart").val();
        if(!iDisplayStart){
            iDisplayStart = 0;
        }
        iDisplayStart = Number(iDisplayStart);
        aoData[3].value = iDisplayStart == 0 ? this.fnSettings()._iDisplayStart : iDisplayStart;
        aoData.push({"name":"static","value":static});
        aoData.push({"name":"cashierInfo","value":cashierInfo});
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

/* 时间格式转换*/
function format(time){
	if(time == null || time == "null" || time == undefined){
		return "";
	}
	var date = new Date(time);
	var seperator1 = '-';
    var seperator2 = ':';
	var month = formatDate(date.getMonth() + 1);
	var day = formatDate(date.getDate());
	var hours = formatDate(date.getHours());
	var minutes = formatDate(date.getMinutes()); 
    var seconds = formatDate(date.getSeconds());
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + day
        + ' ' +hours + seperator2 + minutes
        + seperator2 + seconds;
	return currentdate;
}

function formatDate(val){
	if(val >=1 && val <= 9){
		val = '0' + val;
	}
	if(val == 0){
		val = '00';
	}
	return val;
}

//新增
function add() {
    layer_show("新增收银员", "<%=request.getContextPath()%>/employee/cashierAdd", "800", "600");
}

//员工角色管理
function roleManager(){
    var w = 800;
    var	h = ($(window).height() - 50);
    var index = layer.open({
        type : 2,
        title:'员工 > 员工角色',
        content : "<%=request.getContextPath()%>/role/list",
        area : [ w+'px', h+'px' ],
        maxmin : true
    });
    layer.full(index);
}
</script>
</body>
</html>