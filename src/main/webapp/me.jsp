<%@ page import="java.sql.*" %>
<%@ include file="private/templates/login_check.jsp"%>
<%@ include file="private/library/db_conn.jsp"%>

<%@ include file="private/templates/header.jsp"%>
<%@ include file="private/templates/navbar.jsp"%>

<div  class="row justify-content-center wrapper">
	<div class="col-md-5">
		<div class="text-center shadow p-3 mb-2 bg-light rounded border-bottom border-3 border-success">
			<%
				try{
					PreparedStatement pstmt_name = con.prepareStatement("SELECT  u_name, u_img, TIMESTAMPDIFF(YEAR,u_dob,CURDATE()) AS age, u_gender FROM user WHERE u_id=?");
					pstmt_name.setString(1, session.getAttribute("u_id").toString());
					ResultSet rs_name = pstmt_name.executeQuery();
					rs_name.next();
			%> 
					
					<img src="img/<%=rs_name.getString("u_img")%>" alt="user-image" class="user-image" height="100px" width="100px" >
					<h3><%=rs_name.getString("u_name")%></h3>
					<div class="d-flex justify-content-around">
				<p class="text-secondary fs-5"><strong>Age : &nbsp;</strong><%=rs_name.getString("age")%> </p>
				<p class="text-secondary fs-5"><strong>Gender : &nbsp;</strong><%=rs_name.getString("u_gender")%> </p>
			</div>	
			<%	
				} catch (Exception e) {
					System.out.print(e);
				}
			%>
			
			<div class='d-block text-end'>
			<button type='button' class='btn btn-sm' onclick='updateuser()'><img src='img/icon/edit.svg' alt='edit' height='15px' width='15px'></button>
			<button type='button' class='btn btn-sm' onclick='deleteuser()'><img src='img/icon/bin.svg' alt='delete' height='15px' width='15px'></button>
			</div>
		</div>

		<div class="shadow p-3 mb-3 bg-body rounded border border-secondary">
			<h5>Create post</h5>
			<form enctype='multipart/form-data' method="post" action="private/library/addpost.jsp" onsubmit="return addPostFormCheck()">
				<textarea class="form-control" placeholder="What's on your mind ?"
					style="height: 50px" name="pdesc" id="ip-post-desc" data-pid='' required></textarea>
				<input type="hidden" name="pid" id="pid" value=''>
				<div class="my-1">
					<small class="form-label">Add image (maximum size: 100KB)</small>
					 <input class="form-control form-control-sm" type="file" id="ip_pimg" name="ip_pimg" accept="image/*" data-ischange=0>
				</div>
				<div class="mt-3 d-grid gap-2">
					<button type="submit" class="btn btn-primary" id="add-post">Add post</button>
				</div>
			</form>
		</div>

		<div id="post" class="shadow p-3 mb-3 bg-body rounded">

		</div>
	</div>
</div>

 <div class="modal fade" id="modal-updateaccount" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">Edit Profile</h3>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" id="modal-body-updateaccount">
          <%
          String result = "";	
          PreparedStatement pstmt = null;
  		try{
  			pstmt = con.prepareStatement("SELECT * FROM user WHERE u_id = ?;");
  			
  			pstmt.setString(1, session.getAttribute("u_id").toString());
  						
  			ResultSet rs= pstmt.executeQuery();
  					
  			rs.next();
  			
  			result += "<form id='form-userupdate' name='frm_userupdate' action='private/library/signup.jsp' enctype='multipart/form-data'  method='POST'  onsubmit='return validateSignupForm()'>";
  			result += "<div class='text-center mb-3'> <img src='"+session.getAttribute("home").toString()+"img/"+rs.getString("u_img")+"' alt='user-image' class='user-image mb-3' height='100px' width='100px' id='uimg_prvw'> <input type='file' class='form-control' name='ip_uimg' id='ip_uimg' accept='image/*' data-ischage=0> <small class='form-label'>Add image (maximum image size: 100KB)</small> </div> ";
  			
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
  		}catch(Exception e){
			System.out.print(e);
		}
          %>
          <%= result %>
        </div>
      </div>
    </div>
  </div>




<%@ include file="private/templates/footer.jsp"%>