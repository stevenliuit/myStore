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
    <div class="form form-horizontal" id="form-goods-add">
        <div class="row cl mb-30">
            <div class="col-8">
            	<div class="row cl">
		            <label class="form-label col-3">是否启用：</label>
		            <div class="formControls col-6">
		            	<div class="radio-box">
				          	<input type="radio" id="supplier_using-1" name="supplier_using" value = "1" checked>
				          	<label for="supplier_using-1">是</label>
				        </div>
				        <div class="radio-box">
				          	<input type="radio" id="supplier_using-2" name="supplier_using" value = "2">
				          	<label for="supplier_using-2">否</label>
				        </div>
		            </div>
		            <div class="col-3"></div>
		        </div>
                <div class="row cl">
                    <label class="form-label col-3"><span class="c-red">* </span>供货商编号：</label>
                    <div class="formControls col-6">
                        <input type="text" class="input-text radius" value="" id="supplier_No" placeholder="请输入供货商编号" >
                    </div>
                    <div class="col-3"> </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-3"><span class="c-red">* </span>供货商名称：</label>
                    <div class="formControls col-6">
                        <input type="text" class="input-text radius" value=""  id="supplier_name" placeholder="请输入供货商名称" >
                    </div>
                    <div class="col-3"> </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-3">搜索拼音码：</label>
                    <div class="formControls col-6">
                        <input type="text" class="input-text radius" value=""  id="supplier_pinyin" placeholder="请输入搜索拼音码" >
                    </div>
                    <div class="col-3"> </div>
                </div>
                <div class="row cl">
                	<label class="form-label col-3">联系人：</label>
                	<div class="formControls col-6"><input type = "text" class="input-text radius" id="supplier_contacts" placeholder="请输入联系人"/></div>
                	<div class="col-3"> </div>
                </div>
                <div class="row cl">
                	<label class="form-label col-3">联系电话：</label>
                	<div class="formControls col-6"><input type = "text" class="input-text radius" id="supplier_phone" placeholder="请输入联系电话"/></div>
                	<div class="col-3"> </div>
                </div>
                <div class="row cl">
                	<label class="form-label col-3">联系邮箱：</label>
                	<div class="formControls col-6"><input type = "text" class="input-text radius" id="supplier_email" placeholder="请输入联系邮箱"/></div>
                	<div class="col-3"> </div>
                </div>
            </div>
        </div>
        <div class="row cl">
            <div class="col-6 cl">
                <label class="form-label col-3">配送费返点：</label>
                <div class="formControls col-6">
                    <input type = "text"  class="input-text radius mr-5" id="supplier_packingFeePoint"  style="width: 90%;"/><label>&nbsp;%</label>
                </div>
            </div>
            <div class="col-6 cl">
                <label class="form-label col-3">固定返利点：</label>
                <div class="formControls col-6">
                    <input type = "text"  class="input-text radius mr-5"  id="supplier_rebatePoint"  style="width: 90%;"/><label>&nbsp;%</label>
                </div>
            </div>
        </div>
        <div class="row cl">
        	<div class="col-8">
	            <label class="form-label col-3">地址：</label>
	            <div class="formControls col-9">
	                <textarea rows="2" maxlength="200" class="edit_txt textarea radius" id="supplier_addr"></textarea>
	            </div>
	        </div>
        </div>
        <div class="row cl">
            <div class="col-8">
                <label class="form-label col-3">备注：</label>
                <div class="formControls col-9">
                    <textarea rows="2" maxlength="200" class="edit_txt textarea radius" id="supplier_desc"></textarea>
                </div>
            </div>
        </div>
        <div class="row cl" style="display: none;">
            <div class="row cl">
                <label class="form-label col-3">是否授权供货商：</label>
                <div class="formControls col-6">
                    <div class="radio-box">
                        <input type="radio" id="supplier_isAuthorize-1" name="supplier_isAuthorize" value = "1" checked>
                        <label for="supplier_isAuthorize-1">是</label>
                    </div>
                    <div class="radio-box">
                        <input type="radio" id="supplier_isAuthorize-2" name="supplier_isAuthorize" value = "2">
                        <label for="supplier_isAuthorize-2">否</label>
                    </div>
                </div>
                <div class="col-3"></div>
            </div>
        </div>
        <div class="row cl">
            <div class="col-10 col-offset-5 mt-20">
                <input class="btn btn-primary radius" type="button" id="userAddBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;确认&nbsp;&nbsp;&nbsp;&nbsp;">
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctxResource}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxResource}/js/layer/layer.js"></script>
<script type="text/javascript" src="${ctxResource}/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.js"></script>
<script type="text/javascript" src="${ctxResource}/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctxResource}/js/myself.js"></script>
<script>
</script>
</body>
</html>