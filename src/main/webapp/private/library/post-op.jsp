<%@ include file="db_conn.jsp"%>

<%
	String action = request.getParameter("action");

// ADD POST

   if(action.equals("addpost")){
	   PreparedStatement pstmt = null;
			try{
				
				if(request.getParameter("pid") == null){
					pstmt = con.prepareStatement("INSERT INTO post(p_desc, p_img, u_id) VALUES (?,?,?)");
					pstmt.setString(1, request.getParameter("pdesc"));
					pstmt.setString(2, null);
					pstmt.setString(3, session.getAttribute("u_id").toString());
				}else{					
					pstmt = con.prepareStatement("UPDATE post SET p_desc = ?, p_img = ? WHERE p_id = ?;");
					pstmt.setString(1, request.getParameter("pdesc"));
					pstmt.setString(2, null);
					pstmt.setString(3, request.getParameter("pid"));
				}			
				if(pstmt.executeUpdate() > 0){	
					response.setContentType("text/plain");
					response.getWriter().write("1");
				}				
			}catch(Exception e){
				System.out.print(e);
			}
	}
   
   
// LIKE IN POST
   
   else if(action.equals("like")){ 
		String sts = request.getParameter("sts");
		
		if(sts.equals("liked")){
	
			PreparedStatement pstmt = null;
			try{
				pstmt = con.prepareStatement("DELETE FROM likes WHERE p_id = ? AND u_id = ?;");
				pstmt.setString(1, request.getParameter("pid"));
				pstmt.setString(2, session.getAttribute("u_id").toString());				
				
				if(pstmt.executeUpdate() > 0){
					response.setContentType("text/plain");
					response.getWriter().write("like");
				}				
			}catch(Exception e){
				System.out.print(e);
			}
		}else if(sts.equals("like")){
			
			PreparedStatement pstmt = null;
			try{
				pstmt = con.prepareStatement("INSERT INTO likes (p_id, u_id) VALUES (?, ?);");
				pstmt.setString(1, request.getParameter("pid"));
				pstmt.setString(2, session.getAttribute("u_id").toString());
				
				if(pstmt.executeUpdate() > 0){	
					response.setContentType("text/plain");
					response.getWriter().write("liked");
				}
				
			}catch(Exception e){
				System.out.print(e);
			}
		}
		
	}
   
// ADD OR UPDATE COMMENT

   else if(action.equals("addcomment")){
	   PreparedStatement pstmt = null;
			try{
				if(request.getParameter("cid") == null){
					pstmt = con.prepareStatement("INSERT INTO comments (p_id, u_id, c_desc) VALUES (?, ?, ?);");
					pstmt.setString(1, request.getParameter("pid"));
					pstmt.setString(2, session.getAttribute("u_id").toString());
					pstmt.setString(3, request.getParameter("cdesc"));
				}else{
					pstmt = con.prepareStatement("UPDATE comments SET c_desc = ? WHERE c_id = ?;");
					pstmt.setString(1, request.getParameter("cdesc"));
					pstmt.setString(2, request.getParameter("cid"));
				}
				
				if(pstmt.executeUpdate() > 0){
					response.setContentType("text/plain");
					response.getWriter().write("1");
				}				
			}catch(Exception e){
				System.out.print(e);
			}
	}
   
// DELETE COMMENT
   
   else if(action.equals("deletecomment")){
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("DELETE FROM comments WHERE c_id = ?;");
			pstmt.setString(1, request.getParameter("cid"));		
			if(pstmt.executeUpdate() > 0){
				response.setContentType("text/plain");
				response.getWriter().write("1");
			}		
		}catch(Exception e){
			System.out.print(e);
		}
	}
  
//REPORT POST
   
   else if(action.equals("report")){
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("INSERT INTO reports (p_id, u_id) VALUES (?, ?);");
			pstmt.setString(1, request.getParameter("pid"));	
			pstmt.setString(2, session.getAttribute("u_id").toString());	
			
			if(pstmt.executeUpdate() > 0){
				response.setContentType("text/plain");
				response.getWriter().write("1");
			}			
		}catch(Exception e){
			System.out.print(e);
		}
	}
%>