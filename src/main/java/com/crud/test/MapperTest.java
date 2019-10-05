package com.crud.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.crud.bean.Dempartment;
import com.crud.bean.Employee;
import com.crud.dao.DempartmentMapper;
import com.crud.dao.EmployeeMapper;

/**
 * 测试dao层的工作
 * @author en
 *
 *
 *使用spring的单元测试
 *1.导入spring的单元测试文件
 *2.使用@ContextConfiguration指定spring配置文件的位置，他会自动帮我们创建ioc容器
 *3.直接用autowired注解
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
		
		@Autowired
		DempartmentMapper dempartmentMapper;
		
		@Autowired
		EmployeeMapper employeeMapper;
		
		@Autowired
		SqlSession sqlSession;

		@Test
		public void testCRUD(){
			/*
			 * 推荐使用spring的单元测试
			//1.创建springioc容器
			ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
		
			//2.从spring中获取mapper
			Dempartment  dept=ioc.getBean(Dempartment.class);*/
			//System.out.println(dempartmentMapper);
			
			//插入几个部门
			//dempartmentMapper.insertSelective(new Dempartment(null, "开发部"));
			//dempartmentMapper.insertSelective(new Dempartment(null, "测试部"));
			
			//生成员工数据，测试员工插入
			//employeeMapper.insertSelective(new Employee(null, "royal", "M", "uzi@qq.com", 1));
			
			//3.批量插入多个员工； 可以使用执行批量操作的sqlsession
			EmployeeMapper mapper= sqlSession.getMapper(EmployeeMapper.class);
			/*for(int i=0;i<1000;i++){
				String uid=UUID.randomUUID().toString().substring(0,5)+i;
				mapper.insertSelective(new Employee(null, uid, "M", uid+"@qq.com", 1));
			}
			System.out.println("批量完成");*/
			List<Employee> list=mapper.selectByExampleWithDept(null);
			for (int i=0;i<10;i++) {
				System.out.println(list.get(i).getEmpName());
				System.out.println(list.get(i).getDepartement().getDeptName());
			}
		}
}
