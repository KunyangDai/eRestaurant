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
import com.cn.orm.Tgoods;
import com.cn.service.ShopService;

/**
 * 商品操作Action
 */
public class GoodsAction extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Action调用控制�?
	 */
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		// 请求类型
		String type = req.getParameter("type");

		if (type.endsWith("goodsAdd")) {
			//商品添加
			goodsAdd(req, res);
		}
		if (type.endsWith("goodsMana")) {
			//商品查询
			goodsMana(req, res);
		}
		if (type.endsWith("goodsManaQian")) {
			//商品查询
			goodsManaQian(req, res);
		}
		if (type.endsWith("goodsDel")) {
			//商品删除
			goodsDel(req, res);
		}
		if (type.endsWith("goodsDetailHou")) {
			//商品详细信息
			goodsDetailHou(req, res);
		}

		if (type.endsWith("goodsByCatelog")) {
			//根据商品类别查询
			goodsByCatelog(req, res);
		}
		if (type.endsWith("goodsDetailQian")) {
			//商品详细信息 前台
			goodsDetailQian(req, res);
		}
		if (type.endsWith("goodsUpdate")) {
			//商品信息更新
			goodsUpdate(req, res);
		}
		if (type.endsWith("goodsKucun")) {
			//商品信息库存
			goodsKucun(req, res);
		}
		if (type.endsWith("goodsByKey")) {
			//根据关键字查�?
			goodsByKey(req, res);
		}
	}

	/**
	 * 商品信息添加
	 * @param req
	 * @param res
	 */
	public void goodsAdd(HttpServletRequest req, HttpServletResponse res) {
		//根据商品信息保存到数据库
		int catelog_id = Integer.parseInt(req.getParameter("catelog_id"));
		String bianhao = req.getParameter("bianhao");
		String mingcheng = req.getParameter("mingcheng");
		String jieshao = req.getParameter("jieshao");
		String pinpai = req.getParameter("pinpai");
		String fujian = req.getParameter("fujian");
		int jiage = Integer.parseInt(req.getParameter("jiage"));
		int kucun = 0;
		String del = "no";

		String sql = "insert into t_goods(catelog_id,bianhao,mingcheng,jieshao,pinpai,fujian,jiage,kucun,del) "
				+ "values(?,?,?,?,?,?,?,?,?)";
		Object[] params = { catelog_id, bianhao, mingcheng, jieshao, pinpai,
				fujian, jiage, kucun, del };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "goods?type=goodsMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	/**
	 * 商品信息更新
	 * @param req
	 * @param res
	 */
	public void goodsUpdate(HttpServletRequest req, HttpServletResponse res) {
		int catelog_id = Integer.parseInt(req.getParameter("catelog_id"));
		String bianhao = req.getParameter("bianhao");
		String mingcheng = req.getParameter("mingcheng");
		String jieshao = req.getParameter("jieshao");
		String pinpai = req.getParameter("pinpai");
		String fujian = req.getParameter("fujian");
		int jiage = Integer.parseInt(req.getParameter("jiage"));
		String id = req.getParameter("id");

		String sql = "update t_goods set catelog_id=?,bianhao=?,mingcheng=?,jieshao=?,pinpai=?,jiage=?,fujian=? where id=?";
		Object[] params = { catelog_id, bianhao, mingcheng, jieshao, pinpai,
				jiage, fujian, id };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "goods?type=goodsMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	/**
	 * 商品信息删除
	 * @param req
	 * @param res
	 */
	public void goodsDel(HttpServletRequest req, HttpServletResponse res) {
		int id = Integer.parseInt(req.getParameter("id"));
		String sql = "update t_goods set del='yes' where id=" + id;
		Object[] params = {};
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "goods?type=goodsMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	/**
	 * 商品库存信息查询
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void goodsKucun(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<Tgoods> goodsList = new ArrayList<Tgoods>();
		String sql = "select * from t_goods where del='no' order by kucun";
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tgoods goods = new Tgoods();

				goods.setId(rs.getInt("id"));
				goods.setCatelog_id(rs.getInt("catelog_id"));
				goods.setBianhao(rs.getString("bianhao"));
				goods.setMingcheng(rs.getString("mingcheng"));
				goods.setJieshao(rs.getString("jieshao"));
				goods.setPinpai(rs.getString("pinpai"));
				goods.setFujian(rs.getString("fujian"));

				goods.setJiage(rs.getInt("jiage"));
				goods.setKucun(rs.getInt("kucun"));
				goods.setDel(rs.getString("del"));

				goodsList.add(goods);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("goodsList", goodsList);
		req.getRequestDispatcher("admin/goods/goodsKucun.jsp")
				.forward(req, res);
	}

	/**
	 * 商品列表查询,后台使用
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void goodsMana(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<Tgoods> goodsList = new ArrayList<Tgoods>();
		String sql = "select * from t_goods where del='no' order by id";
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tgoods goods = new Tgoods();

				goods.setId(rs.getInt("id"));
				goods.setCatelog_id(rs.getInt("catelog_id"));
				goods.setBianhao(rs.getString("bianhao"));

				goods.setMingcheng(rs.getString("mingcheng"));
				goods.setJieshao(rs.getString("jieshao"));
				goods.setPinpai(rs.getString("pinpai"));
				goods.setFujian(rs.getString("fujian"));

				goods.setJiage(rs.getInt("jiage"));
				goods.setKucun(rs.getInt("kucun"));
				goods.setDel(rs.getString("del"));

				goodsList.add(goods);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("goodsList", goodsList);
		req.getRequestDispatcher("admin/goods/goodsMana.jsp").forward(req, res);
	}
	
	
	/**
	 * 商品列表查询,前台使用
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void goodsManaQian(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<Tgoods> goodsList = new ArrayList<Tgoods>();
		String sql = "select * from t_goods where del='no' order by id";
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Tgoods goods = new Tgoods();

				goods.setId(rs.getInt("id"));
				goods.setCatelog_id(rs.getInt("catelog_id"));
				goods.setBianhao(rs.getString("bianhao"));

				goods.setMingcheng(rs.getString("mingcheng"));
				goods.setJieshao(rs.getString("jieshao"));
				goods.setPinpai(rs.getString("pinpai"));
				goods.setFujian(rs.getString("fujian"));

				goods.setJiage(rs.getInt("jiage"));
				goods.setKucun(rs.getInt("kucun"));
				goods.setDel(rs.getString("del"));

				goodsList.add(goods);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("goodsList", goodsList);
		req.getRequestDispatcher("qiantai/goods/goodsList.jsp").forward(req, res);
	}

	/**
	 * 商品详细信息,后台使用
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void goodsDetailHou(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));

		req.setAttribute("goods", ShopService.getGoods(id));
		req.getRequestDispatcher("admin/goods/goodsDetailHou.jsp").forward(req,
				res);
	}

	
	/**
	 * 商品根据类别查询,前台使用
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void goodsByCatelog(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		int catelog_id = Integer.parseInt(req.getParameter("catelog_id"));

		req.setAttribute("goodsList", ShopService.goodsByCatelog(catelog_id));
		req.getRequestDispatcher("qiantai/goods/goodsByCatelog.jsp").forward(
				req, res);
	}

	/**
	 * 根据关键字查询商品信�?
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void goodsByKey(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String key = req.getParameter("key");

		req.setAttribute("goodsList", ShopService.goodsByKey(key));
		req.getRequestDispatcher("qiantai/goods/goodsByCatelog.jsp").forward(
				req, res);
	}

	/**
	 * 商品详细信息,前台使用
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void goodsDetailQian(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));

		Tgoods goods = ShopService.getGoods(id);
		List<Tgoods> goodsList = ShopService.goodsByCatelog(goods
				.getCatelog_id());

		List<Tgoods> newList = new ArrayList<Tgoods>();
		if (goodsList != null && goodsList.size() > 0) {
			for (Tgoods tg : goodsList) {
				if (tg.getId() != goods.getId()) {
					newList.add(tg);
				}

			}
		}

		req.setAttribute("goodsList", newList);
		req.setAttribute("goods", goods);
		req.setAttribute("ping", ShopService.pingList(id));
		req.getRequestDispatcher("qiantai/goods/goodsDetailQian.jsp").forward(
				req, res);
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
