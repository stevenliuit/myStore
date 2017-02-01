package cn.dahe.service;

import cn.dahe.dto.Pager;
import cn.dahe.model.TrafficManage;

/**
 * 货流管理
 * Created by fy on 2017/1/30.
 */
public interface ITrafficManageService {
    void add(TrafficManage t);
    void del(int id);
    void update(TrafficManage t);
    TrafficManage get(int id);
    TrafficManage load(int id);

    /**
     * 根据参数查询
     * @param aDataSet
     * @param storeId
     * @return
     */
    Pager<TrafficManage> findByParams(String aDataSet, int storeId);

    /**
     * 通过excel导入货流信息
     * @param storeId
     */
    void importTrafficManageExcel(int storeId);
}