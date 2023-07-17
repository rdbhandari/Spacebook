<%@ include file="private/templates/login_check.jsp"%>
<%@ include file="private/templates/header.jsp"%>
<%@ include file="private/templates/navbar.jsp"%>

<div class="row justify-content-center wrapper">
	<div class="col-md-5 ">
		<div class="shadow p-3 mb-3 bg-body rounded border border-secondary">
			<h5>Create post</h5>
			<form enctype='multipart/form-data' method="post" action="private/library/addpost.jsp" onsubmit="return addPostFormCheck()">
				<textarea class="form-control" placeholder="What's on your mind ?"
					style="height: 50px" name="pdesc" id="ip-post-desc" data-pid='' required></textarea>
				<input type="hidden" name="pid" value=''>
				<div class="my-1">
					<small class="form-label">Add image (maximum image size: 100KB)</small> <input
						class="form-control form-control-sm" type="file" id="ip_img" name="ip_pimg" accept="image/*">
				</div>
				<div class="mt-3 d-grid gap-2">
					<button type="submit" class="btn btn-primary">Add post</button>
				</div>
			</form>
		</div>

		<div id="post" class="shadow p-3 mb-3 bg-body rounded">		
		</div>
	</div>
</div>



<%@ include file="private/templates/footer.jsp"%>