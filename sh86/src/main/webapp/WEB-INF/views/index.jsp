<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>신흥고등학교 86기 동문회</title>
	
	<link rel="stylesheet" href="resources/js/jquery.mobile-1.4.5.css">
	<script src="resources/js/jquery.js"></script>
	<script src="resources/js/jquery.mobile-1.4.5.js"></script>
	
	<!-- 우편번호(다음) -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		
	<style>
		th{
			background-color:#ddd;
			font-weight:bold;
			width:20%;	
		} 
		
		.img-round{
			border:3px solid #CEF279;
			width:80%;
			height:110px;
			border-radius: 70px;
			-moz-border-radius : 70px;
			-khtml-border-radius : 70px;
			-webkit-border-radius : 70px;
			
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
		    border-radius: 70px;
			-moz-border-radius : 70px;
			-khtml-border-radius : 70px;
			-webkit-border-radius : 70px;
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

	</style>
	<script>
		//문자 - 회원검색
		$(document).on('click','#searchUser',function(){
			$('#directForm').css('display','none');
			$('#resultDiv').css('display','none');
			$('#searchForm').css('display','');
			$('#searchKey').focus();
		});
		
		//문자 - 직접입력
		$(document).on('click','#direct',function(){
			$('#searchForm').css('display','none');
			$('#resultDiv').css('display','none');
			$('#directForm').css('display','');
			$('#userHp').focus();
		});
		
		//문자 > 회원검색 > 상세정보입력창 포커스시 힌트 바꿔주기
		$(document).on('focus','#valueDetail',function(){
			var searchKey=$('#searchKey').val();
			console.log(searchKey);
			
			if(searchKey == 'name'){
				$('#searchValue').prop('placeholder','성 혹은 이름만 입력하셔도 검색됩니다.');
			}else if(searchKey == 'hp'){
				$('#searchValue').prop('type','tel');
				$('#searchValue').prop('placeholder','뒤 4자리를 입력하세요');
			}else{
				$('#searchValue').prop('placeholder','시이름을 입력해주세요');
			}
			
		});
		
		// 문자 > 회원검색 > 검색버튼 클릭시 > 검색결과 보여주기
		$(document).on('click','#searchBtn',function(){
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
					var html = "<p style='font-weight:bold;font-size:20px;background-color:#ddd;'>"+data.userList[0].userName+"님 외 총 "+data.count+" 명이 선택되었습니다.</p>"
					html += "<br/><br/>";
					html += "<a class='ui-shadow ui-btn ui-corner-all ui-btn-b' href='#' id='mmsSendBtn'>문자전송</a>";
					$('#resultDiv').empty();
					$('#resultDiv').html(html);
					$('#resultDiv').css('display','');
				}
			});
		});
		
		// 문자 > 회원검색 > 문자발송버튼 클릭시 > 유효성검사 및 검색된 회원에게 문자발송
		$(document).on('click','#mmsSendBtn',function(){
			var searchKey=$('#searchKey').val();
			var searchValue=$('#searchValue').val();
			var mmsMsg = $('#msg').val();
			var sendTel = $('#sendTel').val();
			
			if(sendTel == null || sendTel == ''){
				alert('발송자 번호를 입력해주세요.');
				return;
			}else if(mmsMsg == null || mmsMsg == ''){
				alert('메세지를 입력하세요');
				return;
			}
			
			if(confirm("전송 하시겠습니까?") == true){
				$.ajax({
					url: 'mmsSend',
					data: {'searchKey' : searchKey, 'searchValue':searchValue, 'mmsMsg': mmsMsg,'sendTel': sendTel},
					type: 'post',
					dataType: 'json',
					success : function(data){
						if(data.check == '성공'){
							alert('문자발송에 성공하였습니다.');
							return;
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
			var sendTel = $('#sendTel').val();
			
			if(sendTel == null || sendTel == ''){
				alert('발송자 번호를 입력해주세요.');
				return;
			}else if(mmsMsg == null || mmsMsg == ''){
				alert('메세지를 입력하세요');
				return;
			}
			
			if(confirm("전송 하시겠습니까?") == true){
				$.ajax({
					url: 'mmsSendDirect',
					data: {'userHp': userHp, 'mmsMsg': mmsMsg,'sendTel': sendTel},
					type: 'post',
					dataType: 'json',
					success : function(data){
						if(data.check == '성공'){
							alert('문자발송에 성공하였습니다.');
							return;
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
		$(document).on('click','#sendAllBtn',function(){
			var mmsMsg = $('#msg').val();
			var sendTel = $('#sendTel').val();
			
			if(sendTel == null || sendTel == ''){
				alert('발송자 번호를 입력해주세요.');
				return;
			}else if(mmsMsg == null || mmsMsg == ''){
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
							return;
						}else{
							alert('문자발송에 실패하였습니다.');
						}
					}
				});
			}else{
				return;
			}
			
		});
		
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
		function execDaumPostCodeEvent() {
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
				$('#coPlaceEvent').val('('+data.zonecode+') '+fullAddr);
				// 커서를 상세주소 필드로 이동한다.
				$('#sangseAddEvent').focus();
				
				}
			}).open();
		}
		
		// 소식 > 공지등록 > 부의공지 클릭시
		$(document).on('click','#typeContent',function(){
			$('#noticeTitle').empty();
			$('#noticeTitle').html("<h2 style='background-color:#D4F4FA;text-align:center;'>공지 카테고리 : 부의공지</h2>");
			$('#normalDiv').css('display','none');
			$('#eventDiv').css('display','none');
			$('#contentDiv').css('display','');
		});
		
		//소식 > 공지등록 > 부의공지 > 등록버튼 클릭시 > 부의공지 등록하기
		$(document).on('click','#contentAddBtn',function(){
			var params = $('#contentForm').serialize();
			
			$.ajax({
				url : 'noticeContentAdd',
				data : params,
				dataType : 'json',
				type : 'post',
				success : function(data){
					if(data.check == '성공'){
						alert('부의공지가 등록되었습니다');
						return;
					}else{
						alert('공지등록에 실패하였습니다');
					}
				}
			});
		});
		
		// 소식 > 공지등록 > 행사공지 클릭시
		$(document).on('click','#typeEvent',function(){
			$('#noticeTitle').empty();
			$('#noticeTitle').html("<h2 style='background-color:#D4F4FA;text-align:center;'>공지 카테고리 : 행사공지</h2>");
			$('#contentDiv').css('display','none');
			$('#normalDiv').css('display','none');	
			$('#eventDiv').css('display','');			
		});
		
		//소식 > 공지등록 > 행사공지 > 등록버튼 클릭시 > 행사공지 등록하기
		$(document).on('click','#eventAddBtn',function(){
			var params = $('#eventForm').serialize();
			
			$.ajax({
				url : 'noticeEventAdd',
				data : params,
				dataType : 'json',
				type : 'post',
				success : function(data){
					if(data.check == '성공'){
						alert('행사공지가 등록되었습니다');
						return;
					}else{
						alert('공지등록에 실패하였습니다');
					}
				}
			});
		});
		
		// 소식 > 공지등록 > 일반공지 클릭시
		$(document).on('click','#typeNormal',function(){
			$('#noticeTitle').empty();
			$('#noticeTitle').html("<h2 style='background-color:#D4F4FA;text-align:center;'>공지 카테고리 : 일반공지</h2>");
			$('#contentDiv').css('display','none');
			$('#eventDiv').css('display','none');
			$('#normalDiv').css('display','');		
		});
		
		//소식 > 공지등록 > 일반공지 > 등록버튼 클릭시 > 일반공지 등록하기
		$(document).on('click','#normalAddBtn',function(){
			var params = $('#normalForm').serialize();
			
			$.ajax({
				url : 'noticeAdd',
				data : params,
				dataType : 'json',
				type : 'post',
				success : function(data){
					if(data.check == '성공'){
						alert('행사공지가 등록되었습니다');
						return;
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
			$(this).closest('#accodianDiv').find('#hiddenTable2').css('display','');
			$(this).parent().find('#joJoinShape').val('참여');
			console.log($(this).parent().find('#joJoinShape').val());
		});
		
		//행사공지 불참시
		$(document).on('click','.eventNotJoinBtn',function(){
			$(this).parent().find('.joinBtn').css({'background-color':'#ddd','color':'black'});
			$(this).css({'background-color':'#002266','color':'white'});
			$(this).closest('#accodianDiv').find('#hiddenTable2').css('display','none');
			$(this).parent().find('#joJoinShape').val('불참');
			console.log($(this).parent().find('#joJoinShape').val());
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
		
		function userModify(){
			var formData = new FormData($("#userModifyForm")[0]);
			console.log(formData);
			
			var userHp = $('#userHpModify').val();
			var userAddress = $('#userAddressModify').val();
			
			console.log(userHp,userAddress);
			
			/* var formData = new FormData(); 
			formData.append("userHp", $('#userHpModify').val()); 
			formData.append("userEmail", $('#userEmailModify').val()); 
			formData.append("userAddress", $('#userAddressModify').val()); 
			formData.append("file", $("#userImgNew")[0].files[0]); */

	        $.ajax({
	            type : 'post',
	            url : 'userModify',
	            data : formData ,
	            processData : false,
	            contentType : false,
	            success : function(data) {
	            	if(data.check){
	            		//파일업로드완료
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
			
			$.ajax({
				type : 'post',
				url : 'userModifyText',
				data : {'userHp':userHp,'userAddress':userAddress} ,
				dataType: 'json',
				success:function(data){
					if(data.check) {
						alert('수정처리가 완료되었습니다');
						console.log("최종입력체크 : "+data.check);
						setTimeout(function(){
							location.href='localhost:8080/sh86/';  //로컬
							/* location.href='http://sh86.kr/'; */  //호스팅
							submit();
						},3000);
						
					}
				}
			});
		}
		function searchUser(){
			var userName = $('#searchUserByName').val();
			var sessionId = '${sessionId}';
			console.log("세션값 확인 : "+sessionId);
			
			if(userName != null && userName != ''){
				$.ajax({
					url : 'searchUserByName',
					type : 'post',
					data : {'userName':userName},
					dataType : 'json',
					success:function(data){
						$('#searchUserListDiv').empty();
						
						var html = '';
						html += '<div>';
						html += '<button type="button" style="background-color:#B7F0B1;width:100%;font-weight:bold;">검색결과 '+data.length+' 명</button>';
						html += '<table style="width:100%;">'
							
						$.each(data, function(i, result){
							html += '<tr>';
							html += '<td>';
							if(result.userImgOld != null && result.userImgOld != ''){
								html += '<img src="resources/files/'+result.userId.substring(0,1)+'/'+result.userImgOld+'" style="width:40px;height:40px;margin-top:10px;">'
							}else{
								html += '<img src="resources/img/ready.jpg" style="width:40px;height:40px;margin-top:10px;">'
							}
							html += '</td><td>'
							html += '<font style="color:black;font-weight:bold;">'+result.userName+'</font><br/>';
							if(result.userHp != null && result.userHp != ''){
								html += result.userHp;
							}
							html += '</td><td style="text-align:right;">';
							if(sessionId == result.userId){
								html += '<a href="#page9"><img src="resources/img/info.jpg" style="width:43px;height:43px;"/></a>'
							}
							html += '<a href="tel:'+result.userHp+'"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>';
							html += '</td>';
							html += '</tr>';
						});
						html += '</table>';
						html += '</div>';
						$('#searchUserListDiv').html(html);
					}
					
				});
			}else{
				alert('검색할 이름을 입력하세요!');
				$('searchUserByName').focus();
				return;
			}
		}
		
		function formClose(){
			$('#userSearchForm').slideUp(400);
			$('#userSearchFormOpen').css('display','');
		}
		
		function formOpen(){
			$('#userSearchFormOpen').css('display','none');
			$('#userSearchForm').slideDown(400);
		}
		
		function openWriteForm(){
			$('#writeForm').css('display','');
		}
		</script>
		
</head>
<body>
	<section id="page1" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/logo.png" style="margin-top:-25px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:green;color:white;">MY</a>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="#" class="ui-btn-active ui-state-persist">친구</a></li>
	                <li><a href="#page2" data-transition="none">포토</a></li>
	                <li><a href="#page4" data-transition="none">공지</a></li>
	                <li><a href="#page8" data-transition="none">일상</a></li>
	                <li><a href="#page7" data-transition="none">관리</a></li>
	            </ul>
	        </div><!-- /navbar -->
	    </header>                   
	    
	    <div class="content" data-role="content" style="margin-top:25px;">
	    	<div data-role="collapsible-set" data-inset="false">
	
				<!-- <h2 style="text-align:center;">친구목록</h2> -->
				<div style="width:100%;" id="userSearchForm">
					<input type="text" name="searchUserByName" id="searchUserByName" placeholder="검색할 이름을 입력하세요"/>
					<button type="button" onclick="formClose();" data-icon="arrow-u" style="width:30%;float:right;background-color:#6CC0FF;color:white;">창닫기</button>
					<button type="button" onclick="searchUser();" data-icon="search" style="width:30%;float:right;background-color:#B3D26C;">검색</button><br/><br/><br/><br/>
				</div>
				<div id="userSearchFormOpen" style="display:none;">
					<button type="button" onclick="formOpen();" data-icon="arrow-d" style="background-color:#489FAE;color:white;">검색 폼 열기</button>
				</div>
				
				<div id="searchUserListDiv">
				
				</div>
				<div data-role="collapsible">
					<h3>1반&nbsp;총원 58(핸드폰등록 ${countList.get(0)}명중 ${joinCountList.get(0)}명사용)</h3>
					<ul data-role="listview">
						<c:forEach var="userList" items="${userList}">
							<c:if test="${userList.userId.toString().substring(0,1) eq 1 }">
								<c:choose>
									<c:when test="${userList.userId eq sessionId }">
										<li class="one" data-icon="edit">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#page8" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp ne null}">
										<li class="one" data-icon="phone">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" onclick="document.location.href='tel:${userList.userHp}'" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp eq null}">
										<li class="one" data-icon="lock">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" id="detailBtn">
									</c:when>
								</c:choose>
										<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
											<c:if test="${userList.userImgOld ne null and userList.userImgOld ne ''}">
												<img src="resources/files/1/${userList.userImgOld }" style="width:80px;height:80px;"/>
											</c:if>
											<c:if test="${userList.userImgOld eq null or userList.userImgOld eq ''}">
												<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
											</c:if>
										</c:if>
										<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
											<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
										</c:if>
										
										<c:if test="${userList.userDo eq null or userList.userCityName eq null}">
											<h2>${userList.userName }</h2>
										</c:if>	
										<c:if test="${userList.userDo ne null and userList.userCityName ne null}">
											<h2>${userList.userName }<font style="font-size:13px;">&nbsp;-&nbsp;${userList.userDo} ${userList.userCityName}</font> </h2>
										</c:if>	
										<c:if test="${userList.userHp ne null and userList.userHp ne ''}">
											<h2>${userList.userHp }</h2>
										</c:if>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				
				<!-- 2 -->
				<div data-role="collapsible">
					<h3>2반&nbsp;총원 54(핸드폰등록 ${countList.get(1)}명중 ${joinCountList.get(1)}명사용)</h3>
					<ul data-role="listview">
						<c:forEach var="userList" items="${userList}">
							<c:if test="${userList.userId.toString().substring(0,1) eq 2 }">
								<c:choose>
									<c:when test="${userList.userId eq sessionId }">
										<li data-icon="edit">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#page8" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp ne null}">
										<li data-icon="phone">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" onclick="document.location.href='tel:${userList.userHp}'" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp eq null}">
										<li data-icon="lock">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" id="detailBtn">
									</c:when>
								</c:choose>
										
										<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
											<c:if test="${userList.userImgOld ne null and userList.userImgOld ne ''}">
												<img src="resources/files/2/${userList.userImgOld }" style="width:80px;height:80px;"/>
											</c:if>
											<c:if test="${userList.userImgOld eq null or userList.userImgOld eq ''}">
												<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
											</c:if>
										</c:if>
										<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
											<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
										</c:if>
										<c:if test="${userList.userDo eq null or userList.userCityName eq null}">
											<h2>${userList.userName }</h2>
										</c:if>	
										<c:if test="${userList.userDo ne null and userList.userCityName ne null}">
											<h2>${userList.userName }<font style="font-size:13px;">&nbsp;-&nbsp;${userList.userDo} ${userList.userCityName}</font> </h2>
										</c:if>	
										<c:if test="${userList.userHp ne null and userList.userHp ne ''}">
											<h2>${userList.userHp }</h2>
										</c:if>
										
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				
				<!-- 3 -->
				<div data-role="collapsible">
					<h3>3반&nbsp;총원 55(핸드폰등록 ${countList.get(2)}명중 ${joinCountList.get(2)}명사용)</h3>
					<ul data-role="listview">
						<c:forEach var="userList" items="${userList}">
							<c:if test="${userList.userId.toString().substring(0,1) eq 3 }">
								<c:choose>
									<c:when test="${userList.userId eq sessionId }">
										<li data-icon="edit">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#page8" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp ne null}">
										<li data-icon="phone">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" onclick="document.location.href='tel:${userList.userHp}'" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp eq null}">
										<li data-icon="lock">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" id="detailBtn">
									</c:when>
								</c:choose>
										<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
											<c:if test="${userList.userImgOld ne null and userList.userImgOld ne ''}">
												<img src="resources/files/3/${userList.userImgOld }" style="width:80px;height:80px;"/>
											</c:if>
											<c:if test="${userList.userImgOld eq null or userList.userImgOld eq ''}">
												<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
											</c:if>
										</c:if>
										<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
											<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
										</c:if>
										<c:if test="${userList.userDo eq null or userList.userCityName eq null}">
											<h2>${userList.userName }</h2>
										</c:if>	
										<c:if test="${userList.userDo ne null and userList.userCityName ne null}">
											<h2>${userList.userName }<font style="font-size:13px;">&nbsp;-&nbsp;${userList.userDo} ${userList.userCityName}</font></h2>
										</c:if>	
										<c:if test="${userList.userHp ne null and userList.userHp ne ''}">
											<h2>${userList.userHp }</h2>
										</c:if>
										
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				
				<!-- 4 -->
				<div data-role="collapsible">
					<h3>4반&nbsp;총원 57(핸드폰등록 ${countList.get(3)}명중 ${joinCountList.get(3)}명사용)</h3>
					<ul data-role="listview">
						<c:forEach var="userList" items="${userList}">
							<c:if test="${userList.userId.toString().substring(0,1) eq 4 }">
								<c:choose>
									<c:when test="${userList.userId eq sessionId }">
										<li data-icon="edit">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#page8" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp ne null}">
										<li data-icon="phone">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" onclick="document.location.href='tel:${userList.userHp}'" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp eq null}">
										<li data-icon="lock">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" id="detailBtn">
									</c:when>
								</c:choose>
										<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
											<c:if test="${userList.userImgOld ne null and userList.userImgOld ne ''}">
												<img src="resources/files/4/${userList.userImgOld }" style="width:80px;height:80px;"/>
											</c:if>
											<c:if test="${userList.userImgOld eq null or userList.userImgOld eq ''}">
												<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
											</c:if>
										</c:if>
										<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
											<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
										</c:if>
										<c:if test="${userList.userDo eq null or userList.userCityName eq null}">
											<h2>${userList.userName }</h2>
										</c:if>	
										<c:if test="${userList.userDo ne null and userList.userCityName ne null}">
											<h2>${userList.userName }<font style="font-size:13px;">&nbsp;-&nbsp;${userList.userDo} ${userList.userCityName}</font> </h2>
										</c:if>	
										<c:if test="${userList.userHp ne null and userList.userHp ne ''}">
											<h2>${userList.userHp }</h2>
										</c:if>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				
				<!-- 5 -->
				<div data-role="collapsible">
					<h3>5반&nbsp;총원 56(핸드폰등록 ${countList.get(4)}명중 ${joinCountList.get(4)}명사용)</h3>
					<ul data-role="listview">
						<c:forEach var="userList" items="${userList}">
							<c:if test="${userList.userId.toString().substring(0,1) eq 5 }">
								<c:choose>
									<c:when test="${userList.userId eq sessionId }">
										<li data-icon="edit">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#page8" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp ne null}">
										<li data-icon="phone">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" onclick="document.location.href='tel:${userList.userHp}'" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp eq null}">
										<li data-icon="lock">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" id="detailBtn">
									</c:when>
								</c:choose>
										<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
											<c:if test="${userList.userImgOld ne null and userList.userImgOld ne ''}">
												<img src="resources/files/5/${userList.userImgOld }" style="width:80px;height:80px;"/>
											</c:if>
											<c:if test="${userList.userImgOld eq null or userList.userImgOld eq ''}">
												<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
											</c:if>
										</c:if>
										<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
											<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
										</c:if>
										<c:if test="${userList.userDo eq null or userList.userCityName eq null}">
											<h2>${userList.userName }</h2>
										</c:if>	
										<c:if test="${userList.userDo ne null and userList.userCityName ne null}">
											<h2>${userList.userName }<font style="font-size:13px;">&nbsp;-&nbsp;${userList.userDo} ${userList.userCityName}</font></h2>
										</c:if>	
										<c:if test="${userList.userHp ne null and userList.userHp ne ''}">
											<h2>${userList.userHp }</h2>
										</c:if>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				
				<!-- 6 -->
				<div data-role="collapsible">
					<h3>6반&nbsp;총원 60(핸드폰등록 ${countList.get(5)}명중 ${joinCountList.get(5)}명사용)</h3>
					<ul data-role="listview">
						<c:forEach var="userList" items="${userList}">
							<c:if test="${userList.userId.toString().substring(0,1) eq 6 }">
								<c:choose>
									<c:when test="${userList.userId eq sessionId }">
										<li data-icon="edit">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#page8" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp ne null}">
										<li data-icon="phone">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" onclick="document.location.href='tel:${userList.userHp}'" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp eq null}">
										<li data-icon="lock">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" id="detailBtn">
									</c:when>
								</c:choose>
										<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
											<c:if test="${userList.userImgOld ne null and userList.userImgOld ne ''}">
												<img src="resources/files/6/${userList.userImgOld }" style="width:80px;height:80px;"/>
											</c:if>
											<c:if test="${userList.userImgOld eq null or userList.userImgOld eq ''}">
												<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
											</c:if>
										</c:if>
										<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
											<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
										</c:if>
										<c:if test="${userList.userDo eq null or userList.userCityName eq null}">
											<h2>${userList.userName }</h2>
										</c:if>	
										<c:if test="${userList.userDo ne null and userList.userCityName ne null}">
											<h2>${userList.userName }<font style="font-size:13px;">&nbsp;-&nbsp;${userList.userDo} ${userList.userCityName}</font></h2>
										</c:if>	
										<c:if test="${userList.userHp ne null and userList.userHp ne ''}">
											<h2>${userList.userHp }</h2>
										</c:if>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				
				<!-- 7 -->
				<div data-role="collapsible">
					<h3>7반&nbsp;총원 57(핸드폰등록 ${countList.get(6)}명중 ${joinCountList.get(6)}명사용)</h3>
					<ul data-role="listview">
						<c:forEach var="userList" items="${userList}">
							<c:if test="${userList.userId.toString().substring(0,1) eq 7 }">
								<c:choose>
									<c:when test="${userList.userId eq sessionId }">
										<li data-icon="edit">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#page8" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp ne null}">
										<li data-icon="phone">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" onclick="document.location.href='tel:${userList.userHp}'" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp eq null}">
										<li data-icon="lock">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" id="detailBtn">
									</c:when>
								</c:choose>
										<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
											<c:if test="${userList.userImgOld ne null and userList.userImgOld ne ''}">
												<img src="resources/files/7/${userList.userImgOld }" style="width:80px;height:80px;"/>
											</c:if>
											<c:if test="${userList.userImgOld eq null or userList.userImgOld eq ''}">
												<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
											</c:if>
										</c:if>
										<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
											<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
										</c:if>
										<c:if test="${userList.userDo eq null or userList.userCityName eq null}">
											<h2>${userList.userName }</h2>
										</c:if>	
										<c:if test="${userList.userDo ne null and userList.userCityName ne null}">
											<h2>${userList.userName }<font style="font-size:13px;">&nbsp;-&nbsp;${userList.userDo} ${userList.userCityName}</font> </h2>
										</c:if>	
										<c:if test="${userList.userHp ne null and userList.userHp ne ''}">
											<h2>${userList.userHp }</h2>
										</c:if>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				
				<!-- 8 -->
				<div data-role="collapsible">
					<h3>8반&nbsp;총원 58(핸드폰등록 ${countList.get(7)}명중 ${joinCountList.get(7)}명사용)</h3>
					<ul data-role="listview">
						<c:forEach var="userList" items="${userList}">
							<c:if test="${userList.userId.toString().substring(0,1) eq 8 }">
								<c:choose>
									<c:when test="${userList.userId eq sessionId }">
										<li data-icon="edit">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#page8" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp ne null}">
										<li data-icon="phone">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" onclick="document.location.href='tel:${userList.userHp}'" id="detailBtn">
									</c:when>
									<c:when test="${userList.userId ne sessionId and userList.userHp eq null}">
										<li data-icon="lock">
											<input type="hidden" id="userId" value="${userList.userId }"/>
											<a href="#" id="detailBtn">
									</c:when>
								</c:choose>
										<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
											<c:if test="${userList.userImgOld ne null and userList.userImgOld ne ''}">
												<img src="resources/files/8/${userList.userImgOld }" style="width:80px;height:80px;"/>
											</c:if>
											<c:if test="${userList.userImgOld eq null or userList.userImgOld eq ''}">
												<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
											</c:if>
										</c:if>
										<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
											<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
										</c:if>
										<c:if test="${userList.userDo eq null or userList.userCityName eq null}">
											<h2>${userList.userName }</h2>
										</c:if>	
										<c:if test="${userList.userDo ne null and userList.userCityName ne null}">
											<h2>${userList.userName }<font style="font-size:13px;">&nbsp;-&nbsp;${userList.userDo} ${userList.userCityName}</font> </h2>
										</c:if>	
										<c:if test="${userList.userHp ne null and userList.userHp ne ''}">
											<h2>${userList.userHp }</h2>
										</c:if>
									</a>
								</li>
							</c:if>
						</c:forEach> 
					</ul>
				</div>
			</div>
		</div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	<!-- 포토 -->
	<section id="page2" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/logo.png" style="margin-top:-25px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:green;color:white;">MY</a>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="#page1" data-transition="none">친구</a></li>
	                <li><a href="#" class="ui-btn-active ui-state-persist" data-transition="none">포토</a></li>
	                <li><a href="#page4" data-transition="none">공지</a></li>
	                <li><a href="#page8" data-transition="none">일상</a></li>
	                <li><a href="#page7" data-transition="none">관리</a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:25px;">
		    <!-- 사진등록 가기 버튼 
		    <div>
		    	<a href="#page6" data-role="button" data-icon="plus" style="width:25%" data-transition="none">사진등록</a>
		    </div> -->
		    
		    <div data-role="collapsible-set" data-inset="false">
				<div data-role="collapsible">
					<h3>총동문회 무주 체육대회 (2017.07)</h3>
					<ul data-role="listview">
						<li class="one" data-icon="edit">
							<a>
							
							</a>
						</li>
					</ul>
				</div> 
				<div data-role="collapsible">
					<h3>30주년 행사 (2017.07)</h3>
					<ul data-role="listview">
						<li class="one" data-icon="edit">
							<a>
							
							</a>
						</li>
					</ul>
				</div> 	
				<div data-role="collapsible">
					<h3>고등학교 시절 </h3>
					<ul data-role="listview">
						<li class="one" data-icon="edit">
							<a>
							
							</a>
						</li>
					</ul>
				</div> 	
			</div>
	    </div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>

	
	<!-- 문자 -->
	<section id="page3" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/logo.png" style="margin-top:-25px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:green;color:white;">MY</a>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="#page1" data-icon="user" data-transition="none">친구</a></li>
	                <li><a href="#page2" data-icon="camera" data-transition="none">포토</a></li>
	                <li><a href="#" class="ui-btn-active ui-state-persist" data-icon="mail">문자</a></li>
	                <li><a href="#page4" data-icon="audio" data-transition="none">소식</a></li>
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

	</section>
	
	<!-- 공지 > 목록-->
	<section id="page4" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/logo.png" style="margin-top:-25px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:green;color:white;">MY</a>
	    	<div data-role="navbar">
	             <ul>
	                <li><a href="#page1" >친구</a></li>
	                <li><a href="#page2" data-transition="none">포토</a></li>
	                <li><a href="#page4" data-transition="none" class="ui-btn-active ui-state-persist">공지</a></li>
	                <li><a href="#page7" data-transition="none">일상</a></li>
	                <li><a href="#page8" data-transition="none">관리</a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:20px;">
	       <!-- 공지목록 / 공지내용 선택메뉴  
	       <div data-role="navbar">
	            <ul>
	                <li><a href="#" class="ui-btn-active ui-state-persist" data-icon="bullets" data-transition="none">공지목록</a></li>
	                <li><a href="#page5" data-icon="plus" data-transition="none">공지등록</a></li>
	            </ul>
	        </div> -->
	        
	        <!--공지내용 들어갈부분  -->
	        <div data-role="collapsible-set" data-inset="false">
	        	<h2 style="text-align:center;">공지목록</h2>
	        	<c:forEach var="noticeList" items="${noticeList }" varStatus="i">
	        		<c:if test="${noticeList.noType eq 1 }">
	        			<div data-role="collapsible" id="accodianDiv">
							<h3>[哀事]${noticeList.noSubject }<font style="float:right;font-size:13px;">${noticeList.noRegDate }</font></h3>
							<h4>삼가 고인의 명복을 빕니다.</h4>
							<table  id="bodyTable">
								<thead>
									<tr>
										<th>내용</th>
										<td>${noticeList.coContent }</td>
									</tr>
									<tr>
										<th>발인</th>
										<td>${noticeList.coHanddate }</td>
									</tr>
										<th>장소</th>
										<td>${noticeList.coPlace }</td>
									</tr>
									<tr>
										<th>조문<br/>일시</th>
										<td>${noticeList.noRegDateAfter} 오후7시</td>
									</tr>
								</thead>
								<tbody>
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
							<h3>[行事]${noticeList.noSubject }<font style="float:right;font-size:13px;">${noticeList.noRegDate }</font></h3>
							<h4>행사공지...인사말</h4>
							<table id="bodyTable">
								<thead>
									<tr>
										<th>내용</th>
										<td>${noticeList.coContent }</td>
									</tr>
									<tr>
										<th>행사<br/>일시</th>
										<td>${noticeList.coEventDate }</td>
									</tr>
									<tr>
										<th>회비</th>
										<td>${noticeList.coMoney } 원</td>
									</tr>
										<th>장소</th>
										<td>${noticeList.coPlace }</td>
									</tr>
								</thead>
								<tbody>
									
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
	        			<div data-role="collapsible">
							<h3>[祝賀]${noticeList.noSubject } <font style="float:right;font-size:13px;">${noticeList.noRegDate }</font></h3>
							<h4>${noticeList.noContents }</h4>
						</div>
	        		</c:if>
	        	</c:forEach>
	        </div>

	    </div> 
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	<!--공지 : 공지등록  -->
	<section id="page5" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/logo.png" style="margin-top:-25px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:green;color:white;">MY</a>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="#page1" >친구</a></li>
	                <li><a href="#page2" data-transition="none">포토</a></li>
	                <li><a href="#page4" data-transition="none" class="ui-btn-active ui-state-persist">공지</a></li>
	                <li><a href="#page8" data-transition="none">일상</a></li>
	                <li><a href="#page7" data-transition="none">관리</a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:50px;">
	        <div data-role="navbar">
	            <ul>
	                <li><a href="#page4" data-icon="bullets" data-transition="none">공지목록</a></li>
	                <li><a href="#" class="ui-btn-active ui-state-persist" data-icon="plus" data-transition="none">공지등록</a></li>
	            </ul>
	        </div>
			
			<br/>
			<div id="noticeTitle">
				<h2>공지 카테고리 선택 : </h2>
			</div>
			<div data-role="controlgroup" data-type="horizontal" id="noticeCate">
				<a class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-bars ui-btn-b" href="#" id="typeContent">부의공지</a>
	            <a class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-bars ui-btn-b" href="#" id="typeEvent">행사공지</a>
	            <a class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-bars ui-btn-b" href="#" id="typeNormal">일반공지</a>
	        </div>

			<!-- 부의공지입력폼 -->
			
			<div id="contentDiv" style="display:none;">
				<form id="contentForm">
					<input type="hidden" name="noType" value="1"/>
					
					<label for="noSubject">제목 : </label>
	       			<input type="text" name="noSubject" id="noSubject" placeholder="글 제목">
	       			
	       			<!-- <label for="noImgName">이미지 : </label>
	       			<input type="file" name="noImgName" accept="image/*" multiple="multiple"/> -->
	       			
	       			<label for="writerHp">작성자 휴대폰 : </label>
	       			<input type="tel" name="writerHp" id="writerHp" placeholder="작성자 핸드폰번호">
	       			
	       			<label for="coPlace">장례식장 주소:  </label>
	       			<a class="ui-shadow ui-btn ui-corner-all ui-btn-inline ui-btn-b ui-mini" href="#" id="searchAddBtn" onclick="execDaumPostCodeContent()">주소찾기</a>
					<input type="text" name="coPlace" id="coPlaceContent">
					<input type="text" name="sangseAdd" id="sangseAddContent"/>
					
					<label for="coHanddate">발인날짜 :  </label>
	       			<input type="date" name="coHanddate" id="coHanddate" placeholder="발인날짜">
	       			
	       			<label for="coContent">내용 :  </label>
	       			<textarea name="coContent" id="coContent" rows="8" cols="40" height="150px;" placeholder="내용"></textarea>
	       			
	       			<label for="coPayName">미참자 대납계좌 소유주 :  </label>
	       			<input type="text" name="coPayName" id="coPayName" placeholder="대납계좌 소유주">
	       			
	       			<label for="coPayAccount">미참자 대납계좌 : </label>
	       			<input type="tel" name="coPayAccount" id="coPayAccount" placeholder="대납 계좌번호">
	       			
	       			<br/>
	       			<a data-role="button" data-theme="c" style="background-color:#ff0000;color:#0000ff;" href="#" id="contentAddBtn">공지등록</a>
       			</form>
			</div>
			
			<!-- 행사공지 입력폼 -->
			<div id="eventDiv" style="display:none;">
				<form id="eventForm">
					<input type="hidden" name="noType" value="2"/>
					
					<label for="noSubject">제목 : </label>
	       			<input type="text" name="noSubject" id="noSubject" placeholder="글 제목">
	       			
	       			<!-- <label for="noImgName">이미지 : </label>
	       			<input type="file" name="noImgName" accept="image/*" multiple="multiple"/> -->
	       			
	       			<label for="writerHp">작성자 휴대폰 : </label>
	       			<input type="tel" name="writerHp" id="writerHp" placeholder="작성자 핸드폰번호">
	       			
	       			<label for="coPlace">행사장소:  </label>
	       			<a class="ui-shadow ui-btn ui-corner-all ui-btn-inline ui-btn-b ui-mini" href="#" id="searchAddBtn" onclick="execDaumPostCodeEvent()">주소찾기</a>
					<input type="text" name="coPlace" id="coPlaceEvent">
					<input type="text" name="sangseAdd" id="sangseAddEvent"/>
					
					<label for="coEventDate">행사날짜 :  </label>
	       			<input type="date" name="coEventDate" id="coEventDate" placeholder="발인날짜">
	       			
	       			<label for="coContent">내용 :  </label>
	       			<textarea name="coContent" id="coContent" rows="8" cols="40" height="150px;" placeholder="내용"></textarea>
	       			
	       			<label for="coMoney">회비 : </label>
	       			<input type="tel" name="coMoney" id="coMoney" placeholder="회비">
	       			
	       			<label for="coPayName">회비입금계좌 소유주 :  </label>
	       			<input type="text" name="coPayName" id="coPayName" placeholder="회비입금계좌 소유주">
	       			
	       			<label for="coPayAccount">회비입금계좌 : </label>
	       			<input type="tel" name="coPayAccount" id="coPayAccount" placeholder="회비입금계좌">
	       			
	       			<br/>
	       			<a class="ui-shadow ui-btn ui-corner-all ui-btn-b" href="#" id="eventAddBtn">공지등록</a>
       			</form>
			</div>
			
			<!-- 일반공지 입력폼 -->
			<div id="normalDiv" style="display:none;">
				<form id="normalForm">
					<input type="hidden" name="noType" value="3"/>
					
					<label for="noSubject">제목 : </label>
	       			<input type="text" name="noSubject" id="noSubject" placeholder="글 제목">
	       			
	       			<!-- <label for="noImgName">이미지 : </label>
	       			<input type="file" name="noImgName" accept="image/*" multiple="multiple"/> -->
	       			
	       			<label for="writerHp">작성자 휴대폰 : </label>
	       			<input type="tel" name="writerHp" id="writerHp" placeholder="작성자 핸드폰번호">
	       			
	       			<label for="noContents">내용 :  </label>
	       			<textarea name="noContents" id="noContents" rows="8" cols="40" height="150px;" placeholder="내용"></textarea>
	       			
	       			<br/>
	       			<a class="ui-shadow ui-btn ui-corner-all ui-btn-b" href="#" id="normalAddBtn">공지등록</a>
       			</form>
			</div>
	    </div> 
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	<!-- 포토 > 사진등록 -->
	<section id="page6" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/logo.png" style="margin-top:-25px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:green;color:white;">MY</a>
	    	<div data-role="navbar">
	             <ul>
	                <li><a href="#page1" >친구</a></li>
	                <li><a href="#" class="ui-btn-active ui-state-persist" data-transition="none">포토</a></li>
	                <li><a href="#page4" data-transition="none">공지</a></li>
	                <li><a href="#page8" data-transition="none">일상</a></li>
	                <li><a href="#page7" data-transition="none">관리</a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:50px;">
	    	<a href="#page2" data-role="button" style="width:25%">목록가기</a>
	    	
	    	<!-- <form id="photoForm" enctype="multipart/form-data" method="post">
		        <input type="file" name="uploadFile[]" accept="image/*" id="imgInp" multiple="multiple">
		        <div style="width:100%;height:70%">
		        	<img id="blah" src="#" style="width:100%;height:100%;display:none;" />
		        </div>
		        <input type="text" name="albumMsg"/>
		        <a href="#" data-role="button" id="imgAddBtn">등록하기</a>
			</form> -->

			
	       
	    </div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	<!-- 일상 -->
	<section id="page7" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/logo.png" style="margin-top:-25px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:green;color:white;">MY</a>
	        <div data-role="navbar">
	            <ul>
	                <li><a href="#page1" >친구</a></li>
	                <li><a href="#page2" data-transition="none">포토</a></li>
	                <li><a href="#page4" data-transition="none" >공지</a></li>
	                <li><a href="#" data-transition="none" class="ui-btn-active ui-state-persist">일상</a></li>
	                <li><a href="#page8" data-transition="none">관리</a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:50px;">
	    	<a href="#" onclick="openWriteForm();"><img src="resources/img/write.png" style="width:40px;height:40px;"/></a>
	    	<div id="writeForm" style="width:100%;display:none;">
	    		<textarea></textarea>
	    	</div>
		</div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	<!--관리  -->
	<section id="page8" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/logo.png" style="margin-top:-25px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:green;color:white;">MY</a>
	        <div data-role="navbar">
	             <ul>
	                <li><a href="#page1" >친구</a></li>
	                <li><a href="#page2" data-transition="none">포토</a></li>
	                <li><a href="#page4" data-transition="none" >공지</a></li>
	                <li><a href="#page7" data-transition="none" >일상</a></li>
	                <li><a href="#" data-transition="none" class="ui-btn-active ui-state-persist">관리</a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="height:70%;margin-top:50px;">
	    	관리
		</div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
	
	<!--마이페이지  -->
	<section id="page9" data-role="page">
	    <header data-role="header" style="background-color:#FFBB00;height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/logo.png" style="margin-top:-25px;"/>
	    	<a class="ui-btn-right" href="#page9" data-icon="gear" style="background-color:green;color:white;">MY</a>
	        <div data-role="navbar">
	             <ul>
	                <li><a href="#page1" >친구</a></li>
	                <li><a href="#page2" data-transition="none">포토</a></li>
	                <li><a href="#page4" data-transition="none" >공지</a></li>
	                <li><a href="#page7" data-transition="none" >일상</a></li>
	                <li><a href="#" data-transition="none" class="ui-btn-active ui-state-persist">관리</a></li>
	            </ul>
	        </div>

	    </header>                   
	    
	    <div class="content" data-role="content" style="margin-top:50px;">
	    	<form id="userModifyForm" enctype="multipart/form-data" method="post">
		    	<table style="width:100%;margin-top:10px;">
		    		<tr>
		    			<c:if test="${user.userImgOld eq null && user.userImgNew eq null}">
		 					<!-- <td style="width:50%;"><img src="resources/img/ready.jpg" class="img-round"/></td> -->
		    				<td colspan="2" style="text-align:center;"><img src="resources/img/ready.jpg" id="filePreviewImg" style="width:40%;height:116px;border-radius:70px;"/></td>
		 				</c:if>
		 				<c:if test="${user.userImgOld ne null && user.userImgNew eq null}">
		 					<td style="width:50%;"><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgOld}" class="img-round"/></td>
		    				<td style="width:50%;">
		    					<img src="#" id="filePreviewImg2" style="display:none;width:80%;height:116px;border-radius:70px;"/>
		    				</td>
		 				</c:if>
		 				<c:if test="${user.userImgOld ne null && user.userImgNew ne null}">
		 					<td style="width:50%;"><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgOld}" class="img-round"/></td>
		    				<td><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgNew}" class="img-round" id="filePreviewImg3"/></td>
		 				</c:if>
		 				<c:if test="${user.userImgOld eq null && user.userImgNew ne null}">
		 					<%-- <td style="width:50%;"><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgNew}" class="img-round"/></td> --%>
		    				<td colspan="2" style="text-align:center;"><img src="resources/files/${user.userId.substring(0,1)}/${user.userImgNew}" id="filePreviewImg4" style="width:40%;height:116px;border-radius:70px;"/></td>
		 				</c:if>
		    		</tr>
		    	</table>
		    	<div class="fileInputDiv">
					<img src="resources/img/photo.png" class="fileInputImgBtn" alt="사진등록"/>
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
		    			<td style="border-bottom:1px solid #ddd;width:87%;font-weight:bold;">
		    				${user.userName }
		    			</td>
		    		</tr>
		    		<tr>
		    			<td style="width:13%;"><img src="resources/img/hp.png" style="width:25px;height:25px;"/></td>
		    			<td style="border-bottom:1px solid #ddd;width:87%;font-weight:bold;">
		    				<input type="tel" name="userHp" id="userHpModify" value="${user.userHp }"/>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td style="width:13%;"><img src="resources/img/address.png" style="width:30px;height:30px;"/></td>
		    			<td style="border-bottom:1px solid #ddd;width:85%;font-weight:bold;">
		    				<input type="text" name="userAddress" id="userAddressModify" value="${user.userAddress }"/>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td colspan="2"><button type="button" onclick="userModify();" style="width:100%">개인정보수정</button></td>
		    		</tr>
		    	</table>
	    	
	    	</form>
		</div>
	    
	    <c:import url="./module/footer.jsp"></c:import>

	</section>
</body>
</html>