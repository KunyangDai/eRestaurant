package com.cn.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cn.dao.DB;
import com.cn.orm.Tuser;
import com.cn.util.CommonUtil;

/**
 * 留言操作Action
 */
public class MsgAction extends HttpServlet {

	
	private static final long serialVersionUID = 1L;

	/**
	 * Action调用控制�?
	 */
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// 请求类型
		String type = req.getParameter("type");

		if (type.endsWith("msgAdd")) {
			//留言添加
			msgAdd(req, res);
		}
		if (type.endsWith("msgReply")) {
			//留言回复
			msgReply(req, res);
		}
		if (type.endsWith("msgDel")) {
			//留言删除
			msgDel(req, res);
		}
	}

	/**
	 * 留言信息添加
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void msgAdd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		DB dbm = new DB();

		String msg = request.getParameter("msg");
		if (msg != null) {
			msg = CommonUtil.TextToHtml(msg);
		}
		String date = CommonUtil.getDate();
		Object user = request.getSession().getAttribute("user");

		String appuser = "";
		if (user != null) {
			appuser = ((Tuser) user).getName();
		}

		String type = request.getParameter("type");

		String sql = "insert into t_message(msg,appuser,date,reply)  values('"
				+ msg + "','" + appuser + "','" + date + "','')";

		Statement stat = null;
		Connection conn = null;
		try {
			conn = dbm.getCon();
			stat = conn.createStatement();
			System.out.println(sql);
			stat.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (stat != null)
					stat.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (type != null && type.toString() != null) {
			response.sendRedirect("qiantai/liuyan.jsp");
		}

		out.flush();
		out.close();
	}

	
	/**
	 * 留言信息回复
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void msgReply(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");
		String info = request.getParameter("info");

		DB dbm = new DB();
		String sql = "update t_message set reply='" + info + "'  where id="
				+ id;
		 

		Statement stat = null;
		Connection conn = null;
		try {
			conn = dbm.getCon();
			stat = conn.createStatement();
			stat.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (stat != null)
					stat.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		response.sendRedirect("admin/msg/list.jsp");
		out.flush();
		out.close();
	}

	/**
	 * 留言信息删除
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void msgDel(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");

		DB dbm = new DB();
		String sql = "delete from t_message where id=" + id;

		Statement stat = null;
		Connection conn = null;
		try {
			conn = dbm.getCon();
			stat = conn.createStatement();
			stat.execute(sql);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (stat != null)
					stat.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		response.sendRedirect("admin/msg/list.jsp");
		out.flush();
		out.close();
	}

 
}
