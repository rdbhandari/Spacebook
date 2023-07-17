<%@ include file="db_conn.jsp"%>

<%
	String action = request.getParameter("action");

// READ MY POST

	if(action.equals("readmypost")){
	Integer start = Integer.parseInt(request.getParameter("start"));
	
	PreparedStatement pstmt = null;
	try{
		pstmt = con.prepareStatement("SELECT user.u_id, u_name, u_img, p_id, p_desc, p_img, p_time FROM post LEFT JOIN user ON post.u_id = user.u_id WHERE user.u_id = ? ORDER BY p_time DESC LIMIT ?, 5");
		
		pstmt.setString(1, session.getAttribute("u_id").toString());
		pstmt.setInt(2, start);
					
		ResultSet rs= pstmt.executeQuery();
		String result = "";
		
		while(rs.next()){
			result += "<div class='card border-light' id='p-"+rs.getString("p_id")+"'>";

			// EDIT DELETE
			result += "<div class='d-block text-end'> <button type='submit' class='btn btn-sm' onclick='deletepost("+rs.getString("p_id")+")'> <img src='img/icon/bin.svg' alt='delete' height='15px' width='15px'> </button> <button type='button' class='btn btn-sm' onclick='editpost("+rs.getString("p_id")+")'> <img src='img/icon/edit.svg' alt='edit' height='15px' width='15px'> </button></div>";

			result +="<div class='d-flex'><a href='"+session.getAttribute("home").toString()+"profile.jsp?id="+rs.getString("u_id")+"'>";

			// USER IMAGE
			result += "<img src='"+session.getAttribute("home").toString()+"img/"+rs.getString("u_img")+"' alt='user-image' class='user-image' height='35px' width='35px'></a>";
			            
			// NAME OF USER, POST DESC
			result +="<div class='mx-2'><h5 class='card-title lh-1'>"+rs.getString("u_name")+"</h5><p class='card-text lh-1'><small class='text-muted'>"+rs.getString("p_time")+"</small></p></div></div><p class='card-body lh-1 d-block' id='p-desc-"+rs.getString("p_id")+"'>"+rs.getString("p_desc")+"</p>";

			// POST IMAGE
			if(rs.getString("p_img") != null){
			    result +="<img src='"+session.getAttribute("home").toString()+"img/"+rs.getString("p_img")+"' class='card-img-bottom' alt='post image' height='350px' id='p-img-"+rs.getString("p_id")+"'>";
			}

			result += "<div class='d-flex justify-content-around mt-1'><button type='button' id='btn-like-"+rs.getString("p_id")+"' data-pid='"+rs.getString("p_id")+"' onclick='like(this.id)' class='btn btn-sm shadow-none' ";

			// LIKE BUTTON
			PreparedStatement pstmt_like = con.prepareStatement("SELECT COUNT(*) as count FROM likes WHERE p_id=? AND u_id=?;");
			pstmt_like.setString(1, rs.getString("p_id"));
			pstmt_like.setString(2, session.getAttribute("u_id").toString());
			
			ResultSet rs1= pstmt_like.executeQuery();
			rs1.next();
			
			if(rs1.getString("count").equals("1")){
			    result += "data-sts='liked'><img src='img/icon/liked.svg' alt='liked'";
			}else{
			    result += "data-sts='like'><img src='img/icon/like.svg' alt='like'";
			}
			
			result += "height='30px' width='30px'> Like</button><button type='button' class='btn btn-sm shadow-none' data-bs-toggle='collapse' data-bs-target='#cmnt-div-"+rs.getString("p_id")+"'aria-expanded='false' aria-controls='cmnt-div-"+rs.getString("p_id")+"'><img src='img/icon/comment.svg' alt='comment' height='25px' width='25px'>&nbsp;Comment</button></div>";

			result += "<div class='collapse' id='cmnt-div-"+rs.getString("p_id")+"'><div class='card card-body my-1'>";
			    
			// COMMMENTS            
			PreparedStatement pstmt_comment = con.prepareStatement("SELECT user.u_id, u_name, u_img, c_id, c_desc, c_time FROM comments LEFT JOIN user ON comments.u_id = user.u_id WHERE p_id=?");
			pstmt_comment.setString(1, rs.getString("p_id"));
			ResultSet rs2 = pstmt_comment.executeQuery();

			while(rs2.next()){
				
			    result += "<div class='m-1'><a href='"+session.getAttribute("home").toString()+"profile.jsp?id="+rs2.getString("u_id")+"'><img src='"+session.getAttribute("home")+"img/"+rs2.getString("u_img")+"' alt='user-image' class='user-image' height='30px' width='30px'><b>&nbsp;"+rs2.getString("u_name")+ "<small class='text-muted'>[" +rs2.getString("c_time")+ "]</small>:&nbsp;</b></a><div id='cmnt-"+rs2.getString("c_id")+"'>" + rs2.getString("c_desc") + "</div>";
			    
			    // COMMENT EDIT, DELETE
			    if(session.getAttribute("u_id").toString().equals(rs2.getString("u_id"))){
				    result += "<div class='d-block text-end'> <button type='submit' class='btn btn-sm shadow-none' onclick='deletecomment("+rs2.getString("c_id")+")'>Delete</button> <button type='submit' class='btn btn-sm shadow-none' onclick='editcomment("+rs.getString("p_id")+","+rs2.getString("c_id")+")'>Edit</button></div>";
				}	
			    result += "</div>";
			}
			result += "<textarea class='form-control mb-2' id='cmnt-ip-"+rs.getString("p_id")+"' data-cid='' placeholder='Write your comment here...' name='cdesc'></textarea><button type='button' class='btn btn-primary btn-sm shadow-none' onclick='addcomment("+rs.getString("p_id")+")'>Comment</button></div> </div></div><hr>";
		}
		
		response.setContentType("text/html");  
		response.getWriter().write(result);
	}catch(Exception e){
		System.out.print(e);
	}
}

// EDIT MY POST

else if(action.equals("editpost")){
	Integer start = Integer.parseInt(request.getParameter("start"));
	
	PreparedStatement pstmt = null;
	try{
		pstmt = con.prepareStatement("SELECT user.u_id, u_name, u_img, p_id, p_desc, p_img, p_time FROM post LEFT JOIN user ON post.u_id = user.u_id WHERE user.u_id = ? ORDER BY p_time DESC LIMIT ?, 5");
		
		pstmt.setString(1, session.getAttribute("u_id").toString());
		pstmt.setInt(2, start);
					
		ResultSet rs= pstmt.executeQuery();
		String result = "";
		
		while(rs.next()){
			result += "<div class='card border-light' id='p-"+rs.getString("p_id")+"'>";

			
		}
		response.setContentType("text/html");  
		response.getWriter().write(result);
	}catch(Exception e){
		System.out.print(e);
	}
}

// DELETE MY POST

else if(action.equals("deletepost")){
	PreparedStatement pstmt = null; 
	try{
		pstmt = con.prepareStatement("DELETE FROM post WHERE p_id = ?;");
		pstmt.setString(1, request.getParameter("pid"));		
		if(pstmt.executeUpdate() > 0){
			response.setContentType("text/plain");
			response.getWriter().write("1");
		}									
	}catch(Exception e){
		System.out.print(e);
	}
}







%>