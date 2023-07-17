<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<%
	String uri = request.getRequestURI();
	String pageName = uri.substring(uri.lastIndexOf("/")+1);
	
	if(pageName.equals("me.jsp")){%>
		<script src="js/me.js"></script>
		<script src="js/post-op.js"></script>
		<script src="js/login.js"></script>
	<%}
	else if(pageName.equals("profile.jsp")){%>
		<script src="js/profile.js"></script>
		<script src="js/post-op.js"></script>
	<%}
	else if(pageName.equals("login.jsp")){%>
	<script src="js/login.js"></script>
	<%}
	else if(pageName.equals("friends.jsp")){%>
	<script src="js/friends.js"></script>
	<%}
	else{%>
		<script src="js/index.js"></script>
		<script src="js/post-op.js"></script>
	<%}%>






</body>
</html>