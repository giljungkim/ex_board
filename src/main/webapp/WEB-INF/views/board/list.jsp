<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="org.springframework.security.core.Authentication"%>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String id = "";
    if(principal != null) {
        id = auth.getName();
    }
%>


<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시판</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Board List Page
				<sec:authorize access="isAuthenticated()">
				<button id='regBtn' type="button" class="btn btn-xs pull-right">Register New Board</button>
				</sec:authorize>
			</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<colgroup>
						<col width="15%" />
						<col width="*" />
						<col width="15%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">#번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${!empty list }">
							<c:forEach items="${list}" var="board">
								<tr>
									<td><c:out value="${board.boardIdx}" /></td>

									<td><c:out value="${board.title}" /></td>

									<td><c:out value="${board.writer}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd"
											value="${board.regDate}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd"
											value="${board.modifyDate}" /></td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty list }">
							<tr>
								<td colspan="5">조회된 결과가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<div class='row'>
					<div class="col-lg-12">

						<form id='searchForm' action="/board/list" method='get'>
							<select name='type'>
								<option value=""
									<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
								<option value="W"
									<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
								<option value="TC"
									<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목
									or 내용</option>
								<option value="TW"
									<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목
									or 작성자</option>
								<option value="TWC"
									<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목
									or 내용 or 작성자</option>
							</select> <input type='text' name='keyword'
								value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
								type='hidden' name='pageNum'
								value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input
								type='hidden' name='amount'
								value='<c:out value="${pageMaker.cri.amount}"/>' />
							<button class='btn btn-default'>Search</button>
						</form>
					</div>
				</div>


				<div class='pull-right'>
					<ul class="pagination">

						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous"><a
								href="${pageMaker.startPage -1}"><span class="fa-angle-left"></span></a></li>
						</c:if>

						<c:forEach var="num" begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}">
							<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>

						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a
								href="${pageMaker.endPage +1 }"><span class="fa-angle-right"></span></a></li>
						</c:if>


					</ul>
				</div>
				<!--  end Pagination -->
			</div>
		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<div class="modal fade" id="registerFormModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title" id="myModalLabel">게시물 등록</h4>
            </div>
            <form action="/board/register" id="registerForm" method="post">
            <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
            <div class="modal-body">
              <div class="form-group">
                <label>제목</label> 
                <input class="form-control" name='title'>
              </div>
              <div class="form-group">
                <label>내용</label> 
                <textarea class="form-control" rows="15" name='contents'></textarea>
              </div>
		     <div class="modal-footer">
		     	<button type="button" id="registerBtn" class="btn btn-default">게시물 등록</button>
		        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
		      </div>          
      		</div>
          <!-- /.modal-content -->
          </form>
          <!--  /.form -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
</div>



<script>
	$(function(){
		console.log("로그인 아이디 :" + "<%=id%>");
		
		//ajax board list 가져오기
		$.ajax({
			url : "/board/list.run",
			type : "get",
			success : function(data){
				console.log(data);
			}
		});
			
			$("#regBtn").on("click", function(e){
				e.preventDefault();
				//모달창 내 내용 지우기
				$("#registerFormModal").find(".form-control").val("");
				$("#registerFormModal").modal("show");
				
			});
			
			$("#registerBtn").on("click", function(e){
				e.preventDefault();
				//$("#registerForm").submit();
				//alert("게시물이 등록되었습니다.");
				var header = "${_csrf.headerName}";
			    var token = "${_csrf.token}";
			   
			    $.ajax({
			    	url : "/board/register",
			    	data : $("#registerForm").serialize(),
			    	type : "POST",
			    	beforeSend : function(xhr)
		            {   
		         xhr.setRequestHeader(header, token);
		            },
			    	success : function(data){
			    		console.log(data);
			    		alert("게시물이 등록되었습니다.");
			    		$("#registerFormModal").modal("hide");
			    	},
			    	error : function(data){
			    		alert("게시물 등록 안됨");
			    	}
			    	
			    });//end ajax

			});
			
			
	});
</script>

<%@include file="../includes/footer.jsp"%>
