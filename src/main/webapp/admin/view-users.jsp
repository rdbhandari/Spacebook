<%@ include file="private/templates/login-check-a.jsp"%>
<%@ include file="private/lib/db_conn.jsp"%>

<%@ include file="private/templates/header-a.jsp" %>
<%@ include file="private/templates/navbar-a.jsp" %>


 <div class ="container-sm justify-content-center wrapper">
		<h2 class="text-center">List Of All Users</h2>
		<div class="my-3">
			Filter By
			<select id="filter" onchange='fetchusers(this.value)'>				
				  <option value="id" selected>User Id</option>
				  <option value="nameaz">Name (A-Z)</option>
				  <option value="nameza">Name (Z-A)</option>
				  <option value="agels">Age (Largest-Smallest)</option>
				  <option value="agesl">Age (Smallest-Largest)</option>
				  <option value="gen">Gender</option>
			</select>
		</div>
		 
 		<table class="table table-striped table-hover table-bordered table-sm table-responsive text-center">
		  <thead class="table-light">
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">User ID</th>
		      <th scope="col">Name</th>
		      <th scope="col">D.O.B</th>
		      <th scope="col">Gender</th>
		      <th scope="col">Actions</th>
		    </tr>
		  </thead>
		   <tbody id="post-table">
		   </tbody>
		</table>
</div>
<div class="modal fade" id="viewuser" tabindex="-1" aria-labelledby="viewuserLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="viewuserLabel">View User</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modal-user-view">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="private/templates/footer-a.jsp" %>