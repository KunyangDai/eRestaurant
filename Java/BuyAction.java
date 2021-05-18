package com.cn.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cn.orm.Tgoods;
import com.cn.orm.Torder;
import com.cn.orm.TorderItem;
import com.cn.orm.TpingItem;
import com.cn.orm.Tuser;
import com.cn.service.ShopService;
import com.cn.util.Cart;

/**
 * 购买操作Action
 */
public class BuyAction extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Action调用控制�?
	 */
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		// 请求类型
		String type = req.getParameter("type");

		if (type.endsWith("addToCart")) {
			// 添加商品到购物车
			addToCart(req, res);
		}
		if (type.endsWith("orderSubmit")) {
			// 提交订单
			orderSubmit(req, res);
		}
		if (type.endsWith("myorder")) {
			// 查看我的订单
			myorder(req, res);
		}
		if (type.endsWith("orderDetail")) {
			// 订单明细
			orderDetail(req, res);
		}
		if (type.endsWith("orderBankSubmit")) {
			// 银行订单提交
			orderBankSubmit(req, res);
		}
		if (type.endsWith("orderPing")) {
			// 评价订单
			orderPing(req, res);
		}
		if (type.endsWith("orderReply")) {
			// 评价回复
			orderReply(req, res);
		}
		if (type.endsWith("orderDetailQian")) {
			// 前台订单明细
			orderDetailQian(req, res);
		}
		if (type.endsWith("orderDetailHou")) {
			// 后台订单明细
			orderDetailHou(req, res);
		}
	}

	/**
	 * 银行付款
	 * 
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void orderBankSubmit(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		// 获取订单信息
		String songhuodizhi = (String) session.getAttribute("songhuodizhi");
		String fukuanfangshi = "银行付款";

		Cart cart = (Cart) session.getAttribute("cart");
		Tuser user = (Tuser) session.getAttribute("user");

		Torder order = new Torder();
		order.setId(String.valueOf(new Date().getTime()));
		order.setBianhao(new SimpleDateFormat("yyyyMMddhhmmss")
				.format(new Date()));
		order.setShijian(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")
				.format(new Date()));
		order.setZhuangtai("no");
		order.setSonghuodizhi(songhuodizhi);
		order.setFukuanfangshi(fukuanfangshi);
		order.setJine(cart.getTotalPrice());
		order.setUser_id(user.getId());

		// 保存订单
		ShopService.saveOrder(order);

		// 获得订单明细
		for (Iterator<TorderItem> it = cart.getItems().values().iterator(); it.hasNext();) {

			TorderItem orderItem = it.next();

			String id = String.valueOf(new Date().getTime());
			String order_id = order.getId();
			int goods_id = orderItem.getGoods().getId();
			int goods_quantity = orderItem.getGoods_quantity();
			// 保存订单明细
			ShopService.saveOrderItem(id, order_id, goods_id, goods_quantity);
			// 保存商品库存
			ShopService.updateGoodsKucun(goods_id, goods_quantity);
		}

		// 重新初始化购物车
		cart.getItems().clear();
		session.setAttribute("cart", cart);

		req.setAttribute("order", order);
		req.getRequestDispatcher("qiantai/order/orderSubmit.jsp").forward(req,
				res);

	}

	/**
	 * 添加商品到购物车
	 * 
	 * @param req
	 * @param res
	 */
	public void addToCart(HttpServletRequest req, HttpServletResponse res) {
		// 活动商品信息
		int goods_id = Integer.parseInt(req.getParameter("goods_id"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		Tgoods goods = ShopService.getGoods(goods_id);

		TorderItem orderItem = new TorderItem();
		orderItem.setGoods(goods);
		orderItem.setGoods_quantity(quantity);

		HttpSession session = req.getSession();
		// 添加到购物车
		Cart cart = (Cart) session.getAttribute("cart");
		cart.addGoods(goods_id, orderItem);
		session.setAttribute("cart", cart);

		// 跳转到购物车页面
		req.setAttribute("message", "");
		req.setAttribute("path", "qiantai/cart/mycart.jsp");

		String targetURL = "/common/success.jsp";
		dispatch(targetURL, req, res);

	}

	/**
	 * 提交订单
	 * 
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void orderSubmit(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// 获取订单参数
		String songhuodizhi = req.getParameter("songhuodizhi");
		String fukuanfangshi = req.getParameter("fukuanfangshi");
		HttpSession session = req.getSession();

		// 根据不同的付款方式跳转到不同的处理页�?
		if (fukuanfangshi.equals("银行付款")) {
			session.setAttribute("songhuodizhi", songhuodizhi);
			Cart cart = (Cart) session.getAttribute("cart");
			req.setAttribute("jine", cart.getTotalPrice());
			req.getRequestDispatcher("qiantai/order/orderBank.jsp").forward(
					req, res);

		} else {

			Cart cart = (Cart) session.getAttribute("cart");
			Tuser user = (Tuser) session.getAttribute("user");

			Torder order = new Torder();
			order.setId(String.valueOf(new Date().getTime()));
			order.setBianhao(new SimpleDateFormat("yyyyMMddhhmmss")
					.format(new Date()));
			order.setShijian(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")
					.format(new Date()));
			order.setZhuangtai("no");
			order.setSonghuodizhi(songhuodizhi);
			order.setFukuanfangshi(fukuanfangshi);
			order.setJine(cart.getTotalPrice());
			order.setUser_id(user.getId());
			ShopService.saveOrder(order);

			for (Iterator<TorderItem> it = cart.getItems().values().iterator(); it
					.hasNext();) {

				TorderItem orderItem = it.next();

				String id = String.valueOf(new Date().getTime());
				String order_id = order.getId();
				int goods_id = orderItem.getGoods().getId();
				int goods_quantity = orderItem.getGoods_quantity();
				ShopService.saveOrderItem(id, order_id, goods_id,
						goods_quantity);

				ShopService.updateGoodsKucun(goods_id, goods_quantity);
			}

			cart.getItems().clear();
			session.setAttribute("cart", cart);

			req.setAttribute("order", order);
			req.getRequestDispatcher("qiantai/order/orderSubmit.jsp").forward(
					req, res);
		}
	}

	/**
	 * 订单信息
	 * 
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void myorder(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		Tuser user = (Tuser) session.getAttribute("user");

		String name = req.getParameter("name");
		// 查询订单信息并保存到request�?
		req
				.setAttribute("orderList", ShopService.orderList(user.getId(),
						name));
		req.getRequestDispatcher("qiantai/order/myorder.jsp").forward(req, res);

	}

	/**
	 * 订单明细
	 * 
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void orderDetail(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String order_id = req.getParameter("order_id");
		req.setAttribute("orderItemList", ShopService.orderItemList(order_id));
		req.getRequestDispatcher("qiantai/order/orderDetail.jsp").forward(req,
				res);

	}

	/**
	 * 订单明细,网站前台使用
	 * 
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void orderDetailQian(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String order_id = req.getParameter("order_id");
		req.setAttribute("orderItemList", ShopService.orderItemList(order_id));
		req.getRequestDispatcher("qiantai/order/orderDetailQian.jsp").forward(
				req, res);

	}

	/**
	 * 订单明细,网站后台使用
	 * 
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void orderDetailHou(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String order_id = req.getParameter("order_id");
		req.setAttribute("orderItemList", ShopService.orderItemList(order_id));
		req.getRequestDispatcher("qiantai/order/orderDetailHou.jsp").forward(
				req, res);

	}

	/**
	 * 订单评价
	 * 
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void orderPing(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String order_id = req.getParameter("order_id");
		List<TorderItem> list = ShopService.orderItemList(order_id);
		String itemid = "";
		for (TorderItem ti : list) {
			itemid = itemid + ":" + ti.getId();
		}
		req.setAttribute("orderItemList", ShopService.orderItemList(order_id));
		req.setAttribute("order_id", order_id);
		req.setAttribute("itemid", itemid);
		req.getRequestDispatcher("qiantai/order/orderPing.jsp").forward(req,
				res);

	}

	/**
	 * 订单评价回复
	 * 
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	public void orderReply(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		String order_id = req.getParameter("order_id");
		List<TpingItem> list = ShopService.pingItemList(order_id);
		String pingid = "";
		for (TpingItem ti : list) {
			pingid = pingid + ":" + ti.getId();
		}
		req.setAttribute("pingItemList", list);
		req.setAttribute("order_id", order_id);
		req.setAttribute("pingid", pingid);
		req.getRequestDispatcher("qiantai/order/orderReply.jsp").forward(req,
				res);

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
