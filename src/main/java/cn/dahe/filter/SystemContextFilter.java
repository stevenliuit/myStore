package cn.dahe.filter;


import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class SystemContextFilter implements Filter {
	

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
			//过滤所有的参数，防止sql注入和xss攻击
			chain.doFilter(new XssAndSqlInjectClear((HttpServletRequest)req), resp);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
	}
}
