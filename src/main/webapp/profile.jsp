<%@ include file="private/templates/login_check.jsp"%>
<%
	String p_id = request.getParameter("id");
	if(p_id == null){
		response.sendRedirect(session.getAttribute("home").toString());
	}else if(p_id.equals(session.getAttribute("u_id").toString())){

		response.sendRedirect(session.getAttribute("home").toString()+"me.jsp");
	}
%>

<%@ include file="private/templates/header.jsp"%>
<%@ include file="private/templates/navbar.jsp"%>
<%@ include file="private/library/db_conn.jsp"%>

<div class="row justify-content-center wrapper">
	<div class="col-md-5">
		<div class="text-center shadow p-3 mb-3 bg-light rounded border-bottom border-3 border-success" id="profile-cover">
			<%
			PreparedStatement pstmt_name = null;
				try{					
					pstmt_name = con.prepareStatement("SELECT  u_name, u_img, TIMESTAMPDIFF(YEAR,u_dob,CURDATE()) AS age, u_gender FROM user WHERE u_id=?");
					pstmt_name.setString(1, p_id);
					ResultSet rs_name = pstmt_name.executeQuery();
					rs_name.next();
			%> 
					
					<img src="img/<%=rs_name.getString("u_img")%>" alt="user-image" class="user-image" height="100px" width="100px" >
					<h3><%=rs_name.getString("u_name")%></h3>
					
			<div class="d-flex justify-content-around">
				<p class="text-secondary fs-5"><strong>Age : &nbsp;</strong><%=rs_name.getString("age")%> </p>
				<p class="text-secondary fs-5"><strong>Gender : &nbsp;</strong><%=rs_name.getString("u_gender")%> </p>
			</div>
			<hr>	
			<%	
				} catch (Exception e) {
					System.out.print(e);
				}
			%>
			<div id='div-follow'>
			
			<%
			PreparedStatement pstmt_follow = null;
			try{
				pstmt_follow = con.prepareStatement("SELECT COUNT(*) as count, f_sts FROM follows WHERE u1_id=? AND u2_id=?;");
					
				pstmt_follow.setString(1, session.getAttribute("u_id").toString());	
				pstmt_follow.setString(2, p_id);	
				
				ResultSet rs_follow = pstmt_follow.executeQuery();
				rs_follow.next();
				
				//NOT FOLLOWING OR NOT BLOCKED OR NOT REQUESTED
				if(!rs_follow.getString("count").equals("1")){ %>
					<button type="button" class="btn btn-info btn-sm" id='btn-follow' onclick='follow(event)' data-act='follow'>Follow</button>
					<button type="button" class="btn btn-danger btn-sm" id='btn-follow' onclick='follow(event)' data-act='block'>Block</button>
				<%}
				
				//FOLLOWING THE USER
				else if (rs_follow.getString("f_sts").equals("1")){%>
					<button type="button" class="btn btn-danger btn-sm" onclick='follow(event)' data-act='delrelation'>Unfollow</button>
				<%}
				
				//SENT FOLLOW REQUEST
				else if (rs_follow.getString("f_sts").equals("0")){%>
					<button type="button" class="btn btn-warning btn-sm" onclick='follow(event)' data-act='delrelation'>Cancel Request</button>
				<%}
				
				//BLOKED THE USER
				else if (rs_follow.getString("f_sts").equals("2")){%>
					<button type="button" class="btn btn-info btn-sm" onclick='follow(event)' data-act='delrelation'>Unblock</button>
				<%}
				
				
			} catch (Exception e) {
				System.out.print(e);
			}
			%>	
			</div>			
		</div>

		<div id="post" class="shadow p-3 mb-3 bg-body rounded">
		</div>
	</div>
</div>




<%@ include file="private/templates/footer.jsp"%>