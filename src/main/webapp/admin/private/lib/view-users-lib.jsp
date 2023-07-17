<%@ include file="db_conn.jsp"%>

<%
	String action = request.getParameter("action");

	if(action.equals("fetchusers")){
		String filter = request.getParameter("filter");
		
		PreparedStatement pstmt = null;
		try{
			if(filter.equals("id")){
				pstmt = con.prepareStatement("SELECT u_id, u_name, u_dob, u_gender, u_sts, u_banfor FROM user ORDER BY u_id;");
			}else if(filter.equals("nameaz")){
				pstmt = con.prepareStatement("SELECT u_id, u_name, u_dob, u_gender, u_sts, u_banfor FROM user ORDER BY u_name;");
			}else if(filter.equals("nameza")){
				pstmt = con.prepareStatement("SELECT u_id, u_name, u_dob, u_gender, u_sts, u_banfor FROM user ORDER BY u_name DESC;");
			}else if(filter.equals("agels")){
				pstmt = con.prepareStatement("SELECT u_id, u_name, u_dob, u_gender, u_sts, u_banfor FROM user ORDER BY u_dob;");
			}else if(filter.equals("agesl")){
				pstmt = con.prepareStatement("SELECT u_id, u_name, u_dob, u_gender, u_sts, u_banfor FROM user ORDER BY u_dob DESC;");
			}else if(filter.equals("gen")){
				pstmt = con.prepareStatement("SELECT u_id, u_name, u_dob, u_gender, u_sts, u_banfor FROM user ORDER BY u_gender;");
			}				
			
			
			ResultSet rs= pstmt.executeQuery();
			Integer Count = 1;
			String result = "";
			while(rs.next()){
				result += "<tr><th scope='row'>"+ Count++ +"</th><td>";
				result += rs.getString("u_id") +  "</td><td>";
				result += rs.getString("u_name") +  "</td><td>";		
				result += rs.getString("u_dob") +  "</td><td>";	
				result += rs.getString("u_gender") +  "</td><td>";
				result += "<div class='text-center'>";
				
				if(rs.getString("u_sts").equals("2")){
					result += "<div class='badge bg-danger text-wrap mx-1'>Banned For : "+ rs.getString("u_banfor")+" </div> ";
				}else if(rs.getString("u_sts").equals("0")){
					result += "<div class='badge bg-warning text-wrap mx-1'>Deactivated</div> ";
				}else{
					result += "<button type='button' class='btn btn-danger btn-sm mx-1' onclick='banuser("+ rs.getString("u_id")+")'>Ban</button>";
				}
				result += "<button type='button' class='btn btn-secondary btn-sm' onclick='showmodal("+ rs.getString("u_id")+")'>View</button></div></td></tr>";		   		
		   }
			response.setContentType("text/html");
			response.getWriter().write(result);
			
		}catch(Exception e){
			System.out.print(e);
		}
	}

// FETCH SINGLE USER DETAILS
	
	else if(action.equals("fetchsingleuser")){	
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("SELECT u_id, u_name, u_email, u_dob, u_gender FROM user WHERE u_id=?;");	
			pstmt.setString(1, request.getParameter("uid"));
			
			ResultSet rs = pstmt.executeQuery();
			String result = "";			
			rs.next();
			
			result += "<div class='text-center shadow p-3 mb-3 rounded bg-secondary bg-gradient' id='profile-cover'><img src='img/d00000.jpg' alt='user-image' class='user-image' height='100px' width='100px'>";
			
			result += "<h5>User ID : " +rs.getString("u_id")+ "</h5>";
			result += "<h5>Name    : " +rs.getString("u_name")+ "</h5>";
			result += "<h5>Email   : " +rs.getString("u_email")+ "</h5>";
			result += "<h5>D.O.B   : " +rs.getString("u_dob")+ "</h5>";
			result += "<h5>Gender  : " +rs.getString("u_gender")+ "</h5></div>";			
			
			
			response.setContentType("text/html");
			response.getWriter().write(result);
			
		}catch(Exception e){
			System.out.print(e);
		}
	}
	
	
	
// BAN USER
	
	else if(action.equals("banuser")){	
		PreparedStatement pstmt = null;
		try{
			pstmt = con.prepareStatement("UPDATE user SET u_sts = '2', u_banfor = DATE_ADD(CURRENT_TIMESTAMP, INTERVAL ? HOUR) WHERE u_id = ?;");
			pstmt.setString(1, request.getParameter("hours"));
			pstmt.setString(2, request.getParameter("uid"));
			
			if(pstmt.executeUpdate() > 0){					
				response.setContentType("text/plain");
				response.getWriter().write("1");
			}
		}catch(Exception e){
				System.out.print(e);
		}
	}
%>