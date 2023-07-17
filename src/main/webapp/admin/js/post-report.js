$(document).ready(function(){
	
})


function showmodal(pid){
	var myModal = new bootstrap.Modal(document.getElementById('viewpost'))
 	$.ajax({
		url:"private/lib/post-op.jsp",
		data:{action: "fetchpost", pid: pid},
		type:"POST",
		success:function(rsp){	
			document.getElementById("modal-post-view").innerHTML = rsp
			myModal.show()
		}
	});
	
}

function deletepost(pid){
 	$.ajax({
		url:"private/lib/post-op.jsp",
		data:{action: "deletepost", pid: pid},
		type:"POST",
		success:function(rsp){	
			if(rsp.includes("1")){
				$("#post-table").load(location.href + " #post-table");
			}
			
		}
	});
	
}
function ignorepost(pid){
 	$.ajax({
		url:"private/lib/post-op.jsp",
		data:{action: "ignorepost", pid: pid},
		type:"POST",
		success:function(rsp){	
			if(rsp.includes("1")){
				$("#post-table").load(location.href + " #post-table");
			}
			
		}
	});
	
}
