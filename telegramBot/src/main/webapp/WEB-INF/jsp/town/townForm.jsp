<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Towns</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
            crossorigin="anonymous" type=""></script>
</head>
<body>
<%--<div id="welcome"></div>--%>
<%--<script type="text/javascript">--%>
<%--    const pass = '123';--%>
<%--    let password;--%>
<%--    do {--%>
<%--        password = prompt('Please, enter the password:');--%>
<%--    }--%>
<%--    while (password !== pass);--%>
<%--</script>--%>
<div class="container">
    <p class="h1">Bot configuration</p>
    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="row">Id</th>
            <th scope="row">Town name</th>
            <th scope="row">Town info</th>
            <th scope="row">Update</th>
            <th scope="row">Delete</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${townForm}" var="town">
            <tr>
                <td>${town.id}</td>
                <td>${town.name}</td>
                <td>${town.info}</td>
                <td>
                    <spring:url value="/api/towns/edit/${town.id}" var="Update"/>
                    <a class="btn btn-info" href="${Update}">Update</a>
                </td>
                <td>
                    <spring:url value="/api/towns/delete/${town.id}" var="Delete"/>
                    <a class="btn btn-danger" href="${Delete}">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <spring:url value="/main" var="link"/>
    <a class="btn btn-primary" href="${link}">Homepage</a>
    <spring:url value="/api/towns/add" var="addURL"/>
    <a class="btn btn-success" href="${addURL}">Add town</a>
</div>
</body>
</html>