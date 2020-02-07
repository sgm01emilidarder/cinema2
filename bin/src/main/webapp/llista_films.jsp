<%-- Aquesta pàgina mostrarà la llista de pel·lícules i filtrarà per gènere --%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.cinema.dto.Film"%>
<!-- IMPORTANT: error  -->
<%@ page errorPage="error/error-page.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.cinema.service.FilmService" %>
<%@ page import="com.cinema.dto.Genere" %>
<%-- Lògica de l'aplicació --%>
<%

	// Lectura dels paràmetres
    String pGenere = request.getParameter("genere");

	// Validació del paràmetre i creació del valor enum de tipu Genere
	Genere genere = null;
	if (pGenere != null){
		genere  = Genere.valueOf(pGenere);
	}
  
	// Consultas de les pel·lícules filtrades per gènere
	FilmService serveiFilm = new FilmService();
	HashMap<Integer, Film> llistaFilmsFiltrada = serveiFilm.getFilmsPerGenere(genere);
	
    // Introducció al request de 
	request.setAttribute("llistaFilmsFiltrada", llistaFilmsFiltrada);  
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
    <%-- Enllaços cagegories/genere--%>
    <nav>
    	 <a href="llista_films.jsp">Totes els gèneres</a> |
         <a href="llista_films.jsp?genere=FICCIO">Ciència ficció</a> |
         <a href="llista_films.jsp?genere=AVENTURES">Aventures</a> |
         <a href="llista_films.jsp?genere=TERROR">Terror</a> |
         <a href="llista_films.jsp?genere=DIBUIXOS">Dibuixos</a> |
    </nav>
    
    <p>
    	<label>Motrar:</label>
    	<select name="num-film">
    		<option value="5">5</option>
    		<option value="10">10</option>
    		<option value="15">15</option>
    	</select>
    </p>
    <%-- Mostrar llista pel·lícules per gènere --%>
    <ul>
        <%-- Mostrar màxim les pel·lícules de NUM_FILM --%>
        <c:set var="NUM_FILM" value="5" scope="page" />
        <c:forEach var="film" varStatus="loop" items="${llistaFilmsFiltrada}">
            <c:if test = "${loop.index < NUM_FILM}">
            <li>
            	<a href="detall_film.jsp?codi=<c:out value="${film.key}"/>">
                    <c:out value="${film.value.nom}"/>
                </a>
            </li>
            </c:if>
        </c:forEach>
            
    </ul>
<%@include file="footer.jsp" %>