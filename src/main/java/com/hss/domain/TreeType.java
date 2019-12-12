package com.hss.domain;

public class TreeType {
    /* 节点编号*/
    private Long id;
    /* 节点父编号*/
    private Long pId;
    /* 节点名称*/
    private String name;
    /* 是否展开*/
    private Boolean open;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getpId() {
        return pId;
    }

    public void setpId(Long pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getOpen() {
        return open;
    }

    public void setOpen(Boolean open) {
        this.open = open;
    }

    @Override
    public String toString() {
        return "TreeType{" +
                "id=" + id +
                ", pId=" + pId +
                ", name='" + name + '\'' +
                ", open=" + open +
                '}';
    }
}
