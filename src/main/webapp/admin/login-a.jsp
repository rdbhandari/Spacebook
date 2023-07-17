<% 
	String sts= (String)session.getAttribute("sts");

	if(sts != null){
		response.sendRedirect("http://localhost:8080/Spacebook/admin");
	}
%>

<%@ include file="private/templates/header-a.jsp" %>
<div class="col-lg-3 m-auto shadow p-3 bg-body rounded-3">
				<h3 class="text-center">ADMIN LOGIN</h3>
                <form action="private/lib/auth-a.jsp?action=login" method="POST" >
                    <div class="mb-3">
                        <label class="form-label">Email address</label>
                        <input type="email" class="form-control" name="a_email">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="a_pswd">
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary ">Login</button>
                    </div>
                </form>
            </div>
<%@ include file="private/templates/footer-a.jsp" %>