<%@ include file="db_conn.jsp"%>

<%
	String action = request.getParameter("action");

	if(action.equals("fetchpost")){
		
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("SELECT user.u_id, u_name, u_img, p_id, p_desc, p_img, p_time FROM post LEFT JOIN user ON post.u_id = user.u_id WHERE p_id =?");
			
			pstmt.setString(1, request.getParameter("pid"));
						
			ResultSet rs= pstmt.executeQuery();
			String result = "";
			
			while(rs.next()){
				result += "<div class='card border-light' id='p-"+rs.getString("p_id")+"'>";

				result +="<div class='d-flex'><a href='"+session.getAttribute("home").toString()+"profile.jsp?id="+rs.getString("u_id")+"'>";

				// USER IMAGE
				result += "<img src='"+session.getAttribute("home").toString()+"img/"+rs.getString("u_img")+"' alt='user-image' class='user-image' height='35px' width='35px'></a>";
				            
				// NAME OF USER, POST DESC
				result +="<div class='mx-2'><h5 class='card-title lh-1'>"+rs.getString("u_name")+"</h5><p class='card-text lh-1'><small class='text-muted'>"+rs.getString("p_time")+"</small></p></div></div><p class='card-body lh-1 d-block'>"+rs.getString("p_desc")+"</p>";

				// POST IMAGE
				if(rs.getString("p_img") != null){
				    result +="<img src='"+session.getAttribute("home").toString()+"img/"+rs.getString("p_img")+"' class='card-img-bottom' alt='post image' height='350px'>";
				}
				result += "</div>";
			}
			response.setContentType("text/html");  
			response.getWriter().write(result);
		}catch(Exception e){
			System.out.print(e);
		}
	}else if(action.equals("deletepost")){
		
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("DELETE FROM post WHERE p_id = ?");
			pstmt.setString(1, request.getParameter("pid"));
			
			
			if(pstmt.executeUpdate() > 0){
				response.setContentType("text/plain");
				response.getWriter().write("1");
			}			
			con.close();			
		}catch(Exception e){
			System.out.print(e);
		}
	}else if(action.equals("ignorepost")){
		
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("DELETE FROM reports WHERE p_id = ?;");
			pstmt.setString(1, request.getParameter("pid"));
			
			
			if(pstmt.executeUpdate() > 0){
				response.setContentType("text/plain");
				response.getWriter().write("1");
			}			
			con.close();			
		}catch(Exception e){
			System.out.print(e);
		}
	}
%>