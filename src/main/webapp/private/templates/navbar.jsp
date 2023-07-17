<nav id="navbar"
	class="navbar navbar-expand-lg navbar-light fixed-top w-100 bg-light shadow-sm mb-2 bg-body rounded">
	<div class="container-fluid">
		<a class="navbar-brand fw-bolder text-primary" href="/Spacebook">spacebook</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse py-2 " id="navbarSupportedContent">
			<ul class="navbar-nav m-auto">
				<li class="nav-item mx-3 d-inline"><a href="friends.jsp"><img src='img/icon/friends.svg' alt='friends' height='40px' width='40px'></a></li>
			</ul>
			
			<div class="ms-auto d-inline">
				<img src="img/<%=(String)session.getAttribute("u_img")%>" alt="user-image" class="user-image"
					height="35px" width="35px"> <small><b><%=session.getAttribute("u_name")%></b></small>

				<a class="nav-link dropdown-toggle d-inline" href="#"
					id="navbardropdown" role="button" data-bs-toggle="dropdown"
					aria-expanded="false"></a>

				<ul
					class="dropdown-menu dropdown-menu-dark dropdown-menu-lg-end me-3"
					aria-labelledby="navbardropdown">
					<li><a class="dropdown-item" href="me.jsp">Profile</a></li>
					<li><a class="dropdown-item" href="private/library/auth.jsp?action=logout">Logout</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="private/templates/tandc.jsp">T & C</a></li>
					<li><a class="dropdown-item" href="private/templates/aboutus.jsp">About Us</a></li>
				</ul>
			</div>
		</div>
	</div>
</nav>
