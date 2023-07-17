<%@ include file="db_conn.jsp"%>

<%! String home = "http://localhost:8080/Spacebook/";%>

<%
	String action = request.getParameter("action");
// LOGIN	
	
	if(action.equals("login")){
		String u_email = request.getParameter("uemail");
		String u_pswd = request.getParameter("upswd");
	
		try{
			PreparedStatement pstmt = con.prepareStatement("SELECT * FROM user WHERE u_email=? AND u_pswd=?");
			pstmt.setString(1, u_email);
			pstmt.setString(2, u_pswd);	
			
			ResultSet rs= pstmt.executeQuery();
			
			if(rs.next()){
				// ACCOUNT IS DEACTIVATED
				if(rs.getString("u_sts").equals("0")){					
					response.setContentType("text/plain");
					response.getWriter().write("0");
				}
				// ACCOUNT IS BANNED
				else if(rs.getString("u_sts").equals("2")){	
					Timestamp ban_timestamp = Timestamp.valueOf(rs.getString("u_banfor"));	
					Timestamp cur_timestamp = new Timestamp(System.currentTimeMillis());
					
					if(cur_timestamp.compareTo(ban_timestamp) >= 0){
						PreparedStatement pstmt2 = con.prepareStatement("UPDATE user SET u_sts = 1 WHERE u_email=? AND u_pswd=?");
						pstmt2.setString(1, u_email);
						pstmt2.setString(2, u_pswd);	
						
						if(pstmt2.executeUpdate() > 0){					
							session.setAttribute("home", home);
							session.setAttribute("u_id", rs.getString("u_id"));
							session.setAttribute("u_name", rs.getString("u_name"));				
							session.setAttribute("u_img", rs.getString("u_img"));
							response.setContentType("text/plain");
							response.getWriter().write("1");
						}
					}else{
						response.setContentType("text/plain");
						response.getWriter().write(rs.getString("u_banfor"));
					}
				}
				else{
					session.setAttribute("home", home);
					session.setAttribute("u_id", rs.getString("u_id"));
					session.setAttribute("u_name", rs.getString("u_name"));				
					session.setAttribute("u_img", rs.getString("u_img"));
					response.setContentType("text/plain");
					response.getWriter().write("1");
				}
				
				
			}else{
				response.setContentType("text/plain");
				response.getWriter().write("9");
			}
			con.close();
		}
		catch(Exception e){
			System.out.println(e);
			response.setContentType("text/plain");
			response.getWriter().write("9");
			response.sendRedirect(home +"login.jsp");
		}
	}

// LOGOUT
	else if(action.equals("logout")){
		session.invalidate();
		response.sendRedirect(home +"login.jsp");
	}

// RECOVER ACCOUNT
	else if(action.equals("recoveruser")){
		
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("UPDATE user SET u_sts = 1 WHERE u_email = ?;");
			pstmt.setString(1, request.getParameter("uemail"));
			
			if(pstmt.executeUpdate() > 0){
				response.setContentType("text/plain");
				response.getWriter().write("1");
			}
		}catch(Exception e){
			System.out.print(e);
		}
	}
%>