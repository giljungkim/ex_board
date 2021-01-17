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
					<tbody id="boardList">
						
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


<div class="modal fade" id="detailFormModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">상세 보기</h4>
			</div>
			<div class="modal-body" id="detailForm">
				<div class="form-group">
					<label>제목</label> <input class="form-control" name='title' readonly="readonly">
				</div>
				<div class="form-group">
					<label>글번호</label> <input class="form-control" name='boardIdx' readonly="readonly">
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name='writer' readonly="readonly">
				</div>
				<div class="form-group">
					<label>등록일</label> <input class="form-control" name='regDate' readonly="readonly">
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="15" name='contents' readonly="readonly"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
</div>





<script>
	$(function(){
		console.log("로그인 아이디 :" + "<%=id%>");
		
		getBoardList();//게시물 불러오는 함수
		
		//게시물등록 모달창 띄우기
		$("#regBtn").on("click", function(e) {
			e.preventDefault();
			//모달창 내 내용 지우기
			$("#registerFormModal").find(".form-control").val("");
			$("#registerFormModal").modal("show");

		});

		//게시물 등록하기
		$("#registerBtn").on("click", function(e) {
			e.preventDefault();
			var header = "${_csrf.headerName}";
			var token = "${_csrf.token}";

			$.ajax({
				url : "/board/register",
				data : $("#registerForm").serialize(),
				type : "POST",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(data) {
					console.log(data);
					alert("게시물이 등록되었습니다.");
					$("#registerFormModal").modal("hide");
					getBoardList();//등록 후 게시물 바로 가져오기
				},
				error : function(data) {
					alert("게시물 등록 안됨");
				}

			});//end ajax

		});//end registerBtn

		//디테일 모달 show
		//script 로 생성된 html dom은 id나 class로 컨트롤이 되지 않아 최상위 개체인 document를 먼저 잡은 후 on을 사용하여 핸들러가 가능함
		$(document).on("click", "#detailBtn", function(e) {
			e.preventDefault();
			$("#detailFormModal").modal("show");
			
			var boardIdx = $(this).data("boardidx");
			console.log(boardIdx);
			
			$.ajax({
				url : "/board/detailBoard/" + boardIdx,
				type : "get",
				success : function(board){
					$("#detailForm").find("input[name='title']").val(board.title);
					$("#detailForm").find("input[name='boardIdx']").val(board.boardIdx);
					$("#detailForm").find("input[name='writer']").val(board.writer);
					$("#detailForm").find("input[name='regDate']").val(formatDate(board.regDate));
					$("#detailForm").find("textarea[name='contents']").val(board.contents);
				}
			});//end ajax
			
		});//end #edtailBtn

	});//end document.onload

	function getBoardList() {

		//ajax board list 가져오기
		$.ajax({
			url : "/board/list.run",
			type : "get",
			success : function(list) {
				console.log(list);
				$('#boardList').html("");
				var length = list.length;
				console.log(length);

				if (length === 0) {
					var str = "";
					str += "<tr>";
					str += "<td colspan='5'>조회된 결과가 없습니다.</td>";
					str += "</tr>";

					$("#boardList").append(str);

				} else {
					var str = "";
					for (var i = 0; i < list.length; i++) {
						str += "<tr>";
						str += "<td>" + list[i].boardIdx + "</td>";
						str += "<td><a href='' id='detailBtn' data-boardIdx = '"+list[i].boardIdx+"'>"+ list[i].title + "</a></td>";
						str += "<td>" + list[i].writer + "</td>";
						str += "<td>" + formatDate(list[i].regDate) + "</td>";
						str += "<td>" + formatDate(list[i].modifyDate)+ "</td>";
						str += "</tr>";
					};

					$("#boardList").append(str);

				}//end else
			}//end success
		});//end ajax

	}//end function getBoardList

	//날짜 포맷팅
	function formatDate(dateVal) {
		var date = new Date(dateVal);
		var year = date.getFullYear();
		var month = (1 + date.getMonth());
		month = month >= 10 ? month : '0' + month;
		var day = date.getDate();
		day = day >= 10 ? day : '0' + day;
		return year + '-' + month + '-' + day;
	}
</script>

<%@include file="../includes/footer.jsp"%>
