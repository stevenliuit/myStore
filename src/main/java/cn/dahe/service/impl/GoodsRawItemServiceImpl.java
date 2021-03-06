package cn.dahe.service.impl;

import cn.dahe.dao.IGoodsDao;
import cn.dahe.dao.IGoodsRawDao;
import cn.dahe.dao.IGoodsRawItemDao;
import cn.dahe.model.Goods;
import cn.dahe.model.GoodsRaw;
import cn.dahe.model.GoodsRawItem;
import cn.dahe.service.IGoodsRawItemService;
import cn.dahe.util.DecimalUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 冯源 on 2017/3/26.
 */
@Service("goodsRawItemService")
public class GoodsRawItemServiceImpl implements IGoodsRawItemService{
    @Resource
    private IGoodsRawItemDao goodsRawItemDao;
    @Resource
    private IGoodsDao goodsDao;
    @Resource
    private IGoodsRawDao goodsRawDao;
    @Override
    public void add(GoodsRawItem t) {
        goodsRawItemDao.add(t);
    }

    @Override
    public void del(int id) {
        goodsRawItemDao.delete(id);
    }

    @Override
    public void update(GoodsRawItem t) {
        goodsRawItemDao.update(t);
    }

    @Override
    public GoodsRawItem get(int id) {
        return goodsRawItemDao.get(id);
    }

    @Override
    public GoodsRawItem load(int id) {
        return goodsRawItemDao.load(id);
    }

    @Override
    public List<GoodsRawItem> findByGoodsId(int goodsId) {
        return goodsRawItemDao.findByGoodsId(goodsId);
    }

    @Override
    public void addRawItems(int goodsId, String rawItems, int useRawPrice, int semifinished, int autoFinished, int targetGoodsId, String targetGoodsName, int targetGoodsNum) {
        JSONArray json = JSONArray.parseArray(rawItems);
        goodsRawItemDao.delByGoodsId(goodsId);
        double bid = 0.0;
        int len = json.size();
        for(int i = 0; i < len; i++){
            JSONObject object = JSONObject.parseObject(json.get(i).toString());
            GoodsRawItem goodsRawItem = new GoodsRawItem();
            goodsRawItem.setGoodsId(Integer.parseInt((String)object.get("goodsId")));
            goodsRawItem.setGoodsUnitName((String)object.get("goodsUnitName"));
            String goodsUnitIdStr = (String)object.get("goodsUnitId");
            int unitId = 0;
            if(StringUtils.isNotBlank(goodsUnitIdStr)){
                unitId = Integer.parseInt(goodsUnitIdStr);
            }
            goodsRawItem.setGoodsUnitId(unitId);
            goodsRawItem.setRawId(Integer.parseInt((String)object.get("rawId")));
            goodsRawItem.setRawName((String)object.get("rawName"));
            String rawNumStr = (String)object.get("rawNum");
            int rawNum = 0;
            if(StringUtils.isNotBlank(rawNumStr)){
                rawNum = Integer.parseInt(rawNumStr);
            }
            goodsRawItem.setRawNum(rawNum);
            if(useRawPrice == 1){
                GoodsRaw goodsRaw = goodsRawDao.get(goodsRawItem.getRawId());
                bid += goodsRaw.getPrice() * rawNum * 100;
            }
            goodsRawItem.setRawNo((String)object.get("rawNo"));
            goodsRawItemDao.add(goodsRawItem);
        }

        Goods goods = goodsDao.get(goodsId);
        goods.setAutoFinished(autoFinished);
        goods.setSemifinished(semifinished);
        goods.setUseRawPrice(useRawPrice);
        goods.setTargetGoodsId(targetGoodsId);
        goods.setTargetGoodsName(targetGoodsName);
        goods.setTargetGoodsNum(targetGoodsNum);
        if(useRawPrice == 1){
            goods.setBid(DecimalUtil.getDouble(bid,2));
        }
        if(len > 0){
            goods.setHasRaws(1);
        }else{
            goods.setHasRaws(0);
        }
        goodsDao.update(goods);
    }
}
