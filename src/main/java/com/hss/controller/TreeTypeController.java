package com.hss.controller;

import com.hss.domain.TreeType;
import com.hss.service.TreeTypeService;
import com.hss.util.Msg;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value = "/tree")
public class TreeTypeController {

    private final static Logger logger = Logger.getLogger(TreeTypeController.class);

    @Autowired
    private TreeTypeService treeTypeService;

    @RequestMapping(value = "/findTreeType")
    @ResponseBody
    public Msg findTreeType() {

        logger.info("获取所有节点信息");
        List<TreeType> treeTypeList = treeTypeService.findTreeType();
        return Msg.success().add("treeTypeList",treeTypeList);
    }

    @RequestMapping(value = "/updateTreeType")
    @ResponseBody
    public Msg updateTreeType(TreeType treeType){
        logger.info("修改节点信息");
        treeTypeService.updateTreeType(treeType);
        return Msg.success();
    }

    @RequestMapping(value = "/findTreeTypeById")
    @ResponseBody
    public Msg findTreeTypeById(@RequestParam(value = "id") Long id){
        logger.info("查看节点信息");
        TreeType treeType = treeTypeService.findTreeTypeById(id);
        return Msg.success().add("treeType",treeType);
    }

    @RequestMapping(value = "/addTreeType")
    @ResponseBody
    public Msg addTreeType(TreeType treeType){
        logger.info("添加节点信息");
        treeType = treeTypeService.addTreeType(treeType);
        return Msg.success().add("treeType",treeType);
    }

    @RequestMapping(value = "/deleteTreeType")
    @ResponseBody
    public Msg deleteTreeType(@RequestParam(value = "id") Long id){
        logger.info("删除节点信息");
        treeTypeService.deleteTreeType(id);
        return Msg.success();
    }
}
