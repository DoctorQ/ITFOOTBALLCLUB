<!DOCTYPE html>
<%@page language="java" import="com.aodci.bean.*,java.util.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<ShotBoard> shotBoards = (List<ShotBoard>)request.getAttribute("shotBoards");
%>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>球员详细信息</title>
<link rel="shortcut icon" href="../favicon.ico">

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/desk/demo.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/desk/style.css" />
<link rel="stylesheet" href="<%=basePath%>css/desk/main-stylesheet.css" />

<link rel="stylesheet" href="<%=basePath%>css/desk/stylesly.css">
<link rel="stylesheet" href="<%=basePath%>css/desk/sportermes.css">
<script src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
<script src="<%=basePath%>js/jquery.sly.js"></script>
<script src="<%=basePath%>js/plugins.js"></script>
<script src="<%=basePath%>js/main.js"></script>
<script type="text/javascript"
	src="<%=basePath%>js/jquery.hoverdir.js"></script>
<script src="<%=basePath%>js/modernizr.custom.97074.js"></script>
<script src="<%=basePath%>js/jquery.heatcolor.0.0.1.js"
	type="text/javascript"></script>
<script src="<%=basePath%>js/jquery.tablesorter.pack.js"
	type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$("#ex1").tablesorter();
	function sortwithcolor( column ) {
	$("#ex1 > tbody > tr").heatcolor(
	function() { return $("td:nth-child(" + column + ")", this).text(); }
	);
	};
	$("th").click(function() {
	$(this).siblings().css("background-color","#cccccc").end().css("background-color","#dd0000");
	sortwithcolor( $(this).parent().children().index( this ) + 1 );
	});
	sortwithcolor(8);
});
</script>
<noscript>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/noJS.css" />
</noscript>
</head>
<body>
	<div id="sections" class="container1">
		<div id="vertical" class="clearfix">
			<div class="slyWrap example2">
				<div class="scrollbar">
					<div class="handle"></div>
				</div>

				<div class="sly" data-options='{ "startAt": 1, "scrollBy": 30}'>
					<div>
						<div>
						<h2>射手榜</h2>
						<table width="770" cellspacing="1" cellpadding="2" border="0" align="center"
							id="ex1">
							<thead>
								<tr>
									<th bgcolor="#cccccc" align="center" class="textSm primary">
										射手</th>
									<th width="24" nowrap="nowrap" bgcolor="#cccccc" align="center"
										class="textSm primary"><b>俱乐部</b></th>
									<th width="24" nowrap="nowrap" bgcolor="#cccccc" align="center"
										class="textSm primary"><b>进球</b></th>
									<th width="24" nowrap="nowrap" bgcolor="#cccccc" align="center"
										class="textSm primary"><b> 排名</b></th>
								</tr>
							</thead>
							<tbody>
								<% 
									for(int i=0;i<shotBoards.size();i++){
									ShotBoard sBoard = shotBoards.get(i);
								%>
								<tr>
									<td>
										<table cellspacing="0" cellpadding="0" border="0">
											<tbody>
												<tr>
													<td nowrap="" align="left"><%=sBoard.getName() %></td>
												</tr>
											</tbody>
										</table></td>
									<td align="center"><%=sBoard.getCname()%></td>
									<td align="center"><%=sBoard.getGoals() %></td>
									<td align="center"><%=i+1 %></td>	
								</tr>
								<%
									}
								 %>
							</tbody>
						</table>
						</div>
						<div>
					</div>
				</div>
			</div>
		</div>
		<!--end:#vertical-->
	</div>
	<script type="text/javascript">
		$(function() {
			$(' #da-thumbs > li ').each(function() {
				$(this).hoverdir();
			});

		});
	</script>
</body>
</html>