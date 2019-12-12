package com.hss.service;

import com.hss.domain.TreeType;

import java.util.List;

public interface TreeTypeService {

    /**
     * 查询所有节点信息
     * @return
     */
    List<TreeType> findTreeType();

    /**
     * 编辑节点
     * @return
     */
    void updateTreeType(TreeType treeType);

    /**
     * 由id查询
     * @return
     */
    TreeType findTreeTypeById(Long id);

    /**
     * 新增节点
     */
    TreeType addTreeType(TreeType treeType);

    /**
     * 删除节点,及所有子节点
     */
    void deleteTreeType(Long id);
}
