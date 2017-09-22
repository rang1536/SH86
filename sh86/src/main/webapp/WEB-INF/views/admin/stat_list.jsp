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
	
	<link href="resources/img/logo2.jpg" rel="shortcut icon" />
	<link href="resources/img/logo2.jpg" rel="apple-touch-icon"></link>
	
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
		
		function userList(classNum){
			location.href = 'statDetail?classNum='+classNum;	
			submit();
		}
	</script>
</head>
<body>
<!--관리  -->
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
	    	<table style="width:100%;border-bottom:3px solid #ddd;margin-top:2px;">
	    		<tr>
	    			<td style="width:70%;height:35px;">
	    				<select id="classNum" name="classNum" style="width:100%;height:35px;" onchange="userList(this.value)" data-native-menu="false">
	    					<option value="1">1반(${joinCountList.get(0)}/58)</option>
	    					<option value="2">2반(${joinCountList.get(1)}/54)</option>
	    					<option value="3">3반(${joinCountList.get(2)}/55)</option> 
	    					<option value="4">4반(${joinCountList.get(3)}/57)</option>
	    					<option value="5">5반(${joinCountList.get(4)}/56)</option>
	    					<option value="6">6반(${joinCountList.get(5)}/60)</option>
	    					<option value="7">7반(${joinCountList.get(6)}/57)</option>
	    					<option value="8">8반(${joinCountList.get(7)}/58)</option>
	    				</select>
	    				<script>
	    					$('#classNum').val('${userList.get(0).userId.substring(0,1)}').prop('selected','selected');
	    				</script>
	    			</td>
	    			<td style="width:30%;text-align:right;" onclick="photoList(4);">
	    				<img src="resources/img/list.jpg" style="width:35px;height:35px;"/>
				    </td>
	    			<!-- <td style="width:10%;text-align:center;"><img src="resources/img/cencel2.png" style="width:28px;height:28px;"/></td> -->
	    		</tr>
	    	</table>	
	    	<table style="width:100%;">
	    		<c:if test="${userList.get(0).userId.substring(0,1) eq '6'}">
	    			<tr>
						<td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
							<img src="resources/files/6/3632.jpg" style="width:40px;height:40px;border-radius:10px;">
						</td>
						<td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
							<img src="resources/files/6/3632new.jpg" style="width:40px;height:40px;border-radius:10px;">
						</td>
						<td style="border-bottom:1px dotted #ddd;">
							<font style="color:#030066;font-weight:bold;">재무 오민권</font><br/>
							<font style="font-size:13px;font-weight:bold;">${userList.get(28).userJoinCheck}회 접속</font><br/>
							<font style="font-size:13px;font-weight:bold;">${userList.get(28).userLastDate}</font>
						</td>
						<td style="text-align:right;border-bottom:1px dotted #ddd;">
							<a href="tel:'010-3673-1951'"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>
						</td>
					</tr>
				</c:if>
				<c:if test="${userList.get(0).userId.substring(0,1) eq '8'}">
	    			<tr>
						<td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
							<img src="resources/files/8/3848.jpg" style="width:40px;height:40px;border-radius:10px;">
						</td>
						<td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
							<img src="resources/files/8/3848new.jpg" style="width:40px;height:40px;border-radius:10px;">
						</td>
						<td style="border-bottom:1px dotted #ddd;">
							<font style="color:#030066;font-weight:bold;">회장 최기호</font><br/>
							<font style="font-size:13px;font-weight:bold;">${userList.get(40).userJoinCheck}회 접속</font><br/>
							<font style="font-size:13px;font-weight:bold;">${userList.get(40).userLastDate}</font>
						</td>
						<td style="text-align:right;border-bottom:1px dotted #ddd;">
							<a href="tel:'010-3673-1951'"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>
						</td>
					</tr>
					<tr>
						<td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
							<img src="resources/files/8/3845.jpg" style="width:40px;height:40px;border-radius:10px;">
						</td>
						<td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
							<img src="resources/files/8/3845new.jpg" style="width:40px;height:40px;border-radius:10px;">
						</td>
						<td style="border-bottom:1px dotted #ddd;">
							<font style="color:#030066;font-weight:bold;">총무 정윤승</font><br/>
							<font style="font-size:13px;font-weight:bold;">${userList.get(37).userJoinCheck}회 접속</font><br/>
							<font style="font-size:13px;font-weight:bold;">${userList.get(37).userLastDate}</font>
						</td>
						<td style="text-align:right;border-bottom:1px dotted #ddd;">
							<a href="tel:'010-3673-1951'"><img src="resources/img/call.jpg" style="width:40px;height:40px;"/></a>
						</td>
					</tr>
				</c:if>
	    		<c:forEach var="userList" items="${userList}">
	    			<c:choose>
		    			<c:when test="${userList.userId.substring(0,1) eq '6'}">
		    				<c:if test="${userList.userId ne '632'}">
								<tr>
									<td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
										<c:choose>
											<c:when test="${userList.userImgOld ne null and userList.userImgNew eq null}">
												<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgOld}" style="width:40px;height:40px;margin-top:10px;border-radius:10px;">
												</td><td colspan="2" style="border-bottom:1px dotted #ddd;">
											</c:when>
											<c:when test="${userList.userImgOld ne null and userList.userImgNew ne null}">
												<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgOld}" style="width:40px;height:40px;border-radius:10px;">
												</td><td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
												<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgNew}" style="width:40px;height:40px;border-radius:10px;">
												</td><td style="border-bottom:1px dotted #ddd;">
											</c:when>
											<c:when test="${userList.userImgOld eq null and userList.userImgNew eq null}">
												</td><td colspan="2" style="border-bottom:1px dotted #ddd;">
											</c:when>
										</c:choose>
										<font style="color:black;font-weight:bold;">${userList.userName}</font><br/>
										<c:if test="${userList.userJoinCheck ne 0}">
											<font style="font-size:13px;font-weight:bold;color:blue">${userList.userJoinCheck}회 접속</font><br/>
										</c:if>
										<c:if test="${userList.userJoinCheck eq 0}">
											<font style="font-size:13px;font-weight:bold;">-회 접속</font><br/>
										</c:if>
										<font style="font-size:13px;font-weight:bold;">${userList.userLastDate}</font>
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
							<c:if test="${userList.userId eq '632'}">
							</c:if>
						</c:when>
						<c:when test="${userList.userId.substring(0,1) eq '8'}">
							<c:if test="${userList.userId ne '845' and userList.userId ne '848'}">
								<tr>
									<td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
										<c:choose>
											<c:when test="${userList.userImgOld ne null and userList.userImgNew eq null}">
												<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgOld}" style="width:40px;height:40px;margin-top:10px;border-radius:10px;">
												</td><td colspan="2" style="border-bottom:1px dotted #ddd;">
											</c:when>
											<c:when test="${userList.userImgOld ne null and userList.userImgNew ne null}">
												<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgOld}" style="width:40px;height:40px;border-radius:10px;">
												</td><td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
												<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgNew}" style="width:40px;height:40px;border-radius:10px;">
												</td><td style="border-bottom:1px dotted #ddd;">
											</c:when>
											<c:when test="${userList.userImgOld eq null and userList.userImgNew eq null}">
												</td><td colspan="2" style="border-bottom:1px dotted #ddd;">
											</c:when>
										</c:choose>
										<font style="color:black;font-weight:bold;">${userList.userName}</font><br/>
										<c:if test="${userList.userJoinCheck ne 0}">
											<font style="font-size:13px;font-weight:bold;color:blue">${userList.userJoinCheck}회 접속</font><br/>
										</c:if>
										<c:if test="${userList.userJoinCheck eq 0}">
											<font style="font-size:13px;font-weight:bold;">-회 접속</font><br/>
										</c:if>
										<font style="font-size:13px;font-weight:bold;">${userList.userLastDate}</font>
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
							<c:if test="${userList.userId eq '845' or userList.userId eq '848'}"></c:if>
						</c:when>
						<c:otherwise>
							<tr>
								<td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
									<c:choose>
										<c:when test="${userList.userImgOld ne null and userList.userImgNew eq null}">
											<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgOld}" style="width:40px;height:40px;margin-top:10px;border-radius:10px;">
											</td><td colspan="2" style="border-bottom:1px dotted #ddd;">
										</c:when>
										<c:when test="${userList.userImgOld ne null and userList.userImgNew ne null}">
											<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgOld}" style="width:40px;height:40px;border-radius:10px;">
											</td><td style="width:41px;height:45px;border-bottom:1px dotted #ddd;">
											<img src="resources/files/${userList.userId.substring(0,1)}/${userList.userImgNew}" style="width:40px;height:40px;border-radius:10px;">
											</td><td style="border-bottom:1px dotted #ddd;">
										</c:when>
										<c:when test="${userList.userImgOld eq null and userList.userImgNew eq null}">
											</td><td colspan="2" style="border-bottom:1px dotted #ddd;">
										</c:when>
									</c:choose>
									<font style="color:black;font-weight:bold;">${userList.userName}</font><br/>
									<c:if test="${userList.userJoinCheck ne 0}">
										<font style="font-size:13px;font-weight:bold;color:blue">${userList.userJoinCheck}회 접속</font><br/>
									</c:if>
									<c:if test="${userList.userJoinCheck eq 0}">
										<font style="font-size:13px;font-weight:bold;">-회 접속</font><br/>
									</c:if>
									<font style="font-size:13px;font-weight:bold;">${userList.userLastDate}</font>
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
						</c:otherwise>
					</c:choose>
				</c:forEach>
	    	</table>
	    	
		</div><!--컨텐츠 끝  -->
		
		<c:import url="../module/footer.jsp"></c:import>
	</section>
	 
</body>
</html>