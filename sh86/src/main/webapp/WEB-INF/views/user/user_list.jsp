<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>신흥고등학교 86기 동문회</title>
	
	<link rel="stylesheet" href="resources/js/jquery.mobile-1.4.5.css">
	<script src="resources/js/jquery.js"></script>
	<script src="resources/js/jquery.mobile-1.4.5.js"></script>
	
	<script>
		/* var accordionZoneFlag = true; // true : 열기, false : 닫기
	 	function accordionControl(){
    		if(accordionZoneFlag){
	            $(".one").slideDown(400, function(){
	                accordionZoneFlag = false;
	                $("#ACCORDION_ZONE_DOWN").css("display","none");
	                $("#ACCORDION_ZONE_UP").css("display","");
	            });
	        }else{
	            $(".one").slideUp(400, function(){
	                accordionZoneFlag = true;
	                $("#ACCORDION_ZONE_DOWN").css("display","");
	                $("#ACCORDION_ZONE_UP").css("display","none");
	            });
	        }
	    } */
	    
	    /* $(document).ready(function(){
	    	console.log(self.name);
	    	 if (self.name != 'reload') {
	             self.name = 'reload';
	             self.location.reload(true);
	         }
	         else self.name = ''; 
	    });
	 	$(document).on('click','#listBtn',function(){
	 		var accordionZoneFlag = $('#listBtn').parent().find('#flag').val();
	 		console.log(accordionZoneFlag)
	 		if(accordionZoneFlag == 'open'){
	            $(".one").css('display','none');
	            $('#listBtn').parent().find('#flag').val('close');
	        }else{
	            $(".one").css('display','');
	            $('#listBtn').parent().find('#flag').val('open');
	        }
	 	}); */
		/* $(document).on('click','#detailBtn',function(){
			var userId = $(this).parent().find('#userId').val();
			console.log(userId);
		}); */
	</script>
