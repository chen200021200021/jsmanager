<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header_admin_list.jsp" %>
<body>
<form id="formId1" class="form-horizontal" style="padding:30px 20px 10px 25px;">
	<div class="form-group">
    	<label for="fTable" class="col-xs-3 col-sm-3 col-md-3 control-label"><span style="color:#F00">*</span>学院</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
       		<select class="form-control cmm_category" type="xueyuan" name="xueyuanid">
			</select>
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   ><span style="color:#F00">*</span>姓名</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="name" >
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="fTable" class="col-xs-3 col-sm-3 col-md-3 control-label"><span style="color:#F00">*</span>照片</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
    		<input type="hidden" name="icon" /> 
    		<img  src=""  id="iconImg" style="width:200px; float:left;"/>
    		<div class="layui-btn" id="uploadfile1" style="float:left; "></div>
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   ><span style="color:#F00">*</span>性别</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="sex" >
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   ><span style="color:#F00">*</span>年龄</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="age" >
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   ><span style="color:#F00">*</span>联系电话</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="tel" >
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   ><span style="color:#F00">*</span>学历</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="xueli" >
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   ><span style="color:#F00">*</span>毕业院校</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="school" >
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   >备注</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="descr" >
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   >奖惩信息</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="huojiang" >
    	</div>
  	</div>
  	<div class="form-group  mt-10">
    	<label class="col-xs-3 col-sm-3 col-md-3 control-label"   >工作经历</label>
    	<div class="col-xs-6 col-sm-6 col-md-6">
        	<input type="text" class="form-control" name="gzjl" >
    	</div>
  	</div>
  	<div class="form-group">
    	<div class=" col-xs-6 col-sm-6 col-md-6  col-md-offset-3 col-sm-offset-3 col-xs-offset-4">
      		<button type="submit" class="btn btn-success" lay-submit lay-filter="formDemo">保存</button>
    	</div>
  	</div>
</form>
<script type="text/javascript" charset="utf-8" src="../../resource/lib/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../../resource/lib/ueditor/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="../../resource/lib/ueditor/lang/zh-cn/zh-cn.js"></script> 
<script type="text/javascript">
$(function(){
	//文件上传
	layui.use('upload', function(){
	  var upload = layui.upload;
	  var uploadInst = upload.render({
	    elem: '#uploadfile1'
	    ,url: '../../common/cmm/uploadFile.do'
	    ,accept: 'jpg,png,gif' //允许上传的文件类型
	    ,size: 102400
	    ,done: function(res){
	    	$("#iconImg").attr("src", res.url);
	    	$("[name='icon']").val(res.url);
	    }
	  });
	});
	
	//数据回显
	var id = $(this).getUrlParam("id");
	$.getJSON("getInfo.do?"+ new Date().getTime(), {id:id}, function(data){
		for(k in data){
			if ($("[name='"+k+"']").length){
				$("[name='"+k+"']").attr("val", data[k]);
				$("[name='"+k+"']").val(data[k]);
			}
		}
		$("#iconImg").attr("src", data.icon);
	});
	
	//表单提交
    $("#formId1").validate({
		rules:{
			classid:{required:true},
			name:{required:true,minlength:1,maxlength:100},
			icon:{required:true},
			sex:{required:true,minlength:1},
			age:{required:true,minlength:1},
			tel:{required:true,minlength:1,isMobile : true },
			xueli:{required:true},
			school:{required:true},
		},
		onkeyup:false,
		focusCleanup:true,
		submitHandler:function(form){
			var params = {};
			var t = $('#formId1').serializeArray();
			$.each(t, function() {
				params[this.name] = this.value;
			});
			if (!params['icon']) {
				alert("请选择图片");
				return false;
			}
			params['id'] = $(this).getUrlParam("id");
			$.ajax({
                type:"post",  //提交方式  
                dataType:"json", //数据类型  
                data : params,
                url:"update.do", //请求url  
                success:function(data){ //提交成功的回调函数 
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