<%@ include file="private/templates/login-check-a.jsp"%>
<%@ include file="private/lib/db_conn.jsp"%>

<%@ include file="private/templates/header-a.jsp" %>
<%@ include file="private/templates/navbar-a.jsp" %>


 <div class ="container-sm justify-content-center wrapper">
 		<table id="post-table" class="table table-striped table-hover table-bordered table-sm table-responsive text-center caption-top">
 			<caption>List of Reported Post</caption>
		  <thead class="table-light">
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">Post Id</th>
		      <th scope="col">Report Count</th>
		      <th scope="col">Actions</th>
		    </tr>
		  </thead>
		  <tbody>
<%
	try{
		 PreparedStatement pstmt_rprt = con.prepareStatement("SELECT p_id, COUNT(*) as count FROM reports GROUP BY p_id ORDER BY count DESC;");
				   	
		ResultSet rs_rprt = pstmt_rprt.executeQuery();
		Integer Count = 1;
		while(rs_rprt.next()){%>
						
			<tr>
		      <th scope="row"><%= Count++ %></th>
		      <td><%= rs_rprt.getString("p_id") %></td>
		      <td><%= rs_rprt.getString("count") %></td>
		      <td><div class="text-center">
		      			<button type="button" class="btn btn-secondary btn-sm" onclick="showmodal(<%= rs_rprt.getString("p_id") %>)" >View</button>
		      			<button type="button" class="btn btn-success btn-sm" onclick="ignorepost(<%= rs_rprt.getString("p_id") %>)" >Ignore</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="deletepost(<%= rs_rprt.getString("p_id") %>)" >Delete</button>
						
				  </div>
			  </td>
		    </tr>	   		
		<%}
	}catch(Exception e){
		System.out.print(e);
	}%>
		 </tbody>
	</table>
 
 </div>
 <div class="modal fade" id="viewpost" tabindex="-1" aria-labelledby="viewpostLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="viewpostLabel">View Post</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modal-post-view">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="private/templates/footer-a.jsp" %>