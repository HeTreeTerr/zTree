package com.hss.mapper;

import com.hss.domain.TreeType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 树节点mapper层
 */
@Mapper
public interface TreeTypeMapper {

    /**
     * 查询所有节点信息
     * @return
     */
    List<TreeType> findTreeType();

    /**
     * 由id查询
     * @return
     */
    TreeType findTreeTypeById(@Param(value = "id") Long id);

    /**
     * 编辑节点
     * @return
     */
    void updateTreeType(TreeType treeType);

    /**
     * 新增节点
     */
    Long addTreeType(TreeType treeType);

    /**
     * 删除节点
     */
    void deleteTreeType(@Param(value = "id") Long id);

    /**
     * 由父节点查询子节点
     */
    List<TreeType> findTreeTypeByPid(Long pId);
}
