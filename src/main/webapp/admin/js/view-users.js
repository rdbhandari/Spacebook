$(document).ready(function(){
	fetchusers("id");
})

function fetchusers(filter){
 	$.ajax({
		url:"private/lib/view-users-lib.jsp",
		data:{action: "fetchusers", filter: filter},
		type:"POST",
		success:function(rsp){
			document.getElementById("post-table").innerHTML = rsp;			
		}
	});
	
}

function showmodal(uid){
	var myModal = new bootstrap.Modal(document.getElementById('viewuser'))
 	$.ajax({
		url:"private/lib/view-users-lib.jsp",
		data:{action: "fetchsingleuser", uid: uid},
		type:"POST",
		success:function(rsp){	
			document.getElementById("modal-user-view").innerHTML = rsp
			myModal.show()
		}
	});
}


function banuser(uid){
	var hours = prompt('For how many hours do you want to ban the user?', 24);
	if (hours == null)
		return
	$.ajax({
		url:"private/lib/view-users-lib.jsp",
		data:{action: "banuser", uid: uid, hours: hours},
		type:"POST",
		success:function(rsp){
			if(rsp.trim() == "1"){
				fetchusers("id");
			}	
			
		}
	});
 	
}