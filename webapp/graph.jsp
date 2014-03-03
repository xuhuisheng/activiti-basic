<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>

<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="org.activiti.engine.*"%>
<%@page import="org.activiti.engine.repository.*"%>
<%@page import="org.activiti.engine.task.*"%>
<%@page import="org.activiti.engine.impl.cmd.*"%>
<%@page import="org.activiti.engine.impl.interceptor.Command"%>

<%@page import="com.mossle.activiti.ProcessInstanceDiagramCmd"%>

<%
    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);

	ProcessEngine processEngine = (ProcessEngine) ctx.getBean("processEngine");

	// Get Activiti services
	RepositoryService repositoryService = processEngine
		.getRepositoryService();

	String processDefinitionId = request.getParameter("processDefinitionId");
	String processInstanceId = request.getParameter("processInstanceId");
	String taskId = request.getParameter("taskId");

	response.setContentType("image/png");

	Command<InputStream> cmd = null;

	if (processDefinitionId != null) {
		cmd = new GetDeploymentProcessDiagramCmd(processDefinitionId);
	}

	if (processInstanceId != null) {
		cmd = new ProcessInstanceDiagramCmd(processInstanceId);
	}

	if (taskId != null) {
		Task task = processEngine.getTaskService().createTaskQuery().taskId(taskId).singleResult();
		cmd = new ProcessInstanceDiagramCmd(task.getProcessInstanceId());
	}

	if (cmd != null) {
        InputStream is = processEngine.getManagementService()
			.executeCommand(cmd);

		int len = 0;
		byte[] b = new byte[1024];
		while ((len = is.read(b, 0, 1024)) != -1) {
			response.getOutputStream().write(b, 0, len);
		}
	}

	out.clear();
	out = pageContext.pushBody();

%>