</head>
<body>
	<section id="page1" data-role="page">
	    <header data-role="header" style="background-color:#000000;" data-tap-toggle="false" data-position="fixed"><img src="resources/img/logo.png"/>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="userList" class="ui-btn-active ui-state-persist" data-icon="user">친구</a></li>
	                <li><a href="photoList" data-icon="camera">포토</a></li>
	                <li><a href="smsSendForm" data-icon="mail">문자</a></li>
	                <li><a href="noticeList" data-icon="audio">공지</a></li>
	            </ul>
	        </div><!-- /navbar -->
	    </header>                   
	    
	    <div class="content" data-role="content">
	    	<ul data-role="listview">
				<li data-role="list-divider" style="text-align:center;font-weight:bold;font-size:20px;">
					1반
					<!-- <input type="hidden" id="flag" value="close"/> -->
				</li>
				<c:forEach var="userList" items="${userList}">
					<c:if test="${userList.userId.toString().substring(0,1) eq 1 }">
						<li class="one" >
							<input type="hidden" id="userId" value="${userList.userId }"/>
							<a href="#detailPop" id="detailBtn" data-rel="dialog">
								<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
									<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
									<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userCityName eq null or userList.userCityName eq ''}">
									<h2>${userList.userName }[--]</h2>
								</c:if>
								<c:if test="${userList.userCityName ne null and userList.userCityName ne ''}">
									<h2>${userList.userName }[${userList.userCityName }]</h2>
								</c:if>	
									<p>테스트중입니다</p>
							</a>
						</li>
					</c:if>
				</c:forEach>
			
				<li data-role="list-divider">2반</li>
				<c:forEach var="userList" items="${userList}">
					<c:if test="${userList.userId.toString().substring(0,1) eq 2 }">
						<li data-icon="info">
							<input type="hidden" id="userId" value="${userList.userId }"/>
							<a href="javascript:void(0)" id="detailBtn">
								<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
									<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
									<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userCityName eq null or userList.userCityName eq ''}">
									<h2>${userList.userName }[--]</h2>
								</c:if>
								<c:if test="${userList.userCityName ne null and userList.userCityName ne ''}">
									<h2>${userList.userName }[${userList.userCityName }]</h2>
								</c:if>	
									<p>테스트중입니다</p>
							</a>
						</li>
					</c:if>
				</c:forEach>
				
				<li data-role="list-divider">3반</li>
				<c:forEach var="userList" items="${userList}">
					<c:if test="${userList.userId.toString().substring(0,1) eq 3 }">
						<li data-icon="info">
							<input type="hidden" id="userId" value="${userList.userId }"/>
							<a href="javascript:void(0)" id="detailBtn">
								<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
									<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
									<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userCityName eq null or userList.userCityName eq ''}">
									<h2>${userList.userName }[--]</h2>
								</c:if>
								<c:if test="${userList.userCityName ne null and userList.userCityName ne ''}">
									<h2>${userList.userName }[${userList.userCityName }]</h2>
								</c:if>	
									<p>테스트중입니다</p>
							</a>
						</li>
					</c:if>
				</c:forEach>
				
				<li data-role="list-divider">4반</li>
				<c:forEach var="userList" items="${userList}">
					<c:if test="${userList.userId.toString().substring(0,1) eq 4 }">
						<li data-icon="info">
							<input type="hidden" id="userId" value="${userList.userId }"/>
							<a href="javascript:void(0)" id="detailBtn">
								<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
									<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
									<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userCityName eq null or userList.userCityName eq ''}">
									<h2>${userList.userName }[--]</h2>
								</c:if>
								<c:if test="${userList.userCityName ne null and userList.userCityName ne ''}">
									<h2>${userList.userName }[${userList.userCityName }]</h2>
								</c:if>	
									<p>테스트중입니다</p>
							</a>
						</li>
					</c:if>
				</c:forEach>
				
				<li data-role="list-divider">5반</li>
				<c:forEach var="userList" items="${userList}">
					<c:if test="${userList.userId.toString().substring(0,1) eq 5 }">
						<li data-icon="info">
							<input type="hidden" id="userId" value="${userList.userId }"/>
							<a href="javascript:void(0)" id="detailBtn">
								<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
									<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
									<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userCityName eq null or userList.userCityName eq ''}">
									<h2>${userList.userName }[--]</h2>
								</c:if>
								<c:if test="${userList.userCityName ne null and userList.userCityName ne ''}">
									<h2>${userList.userName }[${userList.userCityName }]</h2>
								</c:if>	
									<p>테스트중입니다</p>
							</a>
						</li>
					</c:if>
				</c:forEach>
				
				<li data-role="list-divider">6반</li>
				<c:forEach var="userList" items="${userList}">
					<c:if test="${userList.userId.toString().substring(0,1) eq 6 }">
						<li data-icon="info">
							<input type="hidden" id="userId" value="${userList.userId }"/>
							<a href="javascript:void(0)" id="detailBtn">
								<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
									<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
									<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userCityName eq null or userList.userCityName eq ''}">
									<h2>${userList.userName }[--]</h2>
								</c:if>
								<c:if test="${userList.userCityName ne null and userList.userCityName ne ''}">
									<h2>${userList.userName }[${userList.userCityName }]</h2>
								</c:if>	
									<p>테스트중입니다</p>
							</a>
						</li>
					</c:if>
				</c:forEach>
				
				<li data-role="list-divider">7반</li>
				<c:forEach var="userList" items="${userList}">
					<c:if test="${userList.userId.toString().substring(0,1) eq 7 }">
						<li data-icon="info">
							<input type="hidden" id="userId" value="${userList.userId }"/>
							<a href="javascript:void(0)" id="detailBtn">
								<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
									<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
									<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userCityName eq null or userList.userCityName eq ''}">
									<h2>${userList.userName }[--]</h2>
								</c:if>
								<c:if test="${userList.userCityName ne null and userList.userCityName ne ''}">
									<h2>${userList.userName }[${userList.userCityName }]</h2>
								</c:if>	
									<p>테스트중입니다</p>
							</a>
						</li>
					</c:if>
				</c:forEach>
				
				<li data-role="list-divider">8반</li>
				<c:forEach var="userList" items="${userList}">
					<c:if test="${userList.userId.toString().substring(0,1) eq 8 }">
						<li data-icon="info">
							<input type="hidden" id="userId" value="${userList.userId }"/>
							<a href="javascript:void(0)" id="detailBtn">
								<c:if test="${userList.userImgNew eq null or userList.userImgNew eq ''}">
									<img src="resources/img/ready.jpg" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userImgNew ne null and userList.userImgNew ne ''}">
									<img src="resources/img/${userList.userImgNew }" style="width:80px;height:80px;"/>
								</c:if>
								<c:if test="${userList.userCityName eq null or userList.userCityName eq ''}">
									<h2>${userList.userName }[--]</h2>
								</c:if>
								<c:if test="${userList.userCityName ne null and userList.userCityName ne ''}">
									<h2>${userList.userName }[${userList.userCityName }]</h2>
								</c:if>	
									<p>테스트중입니다</p>
							</a>
						</li>
					</c:if>
				</c:forEach> 
			</ul>
		
	    </div>
	    
	    <c:import url="../module/footer.jsp"></c:import>

	</section>
	
<c:import url="./user_detailPop.jsp"></c:import>	

</body>
</html>