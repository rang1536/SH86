<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>SH86</title>
	
	<link rel="stylesheet" href="resources/js/jquery.mobile-1.4.5.css">
	<script src="resources/js/jquery.js"></script>
	<script src="resources/js/jquery.mobile-1.4.5.js"></script>
	
	<!-- 우편번호(다음) -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<link href="resources/img/logo2.jpg" rel="shortcut icon" />
	<link href="resources/img/logo2.jpg" rel="apple-touch-icon"></link>
	<script src="resources/js/load-image.all.min.js"></script>
	<script src="resources/js/audio.min.js"></script>
	
	<style>
		.topList4{
			border:2px solid #ddd;
			width:33%;
			height:30px;
			border-radius:5px;
			text-align:center;
			font-weight:bold;
		}
	</style>
	
	<script>
	function photoList(num){
		if(num == 0) {
			location.href = 'userList#page2'
		}else if(num == 1){
			location.href = 'userList#page1'
		}else if(num == 2){
			location.href = 'userList#page4'
		}else if(num == 3){
			location.href = 'userList#page7'
		}else if(num == 4){
			location.href = 'userList#page8'
		}else if(num == 9){
			location.href = 'userList#page9'
		}
		submit(); 
	};
	
	function topBtn(){
		$.mobile.silentScroll(0);
	}
	
	//일상 댓글 >오픈,클로즈!!
	$(document).on('click','.openAlbumCommentBtn',function(){
		var check = $(this).closest('#photoListDiv').find('#commentOpenCheck').val();
		var checkTag = $(this).closest('#photoListDiv').find('#commentOpenCheck')
		var commnetTag = $(this).closest('#photoListDiv').find('#albumCommentDiv');
		console.log(check,checkTag,commnetTag);
		
		if(check == 'close'){
			$(commnetTag).slideDown();
			$(checkTag).val('open');
			$('#comContent').focus();
		}else if(check == 'open'){
			$(commnetTag).slideUp();
			$(checkTag).val('close');
		}
	});
	
	//일상 > 댓글 등록
	$(document).on('click','.addCommentBtn',function(){
		var fileNo = $(this).closest('#photoListDiv').find('#fileNo').val();
		var photoType = $(this).closest('#photoListDiv').find('#photoType').val();
		var comContent = $(this).closest('#photoListDiv').find('input[name="comContent"]').val();
		var commentWriteFormTag = $(this).closest('#commentWriteFormTag');
		var html ='';
		console.log(fileNo,photoType,comContent);
		$.ajax({
			url : 'addPhotoComment',
			data : {'comContent':comContent,'photoType':photoType,'fileNo':fileNo} ,
			dataType : 'json' ,
			type : 'post',
			success : function(data){
				if(data.check == 'true'){
					alert('댓글이 등록되었습니다');
					window.location.reload(true);
					
				}else if(data.check == 'false'){
					alert('댓글 등록에 실패하였습니다')
				}
			}
		});
	});
	
	//좋아요 ++
	$(document).on('click','.goodCountPlusBtn',function(){
		var goodCountNow = parseInt($(this).parent().find('#goodCountTag').text());
		var fileNo = $(this).closest('#photoListDiv').find('#fileNo').val();
		
		var countPlus = goodCountNow + 1;
		var goodCountTag = $(this).find('#goodCountTag');
		
		
		$.ajax({
			url : 'addPhotoGood',
			type : 'post',
			data : {'fileNo':fileNo,'photoGoods':goodCountNow},
			dataType : 'json',
			success : function(data){
				console.log(data.check)
				if(data.check == 'true'){
					$(goodCountTag).empty();
					$(goodCountTag).text(countPlus);
				}else{
					alert('이미 체크 하셨습니다.');
				}				
			}
		});
	});
	
	// 댓글삭제
	$(document).on('click','.commentDeleteBtn',function(){
		var comNum = $(this).parent().find('#commentNum').val();
		console.log('댓글번호 : '+comNum);
		
		if(confirm('댓글을 삭제하시겠습니까?') == true){
			$.ajax({
				url : 'removeComment',
				type : 'post',
				dataType : 'json',
				data : {'comNum':comNum},
				success : function(data){
					if(data.check == 'true'){
						alert('삭제되었습니다');
						window.location.reload(true);
					}else{
						alert('삭제에 실패하였습니다');
						return;
					}
				}
			});
		}
	});
	
	function changeView(){
		var checkValue = $('#hiddenCheck').val();
		console.log(checkValue)
		
		if(checkValue == 1){
			$('#photoListTable').css('display','none');
			$('#totalListDiv').css('display','');
			$('#hiddenCheck').val(2);
		}else if(checkValue == 2){
			$('#photoListTable').css('display','');
			$('#totalListDiv').css('display','none');
			$('#hiddenCheck').val(1);
		}
	}
	</script>
