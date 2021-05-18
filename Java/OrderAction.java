package com.cn.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cn.dao.DB;
import com.cn.orm.Torder;
import com.cn.orm.Tuser;
import com.cn.util.CommonUtil;

/**
 * 订单操作Action
 */
public class OrderAction extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Action调用控制�?
	 */
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// 请求类型
		String type = req.getParameter("type");

		if (type.endsWith("orderMana")) {
			// 订单列表
			orderMana(req, res);
		}
		if (type.endsWith("orderDel")) {
			// 订单删除
			orderDel(req, res);
		}
		if (type.endsWith("orderShouli")) {
			// 订单受理
			orderShouli(req, res);
		}
		if (type.endsWith("orderZhang")) {
			// 账单信息
			orderZhang(req, res);
		}
		if (type.endsWith("orderShouhuo")) {
			// 收货
			orderShouhuo(req, res);
		}
		if (type.endsWith("orderPing")) {
			// 订单评价
			orderPing(req, res);
		}
		if (type.endsWith("orderReply")) {
			// 订单回复
			orderReply(req, res);
		}
		if (type.endsWith("orderSet")) {
			// �?�?
			orderSet(req, res);
		}

	}

	/**
	 * 订单收货
	 * 
	 * @param req
	 * @param res
	 */
	public void orderShouhuo(HttpServletRequest req, HttpServletResponse res) {
		String id = req.getParameter("id");

		String sql = "update t_order set zhuangtai='shou' where id=?";
		Object[] params = { id };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "buy?type=myorder");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	/**
	 * 订单评价
	 */
	public void orderPing(HttpServletRequest req, HttpServletResponse res) {

		String order_id = req.getParameter("order_id");
		String itemids = req.getParameter("itemid");

		Tuser user = (Tuser) req.getSession().getAttribute("user");

		String[] getId = itemids.substring(1).split(":");
		for (String itemid : getId) {

			String pings = req.getParameter("txt" + itemid);
			if (pings.trim().length() == 0) {
				pings = "好评";
			}

			String goodsid = req.getParameter("goods" + itemid);
			String goodsname = req.getParameter("goodsname" + itemid);
			String date = CommonUtil.getDate();

			// 保存评价信息
			String sql = "insert into t_ping(order_id,orderitem_id,goods_id,mingcheng,user_id,loginname,info,adddate) values('"
					+ order_id
					+ "','"
					+ itemid
					+ "',"
					+ goodsid
					+ ",'"
					+ goodsname
					+ "',"
					+ "'"
					+ user.getId()
					+ "','"
					+ user.getLoginname() + "','" + pings + "','" + date + "')";

			System.out.println(sql);
			DB mydb = new DB();
			mydb.doPstm(sql, null);
			mydb.closed();

		}

		// 更新订单状�??
		String usql = "update t_order set zhuangtai='ping' where id='"
				+ order_id + "'";
		DB mydbs = new DB();
		mydbs.doPstm(usql, null);
		mydbs.closed();

		req.setAttribute("msg", "评价成功");
		String targetURL = "/common/ping_success.jsp";
		dispatch(targetURL, req, res);

	}

	/**
	 * 订单评价回复
	 * 
	 * @param req
	 * @param res
	 */
	public void orderReply(HttpServletRequest req, HttpServletResponse res) {

		String order_id = req.getParameter("order_id");
		String pingids = req.getParameter("pingid");

		if (pingids.trim().length() > 0) {
			String[] getId = pingids.substring(1).split(":");
			for (String pingid : getId) {

				String replys = req.getParameter("txt" + pingid);
				if (replys.trim().length() > 0) {

					String date = CommonUtil.getDate();

					String sql = "update t_ping set reply='" + replys
							+ "' , replydate='" + date + "' where id=" + pingid;

					System.out.println(sql);
					DB mydb = new DB();
					mydb.doPstm(sql, null);
					mydb.closed();

				}

			}

		}
		String usql = "update t_order set zhuangtai='hui' where id='"
				+ order_id + "'";

		DB mydbs = new DB();
		mydbs.doPstm(usql, null);
		mydbs.closed();

		req.setAttribute("msg", "回复成功");
		String targetURL = "/common/reply_success.jsp";
		dispatch(targetURL, req, res);

	}

	/**
	 * 订单删除
	 * @param req
	 * @param res
	 */
	public void orderDel(HttpServletRequest req, HttpServletResponse res) {
		String id = req.getParameter("id");

		String sql = "delete from t_order where id=?";
		Object[] params = { id };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "order?type=orderMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	/**
	 * 订单列表信息,后台
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void orderMana(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<Torder> orderList = new ArrayList<Torder>();
		String sql = "select * from t_order order by zhuangtai desc";
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Torder order = new Torder();

				order.setId(rs.getString("id"));
				order.setBianhao(rs.getString("bianhao"));
				order.setShijian(rs.getString("shijian"));
				order.setZhuangtai(rs.getString("zhuangtai"));
				order.setSonghuodizhi(rs.getString("songhuodizhi"));
				order.setFukuanfangshi(rs.getString("fukuanfangshi"));
				order.setJine(rs.getInt("jine"));
				order.setUser_id(rs.getString("user_id"));

				orderList.add(order);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("orderList", orderList);
		req.getRequestDispatcher("admin/order/orderMana.jsp").forward(req, res);
	}

	/**
	 * 账单信息,后台使用
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void orderZhang(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		List<Torder> orderList = new ArrayList<Torder>();
		String sql = "select * from t_order where zhuangtai='yes' order by zhuangtai desc ";
		Object[] params = {};
		DB mydb = new DB();
		try {
			mydb.doPstm(sql, params);
			ResultSet rs = mydb.getRs();
			while (rs.next()) {
				Torder order = new Torder();

				order.setId(rs.getString("id"));
				order.setBianhao(rs.getString("bianhao"));
				order.setShijian(rs.getString("shijian"));
				order.setZhuangtai(rs.getString("zhuangtai"));
				order.setSonghuodizhi(rs.getString("songhuodizhi"));
				order.setFukuanfangshi(rs.getString("fukuanfangshi"));
				order.setJine(rs.getInt("jine"));
				order.setUser_id(rs.getString("user_id"));

				orderList.add(order);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mydb.closed();

		req.setAttribute("orderList", orderList);
		req.getRequestDispatcher("admin/order/orderZhang.jsp")
				.forward(req, res);
	}

	/**
	 * 订单受理
	 * @param req
	 * @param res
	 */
	public void orderShouli(HttpServletRequest req, HttpServletResponse res) {
		String id = req.getParameter("id");

		String sql = "update t_order set zhuangtai='yes' where id=?";
		Object[] params = { id };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		req.setAttribute("message", "操作成功");
		req.setAttribute("path", "order?type=orderMana");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);
	}

	

	/**
	 * 商品�?�?
	 * @param req
	 * @param res
	 */
	public void orderSet(HttpServletRequest req, HttpServletResponse res) {
		String itemid = req.getParameter("itemid");

		String sql = "update  t_orderitem set  goods_state='�?�?' where id=?";
		Object[] params = { itemid };
		DB mydb = new DB();
		mydb.doPstm(sql, params);
		mydb.closed();

		try {
			res.setContentType("text/html");
			PrintWriter out = res.getWriter();

			out.println("<script>alert('已提交申�?');window.close()</script>");
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

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
