<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
            crossorigin="anonymous" type=""></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script type="text/javascript" src="../../../script/script.js"></script>
    <script>
        function checkParams() {
            var name = $('#names').val();
            var info = $('#infos').val();

            if (name.length != 0 && info.length != 0) {
                $('#b1').removeAttr('disabled');
            } else {
                $('#b1').attr('disabled', 'disabled');
            }
        }
    </script>
</head>

<body>
<div class="container">
    <c:if test="${empty town.id}">
        <spring:url value="/api/towns" var="saveURL"/>
    </c:if>
    <c:if test="${!empty town.id}">
        <c:url value="/api/towns/edit/${id}" var="saveURL"/>
    </c:if>
    <table class="table">
        <thead>
        <tr>
            <th scope="row">Name</th>
            <th scope="row">Info</th>
        </tr>
        </thead>
        <tbody>
        <div class="container">
            <form:form modelAttribute="town" method="post" action="${saveURL}" cssClass="form">
                <tr>
                    <td>
                        <form:input path="name" cssClass="form-control" onkeyup="checkParams()" id="names"/>
                    </td>
                    <td>
                        <form:input path="info" cssClass="form-control" onkeyup="checkParams()" id="infos"/>
                    </td>
                    <td>
                        <button id="b1" class="btn btn-success" type="submit" disabled>Save</button>
                    </td>
                </tr>
            </form:form>
        </div>
        </tbody>
    </table>
    <spring:url value="/api/towns" var="link"/>
    <a class="btn btn-danger" href="${link}">Return</a>
</div>
</body>
</html>