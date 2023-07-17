<%@ include file="db_conn.jsp"%>

<%
	String action = request.getParameter("action");

	if(action.equals("fetchuserdet")){
		
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("SELECT * FROM user WHERE u_id = ?;");
			
			pstmt.setString(1, session.getAttribute("u_id").toString());
						
			ResultSet rs= pstmt.executeQuery();
			String result = "";			
			rs.next();
			
			result += "<form id='form-userupdate' name='frm_userupdate' action='private/library/signup.jsp' enctype='multipart/form-data'  method='POST'  onsubmit='return validateSignupForm()'>";
			result += "<div class='text-center mb-3'> <img src='"+session.getAttribute("home").toString()+"img/"+rs.getString("u_img")+"' alt='user-image' class='user-image mb-3' height='100px' width='100px' id='uimg_prvw'> <input type='file' class='form-control' name='ip_uimg' id='ip_uimg' accept='image/*'> <small class='form-label'>Add image (maximum image size: 100KB)</small> </div> ";
			
			result += "<input type='hidden' name='uid' value='"+ session.getAttribute("u_id").toString() +"'>";
			
			result += "<label class='form-label'>Name</label><input type='text' class='form-control' name='ip_uname' value='"+rs.getString("u_name")+"'/>";
			result += "<label class='form-label'>Password</label><input type='password' class='form-control mb-3' name='ip_upswd'value='"+rs.getString("u_pswd")+"'/>";
			result += "<label class='form-label'>Date of birth</label> <input type='date' class='form-control mb-3' name='ip_udob'value='"+rs.getString("u_dob")+"'/>";
			
			if(rs.getString("u_gender").equals("Male") || rs.getString("u_gender").equals("male")){
				result += "<label class='form-label'>Gender</label> <div class='form-control mb-3 d-flex justify-content-evenly'> <input class='form-check-input' type='radio' value='Male' name='ip_ugender'checked /> <label class='form-check-label'>Male</label> <input class='form-check-input' type='radio' value='Female' name='ip_gender'/> <label class='form-check-label'>Female</label> <input class='form-check-input' type='radio' value='Others' name='ip_gender'/> <label class='form-check-label'>Others</label> </div>";
			}else if(rs.getString("u_gender").equals("Female") || rs.getString("u_gender").equals("female")){
				result += "<label class='form-label'>Gender</label> <div class='form-control mb-3 d-flex justify-content-evenly'> <input class='form-check-input' type='radio' value='Male' name='ip_ugender'/> <label class='form-check-label'>Male</label> <input class='form-check-input' type='radio' value='Female' name='ip_gender'checked/> <label class='form-check-label'>Female</label> <input class='form-check-input' type='radio' value='Others' name='ip_gender'/> <label class='form-check-label'>Others</label> </div>";
			}else{
				result += "<label class='form-label'>Gender</label> <div class='form-control mb-3 d-flex justify-content-evenly'> <input class='form-check-input' type='radio' value='Male' name='ip_ugender'/> <label class='form-check-label'>Male</label> <input class='form-check-input' type='radio' value='Female' name='ip_gender'/> <label class='form-check-label'>Female</label> <input class='form-check-input' type='radio' value='Others' name='ip_gender' checked/> <label class='form-check-label'>Others</label> </div>";
			}
			result += "<div class=d-grid gap-2 col-5 mx-auto>  <button  type='submit' class='btn btn-warning'>Update</button> </div> </form>";
			
			
				
			response.setContentType("text/html");  
			response.getWriter().write(result);
		}catch(Exception e){
			System.out.print(e);
		}
	}
	
	
	
	else if(action.equals("updateu")){
		
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("UPDATE user SET u_name = ?, u_email = ?, u_img = ?, u_dob = ?, u_gender = ?, u_pswd = ? WHERE u_id = ?;");
			
			pstmt.setString(1, request.getParameter("ip_uname"));
			pstmt.setString(2, request.getParameter("ip_email"));
			pstmt.setString(3, "d00000.jpg");
			pstmt.setString(4, request.getParameter("ip_dob"));
			pstmt.setString(5, request.getParameter("ip_gender"));
			pstmt.setString(6, request.getParameter("ip_pswd"));
			pstmt.setString(7, session.getAttribute("u_id").toString());
			
			System.out.print(pstmt);
			
			if(pstmt.executeUpdate() > 0){
				session.setAttribute("u_id", request.getParameter("ip_uname"));
				response.setContentType("text/plain");
				response.getWriter().write("1");
			}
		}catch(Exception e){
			System.out.print(e);
		}
	}

	// DELETE USER
	
	else if(action.equals("deleteuser")){
			
			PreparedStatement pstmt = null;
			try{
				pstmt = con.prepareStatement("UPDATE user SET u_sts = 0 WHERE u_id = ?;");
				pstmt.setString(1, session.getAttribute("u_id").toString());
				
				if(pstmt.executeUpdate() > 0){
					session.invalidate();				
					response.setContentType("text/plain");
					response.getWriter().write("1");
				}
			}catch(Exception e){
				System.out.print(e);
			}
	}
%>