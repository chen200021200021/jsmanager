<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header_admin_list.jsp" %>
<body class="gray-bg">
<div class="row wrapper white-bg">
	<div class="col-sm-12">
	    <div class="ibox float-e-margins" style="padding-bottom:0px;margin-bottom:0px;"  >
	        <div class="ibox-title">
	            <h5 id="menuTreeJs" style="color:#999;font-weight:normal;"></h5>
	        </div>
	        <form id="formId1" class="form-horizontal">
	        	<div id="show" class="ibox-content" style="padding-left:16px;">
	            	<div class="col-xs-10 col-sm-8 col-md-10 b-r">
		                <div class="form-group">
		                     <div class="col-md-2">
		                         <input name="id"  value="" placeholder="编号"  class="form-control " value="">    
		                    </div>     
		                    <div class="col-md-2">
		                         <input name="name"  value="" placeholder="姓名"  class="form-control " value="">    
		                    </div> 
		                </div>
	               </div>
	               <div class="col-md-2">
	                    <div class="col-md-4">
	                        <button class="btn btn-primary input-sm col-sm-12 col-md-12 pull-left" id="search" type="button">&nbsp;搜&nbsp;&nbsp;&nbsp;索</button>
	                    </div>
	               </div>
	           </div>
	    	</form>
	 	</div>
	</div>
	
    <div class="mt-5 wrapper  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-content">
                        <div class="jqGrid_wrapper">
                            <table id="table_list_1"></table>
                            <div id="pager_list_1"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>    

<script>
$(document).ready(function(){
    //表格
    var _this_page_data_url = "getPageListStudent.do";
    var params = JSON.parse($(this).form2JsonString("formId1"));
    params["classid"] = $(this).getUrlParam("classid");
    params["kechengid"] = $(this).getUrlParam("kechengid");
    $.jgrid.defaults.styleUI="Bootstrap";
    $(this).jqGridTable("table_list_1","pager_list_1",{
        url:_this_page_data_url,
        postData : params,
        colNames:["学生编号","学生姓名","成绩","操作"],//"最大审核级别",
        colModel:[
          {name:"id",index:"id"},
          {name:"name",index:"name"},
          {name:"score",index:"score"},
          {name:"url",index:"url",formatter:function(cellvalue, options, rowObject){
        	 	var optstr = "";
        	 	optstr += '<button type="button" class="btn btn-primary btn-xs"  onclick="updateScore('+rowObject.id+','+$(this).getUrlParam("kechengid")+')">修改分数</button> ';
    	  		optstr += '<button type="button" class="btn btn-primary btn-xs"  onclick="userinfo20('+rowObject.id+')">学生信息</button> ';
         		return optstr;
          } }    
        ],
        rowList : [ 5, 10, 30 ],
        rowNum : 5
	}); 

    $("#search").click(function(){
    	var params = JSON.parse($(this).form2JsonString("formId1"));
    	params["classid"] = $(this).getUrlParam("classid");
    	params["kechengid"] = $(this).getUrlParam("kechengid");
        jQuery("#table_list_1").jqGrid('setGridParam',{
        url:_this_page_data_url,
        datatype : 'json',
        postData : params,
        page : 1          
      }).trigger('reloadGrid');
    });
     
});

function updateScore(uid,kechengid){
   	layer.open({
	    type: 2,
	    title:'修改分数',
	    shadeClose: true,
	    shade: 0.6,
	    area: ['100%', '95%'],
	    content: 'updateScore30.jsp?uid='+uid+'&kechengid='+kechengid
	}); 
}

function userinfo20(id){
   	layer.open({
	    type: 2,
	    title:'学生信息',
	    shadeClose: true,
	    shade: 0.6,
	    area: ['100%', '95%'],
	    content: '../userinfo20/info.html?id='+id
	}); 
}
</script>
	
</body>
</html>
