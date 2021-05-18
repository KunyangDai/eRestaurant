<%
  session.removeAttribute("admin");
  response.sendRedirect(request.getContextPath() + "/login.jsp");
%>