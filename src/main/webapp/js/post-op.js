function addpost(){
	var pid = document.getElementById("ip-post-desc").dataset.pid;	
	
	if($("#ip-post-desc").val().trim() == ""){
		$(".wrapper").prepend('<div class="alert alert-warning alert-dismissible fade show mx-5 px-5" role="alert"> <strong>Sorry! </strong>Please add post description<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> </div>')
		return
	}
	
	data = "action=addpost&pdesc=" + $("#ip-post-desc").val();
	
	if(pid !== "")
		data += "&pid=" + pid;
	
	$.ajax({
		url:"private/library/addpost.jsp",
		contentType: false,
		type:"POST",
		data: data,
		cache: false,
		success:function(rspns){
			if(rspns.includes("1")){		
				location.reload();
			}
		}
	});
}

function addPostFormCheck(){
	if($("#ip-post-desc").val().trim() == ""){
		$(".wrapper").prepend('<div class="alert alert-warning alert-dismissible fade show mx-5 px-5" role="alert"> <strong>Sorry! </strong>Please add post description<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> </div>')
		return false;
	}
}

$('#ip_img').on('change', function() {
	if( (this.files[0].size / 1024) > 100 ){
		alert("File Size Should Not Be More Than 100 KB")
		document.getElementById("ip_img").value = "";
		return false;
	}
  
});

$('#ip_pimg').on('change', function() {
	if( (this.files[0].size / 1024) > 100 ){
		alert("File Size Should Not Be More Than 100 KB")
		document.getElementById("ip_pimg").value = "";
		return false;
	}
  
});

function like(id){
	var elmnt = document.getElementById(id); 
	
	$.ajax({
		url:"private/library/post-op.jsp",
		data:{action: "like", pid: elmnt.dataset.pid, sts: elmnt.dataset.sts},
		type:"POST",
		success:function(rspns){			
			if(rspns.includes("liked")){
				elmnt.dataset.sts = "liked";
				elmnt.innerHTML = "<img src='img/icon/liked.svg' alt='liked' height='30px' width='30px'> Like";				
				
			}else if(rspns.includes("like")){
				elmnt.dataset.sts = "like";
				elmnt.innerHTML = "<img src='img/icon/like.svg' alt='like' height='30px' width='30px'> Like";	
			}
			$(id).load(location.href+ ' '+id);
		}
	});
}

function addcomment(pid){
	var cid = document.getElementById("cmnt-ip-"+pid).dataset.cid	
	data = "action=addcomment&cdesc=" + $("#cmnt-ip-"+pid).val() + "&pid="+pid;
	
	if(cid !== "")
		data += "&cid=" + cid;
	
	$.ajax({
		url:"private/library/post-op.jsp",
		data: data,
		type:"POST",
		success:function(rspns){
			if(rspns.includes("1")){
				location.reload();
			}
		}
	});
}

function editcomment(pid, cid){
	document.getElementById("cmnt-ip-"+pid).value = document.getElementById("cmnt-"+cid).innerText;
	document.getElementById("cmnt-ip-"+pid).dataset.cid = cid;
}


function deletecomment(cid){
	$.ajax({
		url:"private/library/post-op.jsp",
		data: {action: "deletecomment", cid:cid},
		type:"POST",
		success:function(rspns){
			if(rspns.includes("1")){
				//$(cmnt_div_id).load(location.href+ ' '+cmnt_div_id);			
				location.reload();
			}
		}
	});
}



function report(pid){
	$.ajax({
		url:"private/library/post-op.jsp",
		data: {action: "report", pid:pid},
		type:"POST",
		success:function(rspns){
			if(rspns.includes("1")){			
				location.reload();
			}
		}
	});
}