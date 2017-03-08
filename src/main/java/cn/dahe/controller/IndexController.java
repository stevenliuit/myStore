package cn.dahe.controller;

import cn.dahe.model.Permission;
import cn.dahe.model.Role;
import cn.dahe.model.User;
import cn.dahe.service.IPermissionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * 首页跳转
 * @author fengyuan
 * */
@Controller
public class IndexController {
	/**
	 * @param model
	 * @param session
	 * */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String add(Model model,HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		if(null != user){
			model.addAttribute("user", user);
			Set<Permission> permissionSet = user.getPermissions();
			Role role = user.getRole();
			if(role != null){
                Set<Permission> permissions = role.getPermissions();
                permissionSet.addAll(permissions);
            }
            List<Permission> level0 = new ArrayList<>();
			List<Permission> level1 = new ArrayList<>();
            permissionSet.forEach(permission -> {
                if(permission.getLevel() == 0){
                    level0.add(permission);
                }
                if(permission.getLevel() == 1){
                    level1.add(permission);
                }
            });
            Collections.sort(level0, Comparator.comparing(Permission::getId));
			model.addAttribute("channel", level0);
			model.addAttribute("menu", level1);
			return "backstage/index";
		}else{
			return "login";
		}
	}
	
	/**
	 * @param model
	 * */
	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String welcome(Model model) {
		model.addAttribute("loginIp", "127.0.0.1");
		model.addAttribute("loginTime", new Date());
		return  "welcome";
	}

	/**
	 * 权限不够的跳转
	 * @return
	 */
	@RequestMapping("/403")
	public String unauthorizedRole(){
		return "403";
	}
}
