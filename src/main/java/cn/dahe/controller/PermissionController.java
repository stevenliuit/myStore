package cn.dahe.controller;


import cn.dahe.dto.AjaxObj;
import cn.dahe.dto.Pager;
import cn.dahe.model.Permission;
import cn.dahe.model.SysMenu;
import cn.dahe.model.User;
import cn.dahe.service.IPermissionService;
import cn.dahe.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by fy on 2017/2/9.
 */
@Controller
@RequestMapping("server/permission")
public class PermissionController {
    private static Logger logger = LoggerFactory.getLogger(PermissionController.class);
    @Resource
    private IPermissionService permissionService;

    /**
     * 查询全部权限
     */
    @RequestMapping(value = "findAllPermission", method = RequestMethod.POST)
    @ResponseBody
    public List<Permission> findAllPermission(int type){
        return permissionService.findAll(type);
    }
    /**
     * 列表页查询
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String getPermissionList() {
        return "permission/list";
    }

    /**
     * 列表页查询
     */
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public Pager<Permission> getPermissionList(String aDataSet) {
        logger.info("--- permission list begin ---");
        return permissionService.findByParams(aDataSet);
    }

    /**
     *权限添加
     * @param session
     */
    @RequestMapping(value = "add", method = RequestMethod.GET)
    public String addPermission(HttpSession session){
        return "permission/add";
    }

    /**
     * 权限添加
     * @param permission
     */
    @RequestMapping(value = "add", method = RequestMethod.POST)
    @ResponseBody
    public AjaxObj addPermission(Permission permission){
        AjaxObj json = new AjaxObj();
        boolean b = permissionService.add(permission);
        if(b){
            json.setInfo("权限添加成功");
            json.setStatus("y");
        }else{
            json.setInfo("该权限key已存在");
            json.setStatus("n");
        }
        return json;
    }

    /**
     *权限修改
     * @param id
     * @param model
     */
    @RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
    public String editPermission(@PathVariable int id, Model model){
        Permission permission = permissionService.get(id);
        model.addAttribute("permission", permission);
        return "permission/edit";
    }

    /**
     * 权限修改
     * @param permission
     */
    @RequestMapping(value = "edit", method = RequestMethod.POST)
    @ResponseBody
    public AjaxObj editPermission(Permission permission){
        AjaxObj json = new AjaxObj();
        boolean b = permissionService.update(permission);
        if(b) {
            json.setInfo("权限修改成功");
            json.setStatus("y");
        }else{
            json.setInfo("该权限key已存在");
            json.setStatus("n");
        }
        return json;
    }

    /**
     * 得到所有目录
     */
    @RequestMapping(value = "menu", method = RequestMethod.POST)
    @ResponseBody
    public List<SysMenu> queryAllMenu(){
        return permissionService.findAllSysMenu();
    }
}
