package com.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crud.bean.Dempartment;
import com.crud.dao.DempartmentMapper;


@Service
public class DepatrmentService {

	@Autowired
	private DempartmentMapper dempartmentMapper;
	
	public List<Dempartment> getDepts() {
		// TODO Auto-generated method stub
		List<Dempartment> list = dempartmentMapper.selectByExample(null);
		return list;
	}

}
