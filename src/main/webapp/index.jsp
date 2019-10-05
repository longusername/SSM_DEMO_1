<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.4.1.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>员工信息</title>
</head>
<body>
	<!-- 模态框 -->
	<!-- Modal 员工修改模态框 -->
		<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" >员工修改</h4>
		      </div>
		      <div class="modal-body">
			        <form class="form-horizontal">
			        
					  <div class="form-group">
					    <label  class="col-sm-2 control-label">empName</label>
					    <div class="col-sm-10">
						  <p class="form-control-static" id="empName_update_static"></p>					      
					      <span class="help-block"></span>
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label  class="col-sm-2 control-label">email</label>
					    <div class="col-sm-10">
					      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
					      <span class="help-block"></span>
					    </div>
					  </div>
					  
					   <div class="form-group">
					    <label  class="col-sm-2 control-label">gender</label>
					    <div class="col-sm-10">
					      	<label class="radio-inline">
								<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
							</label>
							<label class="radio-inline">
								<input type="radio" name="gender" id="gender2_update_input" value="F"> 女
							</label>
					    </div>
					  </div>
					  
					   <div class="form-group">
					    <label  class="col-sm-2 control-label">deptName</label>
					    <div class="col-sm-4">
					    	<!-- 部门提交部门id即可 -->
					      	<select class="form-control" name="dId" id="dept_update_select">
					      	</select>
					    </div>
					  </div>
					  
					</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
		      </div>
		    </div>
		  </div>
		</div>
	
	
	<!-- Modal 员工新增模态框 -->
		<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
		      </div>
		      <div class="modal-body">
			        <form class="form-horizontal">
			        
					  <div class="form-group">
					    <label  class="col-sm-2 control-label">empName</label>
					    <div class="col-sm-10">
					      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
					      <span class="help-block"></span>
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label  class="col-sm-2 control-label">email</label>
					    <div class="col-sm-10">
					      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
					      <span class="help-block"></span>
					    </div>
					  </div>
					  
					   <div class="form-group">
					    <label  class="col-sm-2 control-label">gender</label>
					    <div class="col-sm-10">
					      	<label class="radio-inline">
								<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
							</label>
							<label class="radio-inline">
								<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
							</label>
					    </div>
					  </div>
					  
					   <div class="form-group">
					    <label  class="col-sm-2 control-label">deptName</label>
					    <div class="col-sm-4">
					    	<!-- 部门提交部门id即可 -->
					      	<select class="form-control" name="dId" id="dept_add_select">
					      	</select>
					    </div>
					  </div>
					  
					</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
		      </div>
		    </div>
		  </div>
		</div>
	
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>ssm增删改查</h1>
				<%-- <h1>路径：${APP_PATH }</h1> --%>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary btn-lg" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger btn-lg" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>	
							<th>
								<input type="checkbox" id="check_all" />
							</th>
							<th>#</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!--分页文字信息  -->
			<div class="col-md-6" id="page_info_area">
			
			</div>
			<!--分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>	
		</div>
	</div>
	<script type="text/javascript">
		//定义一个全局变量，保存分页信息
		var totalRecord;
		//定义一个当前页的变量
		var currentPage;
		
		//1.页面加载完成后，直接去发送ajax请求，要到分页数据
		$(function(){
			//去首页
			to_page(1);
		});
		
		/* $(function(){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn=1",
				type:"GET",
				success:function(result){
					//console.log(result);打印在控制台
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析显示分页条数据
					build_page_nav(result);
				}
			});
		}); */
		
		//跳转页面
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);打印在控制台
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析显示分页条数据
					build_page_nav(result);
				}
			});
		}
		
		//显示表格数据
		function build_emps_table(result){
			//先清空table表格的数据
			$("#emps_table tbody").empty();
			
			//员工数据
			var emps=result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				//alert(item.empName);
				//内容  封装好每一行
				var checkBoxTd =$("<td><input type='checkbox' class='check_item'></td>");
				var empIdTd=$("<td></td>").append(item.empId);
				var empNameTd=$("<td></td>").append(item.empName);
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.departement.deptName);
				var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
				
				//按钮
				var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个自定义的属性，来表示当前员工id
				editBtn.attr("edit-id",item.empId);
				
				var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加一个自定义的属性，来表示当前员工id
				delBtn.attr("del-id",item.empId);
				
				var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
				
				$("<tr></tr>").append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(btnTd)
				.appendTo("#emps_table tbody");
			});
		}
		
		//解析显示分页信息
		function build_page_info(result){
			//先清空
			$("#page_info_area").empty();
			
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,总"+result.extend.pageInfo.pages
					+"页，总"+result.extend.pageInfo.total+"条记录");
			
			//获取总记录数
			totalRecord=result.extend.pageInfo.total;
			
			//获取当前页
			currentPage=result.extend.pageInfo.pageNum;
		}
		
		//解析显示分页条
		function build_page_nav(result){
			//page_nav_area
			$("#page_nav_area").empty();
			
			var ul=$("<ul></ul>").addClass("pagination");
			
			//构建导航条
			var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
			//判断是否有上一页
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			
			//为元素添加点击翻页的事件
			//首页
			firstPageLi.click(function(){
				to_page(1);
			});
			
			//上一页
			prePageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum-1);
			});
			
			
			var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			
			//判断是否有下一页
			if(result.extend.pageInfo.hasNextPage==false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			
			//为下一页和末页添加事件
			//下一页
			nextPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum+1);
			});
			
			//末页
			lastPageLi.click(function(){
				to_page(result.extend.pageInfo.pages);
			});
				
			//添加首页和前一页
			ul.append(firstPageLi).append(prePageLi);
			
			//遍历后添加到ul中
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi=$("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum ==item){
					numLi.addClass("active");
				}
				//绑定点击事件
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			
			ul.append(nextPageLi).append(lastPageLi);
			
			//把ul加入到nav中
			var navEle=$("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		//表单重置功能
		function reset_form(ele){
			//清空表单数据
			$(ele)[0].reset();
			
			//清空表单样式
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮，弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//完整的重置，重置表单的数据，表单的样式
			reset_form("#empAddModal form");
			
			//弹出模态框之前先重置表单的数据
			//$("#empAddModal form")[0].reset();
			
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
			
		});
		
		//查出所有部门信息并显示在下拉列表中
		function getDepts(ele){
			//先清空
			$(ele).empty();
			
			//再查询
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result)
					//显示部门信息在下拉列表中
					//$("#dept_add_select")
					$("#empAddModal select").append("")
					
					//遍历部门信息
					$.each(result.extend.depts,function(){
						var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		//校验表单数据
		function validate_add_form(){
			//1.n拿到要校验的数据，使用正则表达式
			//校验用户名
			var empName=$("#empName_add_input").val();
			var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//校验失败
				show_validate_msg("#empName_add_input","error","用户名需要是2-5位的中文或6-16位的英文和数字的组合!");
				
				
				//alert("用户名需要是2-5位的中文或6-16位的英文和数字的组合!");
				/* $("#empName_add_input").parent().addClass("has-error");
				$("#empName_add_input").next("span").text("用户名需要是2-5位的中文或6-16位的英文和数字的组合!"); */
				return false;
			}else{
				//校验成功
				show_validate_msg("#empName_add_input","success","");

				/* $("#empName_add_input").parent().addClass("has-success");
				$("#empName_add_input").next("span").text(""); */
			};
			
			//校验邮箱
			var email=$("#email_add_input").val();
			var regEmail=/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input","error","邮箱格式不正确!");
				//alert("邮箱格式不正确");
				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确"); */
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
				/* $("#email_add_input").parent().addClass("has-success");
				$("#email_add_input").next("span").text(""); */
			}
			return true;
		}
		
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//在校验前清除校验状态
			$(ele).parent().removeClass("has-success has-error");
			//清除span中的文本内容
			$(ele).next("span").text("");
			
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		$("#empName_add_input").change(function(){
			//发送ajax请求校验用户名
			var empName=this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				type:"POST",
				data:"empName="+empName,
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用!");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error")
					}
				}	
			});
		});
		
		//员工保存
		$("#emp_save_btn").click(function(){
			//模态框中填写的表单数据提交给服务器进行保存
			
			//1.先对要提交给服务器端数据进行校验
		 	 if(!validate_add_form()){
				return false;
			}
			
			//判断之前的ajax用户名校验是否成功，如果成功
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			
			//2.发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//员工保存成功
					if(result.code == 100){
						//1.关闭模态框
						$("#empAddModal").modal('hide');
						
						//2.来到最后一页，显示刚才保存的数据
						//发送ajax请求，显示最后一页数据即可
						to_page(totalRecord);
					}else{
						//显示失败信息
						console.log(result);
						//alert(result.extend.errorFileds.email);
						//alert(result.extend.errorFileds.empName);
						
						if(undefined !=result.extend.errorFields.email){
							//显示邮箱错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined !=result.extend.errorFields.empName){
							//显示员工姓名的错误信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
						
					}
					
				}
			});
		});
		
		
		
		//我们在按钮创建之前就绑定了click，所以绑定不上。
		//解决办法：1.在创建按钮时绑定  2.绑定.live  （新版jquery使用on替代）
		$(document).on("click",".edit_btn",function(){
		
			//1.查出部门信息,并显示部门列表
			getDepts("#empUpdateModal select");
			
			//2.查出员工信息，显示员工信息	
			getEmp($(this).attr("edit-id"));
			
			//3.把员工的id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));	
			
			//弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		//查询单个员工信息
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log();
					var empData=result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
					
				}
			});
		}
		
		
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			
			
			//1.校验邮箱是否合法
			var email=$("#email_update_input").val();
			var regEmail=/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","邮箱格式不正确!");
				return false;
			}else{
				show_validate_msg("#email_update_input","success","");
			}
			
			
			//2.发送ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				/*方法一，继续发送post请求 
				type:"POST",
				data:$("#empUpdateModal form").serialize()+"&_method=PUT", */
			    type:"PUT",
				data:$("#empUpdateModal form").serialize(), 
				success:function(result){
					//alert(result.msg);
					//1.关闭对话框
					$("#empUpdateModal").modal("hide")
					//2.回到本页面
					to_page(currentPage);
				}
			});
		});
			
		
		//给修改按钮绑定事件
		//单个删除
		$(document).on("click",".delete_btn",function(){
			//1.弹出是否确认删除对话框
			var empName=$(this).parents("tr").find("td:eq(2)").text();
			var empId=$(this).attr("del-id");
			if(confirm("确认删除【"+empName+"】吗？")){
				//确认，发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						console.log(result);
						
						//回到当前页
						to_page(currentPage);
					}
				});
				
			}
		});
		
		//完成全选和全不选功能
		$("#check_all").click(function(){
			//attr获取checked的值是undefined
			//原生的dom属性使用prop获取属性的值,attr获取自定义属性的值
			//alert($(this).prop("checked"));全选按钮的值
			
			//把全选按钮的值赋给每一个复选框
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		$(document).on("click",".check_item",function(){
			//判断当前选择的元素是否是5个
			//判断选择元素是否等于复选框的总数
			var flag=$(".check_item:checked").length==$(".check_item").length;
			
			//把值赋给全选框
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，就批量删除
		$("#emp_delete_all_btn").click(function(){
			
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				//拿到每一个要显示的员工姓名
				//alert($(this).parents("tr").find("td:eq(2)").text());
				//组装了员工姓名字符串
				empNames  +=$(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
				
			});
			
			//去除员工姓名多余的逗号
			empNames =empNames.substring(0,empNames.length-1);
			//去除员工id多余的-号
			del_idstr =del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗？")){
				//发送批量删除的请求，改造删除方法
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage);
					}
				});
			}
			
		});
	</script>
</body>
</html>
