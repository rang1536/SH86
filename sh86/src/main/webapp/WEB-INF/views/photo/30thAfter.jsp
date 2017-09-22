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
	<link href="resources/js/jquery.modal.css" type="text/css" rel="stylesheet" />
	<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
	<script src="resources/js/jquery.modal.min.js"></script>
	
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
	
	//일상 > 댓글 등록
	$(document).on('click','.addCommentBtn',function(){
		var fileNo = $(this).closest('#photoListDivPop').find('#fileNoPop').val();
		var photoType = 3;
		var comContent = $(this).closest('#photoListDivPop').find('input[name="comContent"]').val();
		
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
	
	
	// 댓글삭제
	$(document).on('click','.commentDeleteBtn',function(){
		var comNum = $(this).parent().find('#commentNumPop').val();
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
	
	//사진확대보기
	$(document).on('click','.photoBiggerBtn',function(){
		var fileNo = $(this).find('#fileNo').val();
		var photoType = 3;
		console.log(fileNo);
		
		$.ajax({
			url : 'readPhotoBig',
			data : {'fileNo':fileNo,'photoType':photoType},
			dataType: 'json',
			type : 'post',
			success : function(photo){
				var cookieId = '${cookie.cookieId.value}';
				var html = '<div style="width:100%" id="photoListDivPop">';
				html += '<input type="hidden" id="fileNoPop" value="'+fileNo+'"/>';
				html += '<img src="'+photo.filePath+photo.fileName+'" style="width:100%;border-radius:20px;"/>';
				html += '<table style="width:100%;"><tr><td style="width:16px;">'
				html += '<img src="resources/img/like.png" style="width:14px;height:14px;"/>';
				html += '</td><td style="width:60px;">좋아요 <font style="font-weight:bold;" id="goodCountTagPop">'+photo.photoGoods+'</font></td>';
				html += '<td>댓글 '+photo.commentList.length+'</td>';
				if(cookieId == '632'){
					html += '<td style="text-align:right;" onclick="photoDelete('+fileNo+')"><img src="resources/img/delete.jpg" style="width:24px;height:24px;"/></td>'
				}
				html += '</tr></table>';
				html += '<div style="width:100%;display:none;" id="commentListDiv">'
				html += '<input type="hidden" id="listOpenCheck" value="close"/>'
				html += '<table style="width:100%;">';
				$.each(photo.commentList,function(i, comment){
					html += '<tr>';
					if(comment.userImgNew != null && comment.userImgOld != null){
						html += '<td style="border-top:1px solid #ddd;width:50px;">';
						html += '<img src="resources/files/'+comment.userId.substring(0,1)+'/'+comment.userImgNew+'" style="width:40px;height:40px;border-radius:10px;" />';
						html += '</td>';
					}else if(comment.userImgNew == null && comment.userImgOld != null){
						html += '<td style="border-top:1px solid #ddd;width:50px;">';
						html += '<img src="resources/files/'+comment.userId.substring(0,1)+'/'+comment.userImgOld+'" style="width:40px;height:40px;border-radius:10px;" />';
						html += '</td>';
					}else if(comment.userImgNew == null && comment.userImgOld == null){
						html += '<td style="border-top:1px solid #ddd;width:50px;">';
						html += '</td>';
					}
					html += '<td style="border-top:1px solid #ddd;">';
					html += '<font style="font-weight:bold;font-size:14px;">'+comment.userName+'</font><br/>';
					html += '<font style="font-weight:bold;">'+comment.comContent+'</font>';
					html += '</td>';
					if(comment.userId == cookieId){
						html += '<td style="border-top:1px solid #ddd;text-align:right;">';
						html += '<input type="hidden" id="commentNumPop" value="'+comment.comNum+'"/>';
						html += '<a href="#" class="commentDeleteBtn"><img src="resources/img/cencel.jpg" style="width:26px;height:26px;"/></a>';
						html += '</td>';
					}
				});
				html += '</table>';
				html += '<div style="width:100%;" id="commentWriteDiv">';
				html += '<table style="width:100%;">';
				html += '<td style="width:85%;"><input type="text" style="width:100%" name="comContent" id="comContent" placeholder="댓글 입력"></td>';
				html += '<td style="text-align:right;">';
				html += '<a href="#" style="width:12%;" class="addCommentBtn">';
				html += '<img src="resources/img/plus.jpg" style="width:23px;height:23px;"/>';
				html += '</a>';
				html += '</td>';
				html += '</table>';
				html += '</div>';
				html += '</div>';
				html += '</div>';
				
				infoPopUp(html);
				$('#comContent').focus();
			}
		})
		
		
	});
	
	function infoPopUp(txt){
	    modal({
	        type: 'info',
	        title: '사진보기',
	        text: txt,
	        buttons: [{
	    		text: '댓글', //Button Text
	    		val: 'comment', //Button Value
	    		eKey: true, //Enter Keypress
	    		addClass: 'btn-light-blue', //Button Classes (btn-large | btn-small | btn-green | btn-light-green | btn-purple | btn-orange | btn-pink | btn-turquoise | btn-blue | btn-light-blue | btn-light-red | btn-red | btn-yellow | btn-white | btn-black | btn-rounded | btn-circle | btn-square | btn-disabled)
	    		onClick: function(dialog) {
	    			if($('#commentListDiv').find('#listOpenCheck').val() == 'close'){
	    				$('#commentListDiv').slideDown();
	    				$('#commentListDiv').find('#listOpenCheck').val('open');
	    			}else if($('#commentListDiv').find('#listOpenCheck').val() == 'open'){
	    				$('#commentListDiv').slideUp();
	    				$('#commentListDiv').find('#listOpenCheck').val('close');
	    			}
	    		}
	    	}, 
	    	{
	    		text: '좋아요', //Button Text
	    		val: 'good', //Button Value
	    		eKey: true, //Enter Keypress
	    		addClass: 'btn-light-blue', //Button Classes (btn-large | btn-small | btn-green | btn-light-green | btn-purple | btn-orange | btn-pink | btn-turquoise | btn-blue | btn-light-blue | btn-light-red | btn-red | btn-yellow | btn-white | btn-black | btn-rounded | btn-circle | btn-square | btn-disabled)
	    		onClick: function(dialog) {
	    			var fileNo = $('#fileNoPop').val();
	    			console.log(fileNo);
	    			var count = parseInt($('#goodCountTag').text());
	    			
	    			$.ajax({
	    				url : 'addPhotoGood',
	    				type : 'post',
	    				data : {'fileNo':fileNo,'photoGoods':count},
	    				dataType : 'json',
	    				success : function(data){
	    					if(data.check == 'true'){
	    						count += 1;
	    						$('#goodCountTag').empty();
	    		    			$('#goodCountTag').text(count);
	    						$('#goodCountTagPop').empty();
	    		    			$('#goodCountTagPop').text(count);
	    					}else{
	    						alert('이미 체크 하셨습니다.');
	    					}		 	
	    				}
	    			})
	    		}
	    	}]
	    });
	}
	
	function photoDelete(fileNo){
		if(confirm('삭제하시겠습니까?') == true){
			$.ajax({
				url : 'removePhoto',
				data : {'fileNo':fileNo},
				dataType : 'json',
				type : 'post',
				success : function(data){
					
				}
			});
		}else{
			
		}
		
	}
	
	// 댓글삭제
	$(document).on('click','.commentDeleteBtn2',function(){
		var comNum = $(this).parent().find('#commentNum').val();
		
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
	
	//일상 > 댓글 등록
	$(document).on('click','.addCommentBtn2',function(){
		var comContent = $(this).closest('#photoListDiv').find('input[name="comContent"]').val();
		var fileNo = $(this).closest('#photoListDiv').find('#fileNo').val();
		var photoType = 3;
		
		if(comContent == null || comContent == ''){
			alert('댓글을 입력해주세요!');
			return;
		}
		
		var html ='';
		$.ajax({
			url : 'addPhotoComment',
			data : {'comContent':comContent,'fileNo':fileNo,'photoType':photoType} ,
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
	
	//일상 댓글 >오픈,클로즈!!
	$(document).on('click','.openAlbumCommentBtn2',function(){
		var check = $(this).closest('#photoListDiv').find('#commentOpenCheck').val();
		var checkTag = $(this).closest('#photoListDiv').find('#commentOpenCheck')
		var commnetTag = $(this).closest('#photoListDiv').find('#albumCommentDiv');
		console.log(check,checkTag,commnetTag);
		
		if(check == 'close'){
			$(commnetTag).slideDown();
			$(checkTag).val('open');
		}else if(check == 'open'){
			$(commnetTag).slideUp();
			$(checkTag).val('close');
		}
	});
	
	//좋아요 ++
	$(document).on('click','.goodCountPlusBtn2',function(){
		var goodCountNow = parseInt($(this).closest('#albumButtonTr').find('#goodCountTag').text());
		var fileNo = $(this).closest('#photoListDiv').find('#fileNo').val();
		console.log(goodCountNow,fileNo);
		
		var countPlus = goodCountNow + 1;
		var goodCountTag = $(this).closest('#albumButtonTr').find('#goodCountTag');
		
		
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
	
	function photoListType(folderName){
		location.href = 'after30thList?folderName='+folderName;
		submit();
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
	    	<!-- <div style="width:100%;text-align:center;" onclick="photoList(0);">
	    		<img src="resources/img/list.jpg" style="width:35px;height:35px;float:right;"/>
	    	</div> -->
	    	<input type="hidden" id="hiddenCheck" value="1"/>
	    	<table style="width:100%;">
	    		<tr>
	    			<td style="border-bottom:2px solid #ddd;margin-bottom:10px;">
	    				<select id="folderName" data-native-menu="false" style="width:100%;height:36px;" onchange="photoListType(this.value)">
	    					<option value="30th01" selected="selected">(1)방가이</option>
	    					<option value="30th02">(2)은사와</option>
	    					<option value="30th03">(3)반별로</option>
	    					<option value="30th04">(4)만나서</option>
	    					<option value="30th05">(5)경건히</option>
	    					<option value="30th06">(6)나누고</option>
	    					<option value="30th07">(7)손잡고</option>
	    					<option value="30th08">(8)먹으며</option>
	    					<option value="30th09">(9)마시고</option>
	    					<option value="30th10">(10)즐기고</option>
	    					<option value="30th11">(11)정주고</option>
	    					<option value="30th11">(12)헤어짐</option>
	    				</select>
	    				<script>
	    					$('#folderName').val('${folderName}').prop('selected','selected');
	    				</script>
	    			</td>
	    			<td style="width:37px;text-align:right;border-bottom:2px solid #ddd;margin-bottom:10px;" onclick="changeView();"><img src="resources/img/change.jpg" style="width:40px;height:40px;"/></td>
	    			<td style="width:37px;text-align:right;border-bottom:2px solid #ddd;margin-bottom:10px;" onclick="photoList(0);"><img src="resources/img/list.jpg" style="width:40px;height:40px;"/></td>
	    		</tr>
	    	</table>
	    	
	    	<table style="width:100%;" id="photoListTable">
	   			<c:forEach var="photoList" items="${photoList}" varStatus="i">
	   				
	   				<input type="hidden" id="index" value="${i.index }"/>
	   				<c:if test="${i.index eq 0}">
	   					<tr>
	   				</c:if>
	   					<td style="width:33%;" class="photoBiggerBtn">
	   						<input type="hidden" id="fileNo" value="${photoList.fileNo }"/>
	   						<img src="${photoList.filePath}${photoList.fileName}" style="width:100%;height:90px;border-radius:10px;"/>
	   					</td>
	   				<c:if test="${i.index ne 0 and i.index eq 2 or i.index eq 5 or i.index eq 8 or i.index eq 11 or i.index eq 14}">	
	   					</tr><tr>
	   				</c:if>
	   			</c:forEach>
   			</table>
   			
	    	<div id="totalListDiv" style="display:none;">
		    	<c:forEach var="photoList" items="${photoList }">
			    	<div style="width:100%;font-size:15px;" id="photoListDiv">
			    		<input type="hidden" id="commentOpenCheck" value="close"/>
			    		<input type="hidden" id="photoType" value="5"/>
			    		<input type="hidden" name="fileNo" id="fileNo" value="${photoList.fileNo }"/>
			    		
			    		<c:if test="${cookie.cookieId.value eq '632'}">
				    		<div style="width:100%;text-align:right;">
				    			<img src="resources/img/delete.jpg" style="width:20px;height:20px;">
				    		</div>
			    		</c:if>
			    		
			    		<%-- <div class="photoBiggerBtn">
				    		<input type="hidden" id="fileNo" value="${photoList.fileNo }"/> --%>
				    		<img src="${photoList.filePath }${photoList.fileName}" style="width:100%;border-radius:10px;"/>
			    		<!-- </div> -->
		    			<%-- <div style="font-size:14px;padding-top:10px;margin-bottom:10px;" class="goodCountPlusBtn">
		    				<img src="resources/img/good.jpg" style="width:14px;height:14px;"/>
		    				좋아요 <font style="font-weight:bold;" id="goodCountTag">${photoList.photoGoods }</font>
		    			</div> --%>
		    			
		    			<table style="width:100%;text-align:center;margin-top:5px;margin-bottom:5px;border-bottom:2px solid #ddd;">
			    			<tr id="albumButtonTr">
			    				<td class="topList4 goodCountPlusBtn2">좋아요(<font style="font-weight:bold;" id="goodCountTag">${photoList.photoGoods }</font>)</td>
				    			<td class="topList4 openAlbumCommentBtn2">댓글(${photoList.commentList.size()})</td>
			    				<td class="topList4" onclick="topBtn();">TOP</td>
			    			</tr>
			    		</table>
			    		
		    			<%-- <button type="button" style="width:40%;float:left;" class="goodCountPlusBtn">좋아요 (<font style="font-weight:bold;" id="goodCountTag">${photoList.photoGoods }</font>)</button>
			    		<button type="button" style="width:40%;float:left;" class="openAlbumCommentBtn">댓글 (${photoList.commentList.size()})</button>
			    		<button type="button" style="width:20%;float:left;" onclick="topBtn();">TOP</button> --%>
		    			
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
			    							<c:when test="${commentList.userImgNew eq null and commentList.userImgOld ne null}">
			    								<td style="border-top:1px solid #ddd;width:50px;">
					    							<img src="resources/files/${commentList.userId.substring(0,1)}/${commentList.userImgOld}" style="width:40px;height:40px;border-radius:10px;" />
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
				    						<td style="border-top:1px solid #ddd;text-align:right;">
				    							<input type="hidden" id="commentNum" value="${commentList.comNum }"/>
				    							<a href="#" class="commentDeleteBtn2"><img src="resources/img/cencel.jpg" style="width:26px;height:26px;"/></a>
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
				    					<a href="#" style="width:12%;text-align:right;" class="addCommentBtn2">
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