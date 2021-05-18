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
import com.cn.orm.Tchu;

/**
 * 商品出库Action
 * 
 */
public class ChuKuAction extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Action调用控制�?
	 */
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// 请求类型
		String type = req.getParameter("type");

		if (type.endsWith("chuAdd")) {
			// 出库添加
			chuAdd(req, res);
		}
		if (type.endsWith("chuMana")) {
			// 出库查询
			chuMana(req, res);
		}
		if (type.endsWith("chuDel")) {
			// 出库删除
			chuDel(req, res);
		}
		if (type.endsWith("chuDetail")) {
			// 出库明细
			chuDetail(req, res);
		}

		if (type.endsWith("chuUpdate")) {
			// 出库更新
			chuUpdate(req, res);
		}
	}

	/**
	 * 出库信息添加
	 * @param req
	 * @param res
	 */
	public void chuAdd(HttpServletRequest req, HttpServletResponse res) {
		//获取出库信息参数
		String goods_id = req.getParameter("goods_id");
		String ren = req.getParameter("ren");
		Integer count = Integer.parseInt(req.getParameter("count"));
		String date = req.getParameter("date");
		String mingcheng = goods_id.split(":")[1];
		int goodsid = Integer.parseInt(goods_id.split(":")[0]);

		//添加出库信息
		String sql = "insert into t_chu(mingcheng,goodsid,ren,count,date) values(?,?,?,?,?)";
		Object[] params = { mingcheng, goodsid, ren, count, date };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		//更新库存
		String sql2 = "update t_goods set kucun=kucun-" + count + " where id="
				+ goodsid;
		DB mydbs = new DB();
		mydbs.doPstm(sql2, null);
		mydbs.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "chu?type=chuMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);

	}

	
	/**
	 * 出库信息更新
	 * @param req
	 * @param res
	 */
	public void chuUpdate(HttpServletRequest req, HttpServletResponse res) {

		//获取出库信息
		Integer id = Integer.parseInt(req.getParameter("id"));
		String goods_id = req.getParameter("goods_id");
		String ren = req.getParameter("ren");
		Integer count = Integer.parseInt(req.getParameter("count"));
		String date = req.getParameter("date");
		String mingcheng = goods_id.split(":")[1];
		int goodsid = Integer.parseInt(goods_id.split(":")[0]);

		//更新库存信息
		String sql = "update t_chu set mingcheng=?,goodsid=?,ren=?,count=?,date=? where id=?";
		Object[] params = { mingcheng, goodsid, ren, count, date, id };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		//设置提醒信息
		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "chu?type=chuMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);

	}

	/**
	 * 出库信息删除
	 * @param req
	 * @param res
	 */
	public void chuDel(HttpServletRequest req, HttpServletResponse res) {
		//根据ID删除出库信息
		String id = req.getParameter("id");
		String sql = "delete from t_chu where id=?";
		Object[] params = { id };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "chu?type=chuMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	/**
	 * 出库明细查询
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void chuMana(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<Tchu> chuList = new ArrayList<Tchu>();
		String sql = "select * from t_chu";
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tchu chu = new Tchu();

				chu.setMingcheng(rs.getString("mingcheng"));
				chu.setGoodsid(rs.getInt("goodsid"));
				chu.setRen(rs.getString("ren"));
				chu.setDate(rs.getString("date"));
				chu.setCount(rs.getInt("count"));
				chu.setId(rs.getInt("id"));

				chuList.add(chu);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("chuList", chuList);
		req.getRequestDispatcher("admin/chu/chuMana.jsp").forward(req, res);
	}

	/**
	 * 出库明细
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void chuDetail(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		Tchu chu = new Tchu();

		String sql = "select * from t_chu where id=?";
		Object[] params = { id };
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			rs.next();

			chu.setId(rs.getInt("id"));
			chu.setMingcheng(rs.getString("mingcheng"));
			chu.setGoodsid(rs.getInt("goodsid"));
			chu.setRen(rs.getString("ren"));
			chu.setDate(rs.getString("date"));
			chu.setCount(rs.getInt("count"));

			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("chu", chu);
		req.getRequestDispatcher("admin/chu/chuDetail.jsp").forward(req, res);
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
