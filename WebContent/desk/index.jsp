<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	//设置页面不缓存    
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>


<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>主界面</title>
</head>
<frameset rows="15%,80%,5%" frameborder="NO" border="0" framespacing="0">
	<frame src="<%=basePath%>desk/top.jsp" name="topFrame" scrolling="no"
		marginheight="0" target="middleFrame" />
	<frame src="<%=basePath%>desk/demo.jsp" name="middleFrame"
		scrolling="no" target="_self" />
	<frame src="<%=basePath%>desk/footer.html" name="bottomFrame"
		scrolling="no" />
</frameset>
</html>