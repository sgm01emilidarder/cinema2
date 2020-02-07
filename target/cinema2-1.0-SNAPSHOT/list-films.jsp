<%-- Aquesta pàgina mostrarà la llista de pel·lícules i filtrarà per gènere --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List"%>
<%@ page import="com.cinema.service.FilmService" %>
<%@ page import="com.cinema.dto.Genere" %>
<%@ page import="com.cinema.dto.Film"%>

<%
	// Lectura dels paràmetres
    String pGenere = request.getParameter("genere");
    String ftitle = request.getParameter("titol-pelicula");

	// Validació del paràmetre i creació del valor enum de tipu Genere
	Genere genere = null;
	if (pGenere != null){
		genere  = Genere.valueOf(pGenere);
	}
  
	FilmService serveiFilm = new FilmService();
	List<Film> llistaFilms = serveiFilm.getListFilms(genere);
	request.setAttribute("llistaFilms", llistaFilms);

	List<Film> llistaFilmsByTitle = serveiFilm.getListFilmsByTitle(ftitle);
	request.setAttribute("llistaFilmsByTitle", llistaFilmsByTitle);
	
	// També introduím el genere al request 
	request.setAttribute("genere", pGenere);
	request.setAttribute("title", ftitle);
	
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="./common/header.jsp" %>

	<!-- Categories -->
	<div class="container py-2 mb-4">
		<ul class="nav justify-content-center">
			<li class="nav-item">
				<a class="nav-link <c:out value="${genere==null?'active':''}"/>"  href="list-films.jsp">Totes les categories</a>
			</li>
			<li class="nav-item">
				<a class="nav-link <c:out value="${genere=='AVENTURES'?'active':''}"/>" href="list-films.jsp?genere=AVENTURES">Aventures</a>
			</li>
			<li class="nav-item">
				<a class="nav-link <c:out value="${genere=='FICCIO'?'active':''}"/>" href="list-films.jsp?genere=FICCIO">Ciència ficció</a>
			</li>
			<li class="nav-item">
				<a class="nav-link <c:out value="${genere=='DIBUIXOS'?'active':''}"/>" href="list-films.jsp?genere=DIBUIXOS">Dibuxos</a>
			</li>
			<li class="nav-item">
				<a class="nav-link <c:out value="${genere=='TERROR'?'active':''}"/>" href="list-films.jsp?genere=TERROR">Terror</a>
			</li>
		</ul>
	</div>

	<!-- Contingut central -->
	<div class="container">

		<!-- 1r - Llista pel·lícules -->
		<div class="row">
			<div class="col-12">
				<ul class="list-unstyled">
				
			        <%-- Mostrar màxim les pel·lícules de NUM_FILM --%>
			        <c:set var="NUM_FILM" value="10" scope="page" />
					<c:choose>
						<c:when test="${title != null}">
							<c:forEach var="film" varStatus="loop" items="${llistaFilmsByTitle}">
								<c:if test = "${loop.index < NUM_FILM}">
									<li class="media  my-4">
										<img src="img/${film.caratula}" class="mr-3" style="width:100px">
										<div class="media-body">
											<a href="detail-film.jsp?codi=<c:out value="${film.id}"/>">
												<h5 class="mt-0 mb-1"> <c:out value="${film.nom}"/> </h5>
											</a>
											<c:if test = "${film.estreno eq true}">
												<span class="badge btn-warning">Estrena</span>
											</c:if>
											<p class="py-0 my-0"><c:out value="${film.sinopsi}"/></p>
											<p class="py-0 my-0">
												<img src="img/age-tp.png" style="width:20px"/>
												Edat recomanada: <c:out value="${film.edatRec}"/>
											</p>
											<p class="py-0 my-0"><c:out value="${film.duracio}"/></p>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="film" varStatus="loop" items="${llistaFilms}">
								<c:if test = "${loop.index < NUM_FILM}">
									<li class="media  my-4">
										<img src="img/${film.caratula}" class="mr-3" style="width:100px">
										<div class="media-body">
											<a href="detail-film.jsp?codi=<c:out value="${film.id}"/>">
												<h5 class="mt-0 mb-1"> <c:out value="${film.nom}"/> </h5>
											</a>
											<c:if test = "${film.estreno eq true}">
												<span class="badge btn-warning">Estrena</span>
											</c:if>
											<p class="py-0 my-0"><c:out value="${film.sinopsi}"/></p>
											<p class="py-0 my-0">
												<img src="img/age-tp.png" style="width:20px"/>
												Edat recomanada: <c:out value="${film.edatRec}"/>
											</p>
											<p class="py-0 my-0"><c:out value="${film.duracio}"/></p>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>


				</ul>
			</div>
		</div>

	</div>
	
<%@include file="./common/footer.jsp" %>