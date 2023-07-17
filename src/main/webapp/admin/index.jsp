<%@ include file="private/templates/login-check-a.jsp" %>
<%@ include file="private/lib/db_conn.jsp"%>

<%@ include file="private/templates/header-a.jsp" %>
<%@ include file="private/templates/navbar-a.jsp" %>

	<%
		PreparedStatement pstmt_count = null;
		ResultSet rs_count = null;
		try{									
				pstmt_count = con.prepareStatement("SELECT COUNT(*) AS count FROM user UNION SELECT COUNT(*) FROM (SELECT DISTINCT p_id FROM reports) as x;");
				rs_count = pstmt_count.executeQuery();
				rs_count.next();
				System.out.print("OK");
		} catch (Exception e) {
			System.out.println(e);
		}
	%>


    <div class="row justify-content-center wrapper">
        <div class="card bg-info m-3 col-md-4" style="max-width: 18rem;">
            <div class="card-body text-center">
              <h5 class="card-title text-primary">Total Users</h5>
              <p class="card-text display-1"><%=rs_count.getString("count")%></p>
              <div class="d-grid gap-2">
                <a class="btn btn-primary" href="<%=session.getAttribute("home_a").toString()%>view-users.jsp" role="button">View</a>
              </div>
            </div>
          </div>
          
         <% rs_count.next(); %> 
          
          
          <div class="card bg-info m-3 col-md-4" style="max-width: 18rem;">
            <div class="card-body text-center">
              <h5 class="card-title text-danger">Post Reports</h5>
              <p class="card-text display-1"><%=rs_count.getString("count")%></p>
              <div class="d-grid gap-2">
                <a class="btn btn-primary" href="post-report.jsp" role="button">Check</a>
              </div>
            </div>
          </div>
      </div>
      
<%@ include file="private/templates/footer-a.jsp" %>
