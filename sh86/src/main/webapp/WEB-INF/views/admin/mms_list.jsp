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
	<link href="resources/js/jquery.modal.css" type="text/css" rel="stylesheet" />
	<script src="resources/js/jquery.modal.min.js"></script>
	
	<link href="resources/img/logo2.jpg" rel="shortcut icon" />
	<link href="resources/img/logo2.jpg" rel="apple-touch-icon"></link>
	
	<style>
		.statTd{
			text-align:center;
			border-bottom:1px solid #ddd;
			font-size:15px;
			height:29px;
		}
		
		.duesTr{
			background-color:#FFA648;
			text-align:center;
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
			location.href = 'userListForMms#page8';
		}else if(num == 9){
			location.href = 'userList#page9'
		}
		submit(); 
	};
	
	//팝업창 세팅
	function infoPopUp(txt){
	    modal({
	        type: 'info',
	        title: '발송내역',
	        text: txt,
	        buttons: [{
	    		text: '닫기', //Button Text
	    		val: 'close', //Button Value
	    		eKey: true, //Enter Keypress
	    		addClass: 'btn-light-blue', //Button Classes (btn-large | btn-small | btn-green | btn-light-green | btn-purple | btn-orange | btn-pink | btn-turquoise | btn-blue | btn-light-blue | btn-light-red | btn-red | btn-yellow | btn-white | btn-black | btn-rounded | btn-circle | btn-square | btn-disabled)
	    		onClick: function(dialog) {
	    			return true;
	    		}
	    	}]
	    });
	}
	
	function successList(mmsSendDate){
		$.ajax({
			url : 'mmsSuccessList',
			data : {'mmsSendDate':mmsSendDate},
			dataType : 'json',
			type : 'post',
			success : function(data){
				if(data != null){
					var html = '<table style="width:100%;">';
					html += '<tr>';
					html += '<th class="duesTr">이름</th>';
					html += '<th class="duesTr">번호</th>';
					html += '<th class="duesTr">확인</th>';
					html += '</tr>';
					//실패목록 
					$.each(data,function(i,successList){
						if(successList.result != 2){
							if(successList.userId.substring(0,1) == '1'){
								html += '<tr>';
								html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								if(successList.result == 22) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">거부</font></td>';
								else if(successList.result == 6) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">결번</font></td>';
								else html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">실패</font></td>';
								html += '</tr>'
							}						
						}						
					});
					$.each(data,function(i,successList){
						if(successList.result != 2){
							if(successList.userId.substring(0,1) == '2'){
								html += '<tr>';
								html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								if(successList.result == 22) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">거부</font></td>';
								else if(successList.result == 6) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">결번</font></td>';
								else html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">실패</font></td>';
								html += '</tr>'
							}						
						}						
					});
					$.each(data,function(i,successList){
						if(successList.result != 2){
							if(successList.userId.substring(0,1) == '3'){
								html += '<tr>';
								html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								if(successList.result == 22) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">거부</font></td>';
								else if(successList.result == 6) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">결번</font></td>';
								else html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">실패</font></td>';
								html += '</tr>'
							}						
						}						
					});
					$.each(data,function(i,successList){
						if(successList.result != 2){
							if(successList.userId.substring(0,1) == '4'){
								html += '<tr>';
								html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								if(successList.result == 22) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">거부</font></td>';
								else if(successList.result == 6) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">결번</font></td>';
								else html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">실패</font></td>';
								html += '</tr>'
							}						
						}						
					});
					$.each(data,function(i,successList){
						if(successList.result != 2){
							if(successList.userId.substring(0,1) == '5'){
								html += '<tr>';
								html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								if(successList.result == 22) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">거부</font></td>';
								else if(successList.result == 6) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">결번</font></td>';
								else html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">실패</font></td>';
								html += '</tr>'
							}						
						}						
					});
					$.each(data,function(i,successList){
						if(successList.result != 2){
							if(successList.userId.substring(0,1) == '6'){
								html += '<tr>';
								html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								if(successList.result == 22) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">거부</font></td>';
								else if(successList.result == 6) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">결번</font></td>';
								else html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">실패</font></td>';
								html += '</tr>'
							}						
						}						
					});
					$.each(data,function(i,successList){
						if(successList.result != 2){
							if(successList.userId.substring(0,1) == '7'){
								html += '<tr>';
								html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								if(successList.result == 22) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">거부</font></td>';
								else if(successList.result == 6) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">결번</font></td>';
								else html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">실패</font></td>';
								html += '</tr>'
							}						
						}						
					});
					$.each(data,function(i,successList){
						if(successList.result != 2){
							if(successList.userId.substring(0,1) == '8'){
								html += '<tr>';
								html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								if(successList.result == 22) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">거부</font></td>';
								else if(successList.result == 6) html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">결번</font></td>';
								else html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">실패</font></td>';
								html += '</tr>'
							}						
						}						
					});
					
					//성공목록
					$.each(data,function(i,successList){
						if(successList.result == 2) {
							if(successList.userId != null && successList.userId.substring(0,1) == '1'){
								html += '<tr>';
								if(successList.userId != null) html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								if(successList.userId == null) html += '<td class="statTd">'+successList.destName+' (-)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#000054;">성공</font></td>';
								html += '</tr>'
							}
						}					
					});
					//성공목록
					$.each(data,function(i,successList){
						if(successList.result == 2) {
							if(successList.userId != null && successList.userId.substring(0,1) == '2'){
								html += '<tr>';
								if(successList.userId != null) html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								if(successList.userId == null) html += '<td class="statTd">'+successList.destName+' (-)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#000054;">성공</font></td>';
								html += '</tr>'
							}
						}					
					});
					//성공목록
					$.each(data,function(i,successList){
						if(successList.result == 2) {
							if(successList.userId != null && successList.userId.substring(0,1) == '3'){
								html += '<tr>';
								if(successList.userId != null) html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								if(successList.userId == null) html += '<td class="statTd">'+successList.destName+' (-)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#000054;">성공</font></td>';
								html += '</tr>'
							}
						}					
					});
					//성공목록
					$.each(data,function(i,successList){
						if(successList.result == 2) {
							if(successList.userId != null && successList.userId.substring(0,1) == '4'){
								html += '<tr>';
								if(successList.userId != null) html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								if(successList.userId == null) html += '<td class="statTd">'+successList.destName+' (-)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#000054;">성공</font></td>';
								html += '</tr>'
							}
						}					
					});
					//성공목록
					$.each(data,function(i,successList){
						if(successList.result == 2) {
							if(successList.userId != null && successList.userId.substring(0,1) == '5'){
								html += '<tr>';
								if(successList.userId != null) html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								if(successList.userId == null) html += '<td class="statTd">'+successList.destName+' (-)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#000054;">성공</font></td>';
								html += '</tr>'
							}
						}					
					});
					//성공목록
					$.each(data,function(i,successList){
						if(successList.result == 2) {
							if(successList.userId != null && successList.userId.substring(0,1) == '6'){
								html += '<tr>';
								if(successList.userId != null) html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								if(successList.userId == null) html += '<td class="statTd">'+successList.destName+' (-)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#000054;">성공</font></td>';
								html += '</tr>'
							}
						}					
					});
					//성공목록
					$.each(data,function(i,successList){
						if(successList.result == 2) {
							if(successList.userId != null && successList.userId.substring(0,1) == '7'){
								html += '<tr>';
								if(successList.userId != null) html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								if(successList.userId == null) html += '<td class="statTd">'+successList.destName+' (-)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#000054;">성공</font></td>';
								html += '</tr>'
							}
						}					
					});
					//성공목록
					$.each(data,function(i,successList){
						if(successList.result == 2) {
							if(successList.userId != null && successList.userId.substring(0,1) == '8'){
								html += '<tr>';
								if(successList.userId != null) html += '<td class="statTd">'+successList.destName+' ('+successList.userId.substring(0,1)+'반)</td>';
								if(successList.userId == null) html += '<td class="statTd">'+successList.destName+' (-)</td>';
								html += '<td class="statTd">'+successList.phoneNumber+'</td>';
								html += '<td class="statTd"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#000054;">성공</font></td>';
								html += '</tr>'
							}
						}					
					});
					html += '</table>';
					infoPopUp(html);
				}
				
			}
		});
	}
	
	function mmsRetry(mmsNo){
		
		if(confirm('미접속자에게 문자를 재발송할까요?')==true){
			$.ajax({
				url: 'mmsRetry',
				data:{'mmsNo':mmsNo},
				dataType:'json',
				type:'post',
				success:function(data){
					if(data.check == 'success'){
						alert(data.userCount+'건 재발송하였습니다');
					}else if(data.check == 'fail'){
						alert('재발송에 실패하였습니다.');
					}
				}	
			})			
		} 
	}
	</script>
