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
	 
	 <style>
	 	.songListTd{
			width:25%;
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
			location.href = 'userList#page8'
		}else if(num == 9){
			location.href = 'userList#page9'
		}
		submit(); 
	};
	
	function songList(num){
		location.href = 'songList?num='+num;
	}
	</script>
</head>
<body>
	<section id="page1" data-role="page">
	    <header data-role="header" style="height:45px;" data-tap-toggle="false" data-position="fixed">
	    	<img src="resources/img/topimage.jpg" style="width:100%;height:60px;"/>
	    	<a class="ui-btn-right" onclick="photoList(9)" href="#" data-icon="gear" style="background-color:rgba(255,255,255,0.5);">MY</a>
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
	    	<div style="width:20%;text-align:center;float:right;" onclick="photoList(0);">
	    		<img src="resources/img/list.jpg" style="width:35px;height:35px;"/>
	    	</div>
	    	
	    	<video width="100%" height="100%" controls="controls">
			    <source src="resources/files/song/song3.mp4" type="video/mp4" />
			</video>
			
			<br/><br/>
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
	    
		<c:import url="../module/footer.jsp"></c:import>
	</section>
</body>
</html>