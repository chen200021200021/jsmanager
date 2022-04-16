<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header_admin_list.jsp" %>
<body>
<form id="formId1" class="form-horizontal" style="padding:30px 20px 10px 25px;">
	<input type="hidden" name="id" />
	<input type="hidden" name="type" />
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   ><span style="color:#F00">*</span>名称</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="name" >
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label" ><span style="color:#F00">*</span>排序值</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="sort"  placeholder="数字从小到大排序">
    	</div>
  	</div>
  	<div class="form-group">
    	<div class=" col-xs-6 col-sm-6 col-md-6  col-md-offset-3 col-sm-offset-3 col-xs-offset-4">
      		<button type="submit" class="btn btn-success" lay-submit lay-filter="formDemo">保存</button>
    	</div>
  	</div>
</form>

<script type="text/javascript">
$(function(){
	//数据回显
	var id = $(this).getUrlParam("id");
	$.getJSON("getInfo.do?"+ new Date().getTime(), {id:id}, function(data){
		for(k in data){
			if ($("[name='"+k+"']").length){
				$("[name='"+k+"']").attr("val", data[k]);
				$("[name='"+k+"']").val(data[k]);
			}
		}
	});
	//数据提交
    $("#formId1").validate({
		rules:{
			name:{required:true,minlength:1,maxlength:40},
			sort:{required:true,digits:true},
		},
		onkeyup:false,
		focusCleanup:true,
		submitHandler:function(form){
			var params = JSON.parse($(this).form2JsonString("formId1"));
			params["type"] = params["type"]?params["type"]:$(this).getUrlParam("type");
			$.ajax({
                type:"post", 
                dataType:"json", 
                data : params,
                url:"update.do",
                success:function(data){
                	if (data.success) {
                		layer.msg(data.msg, {icon:data.icon,time:1500},function(){
                			var index = parent.layer.getFrameIndex(window.name);
    		                parent.$('#search').click();
    		                parent.layer.close(index);
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
		}
	});

});
</script> 
</body>
</html>