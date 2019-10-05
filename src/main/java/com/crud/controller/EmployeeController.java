package com.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crud.bean.Employee;
import com.crud.bean.Msg;
import com.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工的crud
 * @author en
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * restful风格
	 *   /emp/{id}  GET    查询员工
	 *   /emp       POST   保存员工
	 *   /emp/{id}  PUT    修改员工
	 *   /emp/{id}  DELETE 删除员工
 	 */
	
	
	/**
	 * 如果直接发送ajax=put的请求
	 * 封装的数据除了路径上的其他全部为null
	 * 
	 * 问题：请求体中有数据，但是employee对象封装不上
	 * 	
	 * 原因：1.tomcat将请求体中的数据封装成一个map，
	 * 		2.request.getParameter("empName")就会从这个map中取值
	 * 		3.springMvc封装POJO对象的时候，
	 * 					会把POJO中每个属性的值，request.getParameter("empName")；
	 * AJAX发送PUT请求：
	 * 		PUT请求，请求体中的数据拿不到，
	 * 		tomcat发现是put请求就不会封装请求体中的数据为map，只有post请求才封装为map
	 * 
	 * 解决办法：
	 * 配置httpPutFormContentFilter；
	 * 它的作用：将请求体中的数据解析包装成一个map
	 * request被重新包装，request.getParameter()被重写，就会从自己封装的map中去数据
	 * 
	 * 
	 * 员工更新方法
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee){
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 单个删除和批量删除二合一
	 * 
	 * 批量删除：1-2-3
	 * 单个删除：1
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids){
		if(ids.contains("-")){//批量删除
			String[] strings = ids.split("-");
			
			List<Integer> list  = new ArrayList<Integer>();
			
			for (String id : strings) {
				list.add(Integer.parseInt(id));	
			}
			employeeService.deleteBatch(list);
		}else{//单个删除
			Integer id=Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		
		return Msg.success();
	}
	
	/*
	 * 单个删除
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("id")Integer id){
		employeeService.deleteEmp(id);
		return Msg.success();
	}*/
	
	
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName){
		//判断用户名是否是合法的表达式
		String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		//判断是否符合正则表达式
		if(!empName.matches(regx)){
			//如果匹配失败
			return Msg.fail().add("va_msg", "用户名需要是2-5位的中文或6-16位的英文和数字的组合!");
		}
		
		boolean b=employeeService.checkUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用，请重新输入！");
		}	
	}
	
	
	//员工保存
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			//校验失败,应该返回失败，在模态框中显示校验失败的错误信息
			//用map封装错误信息返回给前端
			Map<String,Object>  map= new HashMap<String,Object>();
			
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误的信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();
		}
		
	}
	
	/**
	 * 需要导入jackson包，让responsebody正常工作
	 * 升级版
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){
		
		PageHelper.startPage(pn,5);
	
		List<Employee> emps=employeeService.getAll();
		
		PageInfo page= new PageInfo(emps,5);
		
		return Msg.success().add("pageInfo",page);
	}
	
	/**
	 * 查询单个员工信息
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee= employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	/**
	 * 查询员工数据
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){
		System.out.println("进入control层");
		//这不是一个分页查询
		//引入PageHelper分页
		//在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn,5);
		//startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps=employeeService.getAll();
		//使用pageinfo包装查询结果,只需要将pageinfo交给页面就行了
		//封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page= new PageInfo(emps,5);
		model.addAttribute("pageInfo", page);
		
		return "list";
	}
}
