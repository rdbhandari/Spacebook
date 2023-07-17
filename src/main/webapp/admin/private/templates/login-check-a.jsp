<%
	if (session.getAttribute("sts") == null) {
		//System.out.print("NOT LOGGED IN");
		response.sendRedirect("/Spacebook/admin/login-a.jsp");
		return;
	}
%>