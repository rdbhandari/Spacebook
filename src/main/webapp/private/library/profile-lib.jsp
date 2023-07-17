<%@ include file="db_conn.jsp"%>
<%
	String action = request.getParameter("action");

//FETCH USER NAME

	if(action.equals("readname")){
		String p_id = request.getParameter("p_id");
		//System.out.println(" pid: "+p_id+"");
		
		try{
			PreparedStatement pstmt = null;
			pstmt = con.prepareStatement("SELECT u_name FROM user WHERE u_id=?");
			pstmt.setString(1, p_id);
			
			ResultSet rs= pstmt.executeQuery();
			rs.next();
			
			response.setContentType("text/html");
			response.getWriter().write(rs.getString("u_name"));
			
		}catch(Exception e){
			System.out.print(e);
		}
	}

// FOLLOW USER
	
	else if(action.equals("follow")){
		String p_id = request.getParameter("p_id");
		String sts = request.getParameter("sts");
		
		// FOLLOW USER
		if(sts.equals("follow")){
			try{
				PreparedStatement pstmt = con.prepareStatement("INSERT INTO follows (u1_id, u2_id, f_sts) VALUES (?, ?, '0');");
				pstmt.setString(1, session.getAttribute("u_id").toString());
				pstmt.setString(2, p_id);

				if(pstmt.executeUpdate() > 0){		
					response.setContentType("text/plain");
					response.getWriter().write("1");
				}
			}catch(Exception e){
				System.out.print(e);
			}
		}
		
		// BLOCK USER
		else if(sts.equals("block")){
			try{
				PreparedStatement pstmt = con.prepareStatement("INSERT INTO follows (u1_id, u2_id, f_sts) VALUES (?, ?, '2');");
				pstmt.setString(1, session.getAttribute("u_id").toString());
				pstmt.setString(2, p_id);

				if(pstmt.executeUpdate() > 0){		
					response.setContentType("text/plain");
					response.getWriter().write("1");
				}
			}catch(Exception e){
				System.out.print(e);
			}
		}
		
		
		else if(sts.equals("delrelation")){
			try{
				PreparedStatement pstmt = con.prepareStatement("DELETE FROM follows WHERE u1_id = ? AND u2_id = ?;");
				pstmt.setString(1, session.getAttribute("u_id").toString());
				pstmt.setString(2, p_id);
				
				if(pstmt.executeUpdate() > 0){		
					response.setContentType("text/plain");
					response.getWriter().write("1");
				}
			}catch(Exception e){
				System.out.print(e);
			}
		}
	}

%>