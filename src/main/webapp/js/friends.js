function send_follow_request(pid){
	$.ajax({
		url:"private/library/friends-lib.jsp",
		data:{action: "sndflwrqst", pid: pid},
		type:"POST",
		success:function(rspns){
			if(rspns.trim() == "1"){			
				$("#sec-youmayknow-body").load(location.href+ " #sec-youmayknow-body");	
				$(".wrapper").prepend('<div class="alert alert-warning alert-dismissible fade show" role="alert"> <strong>Success!</strong> You have sent friend request<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> </div>')
			}
		}
	});
}


function accept_request(pid){
	$.ajax({
		url:"private/library/friends-lib.jsp",
		data:{action: "acptrqst", pid: pid},
		type:"POST",
		success:function(rspns){
			if(rspns.trim() == "1"){			
				$("#sec-frnd-rqst-body").load(location.href+ " #sec-frnd-rqst-body");
				$("#sec-follower-body").load(location.href+ " #sec-follower-body");
			}
		}
	});
}

function remove_follower(pid){
	$.ajax({
		url:"private/library/friends-lib.jsp",
		data:{action: "rmvflwr", pid: pid},
		type:"POST",
		success:function(rspns){
			if(rspns.trim() == "1"){			
				$("#sec-follower-body").load(location.href+ " #sec-follower-body");
			}
		}
	});
}


function unfollow(pid){
	$.ajax({
		url:"private/library/friends-lib.jsp",
		data:{action: "unflw", pid: pid},
		type:"POST",
		success:function(rspns){
			if(rspns.trim() == "1"){
				$("#sec-follows-body").load(location.href+ " #sec-follows-body")		
				$(".wrapper").prepend('<div class="alert alert-danger alert-dismissible fade show" role="alert"> <strong>Success!</strong> You have unfollow the user<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> </div>')
			}
		}
	});
}

