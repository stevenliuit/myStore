package cn.dahe.dto;

import java.util.HashMap;
import java.util.Map;

/**
 * 商品货流管理
 * Created by fy on 2017/1/29.
 */
public class GoodsTrafficDto {
    //期望发货时间
    private String wishTime;
    //备注
    private String description;
    //订的商品信息 商品id , 订的数量
    private Map<Integer, Integer> goodsMap = new HashMap<>();
    //店面id
    private int storeId;
    public String getWishTime() {
        return wishTime;
    }

    public void setWishTime(String wishTime) {
        this.wishTime = wishTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Map<Integer, Integer> getGoodsMap() {
        return goodsMap;
    }

    public void setGoodsMap(Map<Integer, Integer> goodsMap) {
        this.goodsMap = goodsMap;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }
}