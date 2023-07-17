<%! String home_a = "http://localhost:8080/Spacebook/admin/";%>
<%
	String action = request.getParameter("action");
	
	if(action.equals("login")){
		String a_email = request.getParameter("a_email");
		String a_pswd = request.getParameter("a_pswd");
		
		if (a_email.equals("admin@spacebook.com") && a_pswd.equals("admin")){
			
			session.setAttribute("sts", "1");
			session.setAttribute("home_a", home_a);
			session.setAttribute("home", "http://localhost:8080/Spacebook/");
			response.sendRedirect((String)session.getAttribute("home_a"));
		}else{
			response.sendRedirect(home_a+"login-a.jsp");
		}
	}
	else if(action.equals("logout")){
		session.invalidate();
		response.sendRedirect(home_a +"login-a.jsp");
	}
%>