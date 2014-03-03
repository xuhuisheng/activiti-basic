<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>

<%@page import="java.util.*"%>
<%@page import="org.activiti.engine.*"%>

<%
    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);

	ProcessEngine processEngine = (ProcessEngine) ctx.getBean("processEngine");

	// Get Activiti services
	TaskService taskService = processEngine
		.getTaskService();

	// complete a task
	Map<String, Object> map = new HashMap<String, Object>();
	map.put("superior", "superior");
	taskService.complete(request.getParameter("id"), map);

	response.sendRedirect("index.jsp");
%>


