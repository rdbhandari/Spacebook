<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form enctype='multipart/form-data' method="post" action="form-submit.jsp">
	
	<div class="mb-3">
	  <label class="form-label">File</label>
	  <input type="file" class="form-control" name="ip_image" accept="Image/*">
	</div>
	
	<div class="mb-3">
	  <label class="form-label">File</label>
	  <input type="file" class="form-control" name="ip_image2" accept="Image/*">
	</div>
	
	<div class="mb-3">
	  <label class="form-label">Email address</label>
	  <input type="email" class="form-control" name="email">
	</div>
	<button type="submit" class="btn btn-primary">Submit</button>
</form>

</body>
</html>