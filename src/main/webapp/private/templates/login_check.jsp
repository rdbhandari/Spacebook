<%
	if (session.getAttribute("u_id") == null) {
		response.sendRedirect("/Spacebook/login.jsp");
		
		return;
	}
%>
