<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- Page Content -->
<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">회원가입</h1>
		</div>
		<!-- /.col-lg-12 -->
		<div class="col-lg-8">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form action="/member/registerMember" id="registerMemberForm" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<div class="form-group">
									<label>아이디</label>
									<input class="form-control" name="id" placeholder="아이디를 입력하세요.">
								</div>
								<div class="form-group">
									<label>패스워드</label>
									<input class="form-control" name="password" type="password" placeholder="패스워드를 입력하세요.">
								</div>
								<div class="form-group">
									<label>이름</label>
									<input class="form-control" name="name" placeholder="이름을 입력하세요.">
								</div>
								<div class="form-group">
									<label>전화번호</label>
									<input class="form-control" name="phoneNo" placeholder="휴대폰 번호를 입력하세요.">
								</div>
								<div class="form-group">
									<label>이메일</label>
									<input class="form-control" name="email" placeholder="이메일을 입력하세요.">
								</div>
								<div class="form-group">
									<label>성별</label>
									<div class="radio">
										<label class="radio-inline">
										<input type="radio" name="sex" id="optionsRadiosInline1" value="남" checked>남
										</label> <label class="radio-inline"> <input type="radio"
											name="sex" id="optionsRadiosInline2"
											value="여">여
										</label>
									</div>
								</div>
								<div class="form-group">
									<label>주소</label>
									<input type="text" id="sample4_jibunAddress" name="address" class="form-control" placeholder="동까지만 입력하세요.">
									<span class="input-group-btn">
										<button id="addressBtn" class="btn btn-default" type="button">
											<i class="fa fa-search"></i>
										</button>
									</span>
								</div>
							</form>
							<!-- end from -->
							<button type="button" id="registerBtn" class="btn btn-default">회원가입</button>
						</div>
						<!-- end col-lg-6 -->
					</div>
					<!-- end row -->
				</div>
				<!-- end panel-body -->
			</div>
			<!-- end panel panel-default -->
		</div>
		<!-- end col-lg-12 -->
	</div>
	<!-- /.row -->
</div>
<!-- /.container-fluid -->

<script src="/resources/js/registerMember.js"></script>

<%@include file="../includes/footer.jsp"%>
