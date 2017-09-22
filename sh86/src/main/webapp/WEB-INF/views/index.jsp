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
	
	<!-- 우편번호(다음) -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<link href="resources/img/SH86_128r.jpg" rel="shortcut icon" />
	<link href="resources/img/SH86_128r.jpg" rel="apple-touch-icon"></link>
	
	
	<style>
		.statTd{
			text-align:center;
			font-weight:bold;
			border-bottom:1px solid #ddd;
		}
		
		.statTd2{
			text-align:center;
			font-weight:bold;
			border-bottom:1px solid #ddd;
			height:32px;
		}
		
		th{
			background-color:#ddd;
			font-weight:bold;
			width:20%;	
		} 
		
		.img-round{
			width:80%;
			height:110px;
		}
		
		.fileInputDiv {
		    position:relative;
		    width:100%;
		    height:40px;
		    overflow:hidden;
		}
		.fileInputImgBtn {
		    padding:0 0 0 5px;
		    width:35px;
		    height:35px;
		    float:right;
		}
		.fileInputHidden {
		    font-size:29px;
		    position:absolute;
		    right:0px;
		    top:0px;
		    opacity:0;
		    filter: alpha(opacity=0);
		    -ms-filter: alpha(opacity=0);
		    cursor:pointer;
		}

		.filePreviewDiv {
		    position:relative;
		    width:100%;
		    height:109px;
		    overflow:hidden;
		}
		.fileView {
		    padding:0 0 0 5px;
		    width:80%;
		    height:110px;
		    border-radius: 70px;
			-moz-border-radius : 70px;
			-khtml-border-radius : 70px;
			-webkit-border-radius : 70px;
		}
		
		.inputNone{
			border:0px;
		}

		.topList{
				border:1px solid #ddd;
				border-radius:5px;
				text-align:center;
				font-weight:bold;
		}
		
		.topList2{
			border:2px solid #ddd;
			width:20%;
			height:30px;
			border-radius:5px;
			text-align:center;
		}
		
		.topList3{
			border:2px solid #ddd;
			height:30px;
			border-radius:5px;
			text-align:center;
			font-weight:bold;
		}
		.topList4{
			border:2px solid #ddd;
			width:25%;
			height:30px;
			border-radius:5px;
			text-align:center;
			font-weight:bold;
		}
		.subject{
			border-bottom:3px solid #ddd;
			font-weight:bold;
			font-size:15px;
			width:100%;
		}
		
		.photoList{
			font-weight:bold;
			color:#000000;
			border-bottom:1px solid #ddd;
			padding:7px;
			
		}
		
		.songListTd{
			width:25%;
			text-align:center;
		}
		
		.duesTable{
			color:#030066;
		}
		
		.duesTr{
			background-color:#FFA648;
		}
		
		.noticeH3{
			font-size:15px;
			font-weight:bold;
		}
	</style>
	
	
	<script>
	
		function footerBanner(){
			window.location.href = 'https://www.dcake.co.kr/';
		}
		
		//숫자컴마찍기
	 	function numberChange(){
			$('.numberInput').html(function(){
				var x = $(this).html();
			    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			});
		}
		
		$(document).ready(function(){
			numberChange();
			
		})
		/* 바로가기 자동생성 스크립트 */
		// 접속 핸드폰 정보
		function createIcon(){
			var userAgent = navigator.userAgent.toLowerCase();
			alert(userAgent);
			// 모바일 홈페이지 바로가기 링크 생성
			if(confirm('바로가기 아이콘을 생성하시겠습니까?') == true){
				if(userAgent.match('iphone')) {
				    document.write('<link href="resources/img/SH86_128r.png" rel="apple-touch-icon">') 
				} else if(userAgent.match('android')) {
				    document.write('<link href="resources/img/SH86_128r.png" rel="shortcut icon">') 
				} else {
				    document.write('<link href="resources/img/SH86_128r.png" rel="shortcut icon">') 
				}
			}else{
				return;
			}
		};
		//문자 - 회원검색
		function searchForm(){
			$('#directForm').css('display','none');
			$('#resultDiv').css('display','none');
			$('#searchForm').css('display','');
			$('#searchKey').focus();
		};
		
		//문자 - 직접입력
		function direct(){
			$('#searchForm').css('display','none');
			$('#resultDiv').css('display','none');
			$('#directForm').css('display','');
			$('#userHp').focus();
		};
		
		//문자 > 회원검색 > 상세정보입력창 포커스시 힌트 바꿔주기
		$(document).on('focus','#valueDetail',function(){
			var searchKey=$('#searchKey').val();
			
			if(searchKey == 'name'){
				$('#searchValue').prop('type','text');
				$('#searchValue').prop('placeholder','성 혹은 이름만 입력하셔도 검색됩니다.');
			}else if(searchKey == 'hp'){
				$('#searchValue').prop('type','tel');
				$('#searchValue').prop('placeholder','뒤 4자리를 입력하세요');
			}else{
				$('#searchValue').prop('type','text');
				$('#searchValue').prop('placeholder','시이름을 입력해주세요');
			}
			
		});
		
		// 문자 > 회원검색 > 검색버튼 클릭시 > 검색결과 보여주기
		function searchUserSms(){
			var searchKey=$('#searchKey').val();
			var searchValue=$('#searchValue').val();
			
			$.ajax({
				url: 'searchList',
				data: {'searchKey' : searchKey, 'searchValue':searchValue},
				type: 'post',
				dataType: 'json',
				success : function(data){
					console.log("ajax성공.");
					$('#directForm').css('display','none');
					$('#searchForm').css('display','none');
					var html = "<p style='font-weight:bold;font-size:20px;color:#030066'>"+data.userList[0].userName+"님 외 총 "+data.count+" 명이 선택됨</p>"
					html += "<br/>";
					html += '<button type="button" style="width:100%;height:30px;" id="mmsSendBtn">문자발송</button>';
					$('#resultDiv').empty();
					$('#resultDiv').html(html);
					$('#resultDiv').css('display','');
				}
			});
		};
		
		// 문자 > 회원검색 > 문자발송버튼 클릭시 > 유효성검사 및 검색된 회원에게 문자발송
		$(document).on('click','#mmsSendBtn',function(){
			var searchKey=$('#searchKey').val();
			var searchValue=$('#searchValue').val();
			var mmsMsg = $('#msg').val();
			console.log(searchKey,searchValue);
			
			if(mmsMsg == null || mmsMsg == ''){
				alert('메세지를 입력하세요');
				$('#msg').focus();
				return;
			}else if(searchKey == null || searchKey == ''){
				alert('검색조건을 선택하세요');
				return;
			}else if(searchValue == null || searchValue == '' ){
				alert('반 또는 이름을 입력하세요');
				$('#searchValue').focus();
				return;
			}
			
			if(confirm("전송 하시겠습니까?") == true){
				$.ajax({
					url: 'mmsSend',
					data: {'searchKey' : searchKey, 'searchValue':searchValue, 'mmsMsg': mmsMsg},
					type: 'post',
					dataType: 'json',
					success : function(data){
						
						if(data.check == '성공'){
							alert('문자발송에 성공하였습니다.');
							/* window.location.reload(true); */
							$('#smsSendDiv').empty();
							var success = 0;
							var html = '<table style="width:100%;">';
							html += '<tr>';
							html += '<th class="duesTr">이름</th>';
							html += '<th class="duesTr">전화번호</th>';
							html += '<th class="duesTr">전송</th>';
							html += '</tr>';
							
							$.each(data.userList, function(i,userList){
								html += '<tr>';
								html += '<td class="statTd">'+userList.destName+'</td>';
								html += '<td class="statTd">'+userList.phoneNumber+'</td>';
								if(userList.result == 2){
									html += '<td clss="statTd">성공</td>';
									success++;
								}else if(userList.result == 6){
									html += '<td class="statTd" style="font-weight:bold;color:#DB0000;text-align:center;">결번</td>';
								}else if(userList.result == 22){
									html += '<td class="statTd" style="font-weight:bold;color:#DB0000;text-align:center;">수신거부</td>';
								}else{
									html += '<td class="statTd" style="font-weight:bold;color:#DB0000;text-align:center;">전송실패</td>';
								}
								html += '</tr>';
							});
							html += '<tr>';
							html += '<th class="duesTr">결과</th>';
							html += '<th class="duesTr">-</th>';
							html += '<th class="duesTr">'+success+'/'+data.userList.length+'</th>';
							$('#smsSendDiv').append(html);
						}else{
							alert('문자발송에 실패하였습니다.');
						}
					}
				});
			}else{
				return;
			}
		});
		
		//문자 > 직접입력 > 입력받은 휴대폰으로 문자발송
		$(document).on('click','#sendMmsDirectBtn',function(){
			var userHp = $('#userHp').val();
			var mmsMsg = $('#msg').val();
			
			if(mmsMsg == null || mmsMsg == ''){
				alert('메세지를 입력하세요');
				return;
			}
			
			if(confirm("전송 하시겠습니까?") == true){
				$.ajax({
					url: 'mmsSendDirect',
					data: {'userHp': userHp, 'mmsMsg': mmsMsg},
					type: 'post',
					dataType: 'json',
					success : function(data){
						if(data.check == '성공'){
							alert('문자발송에 성공하였습니다.');
							window.location.reload(true);
						}else{
							alert('문자발송에 실패하였습니다.');
						}
					}
				});
			}else{
				return;
			}
		});
		
		// 문자 > 전체발송 > 휴대폰번호가 입력된 전체 회원에게 문자발송
		function sendAll(){
			var mmsMsg = $('#msg').val();
			if(mmsMsg == null || mmsMsg == ''){
				alert('메세지를 입력하세요');
				return;
			}
			
			if(confirm("전송 하시겠습니까?") == true){
				$.ajax({
					url: 'mmsSendAll',
					data: {'mmsMsg': mmsMsg,'sendTel': sendTel},
					type: 'post',
					dataType: 'json',
					success : function(data){
						if(data.check == '성공'){
							alert('문자발송에 성공하였습니다.');
							/* window.location.reload(true); */
							$('#smsSendDiv').empty();
							var success = 0;
							var html = '<table style="width:100%;">';
							html += '<tr>';
							html += '<th class="duesTr">이름</th>';
							html += '<th class="duesTr">전화번호</th>';
							html += '<th class="duesTr">전송</th>';
							html += '</tr>';
							
							$.each(data.userList, function(i,userList){
								html += '<tr>';
								html += '<td class="statTd">'+userList.destName+'</td>';
								html += '<td class="statTd">'+userList.phoneNumber+'</td>';
								if(userList.result == 2){
									html += '<td class="statTd">성공</td>';
									success++;
								}else if(userList.result == 6){
									html += '<td class="statTd" style="font-weight:bold;color:#DB0000;text-align:center;">결번</td>';
								}else if(userList.result == 22){
									html += '<td class="statTd" style="font-weight:bold;color:#DB0000;text-align:center;">수신거부</td>';
								}else{
									html += '<td class="statTd" style="font-weight:bold;color:#DB0000;text-align:center;">전송실패</td>';
								}
								html += '</tr>';
							});
							html += '<tr>';
							html += '<th class="duesTr">결과</th>';
							html += '<th class="duesTr">-</th>';
							html += '<th class="duesTr">'+success+'/'+data.userList.length+'</th>';
							$('#smsSendDiv').append(html);
						}else{
							alert('문자발송에 실패하였습니다.');
						}
					}
				});
			}else{
				return;
			}
			
		};
		
		// 우편번호 찾기 - 부의공지
		function execDaumPostCodeContent() {
			new daum.Postcode({
				oncomplete: function(data) {
				
				var fullAddr = ''; // 최종 주소 변수
				var extraAddr = ''; // 조합형 주소 변수
				
				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				    fullAddr = data.roadAddress;
				
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
				    fullAddr = data.jibunAddress;
				}
				
				// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
				if(data.userSelectedType === 'R'){
				//법정동명이 있을 경우 추가한다.
				if(data.bname !== ''){
				    extraAddr += data.bname;
				}
				// 건물명이 있을 경우 추가한다.
				if(data.buildingName !== ''){
				    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
				}
				
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				$('#coPlaceContent').val('('+data.zonecode+') '+fullAddr);
				// 커서를 상세주소 필드로 이동한다.
				$('#sangseAddContent').focus();
				
				}
			}).open();
		}
		
		// 우편번호 찾기 - 부의공지
		function execDaumPostCode() {
			new daum.Postcode({
				oncomplete: function(data) {
				
				var fullAddr = ''; // 최종 주소 변수
				var extraAddr = ''; // 조합형 주소 변수
				
				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				    fullAddr = data.roadAddress;
				
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
				    fullAddr = data.jibunAddress;
				}
				
				// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
				if(data.userSelectedType === 'R'){
				//법정동명이 있을 경우 추가한다.
				if(data.bname !== ''){
				    extraAddr += data.bname;
				}
				// 건물명이 있을 경우 추가한다.
				if(data.buildingName !== ''){
				    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
				}
				
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				$('#userAddressModify').val(fullAddr);
				// 커서를 상세주소 필드로 이동한다.
				$('#sangseAdd').css('display','');
				$('#sangseAdd').focus();
				
				}
			}).open();
		}
		
		// 소식 > 공지등록 > 부의공지 클릭시
		$(document).on('click','#typeContent',function(){
			/* $('#noticeTitle').empty();
			$('#noticeTitle').html("<h2 style='background-color:#D4F4FA;text-align:center;'>공지 카테고리 : 부의공지</h2>"); */
			$('#normalDiv').css('display','none');
			$('#eventDiv').css('display','none');
			$('#contentDiv').css('display','');
			$('.topList3').css('background-color','#FFFFFF');
			$(this).css('background-color','#C1F2FF');
		});
		
		//소식 > 공지등록 > 부의공지 > 등록버튼 클릭시 > 부의공지 등록하기
		$(document).on('click','#contentAddBtn',function(){
			var params = $('#contentForm').serialize();
			
			var targetName = $(this).closest('#contentForm').find('#coTargetName').val();
			var targetClass = $(this).closest('#contentForm').find('#coTargetClass').val();
			var content = $(this).closest('#contentForm').find('#coContent').val();
			var place =  $(this).closest('#contentForm').find('#coPlaceContent').val();
			var handDate =  $(this).closest('#contentForm').find('#coHandDate').val();
			var date =  $(this).closest('#contentForm').find('#coVisitDate').val();
			var hour =  $(this).closest('#contentForm').find('#coVisitHour').val();
			var minute =  $(this).closest('#contentForm').find('#coVisitMinute').val();
			
			if(targetName == null || targetName == ''){
				alert('대상의 이름을 입력하세요');
				return;
			}else if(targetClass == null || targetClass == ''){
				alert('대상의 반을 입력하세요');
				return;
			}else if(content == null || content == ''){
				alert('내용을 입력하세요');
				return;
			}else if(place == null || place == ''){
				alert('장례식장을 입력하세요');
				return;
			}else if(handDate == null || handDate == ''){
				alert('발인날짜를 입력하세요');
				return;
			}else if(date == null || date == ''){
				alert('조문일을 입력하세요');
				return;
			}else if(hour == null || hour == ''){
				alert('조문시간을 입력하세요');
				return;
			}else if(minute == null || minute == ''){
				alert('조문시간을 입력하세요');
				return;
			}
			
			
			$.ajax({
				url : 'noticeContentAdd',
				data : params,
				dataType : 'json',
				type : 'post',
				success : function(data){
					if(data.check == '성공'){
						alert('부의공지가 등록되었습니다');
						window.location.reload(true);
					}else{
						alert('공지등록에 실패하였습니다');
					}
				}
			});
		});
		
		// 소식 > 공지등록 > 행사공지 클릭시
		$(document).on('click','#typeEvent',function(){
			/* $('#noticeTitle').empty();
			$('#noticeTitle').html("<h2 style='background-color:#D4F4FA;text-align:center;'>공지 카테고리 : 행사공지</h2>"); */
			$('#contentDiv').css('display','none');
			$('#normalDiv').css('display','none');	
			$('#eventDiv').css('display','');	
			$('.topList3').css('background-color','#FFFFFF');
			$(this).css('background-color','#C1F2FF');
		});
		
		//소식 > 공지등록 > 행사공지 > 등록버튼 클릭시 > 행사공지 등록하기
		$(document).on('click','#eventAddBtn',function(){
			var params = $('#eventForm').serialize();
			
			var subject = $(this).closest('#eventForm').find('#noSubject').val();
			var place = $(this).closest('#eventForm').find('#coPlaceContent').val();
			var money = $(this).closest('#eventForm').find('#coMoney').val();
			var eventDate = $(this).closest('#eventForm').find('#coEventDate').val();
			var content = $(this).closest('#eventForm').find('#coContent').val();
			
			if(content == null || content == ''){
				alert('내용을 입력하세요');
				return;
			}else if(subject == null || subject == ''){
				alert('제목을 입력하세요');
				return;
			}else if(eventDate == null || eventDate == ''){
				alert('행사날짜를 입력하세요');
				return;
			}else if(place == null || place == ''){
				alert('장소를 입력하세요');
				return;
			}else if(money == null || money == ''){
				alert('회비를 입력하세요');
				return;
			}
			
			$.ajax({
				url : 'noticeEventAdd',
				data : params,
				dataType : 'json',
				type : 'post',
				success : function(data){
					if(data.check == '성공'){
						alert('행사공지가 등록되었습니다');
						window.location.reload(true);
					}else{
						alert('공지등록에 실패하였습니다');
					}
				}
			});
		});
		
		// 소식 > 공지등록 > 일반공지 클릭시
		$(document).on('click','#typeNormal',function(){
			/* $('#noticeTitle').empty();
			$('#noticeTitle').html("<h2 style='background-color:#D4F4FA;text-align:center;'>공지 카테고리 : 일반공지</h2>"); */
			$('#contentDiv').css('display','none');
			$('#eventDiv').css('display','none');
			$('#normalDiv').css('display','');	
			$('.topList3').css('background-color','#FFFFFF');
			$(this).css('background-color','#C1F2FF');
		});
		
		//소식 > 공지등록 > 일반공지 > 등록버튼 클릭시 > 축하공지 등록하기
		$(document).on('click','#normalAddBtn',function(){
			var params = $('#normalForm').serialize();
			
			var targetName = $(this).closest('#normalForm').find('#noTargetName').val();
			var targetClass = $(this).closest('#normalForm').find('#noTargetClass').val();
			var content = $(this).closest('#normalForm').find('#noContents').val();
			var subject = $(this).closest('#normalForm').find('#noSubject').val();
			
			if(content == null || content == ''){
				alert('내용을 입력하세요');
				return;
			}else if(subject == null || subject == ''){
				alert('글제목을 입력하세요');
				return;
			}else if(targetClass == null || targetClass == ''){
				alert('대상의 반을 입력하세요');
				return;
			}else if(targetName == null || targetName == ''){
				alert('대상의 이름을 입력하세요');
				return;
			}
			
			$.ajax({
				url : 'noticeAdd',
				data : params,
				dataType : 'json',
				type : 'post',
				success : function(data){
					if(data.check == '성공'){
						alert('축하공지가 등록되었습니다');
						window.location.reload(true);
					}else{
						alert('공지등록에 실패하였습니다');
					}
				}
			});
		});
		
		//부의공지 참여체크이벤트
		$(document).on('click','.contentJoinBtn',function(){
			$(this).css('display','none');
			$(this).parent().find('#bodyTable').css('display','none');
			$(this).parent().find('#hiddenTable').css('display','');
			$(this).closest('#accodianDiv').find('.contentSubmitBtn').css('display','');
		}); 
		
		//부의공지 참여시
		$(document).on('click','.joinBtn',function(){
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).parent().find('.notJoinBtn').css({'background-color':'#ddd','color':'black'});
			$(this).closest('#accodianDiv').find('#hiddenTable2').css('display','none');
			$(this).parent().find('#joJoinShape').val('참여');
			console.log($(this).parent().find('#joJoinShape').val());
		});
		
		//부의공지 불참시
		$(document).on('click','.notJoinBtn',function(){
			$(this).parent().find('.joinBtn').css({'background-color':'#ddd','color':'black'});
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).closest('#accodianDiv').find('#hiddenTable2').css('display','');
			$(this).parent().find('#joJoinShape').val('불참');
			console.log($(this).parent().find('#joJoinShape').val());
		});
		
		//3만원
		$(document).on('click','.3',function(){
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).parent().find('.5').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('.10').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('.etc').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('#joMoney').val(30000);
			console.log($(this).parent().find('#joMoney').val());
		});
		
		//5만원
		$(document).on('click','.5',function(){
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).parent().find('.3').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('.10').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('.etc').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('#joMoney').val(50000);
			console.log($(this).parent().find('#joMoney').val());
		});
		
		//10만원
		$(document).on('click','.10',function(){
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).parent().find('.5').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('.3').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('.etc').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('#joMoney').val(100000);
			console.log($(this).parent().find('#joMoney').val());
		});
		
		//직접입력
		$(document).on('click','.etc',function(){
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).parent().find('.5').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('.10').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('.3').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('#joMoney').val('etc');
			$(this).parent().find('#hiddenMoney').css('display','');
		});
		
		//참여체크등록
		$(document).on('click','.contentSubmitBtn',function(){
			var noNum = $(this).parent().find('#hiddenNoNum').val();
			var formId = noNum + 'Form';
			var joinShape = $(this).parent().find('#joJoinShape').val();
			var joDate = $(this).parent().find('#joDate').val();
			var moneyInput = $(this).parent().find('#moneyInput').val();
			var joMoney = $(this).parent().find('#joMoney').val();
			
			//유효성검사
			if(joinShape == null || joinShape == ''){
				alert('참여/불참 여부를 선택하세요');
				return;
			}else if(joinShape == '참여'){
				if(joDate ==null || joDate == ''){
					alert('조문오실 날짜를 선택해주세요')
					return;
				}
			}else if(joinShape == '불참'){
				if(joMoney == null || joMoney ==''){
					alert('불참시 대납하실 조의금액을 선택하세요')
					return;
				}else if(joMoney == 'etc'){
					if(moneyInput == null || moneyInput == ''){
						alert('직접입력 선택시 조의금을 직접 입력해주세요');
						$(this).parent().find('#moneyInput').focus();
						return;
					}else{
						$(this).parent().find('#joMoney').val(moneyInput);
					}
				}
			}
			var params = $('#'+formId).serialize();
			console.log(params);
			
			if(confirm("전송 하시겠습니까?") == true){
				$.ajax({
					url : 'joinAdd',
					data : params,
					dataType : 'json',
					type : 'post',
					success : function(data){
						if(data.check == '성공'){
							alert('참여체크가 완료되었습니다');
							return;
						}else{
							alert('참여체크에 실패하였습니다');
							return;
						}
					}
				});	
			}else{
				return;
			}
		});
		
		//행사공지 참여시
		$(document).on('click','.eventJoinBtn',function(){
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).parent().find('.eventNotJoinBtn').css({'background-color':'#ddd','color':'black'});
			var noNum = $(this).closest('#bodyTable').find('#noNum').val();
			var joJoinShape = '참여';
			var joinCount = parseInt($(this).closest('#bodyTable').find('#joinCount').val());
			var joinResultTag = $(this).closest('#bodyTable').find('#joinResult');
			
			if(confirm("참여 하시겠습니까?") == true){
				$.ajax({
					url : 'joinEventAdd',
					data : {'noNum':noNum,'joJoinShape':joJoinShape} ,
					dataType : 'json',
					type : 'post',
					success : function(data){
						if(data.check == '성공'){
							alert('참여체크가 완료되었습니다');
							/* $(joinResultTag).empty();
							$(joinResultTag).text('참여'+(joinCount+1)); */
							window.location.reload(true);
						}else{
							alert('이미 체크하셨습니다');
							return;
						}
					}
				});
			} 
		});
		
		//행사공지 불참시
		$(document).on('click','.eventNotJoinBtn',function(){
			$(this).parent().find('.eventJoinBtn').css({'background-color':'#ddd','color':'black'});
			$(this).css({'background-color':'#002266','color':'white'});
			
			var noNum = $(this).closest('#bodyTable').find('#noNum').val();
			var joJoinShape = '불참';
			var notJoinCount = parseInt($(this).closest('#bodyTable').find('#notJoinCount').val());
			var notJoinResultTag = $(this).closest('#bodyTable').find('#notJoinResult');
			
			if(confirm("불참 하시겠습니까?") == true){
				$.ajax({
					url : 'joinEventAdd',
					data : {'noNum':noNum,'joJoinShape':joJoinShape} ,
					dataType : 'json',
					type : 'post',
					success : function(data){
						if(data.check == '성공'){
							alert('참여체크가 완료되었습니다');
							/* $(notJoinResultTag).empty();
							$(notJoinResultTag).text('불참 '+(notJoinCount+1)); */
							window.location.reload(true);
						}else{
							alert('이미 체크하셨습니다');
							return;
						}
					}
				});
			} 
			
		});
		
		//부의공지 참여체크이벤트
		$(document).on('click','.eventJoinCheckBtn',function(){
			$(this).css('display','none');
			$(this).parent().find('#bodyTable').css('display','none');
			$(this).parent().find('#hiddenTable').css('display','');
			$(this).closest('#accodianDiv').find('.eventSubmitBtn').css('display','');
		});
		
		//직접납부
		$(document).on('click','.directPay',function(){
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).parent().find('.accountPay').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('#payType').val('직접납부');
		});
		
		//계좌이체
		$(document).on('click','.accountPay',function(){
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).parent().find('.directPay').css({'background-color':'#ddd','color':'black'});
			$(this).parent().find('#payType').val('계좌이체');
		});
		
		//참여체크등록 - 행사공지
		$(document).on('click','.eventSubmitBtn',function(){
			var noNum = $(this).parent().find('#hiddenNoNum').val();
			var formId = noNum + 'Form';
			var joinShape = $(this).parent().find('#joJoinShape').val();
			var payType = $(this).parent().find('#payType').val();
			
			//유효성검사
			if(joinShape == null || joinShape == ''){
				alert('참여/불참 여부를 선택하세요');
				return;
			}else if(joinShape == '참여'){
				if(payType ==null || payType == ''){
					alert('회비 납부방법을 선택해주세요')
					return;
				}
			}
			
			var params = $('#'+formId).serialize();
			console.log(params);
			
			if(confirm("전송 하시겠습니까?") == true){
				$.ajax({
					url : 'joinEventAdd',
					data : params,
					dataType : 'json',
					type : 'post',
					success : function(data){
						if(data.check == '성공'){
							alert('참여체크가 완료되었습니다');
							return;
						}else{
							alert('참여체크에 실패하였습니다');
							return;
						}
					}
				});	
			}else{
				return;
			}
		});
		
		$(document).ready(function(){
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                    reader.onload = function (e) {
                    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                        $('#blah').attr('src', e.target.result);
                        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                        //(아래 코드에서 읽어들인 dataURL형식)
                    }                   
                    reader.readAsDataURL(input.files[0]);
                    //File내용을 읽어 dataURL형식의 문자열로 저장
                }
            }//readURL()--
   
            //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
            $("#imgInp").change(function(){
                //alert(this.value); //선택한 이미지 경로 표시
                readURL(this);
                console.log($('#imgInp').val())
                $("#blah").css('display','');
            });
            
            function readURL2(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                    reader.onload = function (e) {
                    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                        $('#filePreviewImg').attr('src', e.target.result);
                        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                        //(아래 코드에서 읽어들인 dataURL형식)
                    }                   
                    reader.readAsDataURL(input.files[0]);
                    //File내용을 읽어 dataURL형식의 문자열로 저장
                }
            }//readURL()--
   
            //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
            $("#userImgNew").change(function(){
                //alert(this.value); //선택한 이미지 경로 표시
                readURL2(this);
                console.log($('#userImgNew').val());
                
                $("#filePreviewImg").css('display','');
            });
            
            function readURL3(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                    reader.onload = function (e) {
                    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                        $('#filePreviewImg2').attr('src', e.target.result);
                        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                        //(아래 코드에서 읽어들인 dataURL형식)
                    }                   
                    reader.readAsDataURL(input.files[0]);
                    //File내용을 읽어 dataURL형식의 문자열로 저장
                }
            }//readURL()--
   
            //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
            $("#userImgNew2").change(function(){
                //alert(this.value); //선택한 이미지 경로 표시
                readURL3(this);
               	$("#filePreviewImg2").css('display','');
            });
            
            function readURL4(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                    reader.onload = function (e) {
                    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                        $('#filePreviewImg3').attr('src', e.target.result);
                        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                        //(아래 코드에서 읽어들인 dataURL형식)
                    }                   
                    reader.readAsDataURL(input.files[0]);
                    //File내용을 읽어 dataURL형식의 문자열로 저장
                }
            }//readURL()--
   
            //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
            $("#userImgNew3").change(function(){
                //alert(this.value); //선택한 이미지 경로 표시
                readURL4(this);
                $("#filePreviewImg3").css('display','');
            });
            
            function readURL5(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                    reader.onload = function (e) {
                    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                        $('#filePreviewImg4').attr('src', e.target.result);
                        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                        //(아래 코드에서 읽어들인 dataURL형식)
                    }                   
                    reader.readAsDataURL(input.files[0]);
                    //File내용을 읽어 dataURL형식의 문자열로 저장
                }
            }//readURL()--
   
            //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
            $("#userImgNew4").change(function(){
                //alert(this.value); //선택한 이미지 경로 표시
                readURL5(this);
                $("#filePreviewImg4").css('display','');
            });
            
            function readURL6(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                    reader.onload = function (e) {
                    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                        $('#albumImgView').attr('src', e.target.result);
                        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                        //(아래 코드에서 읽어들인 dataURL형식)
                    }                   
                    reader.readAsDataURL(input.files[0]);
                    //File내용을 읽어 dataURL형식의 문자열로 저장
                }
            }//readURL()--
   
            //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
            $("#albumImg").change(function(){
                //alert(this.value); //선택한 이미지 경로 표시
               	readURL6(this);
                $("#albumImgView").css('display','');
                $('#albumMsg').focus(); 
            	
            });
            
         });

		$(document).on('click','#imgAddBtn',function(){
			var formData = new FormData($("#photoForm")[0]);
			
	        $.ajax({
	            type : 'post',
	            url : 'photoAdd',
	            data : formData,
	            processData : false,
	            contentType : false,
	            success : function(data) {
	                alert("파일 업로드하였습니다.");
	            },
	            error : function(error) {
	                alert("파일 업로드에 실패하였습니다.");
	                console.log(error);
	                console.log(error.status);
	            }
	        });
		});
		
		function userModify(num){
			var formData = new FormData($("#userModifyForm")[0]);
			var imgValue = $('input[name="userImgNew"]').val();
			
			var userHp = $('#userHpModify').val();
			var userAddress = $('#userAddressModify').val();
			var userSangseAdd = $('#sangseAdd').val();
			var userBirthType = $('#birthType').val();
			var userBirthMonth = $('input[name="userBirthMonth"]').val();
			var userBirthDay = $('input[name="userBirthDay"]').val();
			
			console.log(userBirthDay)
			/* var formData = new FormData(); 
			formData.append("userHp", $('#userHpModify').val()); 
			formData.append("userEmail", $('#userEmailModify').val()); 
			formData.append("userAddress", $('#userAddressModify').val()); 
			formData.append("file", $("#userImgNew")[0].files[0]); */
			
			if(imgValue != null && imgValue != ''){
				$.ajax({
		            type : 'post',
		            url : 'userModify',
		            data : formData ,
		            processData : false,
		            contentType : false,
		            success : function(data) {
		            	if(data.check == 'true'){
		            		//파일업로드완료
		            		alert('체크');
		            		window.location.reload(true);
		            	}else{
		            		alert("파일 업로드에 실패하였습니다.");
		            	}
		                
		            },
		            error : function(error) {
		                alert("파일 업로드에 실패하였습니다.");
		                console.log(error);
		                console.log(error.status);
		            }
		        });
			}
			$.ajax({
				type : 'post',
				url : 'userModifyText',
				data : {'userHp':userHp,'userAddress':userAddress,'userBirthType':userBirthType,'userBirthMonth':userBirthMonth,'userBirthDay':userBirthDay,'userSangseAdd':userSangseAdd} ,
				dataType: 'json',
				success:function(data){
					if(data.check) {
						alert('수정처리가 완료되었습니다');
						window.location.reload(true);
					}
				}
			}); 
		}
		function searchUser(){
			var userName = $('#searchUserByName').val();
			var sessionId = '${sessionId}';
			
			if(userName != null && userName != ''){
				$.ajax({
					url : 'searchUserByName',
					type : 'post',
					data : {'userName':userName},
					dataType : 'json',
					success:function(data){
						$('#searchUserListDiv').empty();
						$('#userListDiv').empty();
						var html = '';
						html += '<div>';
						html += '<table style="width:100%;">'
							
						$.each(data, function(i, result){
							html += '<tr>';
							html += '<td style="width:61px;border-bottom:1px dotted #ddd;">';
							if(result.userImgOld != null && result.userImgNew == null){
								html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgOld+'" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">'
								html += '</td><td colspan="2" style="border-bottom:1px dotted #ddd;">'
							}else if(result.userImgOld != null && result.userImgNew != null){
								html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgOld+'" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">'
								html += '</td><td style="width:61px;border-bottom:1px dotted #ddd;">';
								html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgNew+'" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">'
								html += '</td><td style="border-bottom:1px dotted #ddd;">'
							}else if(result.userImgOld == null && result.userImgNew == null){
								html += '</td><td colspan="2" style="border-bottom:1px dotted #ddd;">'
							}
							if(result.userDo == null || result.userCityName == null){
								html += '<font style="color:black;font-weight:bold;">'+result.userName+'</font><br/>';
							}else if(result.userDo != null || result.userCityName != null){
								html += '<font style="color:black;font-weight:bold;">'+result.userName+'</font><br/>';
								html += '<font style="font-size:13px;font-weight:bold;">'+result.userDo+' '+result.userCityName+'</font>';
							}
							html += '</td><td style="text-align:right;border-bottom:1px dotted #ddd;">';
							if(sessionId == result.userId){
								html += '<a href="#page9"><img src="resources/img/info.jpg" style="width:43px;height:43px;"/></a>'
							}
							if(result.userHp != null && result.userHp != ''){
								html += '<a href="tel:'+result.userHp+'"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>';
							}else{
								/* html += '<a href="#page9"><img src="resources/img/nohp.png" style="width:40px;height:40px;"/></a>'; */
							}
							html += '</td>';
							html += '</tr>';
						});
						html += '</table>';
						html += '</div>';
						$('#searchUserListDiv').html(html);
						$('#searchUserListDiv').slideDown(400);
					}
					
				});
			}else{
				alert('검색할 이름을 입력하세요!');
				$('searchUserByName').focus();
				return;
			}
		}
		
		// 친구 > 검색폼 여닫기
		function formOpen(){
			var check = $('#userSearchForm').find('#check').val();
			if(check == 'close'){
				$('#userSearchForm').slideDown(400);
				$('#userSearchForm').find('#check').val('open');
			}else if(check == 'open'){
				$('#userSearchForm').slideUp(400);
				$('#userSearchForm').find('#check').val('close');
			}
			
		}
		
		function userListOpen(checkNum){
			if(checkNum == 2){
				$('#searchUserListDiv').slideUp(400);
				$('#searchUserListDiv').empty();
				$('#userSearchForm').slideUp(400);
				$('#userSearchForm').find('#check').val('close');
			}
		}
		
		function openWriteForm(){
			$('#writeForm').slideDown();
			$('#albumMsg').focus();
		}
		
		function closeWriteForm(){
			$('#writeForm').slideUp();
		}
		
		//일상등록
		function addAlbum(){
			var formData = new FormData($("#albumInputForm")[0]);
			var albumMsg = $('#albumMsg').val();
			
			if(albumMsg == null || albumMsg == ''){
				alert('내용을 입력해주세요')
				return;
			}
			
			$.ajax({
				type : 'post',
	            url : 'addAlbum',
	            data : formData ,
	            processData : false,
	            contentType : false,
	            success : function(data) {
	            	if(data.check){
	            		alert('등록 되었습니다.');
	            		window.location.reload(true);
					}
	            },
				error : function(error) {
	                alert("등록에 실패하였습니다.");
	                console.log(error);
	                console.log(error.status);
	            }
			});
		}
		
		
		//좋아요 ++
		$(document).on('click','.goodCountPlusBtn',function(){
			var goodCountNow = parseInt($(this).closest('#albumButtonTr').find('#goodCountTag').text());
			var albumNo = $(this).closest('#albumDiv').find('#albumNo').val();
			console.log(goodCountNow,albumNo);
			
			var countPlus = goodCountNow + 1;
			var goodCountTag = $(this).closest('#albumButtonTr').find('#goodCountTag');
			
			
			$.ajax({
				url : 'addAlbumGood',
				type : 'post',
				data : {'albumNo':albumNo,'albumGood':goodCountNow},
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
		
		//일상 댓글 >오픈,클로즈!!
		$(document).on('click','.openAlbumCommentBtn',function(){
			var check = $(this).closest('#albumDiv').find('#commentOpenCheck').val();
			var checkTag = $(this).closest('#albumDiv').find('#commentOpenCheck')
			var commnetTag = $(this).closest('#albumDiv').find('#albumCommentDiv');
			console.log(check,checkTag,commnetTag);
			
			if(check == 'close'){
				$(commnetTag).slideDown();
				$(checkTag).val('open');
			}else if(check == 'open'){
				$(commnetTag).slideUp();
				$(checkTag).val('close');
			}
		});
		
		
		//일상 > 댓글 등록
		$(document).on('click','.addCommentBtn',function(){
			var comContent = $(this).closest('#albumDiv').find('input[name="comContent"]').val();
			var albumNo = $(this).closest('#albumDiv').find('#albumNo').val();
			var commentWriteFormTag = $(this).closest('#commentWriteFormTag');
			
			if(comContent == null || comContent == ''){
				alert('댓글을 입력해주세요!');
				return;
			}
			
			var html ='';
			$.ajax({
				url : 'addAlbumComment',
				data : {'comContent':comContent,'albumNo':albumNo} ,
				dataType : 'json' ,
				type : 'post',
				success : function(data){
					if(data.check == 'true'){
						alert('댓글이 등록되었습니다');
						window.location.reload(true);
						
						/* html += '<table style="width:100%">';
						html += '<tr>';
						html += '<td style="border-top:1px solid #ddd;">';
						if(data.comment.userImgOld != null && data.comment.userImgNew != null){
							html += '<img src="resources/files/'+data.comment.userId.substring(0,1)+'/'+data.comment.userImgNew+'" style="width:45px;height:45px;border-radius:15px;" />';
						}else if(data.comment.userImgOld == null && data.comment.userImgNew != null){
							html += '<img src="resources/files/'+data.comment.userId.substring(0,1)+'/'+data.comment.userImgNew+'" style="width:45px;height:45px;border-radius:15px;" />';
						}else if(data.comment.userImgOld == null && data.comment.userImgNew == null){
							html += '<img src="resources/img/ready.jpg" style="width:45px;height:45px;border-radius:15px;" />'
						}
						html += '<td style="border-top:1px solid #ddd;">';
						html += '<font style="font-weight:bold;font-size:14px;">'+data.comment.userName+'</font><br/>';
						html += '<font style="font-weight:bold;">'+data.comment.comContent+'}</font>';
						html += '</td>';
						html += '</td>';
						html += '</tr>';
						html += '</table>';
						
						$(this).closest('#commentWriteFormTag').before(html);  */
					}else if(data.check == 'false'){
						alert('댓글 등록에 실패하였습니다')
					}
				}
			});
		});
		
		function userList(classNum){
			var sessionId = '${sessionId}';
			
			if(classNum != null && classNum != ''){
				$.ajax({
					url : 'searchUserByClass',
					type : 'post',
					data : {'classNum':classNum},
					dataType : 'json',
					success:function(data){
						$('#searchUserListDiv').empty();
						
						var html = '';
						html += '<div>';
						html += '<table style="width:100%;">'
						
						if(data[0].userId.substring(0,1) == '8'){
							html += '<tr>';
							html += '<td style="width:61px;border-bottom:1px dotted #ddd;">';
							html += '<img src="resources/files/8/3848.jpg" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">';
							html += '</td>';
							html += '<td style="width:61px;border-bottom:1px dotted #ddd;">';
							html += '<img src="resources/files/8/3848new.jpg" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">';
							html += '</td>';
							html += '<td style="border-bottom:1px dotted #ddd;">';
							html += '<font style="color:#030066;font-weight:bold;">회장 최기호</font><br/>';
							html += '<font style="font-size:13px;font-weight:bold;">전북 전주시</font>';
							html += '</td><td style="text-align:right;border-bottom:1px dotted #ddd;">';
							html += '<a href="tel:010-2607-0689"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>';
							html += '</td>';
							html += '</tr>';
							
							html += '<tr>';
							html += '<td style="width:61px;border-bottom:1px dotted #ddd;">';
							html += '<img src="resources/files/8/3845.jpg" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">';
							html += '</td>';
							html += '<td style="width:61px;border-bottom:1px dotted #ddd;">';
							html += '<img src="resources/files/8/3845new.jpg" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">';
							html += '</td>';
							html += '<td style="border-bottom:1px dotted #ddd;">';
							html += '<font style="color:#030066;font-weight:bold;">총무 정윤승</font><br/>';
							html += '<font style="font-size:13px;font-weight:bold;">전북 전주시</font>';
							html += '</td><td style="text-align:right;border-bottom:1px dotted #ddd;">';
							html += '<a href="tel:010-9476-4884"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>';
							html += '</td>';
							html += '</tr>';
						}else if(data[0].userId.substring(0,1) == '6'){
							html += '<tr>';
							html += '<td style="width:61px;border-bottom:1px dotted #ddd;">';
							html += '<img src="resources/files/6/3632.jpg" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">';
							html += '</td>';
							html += '<td style="width:61px;border-bottom:1px dotted #ddd;">';
							html += '<img src="resources/files/6/3632new.jpg" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">';
							html += '</td>';
							html += '<td style="border-bottom:1px dotted #ddd;">';
							html += '<font style="color:#030066;font-weight:bold;">재무 오민권</font><br/>';
							html += '<font style="font-size:13px;font-weight:bold;">전북 전주시</font>';
							html += '</td><td style="text-align:right;border-bottom:1px dotted #ddd;">';
							html += '<a href="tel:010-3673-1951"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>';
							html += '</td>';
							html += '</tr>';
						}
						$.each(data, function(i, result){
							if(result.userId != '845' && result.userId != '848' && result.userId != '632'){
								html += '<tr>';
								html += '<td style="width:61px;border-bottom:1px dotted #ddd;height:75px;">';
								if(result.userImgOld != null && result.userImgNew == null){
									html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgOld+'" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">'
									html += '</td><td colspan="2" style="border-bottom:1px dotted #ddd;">'
								}else if(result.userImgOld != null && result.userImgNew != null){
									html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgOld+'" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">'
									html += '</td><td style="width:61px;border-bottom:1px dotted #ddd;">';
									html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgNew+'" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">'
									html += '</td><td style="border-bottom:1px dotted #ddd;">';
								}else if(result.userImgOld == null && result.userImgNew == null){
									html += '</td><td colspan="2" style="border-bottom:1px dotted #ddd;">'
								}
								if(result.userDo == null || result.userCityName == null){
									html += '<font style="color:black;font-weight:bold;">'+result.userName+'</font><br/>';
								}else if(result.userDo != null || result.userCityName != null){
									html += '<font style="color:black;font-weight:bold;">'+result.userName+'</font><br/>';
									html += '<font style="font-size:13px;font-weight:bold;">'+result.userDo+' '+result.userCityName+'</font>';
								}
								html += '</td><td style="text-align:right;border-bottom:1px dotted #ddd;">';
								if(sessionId == result.userId){
									html += '<a href="#page9"><img src="resources/img/info.jpg" style="width:43px;height:43px;"/></a>'
								}
								if(result.userHp != null && result.userHp != ''){
									html += '<a href="tel:'+result.userHp+'"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>';
								}else{
									/* html += '<a href="#page9"><img src="resources/img/nohp.png" style="width:40px;height:40px;"/></a>'; */
								}
								html += '</td>';
								html += '</tr>';
							}
						});
						html += '</table>';
						html += '</div>';
						$('#userListDiv').html(html);
						$('#userListDiv').slideDown(400);
					}
					
				});
			}
		}
		
		function noticeAddCtrl(){
			$('.topList2').css('background-color','#ffffff');
			$('#ctrl1').css('background-color','#C1F2FF');
			
			$('#smsSendDiv').css('display','none');
			$('#accountingDiv').css('display','none');
			$('#statDiv').css('display','none');
			$('#allUserViewDiv').css('display','none');
			$('#connectionDiv').css('display','none');
			$('#duesCtrlDiv').css('display','');
		}
		
		function allUserViewCtrl(){
			$('.topList2').css('background-color','#ffffff');
			$('#ctrl2').css('background-color','#C1F2FF');
			
			$('#duesCtrlDiv').css('display','none');
			$('#smsSendDiv').css('display','none');
			$('#accountingDiv').css('display','none');
			$('#statDiv').css('display','none');
			$('#connectionDiv').css('display','none');
			$('#allUserViewDiv').css('display','');
		}
		
		function smsAddCtrl(){
			$('.topList2').css('background-color','#ffffff');
			$('#ctrl3').css('background-color','#C1F2FF');
			$('#duesCtrlDiv').css('display','none');
			$('#allUserViewDiv').css('display','none');
			$('#accountingDiv').css('display','none');
			$('#statDiv').css('display','none');
			$('#connectionDiv').css('display','none');
			$('#smsSendDiv').css('display','');
		}
		
		function accountingCtrl(){
			$('.topList2').css('background-color','#ffffff');
			$('#ctrl4').css('background-color','#C1F2FF');
			$('#duesCtrlDiv').css('display','none');
			$('#allUserViewDiv').css('display','none');
			$('#smsSendDiv').css('display','none');
			$('#statDiv').css('display','none');
			$('#connectionDiv').css('display','none');
			/* $('#accountingDiv').css('display',''); */
			window.location.href = 'https://m.nonghyup.com/servlet/PMAI1010R.view';
		}
		
		function statCtrl(){
			$('.topList2').css('background-color','#ffffff');
			$('#ctrl5').css('background-color','#C1F2FF');
			$('#duesCtrlDiv').css('display','none');
			$('#allUserViewDiv').css('display','none');
			$('#smsSendDiv').css('display','none');
			$('#accountingDiv').css('display','none');
			$('#connectionDiv').css('display','none');
			$('#statDiv').css('display','');
		}
		
		function connectionCtrl(){
			$('.topList2').css('background-color','#ffffff');
			$('#ctrl6').css('background-color','#C1F2FF');
			$('#duesCtrlDiv').css('display','none');
			$('#allUserViewDiv').css('display','none');
			$('#smsSendDiv').css('display','none');
			$('#accountingDiv').css('display','none');
			$('#statDiv').css('display','none');
			$('#connectionDiv').css('display','');
			
		}
		function inputFormClose(noticeType){
			if(noticeType == 1){
				$('#contentDiv').slideUp(400);
			}else if(noticeType == 2){
				$('#eventDiv').slideUp(400);
			}else if(noticeType == 3){
				$('#normalDiv').slideUp(400);
			}else if(noticeType == 4){
				$('#noticeModifyDiv').slideUp(400);
			}
		}
		
		function cencelModifyAlbum(){
			window.location.reload(true);
		}
		//일상 > 글수정 >> 수정폼연결
		$(document).on('click','.albumModifyBtn',function(){
			//글수정
			var albumMsg = $(this).closest('#albumDiv').find('#albumMsgH4').text();
			
			$(this).closest('#albumDiv').find('#albumMsgH4').empty();
			var html = '<table style="width:100%;">';
			html += '<tr>';
			html += '<td style="width:70%">';
			html += '<textarea name="albumMsg" id="albumMsg2" style="width:95%">'+albumMsg+'</textarea>';
			html += '</td><td>'
			html += '<button type="button" class="modifyAlbum" style="background-color:#D4F4FA;width:90%;height:36px;border-radius:5px;text-align:center;">수정</button>'
			html += '</td><td>'
			html += '<button type="button" onclick="cencelModifyAlbum();" style="background-color:#D4F4FA;width:90%;height:36px;border-radius:5px;text-align:center;">취소</button>'
			html += '</td>';
			html += '</tr>';
			html += '</table>';
			
			$(this).closest('#albumDiv').find('#albumMsgH4').append(html);
			
		});
		
		//일상 > 글삭제
		$(document).on('click','.albumDeleteBtn',function(){
			var albumNo = $(this).closest('#albumDiv').find('#albumNo').val();
			
			if(confirm("삭제 하시겠습니까?") == true){
				$.ajax({
					url : 'removeAlbum',
					type : 'post',
					dataType : 'json',
					data : {'albumNo' : albumNo},
					success : function(data){
						if(data.check == 'true'){
							alert('삭제 되었습니다.');
							window.location.reload(true);
						}else{
							alert('삭제에 실패하였습니다.')
							window.location.reload(true);
						}
					}
				});
			}else{
				return;
			}
		});	
		
		//일상 수정
		$(document).on('click','.modifyAlbum',function(){
			var albumNo = $(this).closest('#albumDiv').find('#albumNo').val();
			var albumMsg = $(this).parent().parent().find('#albumMsg2').val();
			
			console.log(albumNo, albumMsg);
			if(confirm("수정 하시겠습니까?") == true){
				$.ajax({
					url : 'modifyAlbum',
					type : 'post',
					dataType : 'json',
					data : {'albumNo' : albumNo, 'albumMsg':albumMsg},
					success : function(data){
						if(data.check == 'true'){
							alert('수정 되었습니다.');
							window.location.reload(true);
						}else{
							alert('수정에 실패하였습니다.')
							window.location.reload(true);
						}
					}
				});
			}else{
				window.location.reload(true);
			}
		});
		
		// 공지 > 공지 > 삭제
		$(document).on('click','.noticeDeleteBtn',function(){
			var noNum = $(this).closest('#bodyTable').find('#noNum').val();
			
			if(confirm("삭제 하시겠습니까?") == true){
				$.ajax({
					url : 'deleteNotice',
					type : 'post',
					dataType : 'json',
					data : {'noNum' : noNum},
					success : function(data){
						if(data.check == 'true'){
							alert('삭제 되었습니다.');
							window.location.reload(true);
						}else{
							alert('삭제에 실패하였습니다.')
							window.location.reload(true);
						}
					}
				});
			}else{
				return;
			}
		});
		
		//공지 > 행사 > 수정 > 폼생성
		$(document).on('click','.noticeModifyBtn',function(){
			var noNum = $(this).closest('#accodianDiv').find('#noNum').val();
			var noType = $(this).closest('#accodianDiv').find('#noType').val();
			
			$.ajax({
				url : 'readNoticeForModify',
				type : 'post',
				dataType : 'json',
				data : {'noNum' : noNum,'noType':noType},
				success : function(data){
					$('#noticeModifyDiv').empty();
					if(data.noType == 1){
						var html = '<form id="noticeModifyForm">';
						html += '<input type="hidden" name="noType" value="'+data.noType+'"/>';
						html += '<input type="hidden" name="noNum" value="'+data.noNum+'"/>';
						html +=	'<table style="width:100%;border:3px solid #ddd;">';
						html +=	'<tr>'
						html += '<td colspan="2"><input type="text" name="coTargetName" id="coTargetName" style="width:90%;" value="'+data.coTargetName+'"></td>'
						html += '<td style="width:20%"><input type="text" name="coTargetClass" id="coTargetClass" style="width:70px;" value="'+data.coTargetClass+'">';
						html +=	'<td style="width:20%;text-align:right;"><a onclick="inputFormClose(4)">';
						html += '<img src="resources/img/cencel.jpg" style="width:20px;height:20px;">';
						html += '</a>';
						html += '</td></tr><tr>';
						html += '<td colspan="4"><input type="text" name="coContent" id="coContent" style="width:95%" value="'+data.coContent+'"></td>';
						html += '</tr><tr>';
						html += '<td colspan="4"><input type="text" name="coPlace" id="coPlaceContent style="width:95%" value="'+data.coPlace+'"></td>';
						html += '</tr><tr>';
						html += '<td style="width:28%;">발인 : </td>';
						html += '<td colspan="3"><input type="date" name="coHanddate" id="coHanddate" value="'+data.coHanddate+'"></td>';
						html += '</tr><tr>';
						html += '<td style="width:28%;">단체 : </td>';
						html += '<td style="width:35%;"><input type="date" name="coVisitDate" style="width:130px;" id="coVisitDate" value="'+data.coVisitDate+'"></td>';
						html += '<td style="width:17%;"><input type="text" name="coVisitHour" style="width:40px;" value="'+data.coVisitHour+'"/></td>'
						html += '<td style="width:20%;"><input type="text" name="coVisitMinute" style="width:40px;" value="'+data.coVisitMinute+'"/></td>';
						html += '</tr></table>';
						html += '<button type="button" style="background-color:#ddd;width:100%;" id="noticeModify">수정</a>';
						html += '</form>';
					}else if(data.noType == 2){
						var html = '<form id="noticeModifyForm">';
						html += '<input type="hidden" name="noType" value="'+data.noType+'"/>';
						html += '<input type="hidden" name="noNum" value="'+data.noNum+'"/>';
						html +=	'<table style="width:100%;text-align:center;border:3px solid #ddd;">';
						html +=	'<tr>'
						html += '<td><input type="text" name="noSubject" id="noSubject" style="width:100%;" value="'+data.noSubject+'"></td>'
						html += '<td style="font-weight:bold;font-size:17px;width:30px;">'
						html +=	'<a onclick="inputFormClose(4)">'
						html += '<font style="float:right;"><img src="resources/img/cencel.jpg" style="width:20px;height:20px;"></font>';
						html += '</a>';
						html += '</td></tr><tr>';
						html += '<td colspan="2"><input type="text" name="coPlace" style="width:100%;" id="coPlaceContent" value="'+data.coPlace+'"></td>';
						html += '</tr><tr>';
						html += '<td colspan="2"><input type="tel" name="coMoney" style="width:100%;" id="coMoney" value="'+data.coMoney+'"></td>';
						html += '</tr><tr>';
						html += '<td colspan="2"><input type="date" name="coEventDate" id="coEventDate" style="width:100%;" value="'+data.coEventDate+'"></td>';
						html += '</tr><tr>';
						html += '<td colspan="2"><input type="text" name="coContent" id="coContent" style="width:100%;" value="'+data.coContent+'"></td>';
						html += '</tr></table>';
						html += '<button type="button" style="background-color:#ddd;width:100%;" id="noticeModify">수정</a>';
						html += '</form>';
					}else if(data.noType == 3){
						var html = '<form id="noticeModifyForm">';
						html += '<input type="hidden" name="noType" value="'+data.noType+'"/>';
						html += '<input type="hidden" name="noNum" value="'+data.noNum+'"/>';
						html +=	'<table style="width:100%;text-align:center;border:3px solid #ddd;">';
						html +=	'<tr>'
						html += '<td style="width:60%"><input type="text" name="noTargetName" style="width:100%;" id="noTargetName" value="'+data.noTargetName+'"></td>'
						html += '<td style="width:20%"><input type="text" name="noTargetClass" style="width:60px;" id="noTargetClass" value="'+data.noTargetClass+'"></td>'
						html +=	'<td style="width:20%;"><a onclick="inputFormClose(4)">'
						html += '<font style="float:right;"><img src="resources/img/cencel.jpg" style="width:20px;height:20px;"></font>';
						html += '</a>';
						html += '</td></tr><tr>';
						html += '<td colspan="3"><input type="text" name="noSubject" id="noSubject" style="width:100%;" value="'+data.noSubject+'"></td>';
						html += '</tr><tr>';
						html += '<td colspan="3"><input type="text" name="noContents" id="noContents" style="width:100%;" value="'+data.noContents+'"></td>';
						html += '</tr></table>';
						html += '<button type="button" style="background-color:#ddd;width:100%;" id="noticeModify">수정</a>';
						html += '</form>';
					}
					$('#noticeModifyDiv').append(html);
					$('#noticeModifyDiv').slideDown();				
				}
			});			
		});
		
		//공지수정
		$(document).on('click','#noticeModify',function(){
			var params = $('#noticeModifyForm').serialize();
			
			$.ajax({
				url : 'modifyNotice',
				data : params,
				dataType : 'json',
				type : 'post',
				success : function(data){
					if(data.check == 'true'){
						alert('수정이 완료되었습니다');
						window.location.reload(true);
					}
				}
			});
		});
		
		function searchAlbumByUser(){
			var userName = $('#searchAlbumByUser').val();
			var cookieId = '${cookie.cookieId.value}';
			var html = '';
			
			$.ajax({
				url : 'searchAlbumByUser',
				data : {'userName':userName},
				dataType : 'json',
				type : 'post',
				success : function(data){
					console.log(data);
					if(data.length > 0){
						$.each(data,function(i,result){
							html += '<div id="albumDiv">';
							html += '<input type="hidden" id="albumNo" value="'+result.albumNo+'"/>';
							html += '<input type="hidden" id="commentOpenCheck" value="close"/>';
							html += '<input type="hidden" id="albumPath" value="'+result.userId.substring(0,1)+'"/><br/>';
							html += '<table style="width:100%;border-top:2px solid #ddd;">';
							html += '<tr>';
							html += '<td style="width:25px;"><img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgOld+'" style="width:30px;height:30px;border-radius:10px;"/></td>';
							html += '<td style="width:45px;font-size:15px;font-weight:bold;">'+result.userName+'</td>';
							html += '<td style="font-size:14px;">'+result.albumRegDate+'</td>';
							html += '<td style="width:10%;"><a href="tel:'+result.userHp+'"><img src="resources/img/call.jpg" style="width:25px;height:25px;"/></a></td>';
							html += '</tr>';
							html += '</table>';
							$.each(result.fileList, function(i, photoList){
								html += '<input type="hidden" id="fileName" value="'+photoList.fileName+'"/>';
								if(photoList.fileName == 'birthday.PNG'){
									html += '<img src="resources/files/'+photoList.filePath+'/'+photoList.fileName+'" style="width:100%;height:180px;border-radius:10px;"/>';
								}else{
								html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+photoList.fileName+'" style="width:100%;height:180px;border-radius:10px;"/>';
								}
							});
							html += '<h4 id="albumMsgH4">'+result.albumMsg+'</h4>';
							/* 버튼으로 변경
							html += '<div style="font-size:14px;">';
							html += '<img src="resources/img/good.jpg" style="width:14px;height:14px;"/>';
							html += '좋아요 <font style="font-weight:bold;" id="goodCountTag">'+result.albumGood+'</font>';
							html += '</div>'; */
							
							html += '<table style="width:100%;text-align:center;">';
							html += '<tr id="albumButtonTr">';
							if(result.userId == cookieId){
								/* html += '<button type="button" style="width:33%;float:left;" class="openAlbumCommentBtn">';
								html += '댓글 '+result.commentList.length+'</button>';
								html += '<button type="button" style="width:33%;float:left;" class="albumModifyBtn">글수정</button>';
								html += '<button type="button" style="width:33%;float:left;" class="albumDeleteBtn">글삭제</button>'; */
								
								html += '<td class="topList4 goodCountPlusBtn">좋아요(<font style="font-weight:bold;" id="goodCountTag">'+result.albumGood+'</font>)</td>';
								html += '<td class="topList4 openAlbumCommentBtn">댓글('+result.commentList.length+')</td>';
								html += '<td class="topList4 albumModifyBtn">수정</td>';
								html += '<td class="topList4 albumDeleteBtn">삭제</td>';
							}else if(result.userId != cookieId){
								/* html += '<button type="button" style="width:49%;float:left;" class="goodCountPlusBtn">좋아요</button>';
								html += '<button type="button" style="width:49%;float:left;" class="openAlbumCommentBtn">';
								html += '댓글 '+result.commentList.length+'</button>'; */
								
								html += '<td class="topList4 goodCountPlusBtn">좋아요(<font style="font-weight:bold;" id="goodCountTag">'+result.albumGood+'</font>)</td>';
								html += '<td class="topList4 openAlbumCommentBtn">댓글('+result.commentList.length+')</td>';
							}
							html += '</tr>';
							html += '</table>';
							html += '<div id="albumCommentDiv" style="display:none;">';
							html += '<table style="width:100%" id="albumCommentTable">';
							$.each(result.commentList,function(i, commentList){
								html += '<tr>';
								if(commentList.userImgNew != null && commentList.userImgOld != null){
									html += '<td style="border-top:1px solid #ddd;width:50px;">';
									html += '<img src="resources/files/'+commentList.userId.substring(0,1)+'/'+commentList.userImgNew+'" style="width:40px;height:40px;border-radius:10px;" />';
									html += '</td>';
								}else if(commentList.userImgNew == null && commentList.userImgOld != null){
									html += '<td style="border-top:1px solid #ddd;width:50px;">';
									html += '<img src="resources/files/'+commentList.userId.substring(0,1)+'/'+commentList.userImgOld+'" style="width:40px;height:40px;border-radius:10px;" />';
									html += '</td>';
								}else if(commentList.userImgNew == null && commentList.userImgOld == null){
									html += '<td style="border-top:1px solid #ddd;width:50px;">';
									html += '<img src="resources/img/ready.jpg" style="width:40px;height:40px;border-radius:15px;" />';
									html += '</td>';
								}
								html += '<td style="border-top:1px solid #ddd;">';
								html += '<font style="font-weight:bold;font-size:14px;">'+commentList.userName+'</font><br/>';
								html += '<font style="font-weight:bold;">'+commentList.comContent+'</font>';
								html += '</td>';
								if(commentList.userId == cookieId){
									html += '<td style="border-top:1px solid #ddd;text-align:right;">';
									html += '<input type="hidden" id="commentNum" value="'+commentList.comNum+'"/>';
									html += '<a href="#" class="commentDeleteBtn"><img src="resources/img/cencel.jpg" style="width:26px;height:26px;"/></a>';
									html += '</td>';
								}
		
								html += '</tr>';
							});
							
							html += '</table>';
							/*댓글입력  */
							html += '<div style="width:100%;" id="commentWriteForm">';
							html += '<table style="width:100%;">';
							html += '<td style="width:85%;"><input type="text" style="width:100%" name="comContent" placeholder="댓글 입력"></td>';
							html += '<td style="text-align:right;"><a href="#" style="width:12%;" class="addCommentBtn">';
							html += '<img src="resources/img/plus.jpg" style="width:30px;height:30px;"/></a></td>';
							html += '</table>';
							html += '</div>';
							html += '</div>';
							html += '</div>';
							console.log('h2');
						});
						console.log(html);
						$('#albumListDiv').empty();
						$('#albumListDiv').html(html);
					}else{
						alert('검색 결과가 없습니다.');
						return;
					} 
				}
			});
		}
		
		function photoOpen(num){
			if(num == 1){
				location.href = 'muju2016List';
			}else if(num == 2){
				location.href = 'before30thList';
			}else if(num == 3){
				location.href = 'after30thList';
			}else if(num == 4){
				location.href = 'adminList';
			}else if(num == 5){
				location.href = 'muju2017List';
			}else if(num == 7){
				location.href = 'albumList';
			}
			submit();
		}
		
		function statDetail(classNum){
			location.href = 'statDetail?classNum='+classNum;
		}
		
		function songList(num){
			location.href = 'songList?num='+num;
		}
		
		function duesDetail(classNum){
			location.href = 'duesDetail?classNum='+classNum;
		}
		
		// 댓글삭제
		$(document).on('click','.commentDeleteBtn',function(){
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
		
		$(document).on('click','.joinListBtn',function(){
			var noNum = $(this).closest('#bodyTable').find('#noNum').val();
			console.log('공지번호 확인 : '+noNum);
			
			$.ajax({
				url : 'readJoinUserList',
				data : {'noNum':noNum},
				dataType : 'json',
				type : 'post',
				success : function(data){
					console.log(data);
					if(data.length > 0){
						var html = '<table style="width:100%;">';
						$.each(data, function(i, result){
							html += '<tr>';
							html += '<td style="width:43px;border-bottom:1px dotted #ddd;height:42px;">';
							if(result.userImgOld != null && result.userImgNew == null){
								html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgOld+'" style="width:42px;height:42px;margin-top:10px;border-radius:10px;">'
								html += '</td><td style="border-bottom:1px dotted #ddd;">'
							}else if(result.userImgOld != null && result.userImgNew != null){
								/* html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgOld+'" style="width:42px;height:42px;margin-top:10px;border-radius:10px;">'
								html += '</td><td style="width:43px;border-bottom:1px dotted #ddd;">'; */
								html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgNew+'" style="width:42px;height:42px;margin-top:10px;border-radius:10px;">'
								html += '</td><td style="border-bottom:1px dotted #ddd;">';
							}else if(result.userImgOld == null && result.userImgNew == null){
								html += '</td><td style="border-bottom:1px dotted #ddd;">'
							}
							if(result.userDo == null || result.userCityName == null){
								html += '<font style="color:black;font-weight:bold;">'+result.userName+'('+result.userId.substring(0,1)+'반)</font><br/>';
							}else if(result.userDo != null || result.userCityName != null){
								html += '<font style="color:black;font-weight:bold;">'+result.userName+'('+result.userId.substring(0,1)+'반)</font><br/>';
								html += '<font style="font-size:13px;font-weight:bold;">'+result.userDo+' '+result.userCityName+'</font>';
							}
							if(result.joJoinShape == '참여'){
								html += '</td><td style="width:40px;border-bottom:1px dotted #ddd;"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#000054;">참여</font>';
							}else if(result.joJoinShape == '불참'){
								html += '</td><td style="width:40px;border-bottom:1px dotted #ddd;"><font style="border:1px solid #FF0000;border-radius:5px;height:25px;font-weight:bold;padding:3px;color:#C90000;">불참</font>';
							}
							html += '</td><td style="text-align:right;border-bottom:1px dotted #ddd;width:36px;">';
							if(result.userHp != null && result.userHp != ''){
								html += '<a href="tel:'+result.userHp+'"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>';
							}else{
								/* html += '<a href="#page9"><img src="resources/img/nohp.png" style="width:40px;height:40px;"/></a>'; */
							}
							html += '</td>';
							html += '</tr>';
						});
						html += '</table>';
						infoPopUp(html);
					}
				}
			});
		})
		
		function infoPopUp(txt){
		    modal({
		        type: 'info',
		        title: '참여',
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


		</script>
</head>
<body>
	<section id="page1" data-role="page">
	    <header data-role="header" style="height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:rgba(255,255,255,0.5);margin-top:15px;"><font style="font-weight:bold;color:red;">MY</font></a>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="#" class="ui-btn-active ui-state-persist"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#page2" data-transition="none"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#page4" data-transition="none"><font style="font-size:16px;">공지</font></a></li>
	                <li><a href="#page7" data-transition="none"><font style="font-size:16px;">일상</font></a></li>
	                <li><a href="#page8" data-transition="none"><font style="font-size:16px;">관리</font></a></li>
	            </ul>
	        </div><!-- /navbar -->
	    </header>                   
	    
	    <div class="content" data-role="content" style="margin-top:40px;">
	    	<!-- 상단목록 -->
	    	<table style="width:100%;border-bottom:3px solid #ddd;margin-top:2px;font-size:15px;">
	    		<tr>
	    			<!-- <td class="topList" onclick="userList(1);" id="class1">1반<br/><font style="font-size:13px;">58</font></td>
	    			<td class="topList" onclick="userList(2);" id="class2">2반<br/><font style="font-size:13px;">54</font></td>
	    			<td class="topList" onclick="userList(3);" id="class3">3반<br/><font style="font-size:13px;">55</font></td>
	    			<td class="topList" onclick="userList(4);" id="class4">4반<br/><font style="font-size:13px;">57</font></td>
	    			<td class="topList" onclick="userList(5);" id="class5">5반<br/><font style="font-size:13px;">56</font></td>
	    			<td class="topList" onclick="userList(6);" id="class6">6반<br/><font style="font-size:13px;">60</font></td>
	    			<td class="topList" onclick="userList(7);" id="class7">7반<br/><font style="font-size:13px;">57</font></td>
	    			<td class="topList" onclick="userList(8);" id="class8">8반<br/><font style="font-size:13px;">58</font></td>
	    			<td><a href="#" onclick="formOpen()"><img src="resources/img/search.png" style="width:33px;height:33px;"></a></td> -->
	    			
	    			<td style="width:35%;height:35px;">
	    				<select style="height:35px;" onchange="userList(this.value)" data-native-menu="false">
	    					<option value="1">1반(${joinCountList.get(0)}/58)</option>
	    					<option value="2">2반(${joinCountList.get(1)}/54)</option>
	    					<option value="3">3반(${joinCountList.get(2)}/55)</option> 
	    					<option value="4">4반(${joinCountList.get(3)}/57)</option>
	    					<option value="5">5반(${joinCountList.get(4)}/56)</option>
	    					<option value="6" selected="selected">6반(${joinCountList.get(5)}/60)</option>
	    					<option value="7">7반(${joinCountList.get(6)}/57)</option>
	    					<option value="8">8반(${joinCountList.get(7)}/58)</option>
	    				</select>
	    			</td>
	    			<td style="width:50%;">
	    				<input type="text" style="height:39px;" name="searchUserByName" id="searchUserByName" placeholder="이름/지역"/>
	    			</td>
	    			<td style="width:15%;text-align:right;" onclick="searchUser();">
	    				<img src="resources/img/search.jpg" style="width:41px;height:41px;">
	    			</td>
	    			<!-- <td style="width:10%;text-align:center;"><img src="resources/img/cencel2.png" style="width:28px;height:28px;"/></td> -->
	    		</tr>
	    	</table>	
	    	
	    	<!-- <div style="width:100%;display:none;" id="userSearchForm" class="form">
	    		<input type="hidden" id="check" value="close"/>
	    		<table style="width:100%">
	    			<tr>
	    				<td style="width:70%;"><input type="text" style="width:100%;border:2px solid #ddd;padding-top:5px;" name="searchUserByName" id="searchUserByName" placeholder="검색할 이름을 입력"></td>
	    				<td style="width:20%;">
		    				<div style="width:80%;border:2px solid #ddd;border-radius:5px;text-align:center;height:35px;font-size:20px;" onclick="searchUser();">
								검색
							</div>
						</td>
	    				<td onclick="userListOpen(2);"><font><img src="resources/img/cencel.png" style="width:25px;height25px;"/></font></td>
	    			</tr>
	    		</table>
			</div> -->
	    	
	    	<div id="searchUserListDiv">
				
			</div>
			
			<div id="userListDiv">
				<!-- <button type="button" style="background-color:#B4E7FF;width:100%;font-weight:bold;height:40px" onclick="userListOpen(2);">6반
					<font style="float:right;"><img src="resources/img/cencel.png" style="width:25px;height25px;"/></font>
				</button> -->
				<table style="width:100%;">
					<tr>
						<td style="width:61px;height:76px;border-bottom:1px dotted #ddd;">
							<img src="resources/files/6/3632.jpg" style="width:58px;height:58px;border-radius:10px;">
						</td>
						<td style="width:61px;height:76px;border-bottom:1px dotted #ddd;">
							<img src="resources/files/6/3632new.jpg" style="width:58px;height:58px;border-radius:10px;">
						</td>
						<td style="border-bottom:1px dotted #ddd;">
							<font style="color:#030066;font-weight:bold;">재무 오민권</font><br/>
							<font style="font-size:13px;font-weight:bold;">전북&nbsp;전주시</font>
						</td>
						<td style="text-align:right;border-bottom:1px dotted #ddd;">
							<a href="tel:'010-3673-1951'"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>
						</td>
					</tr>
					<c:forEach var="userList" items="${userList}">
						<c:if test="${userList.userId.substring(0,1) eq '6' and userList.userId ne '632'}">
						<tr>
							<td style="width:61px;height:76px;border-bottom:1px dotted #ddd;">
								<c:choose>
									<c:when test="${userList.userImgOld ne null and userList.userImgNew eq null}">
										<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgOld}" style="width:60px;height:60px;margin-top:10px;border-radius:10px;">
										</td><td colspan="2" style="border-bottom:1px dotted #ddd;">
									</c:when>
									<c:when test="${userList.userImgOld ne null and userList.userImgNew ne null}">
										<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgOld}" style="width:58px;height:58px;border-radius:10px;">
										</td><td style="width:61px;height:76px;border-bottom:1px dotted #ddd;">
										<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgNew}" style="width:58px;height:58px;border-radius:10px;">
										</td><td style="border-bottom:1px dotted #ddd;">
									</c:when>
									<c:when test="${userList.userImgOld eq null and userList.userImgNew eq null}">
										</td><td colspan="2" style="border-bottom:1px dotted #ddd;">
									</c:when>
								</c:choose>
								<c:if test="${userList.userDo eq null or userList.userCityName eq null }">
									<font style="color:black;font-weight:bold;">${userList.userName}</font><br/>
								</c:if>
								<c:if test="${userList.userDo ne null or userList.userCityName ne null }">
									<font style="color:black;font-weight:bold;">${userList.userName}</font><br/>
									<font style="font-size:13px;font-weight:bold;">${userList.userDo}&nbsp;${userList.userCityName}</font>
								</c:if>
							</td>
							<td style="text-align:right;border-bottom:1px dotted #ddd;">
								<c:choose>
									<c:when test="${userList.userHp != null && userList.userHp != ''}">
										<a href="tel:'${userList.userHp}'"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>
									</c:when>
									<c:otherwise>
										
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
		</div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	<!-- 포토 -->
	<section id="page2" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:rgba(255,255,255,0.5);margin-top:15px;"><font style="font-weight:bold;color:red;">MY</font></a>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="#page1" data-transition="none"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#" class="ui-btn-active ui-state-persist" data-transition="none"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#page4" data-transition="none"><font style="font-size:16px;">공지</font></a></li>
	                <li><a href="#page7" data-transition="none"><font style="font-size:16px;">일상</font></a></li>
	                <li><a href="#page8" data-transition="none"><font style="font-size:16px;">관리</font></a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:25px;">
	    <br/>  
	    <table class="subject">
    		<tr>
    			<td></td>
    			<td><input type="search" name="searchPhotoByUser" placeholder="이름"/></td>
    			<td style="text-align:right;"><a href="#" style="width:45px;text-align:right;" onclick=""><img src="resources/img/search.jpg" style="width:35px;height:35px;"/></a></td>
    			<c:if test="${cookie.cookieId.value eq 632 or cookie.cookieId.value eq 848 or cookie.cookieId.value eq 845}">
	    			<td style="width:36px;text-align:right;">
	    				<a href="#" onclick="openWriteForm();"><img src="resources/img/photo.jpg" style="width:35px;height:35px;"/></a>
	    			</td>
    			</c:if>
    		</tr>
    	</table>
    	<table style="width:100%;font-size:15px;">
    		<tr>
    			<td style="width:21px;border-bottom:1px solid #ddd;"><img src="resources/img/phototop.png" style="width:20px;height:20px;"/></td>
    			<td class="photoList" onclick="photoOpen(5);">
    				무주 동문회
    			</td>
    			<td style="font-size:13px;text-align:right;border-bottom:1px solid #ddd;">2017.07</td>
    		</tr>
    		<tr>
    			<td style="width:21px;border-bottom:1px solid #ddd;"><img src="resources/img/phototop.png" style="width:20px;height:20px;"/></td>
    			<td class="photoList" onclick="photoOpen(4);">
    				임원진 위취임식 행사
    			</td>
    			<td style="font-size:13px;text-align:right;border-bottom:1px solid #ddd;">2017</td>
    		</tr>
    		<tr>
    			<td style="width:21px;border-bottom:1px solid #ddd;"><img src="resources/img/phototop.png" style="width:20px;height:20px;"/></td>
    			<td class="photoList" onclick="photoOpen(3);">
    				30주년 기념식 사진
    			</td>
    			<td style="font-size:13px;text-align:right;border-bottom:1px solid #ddd;">2017</td>
    		</tr>
    		<tr>
    			<td style="width:21px;border-bottom:1px solid #ddd;"><img src="resources/img/phototop.png" style="width:20px;height:20px;"/></td>
    			<td class="photoList" onclick="photoOpen(2);">
    				30주년을 준비하며
    			</td>
    			<td style="font-size:13px;text-align:right;border-bottom:1px solid #ddd;">2017</td>
    		</tr>
    		<tr>
    			<td style="width:21px;border-bottom:1px solid #ddd;"><img src="resources/img/phototop.png" style="width:20px;height:20px;"/></td>
    			<td class="photoList" onclick="photoOpen(1);">
    				무주 동문회
    			</td>
    			<td style="font-size:13px;text-align:right;border-bottom:1px solid #ddd;">2016</td>
    		</tr>
    		<tr>
    			<td style="width:21px;border-bottom:1px solid #ddd;"><img src="resources/img/phototop.png" style="width:20px;height:20px;"/></td>
    			<td class="photoList" onclick="photoOpen(7);">
    				추억과 졸업앨범
    			</td>
    			<td style="font-size:13px;text-align:right;border-bottom:1px solid #ddd;"></td>
    		</tr>
    	</table>
    	<br/>
    	<table style="width:100%;">
    		<tr>
    			<td class="songListTd">
    				<a href="#" onclick="songList(1);">
	    				<img src="resources/img/song.jpg" style="width:40px;height:40px;"/><br/>
	    				<font style="font-size:14px;font-weight:bold;color:#030066;">유진표</font><br/>
		    			<font style="font-size:14px;font-weight:bold;color:#030066;">천년지기</font>
	    			</a>
    			</td>
    			<td class="songListTd">
    				<a href="#" onclick="songList(2);">
	    				<img src="resources/img/song.jpg" style="width:40px;height:40px;"/><br/>
	    				<font style="font-size:14px;font-weight:bold;color:#030066;">미기</font><br/>
		    			<font style="font-size:14px;font-weight:bold;color:#030066;">천년지기</font>
		    		</a>
    			</td>
    			<td class="songListTd">
    				<a href="#" onclick="songList(3);">
	    				<img src="resources/img/song.jpg" style="width:40px;height:40px;"/><br/>
	    				<font style="font-size:14px;font-weight:bold;color:#030066;">이선희</font><br/>
		    			<font style="font-size:14px;font-weight:bold;color:#030066;">인연</font>
		    		</a>
    			</td>	
    			<td class="songListTd">
    				<a href="#" onclick="songList(4);">
	    				<img src="resources/img/song.jpg" style="width:40px;height:40px;"/><br/>
	    				<font style="font-size:14px;font-weight:bold;color:#030066;">조용필</font><br/>
		    			<font style="font-size:14px;font-weight:bold;color:#030066;">친구여</font>
		    		</a>
    			</td>		    			
    		</tr>
    	</table>
	    
	    </div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>

	
	<!-- 문자 -->
	<%-- <section id="page3" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:rgba(255,255,255,0.5);">MY</a>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="#page1" data-transition="none"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#page2" data-transition="none"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#page4" data-transition="none"><font style="font-size:16px;">공지</font></a></li>
	                <li><a href="#page7" data-transition="none"><font style="font-size:16px;">일상</font></a></li>
	                <li><a href="#" data-transition="none"  class="ui-btn-active ui-state-persist"><font style="font-size:16px;">관리</font></a></li>
	            </ul>
	           
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="margin-top:50px;">
        	
        	<label for="sendTel">발송번호 : </label>
        	<input name="sendTel" id="sendTel" type="tel" placeholder="발송자 휴대폰번호 입력">

			<label for="msg">메세지입력 :</label>
       	 	<textarea name="msg" id="msg" rows="8" cols="40" height="150px;"></textarea>
       	 	
       	 	<label for="msg">수신자 :</label>
       	 	<a class="ui-shadow ui-btn ui-corner-all ui-btn-inline ui-btn-icon-left ui-icon-star" href="#" id="direct">직접입력</a>
       	 	<a class="ui-shadow ui-btn ui-corner-all ui-btn-inline ui-btn-icon-left ui-icon-search" href="#" id="searchUser">회원검색</a>
        	<a class="ui-shadow ui-btn ui-corner-all ui-btn-inline ui-btn-b ui-mini" href="#" id="sendAllBtn">전체발송</a>
        	
        	<div id="directForm" style="display:none;">
        		<input name="userHp" id="userHp" type="tel" placeholder="수신자 휴대폰번호 입력 예)01022223333" >
        		<a class="ui-shadow ui-btn ui-corner-all ui-btn-b" href="#" id="sendMmsDirectBtn">문자발송</a>
        	</div>
        	
        	<div id="searchForm" style="display:none;">
	        	<label class="select" for="searchKey">조건선택</label>
		        <select name="searchKey" id="searchKey" data-native-menu="false">
		            <option>이름/번호선택</option>
		            <option value="name">이름</option>
		            <option value="hp">휴대폰번호</option>
		            <option value="local">지역</option>   
		        </select>
		        <div id="valueDetail">
		        	<input type="text" name="searchValue" id="searchValue" placeholder="상세조건을 입력해주세요"/>
		        </div>
		        <div>
		        	<a class="ui-shadow ui-btn ui-corner-all ui-btn-b" href="#" id="searchBtn">검색</a>
		        </div>
			</div>
			<div id="resultDiv">
			
			</div>
	    </div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section> --%>
	
	<!-- 공지 > 목록-->
	<section id="page4" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:rgba(255,255,255,0.5);margin-top:15px;"><font style="font-weight:bold;color:red;">MY</font></a>
	    	<div data-role="navbar">
	             <ul>
	                <li><a href="#page1" data-transition="none"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#page2" data-transition="none"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#" data-transition="none" class="ui-btn-active ui-state-persist"><font style="font-size:16px;">공지</font></a></li>
	                <li><a href="#page7" data-transition="none"><font style="font-size:16px;">일상</font></a></li>
	                <li><a href="#page8" data-transition="none"><font style="font-size:16px;">관리</font></a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:20px;font-size:15px;">
	        <br/>
	        <!--머릿말 -->
	      	<c:if test="${cookie.cookieId.value eq 632 or cookie.cookieId.value eq 848 or cookie.cookieId.value eq 845}">
		      	<div id="noticeTitle" style="height:auto;margin-top:10px;">
		    		<table style="width:100%;text-align:center;border-bottom:3px solid #ddd;">
		    			<tr>
		    				<td id="typeContent" class="topList3">부의</td>
		    				<td id="typeEvent" class="topList3">행사</td>
		    				<td id="typeNormal" class="topList3">축하</td>
		    				<td class="topList3">기타</td>
		    			</tr>
		    		</table>
			    	
			    	<!--공지수정폼  -->
			    	<div id="noticeModifyDiv" style="display:none;width:100%;">
			    		
			    	</div>
			    	
					<!-- 부의공지입력폼 -->
					<div id="contentDiv" style="display:none;">
						<form id="contentForm">
							<input type="hidden" name="noType" value="1"/>
							<table style="width:100%;text-align:center;">
								<tr>
									<td colspan="2"><input type="text" name="coTargetName" id="coTargetName" placeholder="이름"></td>
									<td style="width:15%"><input type="text" name="coTargetClass" id="coTargetClass" placeholder="반"></td>
									<td>
										<a onclick="inputFormClose(1)">
											<font style="float:right;"><img src="resources/img/cencel.jpg" style="width:34px;height:34px;"></font>
										</a>
									</td>
								</tr>
								<tr>
									<td colspan="4"><input type="text" name="coContent" id="coContent" placeholder="내용" /></td>
								</tr>
								<tr>
									<td colspan="4"><input type="text" name="coPlace" id="coPlaceContent" placeholder="장례식장"></td>
								</tr>
								<tr>
									<td style="width:25%;">발인</td>
									<td colspan="3"><input type="date" name="coHanddate" id="coHanddate" placeholder="발인"></td>
								</tr>
								<tr>
									<td style="width:25%;">조문</td>
									<td style="width:35%;"><input type="date" name="coVisitDate" id="coVisitDate" placeholder="단체조문"></td>
									<td style="width:20%;"><input type="text" name="coVisitHour" placeholder="시"/></td>
									<td style="width:20%;"><input type="text" name="coVisitMinute" placeholder="분"/></td>
								</tr>
							</table>
							<a data-role="button" data-theme="c" style="background-color:#ddd;color:#000000;" href="#" id="contentAddBtn">공지등록</a> 
						</form>
					</div>
							
					
					<!-- 행사공지 입력폼 -->
					<div id="eventDiv" style="display:none;">
						<form id="eventForm">
							<input type="hidden" name="noType" value="2"/>
							<table style="width:100%;text-align:center;">
								<tr>
									<td><input type="text" name="noSubject" id="noSubject" placeholder="행사 제목"></td>
									<td style="font-weight:bold;font-size:17px;width:30px;">
										<a onclick="inputFormClose(2)">
											<font style="float:right;"><img src="resources/img/cencel.jpg" style="width:34px;height:34px;"></font>
										</a>
									</td>
								</tr>
								<tr>
									<td colspan="2"><input type="text" name="coPlace" id="coPlaceContent" placeholder="장소"></td>
								</tr>
								<tr>
									<td colspan="2"><input type="tel" name="coMoney" id="coMoney" placeholder="회비"></td>
								</tr>
								<tr>
									<td colspan="2"><input type="date" name="coEventDate" id="coEventDate" placeholder="행사날짜"></td>
								</tr>
								<tr>
									<td colspan="2"><input type="text" name="coContent" id="coContent" placeholder="행사 내용"></textarea></td>
								</tr>
							</table>
							<a data-role="button" data-theme="c" style="background-color:#ddd;color:#000000;" href="#" id="eventAddBtn">공지등록</a> 
						</form>
					</div>
					
					
					<!-- 축하공지 입력폼 -->
					<div id="normalDiv" style="display:none;">
						<form id="normalForm">
							<input type="hidden" name="noType" value="3"/>
							<table style="width:100%;text-align:center;">
								<tr>
									<td style="width:60%"><input type="text" name="noTargetName" id="noTargetName" placeholder="이름"></td>
									<td style="width:20%"><input type="text" name="noTargetClass" id="noTargetClass" placeholder="반"></td>
									<td>
										<a onclick="inputFormClose(3)">
											<font style="float:right;"><img src="resources/img/cencel.jpg" style="width:34px;height:34px;"></font>
										</a>
									</td>
								</tr>
								<tr>
									<td colspan="3"><input type="text" name="noSubject" id="noSubject" placeholder="제목"></td>
								</tr>
								<tr>
									<td colspan="3"><input type="text" name="noContents" id="noContents" placeholder="내용"></textarea></td>
								</tr>
							</table>
							<a data-role="button" data-theme="c" style="background-color:#ddd;color:#000000;" href="#" id="normalAddBtn">공지등록</a> 
						</form>
					</div>
				</div> <!-- 공지등록 끝 -->
	      	</c:if>
	      	
	        <c:if test="${cookie.cookieId.value ne 632 and cookie.cookieId.value ne 848 and cookie.cookieId.value ne 845}">
	        	<table class="subject" style="margin-top:10px;">
		        	<tr>
		        		<td style="width:28px;"><img src="resources/img/phototop.png" style="width:26px;height:26px;"/></td>
		        		<td>우리 모두 동참합니다</td>
		        	</tr>
		        </table>
	        </c:if>
	        <!--공지내용 들어갈부분  -->
	        <div data-role="collapsible-set" data-inset="false">
	        	<c:forEach var="noticeList" items="${noticeList }" varStatus="i">
	        		<c:if test="${noticeList.noType eq 1 }">
	        			<div data-role="collapsible" id="accodianDiv">
	        				<h3><font class="noticeH3">[哀事]${noticeList.coTargetName}(${noticeList.coTargetClass}반) ${noticeList.coContent }</font><font style="float:right;font-size:14px;padding-top:2px;">${noticeList.noRegDate }</font></h3>
							<table style="width:100%">
								<tr>
									<td>
										<c:if test="${noticeList.userImgOld ne null}">
											<img src="resources/files/${noticeList.coTargetClass}/${noticeList.userImgOld}" style="width:35px;height:35px;"/>
										</c:if>
										<c:if test="${noticeList.userImgNew ne null}">
											<img src="resources/files/${noticeList.coTargetClass}/${noticeList.userImgNew}" style="width:35px;height:35px;"/>
										</c:if>
									</td>
									<td colspan="2" style="text-align:right;">
										<c:if test="${noticeList.coUserHp != null and noticeList.coUserHp != ''}">
											<a href="tel:'${noticeList.coUserHp}'" style="float:right;"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>
										</c:if>
									</td>
								</tr>
							</table>
							<table id="bodyTable" style="width:100%">
								<input type="hidden" id="noNum" value="${noticeList.noNum }"/>
	        					<input type="hidden" id="noType" value="1"/>
								<thead>	
									<tr>
										<td style="width:20%;font-weight:bold;">내용 : </td>
										<td>${noticeList.coTargetName}(${noticeList.coTargetClass}반) ${noticeList.coContent }</td>
									</tr>
									<tr>
										<td style="width:20%;font-weight:bold;">발인 : </td>
										<td>${noticeList.coHanddate }</td>
									</tr>
										<td style="width:20%;font-weight:bold;">장소 : </td>
										<td>${noticeList.coPlace }</td>
									</tr>
									<tr>
										<td style="width:20%;font-weight:bold;">단체 : </td>
										<td>${noticeList.coVisitDate}&nbsp;오후${noticeList.coVisitHour}시&nbsp;${noticeList.coVisitMinute}분</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan="2">
											<c:if test="${cookie.cookieId.value eq 632 or cookie.cookieId.value eq 848 or cookie.cookieId.value eq 845}">
												<button type="button" style="width:49%;float:left;font-size:14px;" class="noticeModifyBtn">수정</button>
								    			<button type="button" style="width:49%;float:left;font-size:14px;" class="noticeDeleteBtn">삭제</button>
											</c:if>
										</td>
									</tr>
								</tbody>
							</table>
							
							
							<%-- <a href="#" class="contentJoinBtn" data-role="button" data-icon="edit" style="background-color:green;color:white;">참여/불참 체크</a>
							
							<form id="${noticeList.noNum}Form">
								<input type="hidden" name="noNum" value="${noticeList.noNum }" id="hiddenNoNum">
								<div id="hiddenTable" style="display:none;">
									<h3 style="text-align:center;background-color:#F6F6F6;">상세일정</h3>
									<table data-role="table" class="ui-responsive" border="1">
										<thead>
											<tr>
												<th>- 내용</th>
												<th>- 발인일시</th>
												<th>- 장소</th>
												<th>${noticeList.coPlace }</th>
												<th>- 조문일시</th>
												<th>- 참여여부</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${noticeList.coContent }</td>
												<td>${noticeList.coHanddate }</td>
												<td></td>
												<td></td>
												<td><input type="date" name="joDate" id="joDate"/></td>
												<td>
													<div data-role="controlgroup" data-type="horizontal">
														<a href="#" data-role="button" class="joinBtn">직접참여</a>
														<a href="#" data-role="button" class="notJoinBtn">불참</a>
														<input type="hidden" name="joJoinShape" id="joJoinShape"/>
										            </div>
										        </td>
											</tr>
										</tbody>
									</table>
								</div>
								<div id="hiddenTable2" style="display:none;">
									<h3 style="text-align:center;background-color:#F6F6F6;">대납안내</h3>
									<table data-role="table" border="1">
										<thead>
											<tr>
												<th>- 이름</th>
												<th>- 계좌번호</th>
												<th>- 금액</th>
												
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${noticeList.coPayName }</td>
												<td>${noticeList.coPayAccount }</td>
												<td>
													<div>
														<a href="#" data-role="button" data-inline="true" class="3">3만원</a>
														<a href="#" data-role="button" data-inline="true" class="5">5만원</a>
														<a href="#" data-role="button" data-inline="true" class="10">10만원</a>
														<a href="#" data-role="button" data-inline="true" class="etc">직접입력</a>
														<div style="display:none;" id="hiddenMoney">
															<input type="tel" id="moneyInput" placeholder="금액입력"/>
														</div>
														<input type="hidden" name="joMoney" id="joMoney"/>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<a href="#" data-role="button" style="background-color:green;color:white;display:none;" class="contentSubmitBtn">등록</a>
							</form> 참여체크로직 끝--%>
						</div>
	        		</c:if>
	        		<c:if test="${noticeList.noType eq 2 }">
	        			<div data-role="collapsible" id="accodianDiv">
							<h3><font class="noticeH3">[行事]${noticeList.noSubject }</font><font style="float:right;font-size:14px;padding-top:2px;">${noticeList.noRegDate }</font></h3>
							<table style="width:100%">
								<tr>
									<td>
										<img src="resources/files/6/3632.jpg" style="width:35px;height:35px;"/>
										<img src="resources/files/6/3632new.jpg" style="width:35px;height:35px;"/>
									</td>
									<td>
										<c:if test="${cookie.cookieId.value eq 632 or cookie.cookieId.value eq 848 or cookie.cookieId.value eq 845}">
											<a style="float:right;" class="noticeDeleteBtn"><img src="resources/img/cencel.jpg" style="width:35px;height:35px;" alt="삭제"></a>
											<a style="float:right;" class="noticeModifyBtn"><img src="resources/img/edit.jpg" style="width:35px;height:35px;" alt="취소"></a>
											<a href="tel:'010-3673-1951'" style="float:right;"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>
							    		</c:if>
							    		<c:if test="${cookie.cookieId.value ne 632 and cookie.cookieId.value ne 848 and cookie.cookieId.value ne 845}">
											<a href="tel:'010-3673-1951'" style="float:right;"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>
										</c:if>
									</td>
								</tr>
							</table>
							<table id="bodyTable" style="width:100%">
								<input type="hidden" id="noNum" value="${noticeList.noNum }"/>
								<input type="hidden" id="joinCount" value="${noticeList.joinCount }"/>
								<input type="hidden" id="notJoinCount" value="${noticeList.notJoinCount }"/>
								<input type="hidden" id="noType" value="2"/>
								<thead>
									<tr>
										<td style="width:20%;font-weight:bold;">일시 : </td>
										<td>${noticeList.coEventDate }</td>
									</tr>
									<tr>	
										<td style="width:20%;font-weight:bold;">회비 : </td>
										<td>${noticeList.coMoney} 원</td>
									</tr>
									<tr>
										<td style="width:20%;font-weight:bold;">장소 : </td>
										<td>${noticeList.coPlace }</td>
									</tr>
										<td style="width:20%;font-weight:bold;">내용 : </td>
										<td>${noticeList.coContent }</td>
									</tr>
									<tr>
										<td colspan="2">
											<button type="button" style="width:33%;float:left;font-size:15px;" class="eventJoinBtn">참여(${noticeList.joinCount})</button>
											<button type="button" style="width:33%;float:left;font-size:15px;" class="eventNotJoinBtn">불참(${noticeList.notJoinCount})</button>
											<button type="button" style="width:33%;float:left;font-size:15px;" class="joinListBtn">목록</button>
										</td>
									</tr>
								</thead>
								<tbody>
									<%-- <tr>
										<td colspan="3">
											<c:if test="${cookie.cookieId.value eq 632 or cookie.cookieId.value eq 848 or cookie.cookieId.value eq 845}">
												<button type="button" style="width:49%;float:left;">수정</button>
								    			<button type="button" style="width:49%;float:left;">삭제</button>
											</c:if>
										</td>
									</tr> --%>
								</tbody>
							</table>
							
							
							<%-- <a href="#" class="eventJoinCheckBtn" data-role="button" data-icon="edit" style="background-color:green;color:white;">참여/불참 체크</a>
						
							<form id="${noticeList.noNum}Form">
								<input type="hidden" name="noNum" value="${noticeList.noNum }" id="hiddenNoNum">
								<div id="hiddenTable" style="display:none;">
									<h3 style="text-align:center;background-color:#F6F6F6;">상세일정</h3>
									<table data-role="table" class="ui-responsive">
										<thead>
											<tr>
												<th>- 내용</th>
												<th>- 행사일시</th>
												<th>- 장소</th>
												<th>${noticeList.coPlace }</th>
												<th>- 참여여부</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${noticeList.coContent }</td>
												<td>${noticeList.coEventDate }</td>
												<td></td>
												<td></td>
												<td>
													<div data-role="controlgroup" data-type="horizontal">
														<a href="#" data-role="button" class="eventJoinBtn">참여</a>
														<a href="#" data-role="button" class="eventNotJoinBtn">불참</a>
														<input type="hidden" name="joJoinShape" id="joJoinShape"/>
										            </div>
										        </td>
											</tr>
										</tbody>
									</table>
								</div>
								<div id="hiddenTable2" style="display:none;">
									<h3 style="text-align:center;background-color:#F6F6F6;">회비납부안내</h3>
									<table data-role="table" class="ui-responsive">
										<thead>
											<tr>
												<th>- 이름</th>
												<th>- 계좌번호</th>
												<th>- 금액</th>
												
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${noticeList.coPayName }</td>
												<td>${noticeList.coPayAccount }</td>
												<td>
													<div>
														<a href="#" data-role="button" data-inline="true" class="directPay">직접납부</a>
														<a href="#" data-role="button" data-inline="true" class="accountPay">계좌이체</a>
														<input type="hidden" name="payType" id="payType"/>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<a href="#" data-role="button" style="background-color:green;color:white;display:none;" class="eventSubmitBtn">등록</a>
							</form> 행사공지 참여체크--%>
							
						</div>
	        		</c:if>
	        		<c:if test="${noticeList.noType eq 3 }">
	        			<div data-role="collapsible" id="accodianDiv">
	        				<table id="bodyTable" style="width:100%">
	        					<input type="hidden" id="noNum" value="${noticeList.noNum }"/>
	        					<input type="hidden" id="noType" value="3"/>
	        					<tr>
	        						<td>
										<c:if test="${noticeList.userImgOld ne null}">
											<img src="resources/files/${noticeList.noTargetClass}/${noticeList.userImgOld}" style="width:35px;height:35px;"/>
										</c:if>
										<c:if test="${noticeList.userImgNew ne null}">
											<img src="resources/files/${noticeList.noTargetClass}/${noticeList.userImgNew}" style="width:35px;height:35px;"/>
										</c:if>
									</td>
									<td colspan="2" style="text-align:right;">
										<c:if test="${noticeList.coUserHp != null and noticeList.coUserHp != ''}">
											<a href="tel:'${noticeList.coUserHp}'" style="float:right;"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>
										</c:if>
									</td>
								
	        						<td>
		        						<c:if test="${cookie.cookieId.value eq 632 or cookie.cookieId.value eq 848 or cookie.cookieId.value eq 845}">
											<a style="float:right;" class="noticeDeleteBtn"><img src="resources/img/cencel.jpg" style="width:35px;height:35px;" alt="삭제"></a>
											<a style="float:right;" class="noticeModifyBtn"><img src="resources/img/edit.jpg" style="width:35px;height:35px;" alt="취소"></a>
											<c:if test="${noticeList.noUserHp != null and noticeList.noUserHp != ''}">
												<a href="tel:'${noticeList.coUserHp}'" style="float:right;"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>
											</c:if>
										</c:if>
										<c:if test="${cookie.cookieId.value ne 632 and cookie.cookieId.value ne 848 and cookie.cookieId.value ne 845}">
											<c:if test="${noticeList.noUserHp != null and noticeList.noUserHp != ''}">
												<a href="tel:'${noticeList.noUserHp}'" style="float:right;"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>
											</c:if>
										</c:if>
									</td>
	        					</tr>
	        				</table>
	        				<h3><font class="noticeH3">[祝賀]${noticeList.noSubject }</font> <font style="float:right;font-size:14px;padding-top:2px;">${noticeList.noRegDate }</font></h3>
							<h4>${noticeList.noTargetName}(${noticeList.noTargetClass}반)<br/> ${noticeList.noContents }</h4>
						</div>
					</c:if>
	        	</c:forEach>
	        </div>

	    </div> 
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	
	<!-- 포토 > 사진등록 -->
	<%-- <section id="page6" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:rgba(255,255,255,0.5);margin-top:15px;"><font style="font-weight:bold;color:red;">MY</font></a>
	    	<div data-role="navbar">
	             <ul>
	                <li><a href="#page1" data-transition="none"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#page2" data-transition="none"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#page4" data-transition="none"><font style="font-size:16px;">공지</font></a></li>
	                <li><a href="#page7" data-transition="none"><font style="font-size:16px;">일상</font></a></li>
	                <li><a href="#" data-transition="none" class="ui-btn-active ui-state-persist" ><font style="font-size:16px;">관리</font></a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:50px;">
	    	<a href="#page2" data-role="button" style="width:25%">목록가기</a>
	    	
	    	<form id="photoForm" enctype="multipart/form-data" method="post">
		        <input type="file" name="uploadFile[]" accept="image/*" id="imgInp" multiple="multiple">
		        <div style="width:100%;height:70%">
		        	<img id="blah" src="#" style="width:100%;height:100%;display:none;" />
		        </div>
		        <input type="text" name="albumMsg"/>
		        <a href="#" data-role="button" id="imgAddBtn">등록하기</a>
			</form>

			
	       
	    </div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section> --%>
	
	<!-- 일상 -->
	<section id="page7" data-role="page">
	    <header data-role="header" style="height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:rgba(255,255,255,0.5);margin-top:15px;"><font style="font-weight:bold;color:red;">MY</font></a>
	        <div data-role="navbar">
	            <ul>
	                <li><a href="#page1" data-transition="none"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#page2" data-transition="none"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#page4" data-transition="none" ><font style="font-size:16px;">공지</font></a></li>
	                <li><a href="#" data-transition="none" class="ui-btn-active ui-state-persist"><font style="font-size:16px;">일상</font></a></li>
	                <li><a href="#page8" data-transition="none"><font style="font-size:16px;">관리</font></a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:40px;font-size:15px;">
	    	<table class="subject">
	    		<tr>
	    			<td></td>
	    			<td><input type="search" name="searchAlbumByUser" id="searchAlbumByUser" placeholder="이름"/></td>
	    			<!-- <td><button type="button" style="height:35px;">검색</button></td>
	    			<td style="width:45px;">
	    				<button type="button" style="height:35px;" onclick="openWriteForm();">등록</button>
	    			</td> -->
	    			<td><a href="#" style="text-align:right;" onclick="searchAlbumByUser();"><img src="resources/img/search.jpg" style="width:35px;height:35px;"/></a></td>
	    			<td style="width:36px;text-align:right;">
	    				<a href="#" onclick="openWriteForm();"><img src="resources/img/edit.jpg" style="width:35px;height:35px;"/></a>
	    			</td>
	    		</tr>
	    	</table>
	    	
	    	
	    	<!-- 일상 등록폼 -->
	    	<div id="writeForm" style="width:100%;display:none;">
	    		<form id="albumInputForm" enctype="multipart/form-data" method="post">
		    		<div class="fileInputDiv">
						<img src="resources/img/photo.jpg" class="fileInputImgBtn" alt="사진등록"/>
						<input type="file" class="fileInputHidden" id="albumImg" name="albumImg" accept="image/*" multiple/>
					</div>
					<img src="#" id="albumImgView" style="display:none;width:100%;height:200px;border-radius:7px;"/>
		    		<textarea name="albumMsg" id="albumMsg"></textarea>
		    		<div>
		    			<button type="button" onclick="addAlbum();" style="width:49%;float:left;font-size:15px;">등록</a>
		    			<button type="button" onclick="closeWriteForm();" style="width:49%;float:left;font-size:15px;">취소</a>
		    		</div>
	    		</form>
	    	</div>
	    	
	    	<!-- 일상 수정폼 -->
	    	<div id="albumModifyForm" style="width:100%;display:none;font-size:15px;">
	    		<textarea name="albumMsg" id="albumMsg2"></textarea>
	    		<a href="#" onclick="" data-role="button" data-icon="edit" style="background-color:#D4F4FA;">수정</a>
	    		
	    	</div>
	    	
	    	<!-- 일상목록 -->
	    	<div id="albumListDiv" style="width:100%;">
	    		<c:forEach var="albumList" items="${albumList }" varStatus="i">
	    			<div id="albumDiv">
	    				<input type="hidden" id="albumNo" value="${albumList.albumNo }"/>
	    				<input type="hidden" id="commentOpenCheck" value="close"/>
	    				<input type="hidden" id="albumPath" value="${albumList.userId.substring(0,1)}"/>
	    				
		    			<%-- <h4 style="border-top:2px solid #ddd;">
		    				<img src="resources/files/${albumList.userId.substring(0,1)}/${albumList.userImgOld}" style="width:25px;height:25px;border-radius:10px;"/>
		    				${albumList.userName }<font style="font-size:14px;float:right;">${albumList.albumRegDate} </font>
		    			</h4> --%>
		    			<br/>
		    			<table style="width:100%;border-top:2px solid #ddd;">
		    				<tr>
		    					<td style="width:25px;"><img src="resources/files/${albumList.userId.substring(0,1)}/${albumList.userImgOld}" style="width:30px;height:30px;border-radius:10px;"/></td>
		    					<td style="width:45px;font-size:15px;font-weight:bold;">${albumList.userName }</td>
		    					<td style="font-size:14px;">${albumList.albumRegDate}</td>
		    					<td style="width:10%;"><a href="tel:'${albumList.userHp}'"><img src="resources/img/call.jpg" style="width:25px;height:25px;"/></a></td>
		    				</tr>
		    			</table>
		    			
		    			<c:forEach var="photoList" items="${albumList.fileList }">
		    				<input type="hidden" id="fileName" value="${photoList.fileName}"/>
		    				<c:if test="${photoList.fileName eq 'birthday.PNG'}">
		    					<img src="resources/files/${photoList.filePath }/${photoList.fileName}" style="width:100%;border-radius:10px;"/>
		    				</c:if>
		    				<c:if test="${photoList.fileName ne 'birthday.PNG'}">
		    					<img src="resources/files/${albumList.userId.substring(0,1)}/${photoList.fileName}" style="width:100%;border-radius:10px;"/>
		    				</c:if>
		    			</c:forEach>
		    			
		    			<h4 id="albumMsgH4">${albumList.albumMsg }</h4>
		    			
		    			<%-- <div style="font-size:14px;">
		    				<img src="resources/img/like.png" style="width:14px;height:14px;"/>
		    				좋아요 <font style="font-weight:bold;" id="goodCountTag">${albumList.albumGood }</font>
		    			</div> --%>
		    			
		    			
		    			<table style="width:100%;text-align:center;">
			    			<tr id="albumButtonTr">
			    				<c:if test="${albumList.userId eq cookie.cookieId.value }">
				    				<td class="topList4 goodCountPlusBtn">좋아요(<font style="font-weight:bold;" id="goodCountTag">${albumList.albumGood }</font>)</td>
				    				<td class="topList4 openAlbumCommentBtn">댓글(${albumList.commentList.size()})</td>
				    				<td class="topList4 albumModifyBtn">수정</td>
				    				<td class="topList4 albumDeleteBtn">삭제</td>
			    				</c:if>
			    				<c:if test="${albumList.userId ne cookie.cookieId.value }">
			    					<td class="topList4 goodCountPlusBtn">좋아요(<font style="font-weight:bold;" id="goodCountTag">${albumList.albumGood }</font>)</td>
				    				<td class="topList4 openAlbumCommentBtn">댓글(${albumList.commentList.size()})</td>
			    				</c:if>
			    			</tr>
			    		</table>
		    			
		    			<%-- <c:if test="${albumList.userId eq cookie.cookieId.value }">
		    				<button type="button" style="width:33%;float:left;" class="openAlbumCommentBtn">
			    				댓글 (${albumList.commentList.size()})
			    			</button>
			    			<button type="button" style="width:33%;float:left;" class="albumModifyBtn">수정</button>
			    			<button type="button" style="width:33%;float:left;" class="albumDeleteBtn">삭제</button>
		    			</c:if>
		    			<c:if test="${albumList.userId ne cookie.cookieId.value }">
		    				<button type="button" style="width:49%;float:left;" class="goodCountPlusBtn">좋아요</button>
			    			<button type="button" style="width:49%;float:left;" class="openAlbumCommentBtn">
			    				댓글 (${albumList.commentList.size()})
			    			</button>
			    		</c:if> --%>
		    			
		    			<!-- 댓글 목록-->
		    			<div id="albumCommentDiv" style="display:none;">
		    				<!-- 댓글목록 -->
		    				<table style="width:100%" id="albumCommentTable">
		    					<c:forEach var="commentList" items="${albumList.commentList }">
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
				    							<a href="#" class="commentDeleteBtn"><img src="resources/img/cencel.jpg" style="width:26px;height:26px;"/></a>
				    						</td>
			    						</c:if>
			    					</tr>
		    					</c:forEach>
		    				</table>
		    				
		    				<!-- 댓글입력 -->
		    				<div style="width:100%;" id="commentWriteForm">
			    				<table style="width:100%;">
			    					<td style="width:85%;"><input type="text" style="width:100%" name="comContent" placeholder="댓글 입력"></td>
			    					<td style="text-align:right;">
				    					<a href="#" style="width:12%;" class="addCommentBtn">
				    						<img src="resources/img/plus.jpg" style="width:32px;height:32px;"/>
				    					</a>
			    					</td>
			    				</table>
		    				</div>
		    			</div>
	    			</div>
	    		</c:forEach>
	    	</div>
		</div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	<!--관리  -->
	<section id="page8" data-role="page">
	    <header data-role="header" style="height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:rgba(255,255,255,0.5);margin-top:15px;"><font style="font-weight:bold;color:red;">MY</font></a>
	        <div data-role="navbar">
	             <ul>
	                <li><a href="#page1" data-transition="none"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#page2" data-transition="none"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#page4" data-transition="none"><font style="font-size:16px;">공지</font></a></li>
	                <li><a href="#page7" data-transition="none"><font style="font-size:16px;">일상</font></a></li>
	                <li><a href="#" data-transition="none" class="ui-btn-active ui-state-persist"><font style="font-size:16px;">관리</font></a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:50px;font-size:15px;">
	    	<c:if test="${cookie.cookieId.value eq 632 or cookie.cookieId.value eq 848 or cookie.cookieId.value eq 845}">
		    	<table class="subject">
		    		<tr>
		    			<td class="topList2" id="ctrl2" onclick="allUserViewCtrl()" style="background-color:#C1F2FF;">임원</td>
		    			<td class="topList2" id="ctrl3" onclick="smsAddCtrl()">문자</td>
		    			<td class="topList2" id="ctrl1" onclick="noticeAddCtrl()">회비</td>
		    			<td class="topList2" id="ctrl4" onclick="accountingCtrl()">회계</td>
		    			<td class="topList2" id="ctrl5" onclick="statCtrl()">이용</td>
		    		</tr>
		    	</table>
			    <!-- 공지 이미지 뷰 
			    <div style="text-align:center;margin-top:5%;margin-left:10%;margin-right:10%;width:80%;font-weight:bold;">
			    	<br/><br/>
			    	<table style="width:100%;">
			    		<tr>
			    			<td style="width:50%"><img src="resources/img/photo2.png"><br/>포토등록</td>
			    			<td><img src="resources/img/notice.png"><br/>공지등록</td>
			    		</tr>
			    	</table>
			    	<br/><br/>
			   		<table style="width:100%;">
			    		<tr>
			    			<td style="width:50%"><img src="resources/img/mail.png"><br/>단체문자</td>
			    			<td><img src="resources/img/research.png"><br/>이용통계</td>
			    		</tr>
			    	</table>
			    </div> -->
			    
			    <!-- 회비 -->
				<div id="duesCtrlDiv" style="display:none;border:2px solid #ddd;">
					<h3 style="font-weight:bold;text-align:right;color:blue;font-size:15px;margin:-2px 0 0 0;">(단위:만원)</h3>
					<table style="width:100%;" class="duesTable">
						<tr>
							<th class="duesTr">반</th>
							<th class="duesTr">~2017</th>
							<th class="duesTr">30th기부</th>
							<th class="duesTr">30th이후</th>
						</tr>
						<tr>
							<td class="statTd2"><a href="#" onclick="duesDetail(1);">1반</a></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${duesList.get(0)}</number></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${kibuList.get(0) }</number></td>
							<c:if test="${thirtyList.get(0) ne 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">${thirtyList.get(0) }</number></td>
							</c:if>
							<c:if test="${thirtyList.get(0) eq 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">-</number></td>
							</c:if>
						</tr>
						<tr>
							<td class="statTd2"><a href="#" onclick="duesDetail(2);">2반</a></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${duesList.get(1)}</number></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${kibuList.get(1) }</number></td>
							<c:if test="${thirtyList.get(1) ne 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">${thirtyList.get(1) }</number></td>
							</c:if>
							<c:if test="${thirtyList.get(1) eq 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">-</number></td>
							</c:if>
						</tr>
						<tr>
							<td class="statTd2"><a href="#" onclick="duesDetail(3);">3반</a></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${duesList.get(2)}</number></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${kibuList.get(2) }</number></td>
							<c:if test="${thirtyList.get(2) ne 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">${thirtyList.get(2) }</number></td>
							</c:if>
							<c:if test="${thirtyList.get(2) eq 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">-</number></td>
							</c:if>
						</tr>
						<tr>
							<td class="statTd2"><a href="#" onclick="duesDetail(4);">4반</a></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${duesList.get(3)}</number></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${kibuList.get(3) }</number></td>	
							<c:if test="${thirtyList.get(3) ne 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">${thirtyList.get(3) }</number></td>
							</c:if>
							<c:if test="${thirtyList.get(3) eq 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">-</number></td>
							</c:if>
						</tr>
						<tr>
							<td class="statTd2"><a href="#" onclick="duesDetail(5);">5반</a></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${duesList.get(4)}</number></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${kibuList.get(4) }</number></td>	
							<c:if test="${thirtyList.get(4) ne 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">${thirtyList.get(4) }</number></td>
							</c:if>
							<c:if test="${thirtyList.get(4) eq 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">-</number></td>
							</c:if>
						</tr>
						<tr>	
							<td class="statTd2"><a href="#" onclick="duesDetail(6);">6반</a></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${duesList.get(5)}</number></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${kibuList.get(5) }</number></td>
							<c:if test="${thirtyList.get(5) ne 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">${thirtyList.get(5) }</number></td>
							</c:if>
							<c:if test="${thirtyList.get(5) eq 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">-</number></td>
							</c:if>
						</tr>
						<tr>
							<td class="statTd2"><a href="#" onclick="duesDetail(7);">7반</a></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${duesList.get(6)}</number></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${kibuList.get(6) }</number></td>	
							<c:if test="${thirtyList.get(6) ne 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">${thirtyList.get(6) }</number></td>
							</c:if>
							<c:if test="${thirtyList.get(6) eq 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">-</number></td>
							</c:if>
						</tr>
						<tr>
							<td class="statTd2"><a href="#" onclick="duesDetail(8);">8반</a></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${duesList.get(7)}</number></td>
							<td class="statTd2" style="text-align:right;"><number class="numberInput">${kibuList.get(7) }</number></td>	
							<c:if test="${thirtyList.get(7) ne 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">${thirtyList.get(7) }</number></td>
							</c:if>
							<c:if test="${thirtyList.get(7) eq 0}">
								<td class="statTd2" style="text-align:right;"><number class="numberInput">-</number></td>
							</c:if>
						</tr>
						<tr>
							<td style="background-color:#FFA648;text-align:center;font-weight:bold;">합계</td>
							<td style="background-color:#FFA648;text-align:right;font-weight:bold;"><number class="numberInput">${duesList.get(0)+duesList.get(1)+duesList.get(2)+duesList.get(3)+duesList.get(4)+duesList.get(5)+duesList.get(6)+duesList.get(7)}</number></td>
							<td style="background-color:#FFA648;text-align:right;font-weight:bold;"><number class="numberInput">${kibuList.get(0)+kibuList.get(1)+kibuList.get(2)+kibuList.get(3)+kibuList.get(4)+kibuList.get(5)+kibuList.get(6)+kibuList.get(7)}</number></td>	
							<c:if test="${thirtyList.get(0)+thirtyList.get(1)+thirtyList.get(2)+thirtyList.get(3)+thirtyList.get(4)+thirtyList.get(5)+duthirtyListsList.get(6)+thirtyList.get(7) ne 0}">
								<td style="background-color:#FFA648;text-align:right;font-weight:bold;"><number class="numberInput">${thirtyList.get(0)+thirtyList.get(1)+thirtyList.get(2)+thirtyList.get(3)+thirtyList.get(4)+thirtyList.get(5)+duthirtyListsList.get(6)+thirtyList.get(7)}</number></td>
							</c:if>
							<c:if test="${thirtyList.get(0)+thirtyList.get(1)+thirtyList.get(2)+thirtyList.get(3)+thirtyList.get(4)+thirtyList.get(5)+duthirtyListsList.get(6)+thirtyList.get(7) eq 0}">
								<td style="background-color:#FFA648;text-align:right;font-weight:bold;"><number class="numberInput">-</number></td>
							</c:if>
						</tr>
					</table>
				</div>
				
				<!-- 사진등록 -->
				<div id="photoCtrlDiv" style="display:none;">
					<img src="resources/img/readying.png" style="width:100%;height:70%;"/>
				</div>
				
				<!-- 문자보내기 -->
				<div id="smsSendDiv" style="display:none;">
					<!-- <label for="msg">메세지입력 :</label> -->
		       	 	<textarea name="msg" id="msg" rows="8" cols="40" height="150px;"></textarea>
		       	 	
		        	<table style="width:100%;text-align:center;border:3px solid #ddd;">
		    			<tr>
		    				<!-- <td id="typeContent" class="topList3" id="direct" onclick="direct();">직접입력</td> -->
		    				<td id="typeEvent" class="topList3" id="searchUser" onclick="searchForm();">회원검색</td>
		    				<td id="typeNormal" class="topList3" id="sendAllBtn" onclick="sendAll();">전체발송</td>
		    			</tr>
		    		</table>
		    		
		        	<div id="directForm" style="display:none;">
		        		<input name="userHp" id="userHp" type="tel" placeholder="수신자 휴대폰번호 입력 예)01022223333" >
		        		<button type="button" id="sendMmsDirectBtn">문자발송</a>
		        		
		        	</div>
		        	
		        	<div id="searchForm" style="display:none;">
		        		<table style="width:100%;border:3px solid #ddd;">
		        			<tr>
		        				<td colspan="2">
		        					<select name="searchKey" id="searchKey" data-native-menu="false" style="width:100%;">
							            <option>반/지역 선택</option>
							            <option value="class">반</option> 
							            <option value="local">지역</option> 
							        </select>
		        				</td>
		        			</tr>
		        			<tr>
		        				<td style="width:80%;">
		        					<input type="text" name="searchValue" id="searchValue" placeholder="상세">
		        				</td>
		        				<td style="width:20%">
		        					<div style="border:2px solid #ddd;border-radius:5px;text-align:center;height:25px;padding-top:7px;" onclick="searchUserSms();">
										검색
									</div>
		        				</td>
		        			</tr>
		        		</table>
				        
				        <!-- <div id="valueDetail">
				        	<input type="text" style="width:85%;float:left;border-bottom:1px solid #ddd;" name="searchValue" id="searchValue" placeholder="검색 키워드를입력">
							<div style="width:12%;float:right;border:2px solid #ddd;border-radius:5px;text-align:center;height:26px;" onclick="searchUserSms();">
								검색
							</div>
				        </div> -->
				    </div>
					<div id="resultDiv">
					
					</div>
				</div> <!-- 문자발송끝 -->
				
				<!-- 회계 -->
				<div id="accountingDiv" style="display:none;">
					 <img src="resources/img/readying.png" style="width:100%;height:70%;"/>
				</div>
	
				<!-- 이용 -->
				<div id="statDiv" style="display:none;">
					<table style="width:100%;color:#030066;">
						<tr>
							<th class="duesTr">반</th>
							<th class="duesTr">총원</th>
							<th class="duesTr">접속</th>
							<th class="duesTr">목록</th>
						</tr>
						<tr>
							<td class="statTd">1반</td>
							<td class="statTd">59명</td>
							<td class="statTd">${joinCountList.get(0)}명</td>
							<td class="statTd"><a href="#" onclick="statDetail(1);"><img src="resources/img/list.jpg" style="width:30px;height:30px;"/></a></td>
						</tr>
						<tr>
							<td class="statTd">2반</td>
							<td class="statTd">54명</td>
							<td class="statTd">${joinCountList.get(1)}명</td>
							<td class="statTd"><a href="#" onclick="statDetail(2);"><img src="resources/img/list.jpg" style="width:30px;height:30px;"/></a></td>
						</tr>
						<tr>
							<td class="statTd">3반</td>
							<td class="statTd">55명</td>
							<td class="statTd">${joinCountList.get(2)}명</td>
							<td class="statTd"><a href="#" onclick="statDetail(3);"><img src="resources/img/list.jpg" style="width:30px;height:30px;"/></a></td>
						</tr>
						<tr>
							<td class="statTd">4반</td>
							<td class="statTd">57명</td>
							<td class="statTd">${joinCountList.get(3)}명</td>
							<td class="statTd"><a href="#" onclick="statDetail(4);"><img src="resources/img/list.jpg" style="width:30px;height:30px;"/></a></td>	
						</tr>
						<tr>
							<td class="statTd">5반</td>
							<td class="statTd">56명</td>
							<td class="statTd">${joinCountList.get(4)}명</td>
							<td class="statTd"><a href="#" onclick="statDetail(5);"><img src="resources/img/list.jpg" style="width:30px;height:30px;"/></a></td>	
						</tr>
						<tr>	
							<td class="statTd">6반</td>
							<td class="statTd">60명</td>
							<td class="statTd">${joinCountList.get(5)}명</td>
							<td class="statTd"><a href="#" onclick="statDetail(6);"><img src="resources/img/list.jpg" style="width:30px;height:30px;"/></a></td>
						</tr>
						<tr>
							<td class="statTd">7반</td>
							<td class="statTd">57명</td>
							<td class="statTd">${joinCountList.get(6)}명</td>
							<td class="statTd"><a href="#" onclick="statDetail(7);"><img src="resources/img/list.jpg" style="width:30px;height:30px;"/></a></td>	
						</tr>
						<tr>
							<td class="statTd">8반</td>
							<td class="statTd">58명</td>
							<td class="statTd">${joinCountList.get(7)}명</td>
							<td class="statTd"><a href="#" onclick="statDetail(8);"><img src="resources/img/list.jpg" style="width:30px;height:30px;"/></a></td>	
						</tr>
					</table>
				</div>
				
			</c:if>
			
			<!-- 임원 -->
			<div id="allUserViewDiv">
				<table style="width:100%">
					<tr>
						<td style="width:30%;border-bottom:1px dotted #ddd;"><img src="resources/files/admin/3848new.jpg" style="width:100px;height:100px;"/></td>
						<td style="width:50%;border-bottom:1px dotted #ddd;">
							<font style="font-weight:bold;font-size:16px;color:#030066;">회장 최기호(8반)</font><br/><br/>
							<font style="font-weight:bold;font-size:14px;">떡보의 하루 대표</font><br/>
							<font style="font-weight:bold;font-size:14px;">전북 전주 거주</font>
						</td>
						<td style="width:20%;text-align:center;border-bottom:1px dotted #ddd;">
							<a href="sms:010-2607-0689"><img src="resources/img/sms.jpg" style="width:35px;height:35px;"/></a><br/>
							<a href="tel:'010-2607-0689'"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>
						</td>
					</tr>
					<tr>
						<td style="width:30%;border-bottom:1px dotted #ddd;"><img src="resources/files/admin/3845new.jpg" style="width:100px;height:100px;"/></td>
						<td style="width:50%;border-bottom:1px dotted #ddd;">
							<font style="font-weight:bold;font-size:16px;color:#030066;">총무 정윤승(8반)</font><br/><br/>
							<font style="font-weight:bold;font-size:14px;">금강여행사 대표</font><br/>
							<font style="font-weight:bold;font-size:14px;">전북 전주 거주</font>
						</td>
						<td style="width:20%;text-align:center;border-bottom:1px dotted #ddd;">
							<a href="sms:010-9476-4884"><img src="resources/img/sms.jpg" style="width:35px;height:35px;"/></a><br/>
							<a href="tel:'010-9476-4884'"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>
						</td>
					</tr>
					<tr>
						<td style="width:30%;border-bottom:3px solid #ddd;"><img src="resources/files/admin/omg.jpg" style="width:100px;height:100px;"/></td>
						<td style="width:50%;border-bottom:3px solid #ddd;">
							<font style="font-weight:bold;font-size:16px;color:#030066;">재무 오민권(6반)</font><br/><br/>
							<font style="font-weight:bold;font-size:14px;">(주)한국정보통계 대표</font><br/>
							<font style="font-weight:bold;font-size:14px;">전북 전주 거주</font>
						</td>
						<td style="width:20%;text-align:center;border-bottom:3px solid #ddd;">
							<a href="sms:010-3673-1951"><img src="resources/img/sms.jpg" style="width:35px;height:35px;"/></a><br/>
							<a href="tel:'010-3673-1951'"><img src="resources/img/call.jpg" style="width:35px;height:35px;"/></a>
						</td>
					</tr>
					<tr>
						<td style="width:30%;border-bottom:3px solid #ddd;margin-top:8px;">
							<font style="font-weight:bold;font-size:16px;color:black;">회비 및 <br/>후원계좌</font>
						</td>
						<td colspan="2" style="width:50%;border-bottom:3px solid #ddd;margin-top:8px;">
							<font style="font-weight:bold;font-size:16px;color:#030066;">농협 오민권<br/>301-0216-9668-01</font>
						</td>
					</tr>
				</table>
			</div>
			
		</div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	<!--마이페이지  -->
	<section id="page9" data-role="page">
	    <header data-role="header" style="height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:rgba(255,255,255,0.5);margin-top:15px;"><font style="font-weight:bold;color:red;">MY</font></a>
	        <div data-role="navbar">
	             <ul>
	                <li><a href="#page1" data-transition="none"><font style="font-size:16px;">친구</font></a></li>
	                <li><a href="#page2" data-transition="none"><font style="font-size:16px;">포토</font></a></li>
	                <li><a href="#page4" data-transition="none" ><font style="font-size:16px;">공지</font></a></li>
	                <li><a href="#page7" data-transition="none" ><font style="font-size:16px;">일상</font></a></li>
	                <li><a href="#page8" data-transition="none"><font style="font-size:16px;">관리</font></a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="margin-top:50px;">
	    	<div style="width:100%;font-size:15px;">
	    	<form id="userModifyForm" enctype="multipart/form-data" method="post">
		    	<table style="width:100%;margin-top:10px;">
		    		<tr>
		    			<c:if test="${user.userImgOld eq null && user.userImgNew eq null}">
		 					<!-- <td style="width:50%;"><img src="resources/img/ready.jpg" class="img-round"/></td> -->
		    				<td colspan="2" style="text-align:center;"><img src="resources/img/ready.jpg" id="filePreviewImg" style="width:40%;height:116px;"/></td>
		 				</c:if>
		 				<c:if test="${user.userImgOld ne null && user.userImgNew eq null}">
		 					<td style="width:50%;text-align:center;"><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgOld}" class="img-round"/></td>
		    				<td style="width:50%;text-align:center;">
		    					<img src="#" id="filePreviewImg2" style="display:none;width:80%;height:116px;"/>
		    				</td>
		 				</c:if>
		 				<c:if test="${user.userImgOld ne null && user.userImgNew ne null}">
		 					<td style="width:50%;text-align:center;"><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgOld}" class="img-round"/></td>
		    				<td style="width:50%;text-align:center;"><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgNew}" class="img-round" id="filePreviewImg3"/></td>
		 				</c:if>
		 				<c:if test="${user.userImgOld eq null && user.userImgNew ne null}">
		 					<%-- <td style="width:50%;"><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgNew}" class="img-round"/></td> --%>
		    				<td colspan="2" style="text-align:center;"><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgNew}" id="filePreviewImg4" style="width:40%;height:116px;"/></td>
		 				</c:if>
		    		</tr>
		    	</table>
		    	<div class="fileInputDiv">
					<img src="resources/img/photo.jpg" class="fileInputImgBtn" alt="사진등록"/>
					<c:if test="${user.userImgOld eq null && user.userImgNew eq null}">
						<input type="file" name="userImgNew" id="userImgNew" class="fileInputHidden" accept="image/*" multiple/>
					</c:if>
					<c:if test="${user.userImgOld ne null && user.userImgNew eq null}">
						<input type="file" name="userImgNew" id="userImgNew2" class="fileInputHidden" accept="image/*" multiple/>
					</c:if>
					<c:if test="${user.userImgOld ne null && user.userImgNew ne null}">
						<input type="file" name="userImgNew" id="userImgNew3" class="fileInputHidden" accept="image/*" multiple/>
					</c:if>
					<c:if test="${user.userImgOld eq null && user.userImgNew ne null}">
	 					<input type="file" name="userImgNew" id="userImgNew4" class="fileInputHidden" accept="image/*" multiple/>
	 				</c:if>
				</div>
		    	
		    	<table style="width:100%;">
		    		<tr>
		    			<td style="width:13%;"><img src="resources/img/name.png" style="width:25px;height:25px;"/></td>
		    			<td style="border-bottom:1px solid #ddd;font-weight:bold;" colspan="3">
		    				${user.userName }
		    			</td>
		    		</tr>
		    		<tr>
		    			<td style="width:13%;"><img src="resources/img/hp.png" style="width:25px;height:25px;"/></td>
		    			<td style="border-bottom:1px solid #ddd;font-weight:bold;" colspan="3">
		    				<input type="tel" name="userHp" id="userHpModify" value="${user.userHp }"/>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td><img src="resources/img/birth.png" style="width:25px;height:25px;"/></td>
		    			<td>
		    				<select name="birthType" id="birthType" data-native-menu="false" style="height:33px;" data-inline="true">
		    					<option value="양력" selected="selected">양력</option>
		    					<option value="음력">음력</option>
		    				</select>
		    				<c:if test="${user.userBirthType ne null }">
			    				<script>
			    					$('#birthType').val('${user.userBirthType}').prop('selected','selected');
			    				</script>
		    				</c:if>
		    			</td>
		    			<td>
		    				<input type="number" name="userBirthMonth" placeholder="월" value="${user.userBirthMonth }"/>
		    			</td>
		    			<td>
		    				<input type="number" name="userBirthDay" placeholder="일" value="${user.userBirthDay }"/>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td style="width:13%;"><img src="resources/img/address.png" style="width:30px;height:30px;"/></td>
		    			<td style="font-weight:bold;padding-top:7px;" colspan="3">
		    				<font style="border:1px solid #FF5E00;width:100px;height:33px;padding:5px;text-align:center;border-radius:5px;color:#000042;" onclick="execDaumPostCode();">주소찾기</font>
		    				<input type="text" name="userAddress" id="userAddressModify" value="${user.userAddress }"/>
		    				<c:if test="${user.userSangseAdd eq null or user.userSangseAdd eq '' }">
		    					<input type="text" name="userSangseAdd" id="sangseAdd" style="display:none;"/>
		    				</c:if>
		    				<c:if test="${user.userSangseAdd ne null and user.userSangseAdd ne '' }">
		    					<input type="text" name="userSangseAdd" id="sangseAdd" value="${user.userSangseAdd }"/>
		    				</c:if>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td colspan="4"><button type="button" onclick="userModify();" style="width:100%">개인정보수정</button></td>
		    		</tr>
		    	</table>
	    	
	    	</form>
	    	</div>
		</div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	
	
</body>
</html>