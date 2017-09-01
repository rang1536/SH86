<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<section id="detailPop" data-role="popup">
    <header data-role="header" data-add-back-btn="true"><h1>친구정보</h1></header>
    <div class="content" data-role="content">
		<ul data-role="listview">
			<li data-role="listdivider">앨범</li>
			<li>
				<img src="resources/img/ready.jpg" style="width:130px;height:130px;"/>
        		<img src="resources/img/ready.jpg" style="width:130px;height:130px;"/>
			</li>
			<li data-role="listdivider">회원정보</li>
			<li>${userName}</li>
		</ul>
        	
        <p><a href="#page3">하이하이</a></p>
    </div>
    <footer data-role="footer"><h1>cofs</h1></footer>
</section>
