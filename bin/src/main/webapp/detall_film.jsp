<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page errorPage="error/error-page.jsp"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.cinema.service.FilmService" %>
<%@ page import="com.cinema.dto.Film"%>

<%
    // Lectura de paràmetres: codi de la pel·lícula
    Integer codiFilm = Integer.parseInt(request.getParameter("codi"));
    System.out.println("Codi film:"+codiFilm);

 	// Recuperam l'objecte pel·lícula
	FilmService serveiFilm = new FilmService();
	Film film = serveiFilm.getFilm(codiFilm);	
	
	// Necessari per ser processat per JSLT
    request.setAttribute("pelicula", film);
	
	// Variable per determinar si mostra la fitxa html de la pel·lícula o no
	boolean trobada = (film!=null);
    request.setAttribute("exist", trobada);
 %>
 
<%-- capçalera --%>
<jsp:include page="header.jsp" />

<c:if test = "${exist}">    
    <%-- Presentació de les dades de la pel·lícula --%>
    <ul>
        <li>Nom:<c:out value="${pelicula.nom}"/></li>
        <li>Sinopsis:<c:out value="${pelicula.sinopsis}"/></li>
        <li>Gènere:<c:out value="${pelicula.genere}"/></li>
        <li>Caràtula:<c:out value="${pelicula.caratula}"/></li>        
        <li>Estrena:<c:out value="${pelicula.estreno}"/></li>
       
        <%-- Transformació de LocaleData a Date i després al format català --%>
        <fmt:parseDate value="${pelicula.dataEstreno}" pattern="yyyy-MM-dd" var="dataEstrenoParse" type="date" />
        <fmt:formatDate value="${dataEstrenoParse}" var="data_estreno" pattern="dd-MM-yyyy"/>
        
        <%-- Missatge segons si és pel·licula d'estrena --%>
        <c:if test = "${pelicula.estreno}">
            <li>Data estrena:<c:out value="${data_estreno==null ?'Proximament':data_estreno}" /> </li>
        </c:if> 
        
        <%-- Missatge segons l'edat recomanada --%>
        <c:choose>
            <c:when test="${pelicula.edatRec eq 18}">
                <c:out value="${'<li>Edat recomanora a partir de 18'}" escapeXml="false" />
                <c:out value="${'<li>Conté contigut que pot especialment sensible</li>'}" escapeXml="false"/>
            </c:when>
            <c:when test="${pelicula.edatRec eq 16}">
                <c:out value="${'<li>Edat recomanora a partir de 16. Pot contenir escenes i vocabulari violent</li>'}" escapeXml="false"/>
            </c:when>
            <c:otherwise>
                <c:out value="${'<li>Tots els públics. Divertida per tota la familia</li>'}" escapeXml="false"/>
            </c:otherwise>
        </c:choose>
        
        <%-- Es mostra horari del cinema si no hi es d'estreno o si la data d'avui és igual que l'actual --%>
        <fmt:formatDate value="${now}" var="avui" pattern="dd-MM-yyyy"/>        
        <c:if test = "${!pelicula.estreno || (data_estreno eq avui)}">
            <p>
                <c:forEach var="hora" varStatus="loop" items="${pelicula.horari}">  
                     <c:out value="${hora.value}"/>
                     <%-- Dibuix de n "," --%>
                    <%-- <c:if test = "${loop.index < ((pelicula.horari)-1)}">,</c:if>--%>
                </c:forEach>
            </p>
        </c:if>           
    </ul>
</c:if>

<%-- Missatge d'avís controlat si no s'ha trobat cap pel·lícula amb el codi especificat --%>
<c:if test = "${!exist}">
    <jsp:forward page = "codi_incorrecte.jsp" />     
</c:if>

<%-- Foote: inclou el resultat de la URL --%>
<jsp:include page="footer.jsp" />
                   

