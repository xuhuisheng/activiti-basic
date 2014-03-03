<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>

<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="org.activiti.engine.*"%>
<%
	String action = request.getParameter("action");

	if ("deploy".equals(action)) {
		String xml = request.getParameter("xml");

		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);

		ProcessEngine processEngine = (ProcessEngine) ctx.getBean("processEngine");

		// Get Activiti services
		RepositoryService repositoryService = processEngine
			.getRepositoryService();

		// Deploy the process definition
		repositoryService.createDeployment()
						 .addInputStream("process.bpmn20.xml", new ByteArrayInputStream(xml.getBytes("UTF-8")))
						 .deploy();

		response.sendRedirect("index.jsp");
		return;
	}

%>
<html>
  <head>
    <title>deploy</title>
  </head>
  <body>
    <form action="deploy.jsp?action=deploy" method="post">
	  <button>deploy</button>
	  <br>
	  <textarea name="xml" rows="20" cols="120"></textarea>
	</form>
  </body>
</html>


