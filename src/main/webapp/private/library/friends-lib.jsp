<%@ include file="db_conn.jsp"%>
<%
	String action = request.getParameter("action");
//SEND FOLLOW REQUEST

	if(action.equals("sndflwrqst")){
		String pid = request.getParameter("pid");
		
		try{
			PreparedStatement pstmt = con.prepareStatement("INSERT INTO follows (u1_id, u2_id, f_sts) VALUES (?, ?, '0')");
			pstmt.setString(1, session.getAttribute("u_id").toString());
			pstmt.setString(2, pid);
			
			if(pstmt.executeUpdate() > 0){		
				response.setContentType("text/plain");
				response.getWriter().write("1");
			}
			
		}catch(Exception e){
			System.out.print(e);
		}
	}
	
//ACCEPT FOLLOW REQUEST

else if(action.equals("acptrqst")){
		String pid = request.getParameter("pid");
		
		try{
			PreparedStatement pstmt = con.prepareStatement("UPDATE follows SET f_sts = 1 WHERE u1_id = ? AND u2_id = ?;");
			pstmt.setString(1, pid);
			pstmt.setString(2, session.getAttribute("u_id").toString());
			
			if(pstmt.executeUpdate() > 0){		
				response.setContentType("text/plain");
				response.getWriter().write("1");
			}
			
		}catch(Exception e){
			System.out.print(e);
		}
	}

	//REMOVE FOLLOWER

	else if(action.equals("rmvflwr")){
			String pid = request.getParameter("pid");
			
			try{
				PreparedStatement pstmt = con.prepareStatement("DELETE FROM follows WHERE u1_id = ? AND u2_id = ?;");
				pstmt.setString(1, pid);
				pstmt.setString(2, session.getAttribute("u_id").toString());
				
				if(pstmt.executeUpdate() > 0){		
					response.setContentType("text/plain");
					response.getWriter().write("1");
				}
				
			}catch(Exception e){
				System.out.print(e);
			}
		}


//UNFOLLOW

		else if(action.equals("unflw")){
			String pid = request.getParameter("pid");
			
			try{
				PreparedStatement pstmt = con.prepareStatement("DELETE FROM follows WHERE u1_id = ? AND u2_id = ?");
				pstmt.setString(1, session.getAttribute("u_id").toString());
				pstmt.setString(2, pid);
				
				if(pstmt.executeUpdate() > 0){		
					response.setContentType("text/plain");
					response.getWriter().write("1");
				}
				
			}catch(Exception e){
				System.out.print(e);
			}
		}

%>