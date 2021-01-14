<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>

<div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
            	<sec:authorize access="isAnonymous()">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                        <form action="/member/login" method="post">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" type="text" placeholder="아이디를 입력하세요." name="username" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="password" name="password" type="password" value="">
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <a href="index.html" class="btn btn-lg btn-success btn-block">Login</a>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                    </div>
                </div>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
				<form action="/member/logout" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button class="primary-btn">로그아웃</button>
				</form>
			</sec:authorize>
            </div>
        </div>
    </div>
    
    <script>
    	$(".btn-success").on("click", function(e){
    		e.preventDefault();
    		$("form").submit();
    	});
    </script>


<%@include file="../includes/footer.jsp"%>