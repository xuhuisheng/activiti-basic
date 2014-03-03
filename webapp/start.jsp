<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>

<%@page import="java.util.*"%>
<%@page import="org.activiti.engine.*"%>

<%
    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);

	ProcessEngine processEngine = (ProcessEngine) ctx.getBean("processEngine");

	// Get Activiti services
	RuntimeService runtimeService = processEngine
		.getRuntimeService();

	// Start a process instance
	Map params = new HashMap();
	params.put("assignee", "Lingo");
	params.put("participants", "user1,user2");
	runtimeService.startProcessInstanceById(request.getParameter("id"), params);

	response.sendRedirect("index.jsp");
%>


