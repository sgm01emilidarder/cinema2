<%@page import="java.time.LocalDate"%>
<%@page import="com.cinema.dto.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nomWeb = "CinemaDor";       
    int anysAniversari = 30;
    LocalDate dataFundacio = LocalDate.of(1986, 3, 11);
    //Coordenades localització
    float x = 167.23f;
    float y = 168.23f; 
    
    
    User usuari = (User)session.getAttribute("user");
    request.setAttribute("usuari", usuari); 
    
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cinema</title>
    </head>
    <body>
        <h1><%=nomWeb %></h1>
        <c:set var="avui" value="<%=new java.util.Date()%>" />
        <p>Avui:<c:out value="${avui}"/></p>
        
        <c:if test = "${usuari==null}">
	        <div style="text-align:right">
	        	<a href="login/user-login.jsp">LOG in</a>
	        </div>
        </c:if>
        <c:if test = "${usuari!=null}">
	        <div style="text-align:right">
	        	<c:out value="${usuari.nom}"/>
	        </div>
        </c:if>