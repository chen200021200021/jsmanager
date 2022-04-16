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
		                         <input name="name"  value="" placeholder="昵称(模糊搜索)"  class="form-control " value="">    
		                    </div>
		                     <div class="col-md-2">
		                         <input name="login"  value="" placeholder="登录账户"  class="form-control " value="">    
		                    </div>     
		                    <div class="col-xs-6 col-sm-6 col-md-2">
			                 	<select name="utype" class="cmm_code form-control" def="-- 类型 --"  code="USER_TYPE" val=""></select>
			              	</div> 
			              	<div class="col-xs-6 col-sm-6 col-md-2">
			                 	<select name="status" class="cmm_code form-control" def="-- 状态 --"  code="USER_STATUS" val=""></select>
			              	</div>       
		                </div>
	               </div>
	               <div class="col-md-2">
	                    <div class="col-md-4">
	                        <button class="btn btn-primary input-sm col-sm-12 col-md-12 pull-left" id="search" type="button">&nbsp;搜&nbsp;&nbsp;&nbsp;索</button>
	                    </div>
	                    <div class="col-md-4">
	                        <button class="btn btn-success input-sm col-sm-12 col-md-12 pull-left mr-5" id="add" type="button">&nbsp;添加</button>
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
    var _this_page_data_url = "getPageList.do";
    $.jgrid.defaults.styleUI="Bootstrap";
    $(this).jqGridTable("table_list_1","pager_list_1",{
        url:_this_page_data_url,
        postData : JSON.parse($(this).form2JsonString("formId1")),
        colNames:["编号","用户昵称","登录账号","用户类型","状态","添加时间","操作"],//"最大审核级别",
        colModel:[
          {name:"id",index:"id"},
          {name:"name",index:"name"},
          {name:"login",index:"login"},
          {name:"usertypeNm",index:"usertypeNm"},
          {name:"statusNm",index:"statusNm"},
          {name:"itime",index:"itime"},
          {name:"url",index:"url",formatter:function(cellvalue, options, rowObject){
        	 	var optstr = "";
        	  	if (rowObject.id!=1) {
        			optstr += '<button type="button" class="btn btn-primary btn-xs"  onclick="update('+rowObject.id+')">修改</button> ';
        			optstr += '<button type="button" class="btn btn-warning btn-xs"  onclick="resetPwd('+rowObject.id+')">重置密码</button> ';
        			optstr += '<button type="button" class="btn btn-danger btn-xs"  onclick="del('+rowObject.id+')">删除</button>';
        	  	}
         		return optstr;
          } }    
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
     
    $("#add").click(function(){
        layer.open({
            type: 2,
            title: '添加',
            shadeClose: true,
            shade: 0.6,
            maxmin: true, //开启最大化最小化按钮
            area: ['500px', '450px'],
            content: "add.jsp"
       });   
    }); 
});

function update(id){
   	layer.open({
	    type: 2,
	    title:'修改',
	    shadeClose: true,
	    shade: 0.6,
	    area: ['500px', '450px'],
	    content: 'update.jsp?id='+id
	}); 
}

function resetPwd(id){
   	layer.open({
	    type: 2,
	    title:'重置密码',
	    shadeClose: true,
	    shade: 0.6,
	    area: ['500px', '450px'],
	    content: 'resetPwd.jsp?id='+id
	}); 
}

function del(id){
	layer.confirm('确定要删除吗?', {
			title: false,
			btn: ['确定','取消'] //按钮
		}, function(ind){
			layer.close(ind);
			var params = {
					id:id,
			};
			$.ajax({
		        type:"post",  //提交方式  
		        dataType:"json", //数据类型  
		        data : params,
		        url:"del.do", //请求url  
		        success:function(data){ //提交成功的回调函数 
		        	if (data.success) {
		        		layer.msg(data.msg, {icon:data.icon,time:1500},function(){
			               $('#search').click();
			            });
		        	} else {
		        		layer.alert(data.msg,{icon : data.icon});
		        	}
		        },
		        error:function(XMLHttpRequest, textStatus, errorThrown) {
		        	alert(XMLHttpRequest.status + "\r\n"+ errorThrown);
		        	console.log(XMLHttpRequest, XMLHttpRequest.status,textStatus, errorThrown);
		        }  
		    });
		}, function(inds){
			layer.close(inds);
		}
	);
}

</script>
	
</body>
</html>
