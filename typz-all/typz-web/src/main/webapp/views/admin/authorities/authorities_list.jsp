<%@ page language="java" contentType="text/html; charset=UTF-8"
	session="false" pageEncoding="UTF-8"%>
<%@include file="/taglibs.jsp"%>
<!doctype html>
<html>

  <head>
<%@include file="/common/meta.jsp"%>
<%@include file="/common/snew.jsp"%>
</head>

<body class="page-header-fixed"> 
<jsp:include page="/common/header.jsp"></jsp:include> 
	<div class="clearfix"></div>
	<div class="page-container">
		<jsp:include page="/common/left.jsp"></jsp:include>
		<div class="page-header" style="margin-top: 0px;margin-bottom: 0px;padding-bottom: 0px; "> 
			<jsp:include page="/common/pageheader.jsp"></jsp:include>
		</div>
		<div class="page-content">

		<div class="content content-inner">
			<div id="div_Mask11" class="div_Mask" style="display: none;"></div>
			<!-- 操作按钮如下 -->
			<div class="content content-inner">
			<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">
				<h3 class="panel-title">权限列表</h3>
			</div>
			<div class="panel-body">
				<a href="javascript:;" onclick="javascript:window.location.reload();" class="btn btn-sm default" ><i class="fa fa-rotate-right"></i>刷新</a>
				<a href="${ctx }/authorities/authorities_edit.izhbg" id="addDialog" class="btn btn-sm default"  ><i class="fa fa-plus-square"></i>新增</a>
				<a href="javascript:authority_del()" class="btn btn-sm red" ><span class="glyphicon glyphicon-calendar"></span>删除</a>
				<a class="btn btn-sm default"  type="button" onclick="role_updflag();"><i class="fa fa-ban"></i>更改状态</a>
				<form action="${ctx}/authorities/authorities_list.izhbg" id="form1"></form>
				<div class="pull-right">
					每页显示
					<select class="m-wrap xsmall"> 
					    <option value="10">10</option> 
					    <option value="20">20</option>
					    <option value="50">50</option>
					 </select>
					条
				</div>
		
			</div>
			<!-- Table -->
			 <table id="userGrid" class="table table-striped table-bordered table-hover dataTable" >
				<thead >
					<tr >
						<th width="50" style="text-align: center;" class="id">
							<input type="checkbox" name="checkAll" id="checkAll" onchange="toggleSelectedItems(this.checked)" />
						</th>
						<th width="140">操作</th>
						<th width="140">权限名称</th>
						<th width="140">有效标记</th>
						<th>备注</th>
					</tr>
				</thead>
				
				<tbody >
					<c:forEach items="${page.result}" var="item">
						<tr id="${item.authorityId}">
							<td style="text-align: center;" class="id">
								<input type="checkbox" name="checkdel" class="selectedItem a-check"  value="${item.authorityId}"/></td>
							<td nowrap>
									<a href="${ctx }/authorities/authorities_edit.izhbg?authorityId=${item.authorityId }">编辑</a>
									&nbsp; 
									<a href="${ctx }/authorities_resources/authorities_resources_list.izhbg?authorityId=${item.authorityId }">授权资源</a>
							</td>
							<td>${item.authorityName}
							</td>
							<td>${item.enabled==1?'有效':'无效' }
							</td>
							<td>${item.authorityDesc }
							</td>  
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
			<div class="form-actions fluid" style="margin-top: 0px;">
			<div class="col-md-5">  
				<div class="dataTables_info" id="sample_3_info">共${page.totalCount}条记录 显示${page.start+1}到${page.start+page.pageSize}条记录</div>
			</div>
			<div class="col-md-7">
				<div class="dataTables_paginate paging_bootstrap  pull-right">    
				  <button class="btn btn-sm default">&lt;</button>
				  <button class="btn btn-sm default">1</button>
				  <button class="btn btn-sm default">&gt;</button>
				</div>
						
			</div>
			</div>
			</div>
			<!-- 搜索条件结束 -->
		
			
		</div>
		<div class="clearfix"></div>
	</div>
	</div>
	</div>
<jsp:include page="/common/footer.jsp"></jsp:include>
</body>
<script type="text/javascript" src="${ctx}/s/assets/plugins/guser/js/common.js"></script>  
<script type="text/javascript" src="${ctx}/s/assets/plugins/guser/js/ucenter.js"></script>  
<script type="text/javascript">
var config = {
		id: 'userGrid',
	    pageNo: ${page.pageNo},
	    pageSize: ${page.pageSize},
	    totalCount: ${page.totalCount},
	    resultSize: ${page.resultSize},
	    pageCount: ${page.pageCount},
	    orderBy: '${page.orderBy == null ? "" : page.orderBy}',
	    order: '${page.order=="ASC"?"DESC":"ASC"}',
	    params: {
	        'appId':'${parameterMap.appId }'
	    },
		selectedItemClass: 'selectedItem',
		gridFormId: 'form1' 
		};

var table;

$(function() {
	table = new Table(config);
    table.configPagination('.dataTables_paginate');
    table.configPageInfo('.dataTables_info'); 
    table.configPageSize('.m-wrap'); 
});

function deleteInfo(){
	$.ajax({
		type: "POST",
	    url: "${ctx }/authorities/authorities_dell.izhbg",
	    data: $("#form1").serialize()+"&"+$("input:checkbox[name=checkdel]:checked").serialize(),
	    dataType:"html",
		cache: false,
		success: function(data){
	    	$("#form1").submit();
		}
		});
}
function changeUserState(){
	$.ajax({
			type: "POST",
		    url: "${ctx }/authorities/authorities_updStatus.izhbg",
		    data: $("#form1").serialize()+"&"+$("input:checkbox[name=checkdel]:checked").serialize(),
		    dataType:"html",
			cache: false,
			success: function(data){
		    	$("#form1").submit();
			}
		});
}
function clearForm(){
	$(':input','#form1')  
	 .not(':button, :submit, :reset, :hidden')
	 .val('')  
	 .removeAttr('checked')  
	 .removeAttr('selected'); 
}

</script>
</html>