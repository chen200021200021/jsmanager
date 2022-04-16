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
		                         <input name="name"  value="" placeholder="名称(模糊搜索)"  class="form-control " value="">    
		                    </div>
		                    <div class="col-md-2">
		                         <select class="form-control cmm_category" type="class" name="classid" def="-- 所属班级 --"></select>
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
    var _this_page_data_url = "getPageList30.do";
    $.jgrid.defaults.styleUI="Bootstrap";
    var params = JSON.parse($(this).form2JsonString("formId1"));
    $(this).jqGridTable("table_list_1","pager_list_1",{
        url:_this_page_data_url,
        postData : params,
        colNames:["编号","名称","所属班级","授课时间","授课地点"],//"最大审核级别",
        colModel:[
          {name:"id",index:"id"},
          {name:"name",index:"name"},
          {name:"classidNm",index:"classidNm"},
          {name:"time",index:"time"},
          {name:"addr",index:"addr"}
        ]
	}); 

    $("#search").click(function(){
    	var params = JSON.parse($(this).form2JsonString("formId1"));
    	console.log(params);
        jQuery("#table_list_1").jqGrid('setGridParam',{
        url:_this_page_data_url,
        datatype : 'json',
        postData : params,
        page : 1          
      }).trigger('reloadGrid');
    });
    
});


function list(classid,kechengid,title){
   	layer.open({
	    type: 2,
	    title:'【'+title+'】 学生列表',
	    shadeClose: true,
	    shade: 0.6,
	    area: ['100%', '98%'],
	    content: 'listStudent30.jsp?classid='+classid+'&kechengid='+kechengid
	}); 
}
</script>
	
</body>
</html>
