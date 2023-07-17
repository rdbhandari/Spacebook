<% 
	if(session.getAttribute("u_id") != null){
		response.sendRedirect("http://localhost:8080/Spacebook/");
	}
%>

	<%@ include file="private/templates/header.jsp" %>

    <div class="container-fluid">
        <div class="row align-items-center min-vh-100">
            <div class="col-lg-6 m-auto">
                <h1 class="text-primary fw-bolder">spacebook</h1>
                <h5>Spacebook helps you connect and share with the people in your life.</h5>
            </div>
            <div class="col-lg-3 m-auto shadow p-3 bg-body rounded-3">
            
                <form name="frm_login">
                    <div class="mb-3">
                        <label class="form-label">Email address</label>
                        <input type="email" class="form-control" name="ip_uemail">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="ip_upswd">
                    </div>
                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-primary" onclick="login()">Login</button>
                    </div>
                </form>
                
                
                <div class="text-center">
                   <!--  <a href="#" class="my-2">Forgotten password?</a> --> 
                    <hr>
                    <button type="button" class="btn btn-warning my-2" data-bs-toggle="modal"
                        data-bs-target="#modal-createnewaccount">Create New Account
                    </button>
                </div>


            </div>
            <!-- Modal -->
            <div class="modal fade" id="modal-createnewaccount" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div>
                                <h3 class="modal-title">Sign Up</h3>
                                <small class="d-block">It's quick and easy.</small>
                            </div>
                            
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form name="frm_signup" enctype='multipart/form-data' action="private/library/signup.jsp" method="POST" onsubmit="return validateSignupForm()" >
                            
                            	<div class="text-center mb-3">
                            		<img src="img/d00000.jpg" alt="user-image" class="user-image mb-3" height="100px" width="100px" id="uimg_prvw">
                            		
                            		<input type="file" class="form-control" name="ip_uimg" id="ip_uimg" accept="image/*">
                            		<small class="form-label">Add image (maximum image size: 100KB)</small>
                            	</div>                           

                                <input type="text" class="form-control mb-3" placeholder="Fullname" name="ip_uname" >
                                
                                <input type="email" class="form-control mb-3" placeholder="Email address" name="ip_uemail">
                                <input type="password" class="form-control mb-3" placeholder="New password" name="ip_upswd">
                                <label class="form-label">Date of birth</label>
                                <input type="date" class="form-control mb-3" name="ip_udob">

                                <label class="form-label">Gender</label>
                                <div class="form-control mb-3 d-flex justify-content-evenly">
                                    <input class="form-check-input" type="radio" value="Male" name="ip_ugender" checked>
                                    <label class="form-check-label">Male</label>

                                    <input class="form-check-input" type="radio" value="Female" name="ip_ugender">
                                    <label class="form-check-label">Female</label>

                                    <input class="form-check-input" type="radio" value="Others" name="ip_ugender">
                                    <label class="form-check-label">Others</label>
                                </div>


                                <small class="mb-3 fst-italic lh-1">By clicking Sign Up, you agree to our <a href="private/templates/tandc.jsp">Terms, Data Policy and Cookie Policy</a> .</small>


                                <div class="d-grid gap-2 col-5 mx-auto my-2">
                                    <button type="submit" class="btn btn-warning">Sign up</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


        </div>

    </div>


    <%@ include file="private/templates/footer.jsp" %>