</head>
<body>
	<section id="page1" data-role="page">
	    <header data-role="header" style="height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" onclick="photoList(9)" href="#" data-icon="gear" style="background-color:rgba(255,255,255,0.5);"><font style="color:#030066;font-weight:bold;">MY</font></a>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="#" onclick="photoList(1);"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#" class="ui-btn-active ui-state-persist"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#"><font style="font-size:16px;" onclick="photoList(2);">공지</font></a></li>
	                <li><a href="#" ><font style="font-size:16px;" onclick="photoList(3);">일상</font></a></li>
	                <li><a href="#" ><font style="font-size:16px;" onclick="photoList(4);">관리</font></a></li>
	            </ul>
	        </div><!-- /navbar -->
	    </header>                   
	    
	    <div class="content" data-role="content" style="margin-top:40px;">
	    	<div style="width:100%;text-align:right;border-bottom:2px solid #ddd;margin-bottom:10px;" onclick="photoList(0);">
	    		<img src="resources/img/list.jpg" style="width:35px;height:35px;"/>
	    	</div>
	    	
	    	<c:forEach var="photoList" items="${photoList }">
		    	<div style="width:100%" id="photoListDiv">
		    		<input type="hidden" id="commentOpenCheck" value="close"/>
		    		<input type="hidden" id="photoType" value="2"/>
		    		<input type="hidden" name="fileNo" id="fileNo" value="${photoList.fileNo }"/>
		    		
		    		<c:if test="${cookie.cookieId.value eq '632'}">
			    		<div style="width:100%;text-align:right;">
			    			<img src="resources/img/delete.jpg" style="width:20px;height:20px;">
			    		</div>
		    		</c:if>
		    		
		    		<img src="resources/files/${photoList.filePath }/${photoList.fileName}" style="width:100%;border-radius:10px;"/>
	    			
	    			<%-- <div style="font-size:14px;padding-top:10px;margin-bottom:10px;">
	    				<img src="resources/img/good.jpg" style="width:14px;height:14px;"/>
	    				좋아요 <font style="font-weight:bold;" id="goodCountTag">${photoList.photoGoods }</font>
	    			</div> --%>
	    			
	    			<table style="width:100%;text-align:center;margin-top:5px;margin-bottom:5px;border-bottom:2px solid #ddd;">
		    			<tr id="albumButtonTr">
		    				<td class="topList4 goodCountPlusBtn">좋아요(<font style="font-weight:bold;" id="goodCountTag">${photoList.photoGoods }</font>)</td>
			    			<td class="topList4 openAlbumCommentBtn">댓글(${photoList.commentList.size()})</td>
		    			</tr>
		    		</table>
		    		
		    		<!-- 댓글 목록-->
	    			<div id="albumCommentDiv" style="display:none;">
	    				<!-- 댓글목록 -->
	    				<table style="width:100%" id="albumCommentTable">
	    					<c:forEach var="commentList" items="${photoList.commentList }">
		    					<tr>
		    						<c:choose>
		    							<c:when test="${commentList.userImgNew ne null and commentList.userImgOld ne null}">
		    								<td style="border-top:1px solid #ddd;width:50px;">
				    							<img src="resources/files/${commentList.userId.substring(0,1)}/${commentList.userImgNew}" style="width:40px;height:40px;border-radius:10px;" />
				    						</td>
		    							</c:when>
		    							<c:when test="${commentList.userImgNew ne null and commentList.userImgOld eq null}">
		    								<td style="border-top:1px solid #ddd;width:50px;">
				    							<img src="resources/files/${commentList.userId.substring(0,1)}/${commentList.userImgNew}" style="width:40px;height:40px;border-radius:10px;" />
				    						</td>
		    							</c:when>
		    							<c:when test="${commentList.userImgNew eq null and commentList.userImgOld eq null}">
		    								<td style="border-top:1px solid #ddd;width:50px;">
				    							<img src="resources/img/ready.jpg" style="width:40px;height:40px;border-radius:15px;" />
				    						</td>
		    							</c:when>
		    						</c:choose>
		    						<td style="border-top:1px solid #ddd;">
		    							<font style="font-weight:bold;font-size:14px;">${commentList.userName }</font><br/>
		    							<font style="font-weight:bold;">${commentList.comContent }</font>
		    						</td>
		    						<c:if test="${commentList.userId eq cookie.cookieId.value }">
			    						<td style="border-top:1px solid #ddd;">
			    							<input type="hidden" id="commentNum" value="${commentList.comNum }"/>
			    							<a href="#" class="commentDeleteBtn"><img src="resources/img/cencel.jpg" style="width:26px;height:26px;"/></a>
			    						</td>
		    						</c:if>
		    					</tr>
	    					</c:forEach>
	    				</table>
	    				
	    				<!-- 댓글입력 -->
	    				<div style="width:100%;" id="commentWriteForm">
		    				<table style="width:100%;">
		    					<td style="width:85%;"><input type="text" style="width:100%" name="comContent" id="comContent" placeholder="댓글 입력"></td>
		    					<td>
			    					<a href="#" style="width:12%;" class="addCommentBtn">
			    						<img src="resources/img/plus.jpg" style="width:35px;height:35px;"/>
			    					</a>
		    					</td>
		    				</table>
	    				</div>
	    			</div>
    			</c:forEach>
	    	</div> 	
	    </div>
	    
		<c:import url="../module/footer.jsp"></c:import>
	</section>
</head>
<body>

</body>
</html>