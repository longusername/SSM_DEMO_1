package com.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crud.bean.DempartmentExample.Criteria;
import com.crud.bean.Employee;
import com.crud.bean.EmployeeExample;
import com.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
		
		@Autowired
		EmployeeMapper  employeeMapper;
	
		/**
		 * 查询所有员工
		 * @return
		 */
		public List<Employee> getAll(){
			//System.out.println("进入service的getAll");
			return employeeMapper.selectByExampleWithDept(null);
			
		}
		
		/**
		 * 员工保存
		 */
		public void saveEmp(Employee employee) {
			// TODO Auto-generated method stub
			System.out.println("---------save------ok----");
			employeeMapper.insertSelective(employee);
		}
		
		/**
		 * 检验用户名是否可用
		 * @param empName
		 * @return
		 */
		public boolean checkUser(String empName) {
			// TODO Auto-generated method stub
			
			EmployeeExample example=new EmployeeExample();
			
			
			com.crud.bean.EmployeeExample.Criteria c=example.createCriteria();
			c.andEmpNameEqualTo(empName);
			
			long count=employeeMapper.countByExample(example);
			return count==0;
		}
		
		/**
		 * 按照员工id查询员工
		 * @param id
		 * @return
		 */
		public Employee getEmp(Integer id) {
			// TODO Auto-generated method stub
			Employee employee = employeeMapper.selectByPrimaryKey(id);
			return employee;
		}
		
		/**
		 * 修改员工信息
		 * @param employee
		 */
		public void updateEmp(Employee employee) {
			// TODO Auto-generated method stub
			employeeMapper.updateByPrimaryKeySelective(employee);
		}
		
		/**
		 * 删除员工信息
		 */
		public void deleteEmp(Integer id) {
			// TODO Auto-generated method stub
			employeeMapper.deleteByPrimaryKey(id);
		}
		
		/**
		 * 批量删除
		 * @param ids
		 */
		public void deleteBatch(List<Integer> ids) {
			// TODO Auto-generated method stub
			EmployeeExample example = new EmployeeExample();
			com.crud.bean.EmployeeExample.Criteria criteria = example.createCriteria();
			
			//相当于delete from xxx where emp_id in(ids这个list集合)
			criteria.andEmpIdIn(ids);
			employeeMapper.deleteByExample(example);
		}
}
