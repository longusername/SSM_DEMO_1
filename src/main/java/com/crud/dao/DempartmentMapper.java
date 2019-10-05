package com.crud.dao;

import com.crud.bean.Dempartment;
import com.crud.bean.DempartmentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DempartmentMapper {
    long countByExample(DempartmentExample example);

    int deleteByExample(DempartmentExample example);

    int deleteByPrimaryKey(Integer deptId);

    int insert(Dempartment record);

    int insertSelective(Dempartment record);

    List<Dempartment> selectByExample(DempartmentExample example);

    Dempartment selectByPrimaryKey(Integer deptId);

    int updateByExampleSelective(@Param("record") Dempartment record, @Param("example") DempartmentExample example);

    int updateByExample(@Param("record") Dempartment record, @Param("example") DempartmentExample example);

    int updateByPrimaryKeySelective(Dempartment record);

    int updateByPrimaryKey(Dempartment record);
}