package com.cn.action;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cn.dao.DB;
import com.cn.orm.Tadmin;

/**
 * 管理员操作Action
 * 
 */
public class AdminAction extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Action调用控制�?
	 */
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// 请求类型
		String type = req.getParameter("type");

		if (type.endsWith("adminMana")) {
			// 请求管理员列�?
			adminMana(req, res);
		}
		if (type.endsWith("adminAdd")) {
			// 请求管理员添�?
			adminAdd(req, res);
		}
		if (type.endsWith("adminDel")) {
			// 请求管理员删�?
			adminDel(req, res);
		}
	}

	/**
	 * 管理员列�?
	 * 
	 * @param req
	 *            HttpServletRequest
	 * @param res
	 *            HttpServletResponse
	 * @throws ServletException
	 * @throws IOException
	 */
	public void adminMana(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<Tadmin> adminList = new ArrayList<Tadmin>();

		// 从数据库中查询到管理员信�?
		String sql = "select * from t_admin";
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				// 将查询到的信息封装成Tadmin bean
				Tadmin admin = new Tadmin();
				admin.setUserId(rs.getInt("userId"));
				admin.setUserName(rs.getString("userName"));
				admin.setUserPw(rs.getString("userPw"));
				admin.setUserType(rs.getString("userType"));
				adminList.add(admin);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		// 将对象保存到request
		req.setAttribute("adminList", adminList);
		req.getRequestDispatcher("admin/admin/adminMana.jsp").forward(req, res);
	}

	/**
	 * 管理员添�?
	 * 
	 * @param req
	 * @param res
	 */
	public void adminAdd(HttpServletRequest req, HttpServletResponse res) {
		// 获取从表单提交的管理员信�?
		String userName = req.getParameter("userName");
		String userPw = req.getParameter("userPw");
		String userType = req.getParameter("userType");

		// 保存到数据库
		String sql = "insert into t_admin(userName,userPw,userType) values(?,?,?)";
		Object[] params = { userName, userPw, userType };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		// 设置提示信息
		req.setAttribute("message", "操作成功");
		// 设置跳转页面
		req.setAttribute("path", "admin?type=adminMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	/**
	 * 管理员删�?
	 * 
	 * @param req
	 * @param res
	 */
	public void adminDel(HttpServletRequest req, HttpServletResponse res) {
		// 根据用户ID删除数据
		String sql = "delete from t_admin where userId="
				+ Integer.parseInt(req.getParameter("userId"));
		Object[] params = {};
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "admin?type=adminMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	/**
	 * 跳转服务工具方法
	 * 
	 * @param targetURI
	 * @param request
	 * @param response
	 */
	public void dispatch(String targetURI, HttpServletRequest request,
			HttpServletResponse response) {
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(
				targetURI);
		try {
			dispatch.forward(request, response);
			return;
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

}
