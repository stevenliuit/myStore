package cn.dahe.model;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * 货流 订货信息单
 * Created by fy on 2017/1/22.
 */
@Table(name = "t_goods_traffic")
@Entity
public class GoodsTraffic {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    //下单时间
    @Column(name = "order_time")
    private Date orderTime;
    //期望发货时间
    @Column(name = "wish_time")
    private Date wishTime;
    //订货状态 -1 已作废 0 待审核 1 配货中 2 已完成
    private int status;
    //0 商品  1 原材料
    @Column(name = "order_type")
    private int orderType;
    //备注
    private String description;
    //订货门店Id
    @Column(name = "order_store_id")
    private int orderStoreId;
    //订货门店名称
    @Column(name = "order_store_name")
    private String orderStoreName;
    //如果订货的门店是连锁店则需要以下属性：
    //配货门店Id
    @Column(name = "prepare_store_id")
    private int prepareStoreId;
    //配货门店名称
    @Column(name = "prepare_store_name")
    private String prepareStoreName;
    //配货方式 0 通过调货来配货（来源为指定的配货门店） 1 通过进货来配货 （来源为供货商）
    @Column(name = "prepare_type")
    private int prepareType;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Date getWishTime() {
        return wishTime;
    }

    public void setWishTime(Date wishTime) {
        this.wishTime = wishTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getOrderStoreId() {
        return orderStoreId;
    }

    public void setOrderStoreId(int orderStoreId) {
        this.orderStoreId = orderStoreId;
    }

    public String getOrderStoreName() {
        return orderStoreName;
    }

    public void setOrderStoreName(String orderStoreName) {
        this.orderStoreName = orderStoreName;
    }

    public int getPrepareStoreId() {
        return prepareStoreId;
    }

    public void setPrepareStoreId(int prepareStoreId) {
        this.prepareStoreId = prepareStoreId;
    }

    public String getPrepareStoreName() {
        return prepareStoreName;
    }

    public void setPrepareStoreName(String prepareStoreName) {
        this.prepareStoreName = prepareStoreName;
    }

    public int getPrepareType() {
        return prepareType;
    }

    public void setPrepareType(int prepareType) {
        this.prepareType = prepareType;
    }

    public int getOrderType() {
        return orderType;
    }

    public void setOrderType(int orderType) {
        this.orderType = orderType;
    }

    @Override
    public String toString() {
        return "GoodsTraffic{" +
                "id=" + id +
                ", orderTime=" + orderTime +
                ", wishTime=" + wishTime +
                ", status=" + status +
                ", description='" + description + '\'' +
                ", orderStoreId=" + orderStoreId +
                ", orderStoreName='" + orderStoreName + '\'' +
                ", prepareStoreId=" + prepareStoreId +
                ", prepareStoreName='" + prepareStoreName + '\'' +
                ", prepareType=" + prepareType +
                '}';
    }
}
