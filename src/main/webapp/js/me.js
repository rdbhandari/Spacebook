post_offset = 0;
$(document).ready(function(){
	getChunkOfPost(post_offset);
	
	$(window).scroll(function(){
		if($(window).scrollTop()>=$(document).height() - $(window).height()){
			getChunkOfPost(post_offset);
		}
	})
})

function getChunkOfPost(start){
	$.ajax({
		url:"private/library/me-post.jsp",
		data:{action: "readmypost", start: start},
		type:"POST",
		success:function(rsp){
			$('#post').append(rsp);
			post_offset += 5;
		}
	});
}

function deletepost(pid){
	$.ajax({
		url:"private/library/me-post.jsp",
		data: {action: "deletepost", pid:pid},
		type:"POST",
		success:function(rspns){
			if(rspns.includes("1")){			
				location.reload();
			}
		}
	});
}

function editpost(pid){
	document.getElementById("ip-post-desc").value = document.getElementById("p-desc-"+pid).innerText;
	document.getElementById("add-post").innerText = "Update Post";
	
	document.getElementById("pid").value = pid;
	
	window.scrollTo(0, 0);
}


function updateuser(){
	var myModal = new bootstrap.Modal(document.getElementById('modal-updateaccount'))
	myModal.show()
}

/*
function updateuser(){
	var myModal = new bootstrap.Modal(document.getElementById('modal-updateaccount'))
 	$.ajax({
		url:"private/library/me-lib.jsp",
		data:{action: "fetchuserdet"},
		type:"POST",
		success:function(rsp){	
			document.getElementById("modal-body-updateaccount").innerHTML = rsp
			myModal.show()
		}
	});
}

*/

function updateu(){
	var data = $('#form-userupdate').serialize() + "&action=updateu";
	$.ajax({
		url:"private/library/me-lib.jsp",
		data:data,
		type:"POST",
		success:function(rsp){	
			if(rsp.includes("1")){			
				location.reload();
			}
		}
	});
}

function deleteuser(){
	if (confirm("Are you sure to deactivate your account ?")){
        $.ajax({
		url:"private/library/me-lib.jsp",
		data:{action: "deleteuser"},
		type:"POST",
		success:function(rsp){	
			if(rsp.trim() == "1"){			
				location.reload();
			}
		}
	});
    }
}



function validateSignupForm(){
	var name = document.forms['frm_userupdate']["ip_uname"].value;
	var pswd = document.forms['frm_userupdate']["ip_upswd"].value;
	var dob = document.forms['frm_userupdate']["ip_udob"].value;
	var gender = document.forms['frm_userupdate']["ip_ugender"].value;
	
	 if(name == "" || pswd == "" || dob == "" || gender == ""){
		alert('Fill all the field')
		return false
	}
	else if ( pswd.length < 8 || pswd.length > 20 ){
		alert('Length of password should be in between 8 to 20 charcters')
		return false
	}else if( Math.floor((new Date() - new Date(dob)) / 31557600000) < 18 ){
		alert('Your age should be atleast 18')
		return false
	}
	
	
}



