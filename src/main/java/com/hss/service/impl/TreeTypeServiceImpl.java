package com.hss.service.impl;

import com.hss.domain.TreeType;
import com.hss.mapper.TreeTypeMapper;
import com.hss.service.TreeTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class TreeTypeServiceImpl implements TreeTypeService {

    @Autowired
    private TreeTypeMapper treeTypeMapper;

    @Override
    public List<TreeType> findTreeType() {

        return treeTypeMapper.findTreeType();
    }

    @Override
    public void updateTreeType(TreeType treeType) {

        treeTypeMapper.updateTreeType(treeType);
    }

    @Override
    public TreeType findTreeTypeById(Long id) {
        return treeTypeMapper.findTreeTypeById(id);
    }

    @Override
    public TreeType addTreeType(TreeType treeType) {
        treeTypeMapper.addTreeType(treeType);
        treeType = treeTypeMapper.findTreeTypeById(treeType.getId());
        return treeType;
    }

    @Override
    public void deleteTreeType(Long id) {
        if(id != null){
            List<TreeType> treeTypeList = treeTypeMapper.findTreeTypeByPid(id);
            //删除所有子节点
            if(treeTypeList != null){
                for(TreeType treeType : treeTypeList){
                    deleteTreeType(treeType.getId());
                }
            }
            //删除自身
            treeTypeMapper.deleteTreeType(id);
        }
    }
}
