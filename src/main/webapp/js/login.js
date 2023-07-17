function validateSignupForm(){
	var name = document.forms['frm_signup']["ip_uname"].value;
	var email = document.forms['frm_signup']["ip_uemail"].value;
	var pswd = document.forms['frm_signup']["ip_upswd"].value;
	var dob = document.forms['frm_signup']["ip_udob"].value;
	var gender = document.forms['frm_signup']["ip_ugender"].value;
	
	 if(name == "" || email == "" || pswd == "" || dob == "" || gender == ""){
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


function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#uimg_prvw').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

$("#ip_uimg").change(function(){
	if( (this.files[0].size / 1024) > 100 ){
		alert("Image Size Should Not Be More Than 100 KB")
		
		element.setAttribute("class", "democlass");
		return false;
	}
    readURL(this);
});

function login(){
	var email = document.forms['frm_login']["ip_uemail"].value;
	var pswd = document.forms['frm_login']["ip_upswd"].value;
	
	
	
	$.ajax({
		url:"private/library/auth.jsp",
		data:{action: "login", uemail: email, upswd:pswd},
		type:"POST",
		success:function(rsp){	
			if(rsp.trim() == "0"){			
				if(confirm("You deactivated your account ! \nDo you want to activate your account again?")){
					recover_account(email)
				}
			}
			else if(rsp.trim() == "1"){
				location.reload();	
			}
			else if (rsp.trim() == "9"){				
				$(".container-fluid").prepend('<div class="alert alert-warning alert-dismissible fade show mx-5 px-5" role="alert"> <strong>Error! </strong>Invalid Login Email and Password<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> </div>')
			}else if (rsp.trim().length > 1){				
				$(".container-fluid").prepend('<div class="alert alert-danger alert-dismissible fade show mx-5 px-5" role="alert"> <strong>Sorry! </strong>Your account is banned for &nbsp;'+rsp.trim()+'<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> </div>')
			}else {				
				$(".container-fluid").prepend('<div class="alert alert-danger alert-dismissible fade show mx-5 px-5" role="alert"> <strong>Error! </strong>There are something error. Please check back after some time.<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> </div>')
			}
			
		}
	});
}

function recover_account(email){
	$.ajax({
		url:"private/library/auth.jsp",
		data:{action: "recoveruser", uemail: email},
		type:"POST",
		success:function(rsp){	
			if(rsp.trim() == "1"){			
				$(".container-fluid").prepend('<div class="alert alert-warning alert-dismissible fade show mx-5 px-5" role="alert"> <strong>Success! </strong>Your account has been recovered. You can login now<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> </div>')
			}
		}
	});
}