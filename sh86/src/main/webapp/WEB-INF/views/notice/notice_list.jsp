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
	
</head>
<body>
	<section id="page4" data-role="page">
	    <header data-role="header" style="background-color:#000000;" data-tap-toggle="false" data-position="fixed"><img src="resources/img/logo.png"/>
	    	<div data-role="navbar">
	            <ul>
	                <li><a href="userList" data-icon="user">친구</a></li>
	                <li><a href="photoList" data-icon="camera">포토</a></li>
	                <li><a href="smsSendForm" data-icon="mail">문자</a></li>
	                <li><a href="noticeList" class="ui-btn-active ui-state-persist" data-icon="audio">공지</a></li>
	            </ul>
	        </div><!-- /navbar -->

	    </header>                   
	    
	    <div class="content" data-role="content">
			공지사항!!<br/>
			공지사항!!
	    </div>
	    
	    <c:import url="../module/footer.jsp"></c:import>

	</section>

</body>
</html>