</head>
<body>
	<section id="page1" data-role="page">
	    <header data-role="header" style="height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" onclick="photoList(9)" href="#" data-icon="gear" style="background-color:rgba(255,255,255,0.5);margin-top:15px;"><font style="font-weight:bold;color:red;">MY</font></a>
	    
	        <div data-role="navbar">
	             <ul>
	               <li><a href="#" onclick="photoList(1);"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#" onclick="photoList(0);"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#" onclick="photoList(2);"><font style="font-size:16px;" onclick="photoList(2);">공지</font></a></li>
	                <li><a href="#" onclick="photoList(3);"><font style="font-size:16px;" onclick="photoList(3);">일상</font></a></li>
	                <li><a href="#" class="ui-btn-active ui-state-persist" onclick="photoList(4);"><font style="font-size:16px;" onclick="photoList(4);">관리</font></a></li>
	            </ul>
	        </div>
		</header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:35px;">
	    	<br/>
			<table style="width:100%;">
				<tr>
					<td></td>
					<td style="width:36px;text-align:right;" onclick="photoList(4);">
	    				<img src="resources/img/back.PNG" style="width:70px;height:35px;"/>
				    </td>
				</tr>
			</table>
			
			<%-- <table style="width:100%;">
				<tr>
					<th class="duesTr">발송일</th>
					<th class="duesTr">발신</th>
					<th class="duesTr">발송자</th>
					<th class="duesTr">내용</th>
				</tr>
				<c:forEach var="list" items="${reportList}">
					<tr>
						<td class="statTd">${list.mmsSendDate.substring(0,8)}</td>
						<td class="statTd" onclick="successList(${list.mmsSendDate});"><font style="font-weight:bold;color:#36589C;">${list.mmsSuccess }/${list.mmsTotalCount }</font></td>
						<td class="statTd">${list.mmsSender }</td>
						<td class="statTd">${list.mmsMsg }</td>
					</tr>
				</c:forEach>
			</table> --%>
			
			<c:forEach var="list" items="${reportList}">
				<table style="width:100%;border:1px solid #ddd;border-top:2px solid #0100FF;">
					<tr>
						<th class="duesTr" style="width:38px;">발신</th>
						<td class="statTd" style="font-weight:bold;" colspan="3">${list.mmsSender } ( ${list.mmsSendDate.substring(4,6)}-${list.mmsSendDate.substring(6,8)} )</td>								
					</tr>
					<tr>
						<th class="duesTr">내용</th>
						<td class="statTd" colspan="3" style="font-size:14px;text-align:left;">${list.mmsMsg }</td>
					</tr>
					<tr>
						<th class="duesTr">결과</th>	
						<td style="text-align:center;font-size:15px;height:29px;"><font style="font-weight:bold;color:#36589C;">성공${list.mmsSuccess }/총${list.mmsTotalCount }/접속 ${list.connectCount }</font></td>							
						<td style="text-align:right;"><img src="resources/img/list.jpg" style="width:29px;height:29px;" onclick="successList(${list.mmsSendDate});"/></td>
						<td style="text-align:center;"><img src="resources/img/sms.jpg" style="width:29px;height:29px;" onclick="mmsRetry(${list.mmsNo});"/></td>
					</tr>
				</table>
			</c:forEach>
	    </div>
	</section>
</body>
</html>