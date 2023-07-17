post_offset = 0;
post_offset2 = 0;
$(document).ready(function(){
	getChunkOfPost(post_offset);
	
	$(window).scroll(function(){
		if($(window).scrollTop()>=$(document).height() - $(window).height()){
			getChunkOfPost(post_offset);
			//getChunkOfSuggestivePost(post_offset2);
		}
	})
})

function getChunkOfPost(start){
	$.ajax({
		url:"private/library/index-post.jsp",
		data:{action: "readallpost", start: start},
		type:"POST",
		success:function(rsp){			
			$('#post').append(rsp);
			post_offset += 5;
		}
	});
}

function getChunkOfSuggestivePost(start){
	$.ajax({
		url:"private/library/index-post.jsp",
		data:{action: "readallSuggestpost", start: start},
		type:"POST",
		success:function(rsp){			
			$('#post').append(rsp);
			post_offset2 += 1;
		}
	});
}



