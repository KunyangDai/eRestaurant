package com.cn.action;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cn.dao.DB;
import com.cn.orm.Tgonggao;
import com.cn.util.CommonUtil;

/**
 * 公告操作Action
 * 
 */
public class GonggaoAction extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Action调用控制�?
	 */
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		// 请求类型
		String type = req.getParameter("type");

		if (type.endsWith("gonggaoAdd")) {
			// 公告添加
			gonggaoAdd(req, res);
		}
		if (type.endsWith("gonggaoMana")) {
			// 公告查询
			gonggaoMana(req, res);
		}
		if (type.endsWith("gonggaoDel")) {
			// 公告删除
			gonggaoDel(req, res);
		}
		if (type.endsWith("gonggaoDetail")) {
			// 公告明细
			gonggaoDetail(req, res);
		}

		if (type.endsWith("gonggaoDetailQian")) {
			// 新闻公告前台显示
			gonggaoDetailQian(req, res);
		}
		if (type.endsWith("gonggaoManaQian")) {
			// 新闻公告前台列表
			gonggaoManaQian(req, res);
		}
		if (type.endsWith("gonggaoUpdate")) {
			// 新闻公告更新
			gonggaoUpdate(req, res);
		}
	}

	/**
	 * 新闻公告添加
	 * 
	 * @param req
	 * @param res
	 */
	public void gonggaoAdd(HttpServletRequest req, HttpServletResponse res) {
		String id = String.valueOf(new Date().getTime());
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String shijian = CommonUtil.getDate();

		//保存到新闻公告表
		String sql = "insert into t_gonggao values(?,?,?,?)";
		Object[] params = { id, title, content, shijian };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "gonggao?type=gonggaoMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);

	}

	/**
	 * 新闻公告更新
	 * @param req
	 * @param res
	 */
	public void gonggaoUpdate(HttpServletRequest req, HttpServletResponse res) {

		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String id = req.getParameter("id"); 

		//更新新闻公告内容
		String sql = "update t_gonggao set title=?,content=? where id=?";
		Object[] params = { title, content, id };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "gonggao?type=gonggaoMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);

	}

	/**
	 * 新闻公告删除
	 * @param req
	 * @param res
	 */
	public void gonggaoDel(HttpServletRequest req, HttpServletResponse res) {
		String id = req.getParameter("id");

		//根据公告ID删除新闻公告
		String sql = "delete from t_gonggao where id=?";
		Object[] params = { id };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "gonggao?type=gonggaoMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	/**
	 * 后台查询新闻公告列表
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void gonggaoMana(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<Tgonggao> gonggaoList = new ArrayList<Tgonggao>();
		String sql = "select * from t_gonggao";
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tgonggao gonggao = new Tgonggao();

				gonggao.setId(rs.getString("id"));
				gonggao.setTitle(rs.getString("title"));
				gonggao.setContent(rs.getString("content"));
				gonggao.setShijian(rs.getString("shijian"));

				gonggaoList.add(gonggao);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("gonggaoList", gonggaoList);
		req.getRequestDispatcher("admin/gonggao/gonggaoMana.jsp").forward(req,
				res);
	}

	/**
	 * 前台查询新闻公告列表
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void gonggaoManaQian(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<Tgonggao> gonggaoList = new ArrayList<Tgonggao>();
		String sql = "select * from t_gonggao";
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tgonggao gonggao = new Tgonggao();

				gonggao.setId(rs.getString("id"));
				gonggao.setTitle(rs.getString("title"));
				gonggao.setContent(rs.getString("content"));
				gonggao.setShijian(rs.getString("shijian"));

				gonggaoList.add(gonggao);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("gonggaoList", gonggaoList);
		req.getRequestDispatcher("/qiantai/gonggao/gonggaoListQian.jsp")
				.forward(req, res);
	}

	/**
	 * 新闻公告详细信息,后台使用
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void gonggaoDetail(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		Tgonggao gonggao = new Tgonggao();

		String sql = "select * from t_gonggao where id=?";
		Object[] params = { id };
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			rs.next();

			gonggao.setId(rs.getString("id"));
			gonggao.setTitle(rs.getString("title"));
			gonggao.setContent(rs.getString("content"));
			gonggao.setShijian(rs.getString("shijian"));

			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("gonggao", gonggao);
		req.getRequestDispatcher("admin/gonggao/gonggaoDetail.jsp").forward(
				req, res);
	}

	/**
	 * 新闻公告详细信息,前台
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void gonggaoDetailQian(HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException {
		String id = req.getParameter("id");
		Tgonggao gonggao = new Tgonggao();

		String sql = "select * from t_gonggao where id=?";
		Object[] params = { id };
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			rs.next();

			gonggao.setId(rs.getString("id"));
			gonggao.setTitle(rs.getString("title"));
			gonggao.setContent(rs.getString("content"));
			gonggao.setShijian(rs.getString("shijian"));

			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("gonggao", gonggao);
		req.getRequestDispatcher("/qiantai/gonggao/gonggaoDetailQian.jsp")
				.forward(req, res);
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
