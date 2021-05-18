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
import com.cn.orm.Tgonggao;
import com.cn.service.ShopService;

/**
 * 网站首页操作Action
 */
public class IndexAction extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Action调用控制�?
	 */
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		//�?新商�?
		req.setAttribute("goodsList", ShopService.goodsNew());
		//热销商品
		req.setAttribute("paihangList", ShopService.goodsPaihang4());
		//商品类别
		req.getSession().setAttribute("catelogList", ShopService.catelogList());

		//新闻公告信息
		List<Tgonggao> gonggaoList = new ArrayList<Tgonggao>();
		String sql = "select * from t_gonggao order by id desc";
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
		if (gonggaoList.size() > 5) {
			gonggaoList = gonggaoList.subList(0, 5);
		}
		req.getSession().setAttribute("gonggaoList", gonggaoList);

		req.getRequestDispatcher("qiantai/index.jsp").forward(req, res);
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
