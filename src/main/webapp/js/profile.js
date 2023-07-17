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
		url:"private/library/profile-post.jsp",
		data:{action: "readupost", start: start, p_id: findGetParameter("id")},
		type:"POST",
		success:function(rsp){
			$('#post').append(rsp);
			post_offset += 5;
		}
	});
}



function follow(e){
	$.ajax({
		url:"private/library/profile-lib.jsp",
		data:{action: "follow", p_id: findGetParameter("id"), sts: e.target.dataset.act},
		type:"POST",
		success:function(rspns){
			if(rspns.includes("1")){
				$("#div-follow").load(location.href+ " #div-follow");
			}
		}
	});
}

function findGetParameter(parameterName) {
    var result = null,
        tmp = [];
    location.search
        .substr(1)
        .split("&")
        .forEach(function (item) {
          tmp = item.split("=");
          if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
        });
    return result;
}