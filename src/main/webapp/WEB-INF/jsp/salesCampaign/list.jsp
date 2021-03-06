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

<title>促销活动</title>
</head>
<body class="pos-r">
<div>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 营销 <span class="c-gray en">&gt;</span> 促销活动 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="clearfix">
        <div class="text-r cl pl-20 pt-10 pb-10 box-shadow">
            <span class="l">
                <a href="javascript:void(0);" onclick="add();" class="btn btn-primary radius">新增促销</a>
            </span>
            <span class="select-box radius" style="width: 100px;">
                <select class="select" id="salesCam_type">
                    <option value="-1">全部类型</option>
                    <option value="0">打折促销</option>
                    <option value="1">套餐促销</option>
                    <option value="2">满额返现</option>
                    <option value="3">换购促销</option>
                    <option value="4">第二件打折</option>
                </select>
            </span>
            <span class="select-box radius" style="width: 100px;">
                <select class="select" id="salesCam_status">
                    <option value="-1">全部状态</option>
                    <option value="0">未过期</option>
                    <option value="1">已结束</option>
                </select>
            </span>
            <input type="text" id="sales_name" style="width:260px" class="input-text radius">
            <button id="sales_search" class="btn btn-success"><i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <div class="pd-20 clearfix">
            <table class="table table-border table-bordered table-bg table-hover table-striped box-shadow" id="salesCam_table">
                <thead>
                    <tr class="text-c">
                        <th width="50">序号</th>
                        <th width="50">操作</th>
                        <th width="100">促销名称</th>
                        <th width="50">创建门店</th>
                        <th width="50">促销类型</th>
                        <th width="50">适用范围</th>
                        <th width="50">开始日期</th>
                        <th width="50">结束日期</th>
                        <th width="50">状态</th>
                        <%--<th width="50">优惠券</th>--%>
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
<script type="text/javascript">
$(function(){
    $("#sales_search").on("click", function () {
        table.fnDraw();
    })
})
//table start here
table = $('#salesCam_table').dataTable({
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
	  	{"mData" : "", "sDefaultContent" : "", "sClass":"center", "bSortable":false, "mRender":function(data, type, full){
	       return "<a style='text-decoration:none' onclick='edit(\""+full.id+"\")'>编辑</a>";
        }},
        {"mData" : "name", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "storeName", "sDefaultContent" : "", "bSortable":false},
        {"mData" : "type", "sDefaultContent" : "", "bSortable":false, "mRender":function (data, type, full) {
            switch (data){
                case 0 : return "打折促销";
                case 1 : return "套餐促销";
                case 2 : return "满额返现";
                case 3 : return "换购促销";
                case 4 : return "第二件打折";
                default : return "-";
            }
        }},
        {"mData" : "appScope", "sDefaultContent" : "", "bSortable":false, "mRender":function (data, type, full) {
	       if(!data){
	           return "-";
           }else{
               if(data.indexOf("0") != -1 && data.indexOf("1") == -1){
                    return "实体店";
               }else if(data.indexOf("1") != -1 && data.indexOf("1") == -1){
                   return "网店";
               }else{
                   return "实体店，网店";
               }
           }
        }},
        {"mData" : "startDate", "sDefaultContent" : "", "mRender":function(data, type, full){
               return format(data).substring(0, 10);
           },"bSortable":false,"sClass":"center"
        },
        {"mData" : "endDate", "sDefaultContent" : "", "mRender":function(data, type, full){
               return format(data).substring(0, 10);
           },"bSortable":false,"sClass":"center"
        },
        {"mData" : "overdue", "sDefaultContent" : "", "mRender":function(data, type, full){
               return data == 0 ? "<span class='c-danger'>已结束</span>" : "有效";
           },"bSortable":false,"sClass":"center"
        }/*,
        {"mData" : "auto", "sDefaultContent" : "", "mRender":function(data, type, full){
        	return data == 1?"是":"否";
        	},"bSortable":false,"sClass":"center"
        }*/
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
       "sAjaxSource" : "<%=request.getContextPath()%>/server/salesCampaign/list",
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
        var status = $("#salesCam_status").val();
        var type = $("#salesCam_type").val();
        var info = $("#sales_name").val();
        aoData.push({"name":"overdue","value":status});
        aoData.push({"name":"type","value":type});
        aoData.push({"name":"name","value":info});
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


//新增
function add() {
    layer_show("新增", "<%=request.getContextPath()%>/server/salesCampaign/add", "700", "450");
}

//会员编辑
function edit(id){
    layer_show("编辑", "<%=request.getContextPath()%>/server/salesCampaign/edit/"+id, "700", "450");
}
</script>
</body>
</html>