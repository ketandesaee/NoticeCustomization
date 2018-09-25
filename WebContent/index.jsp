<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.*"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.parser.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<%
	JSONParser parser = new JSONParser();
	JSONObject obj = new JSONObject();
	JSONArray notices = new JSONArray();
	String strStates = "", strPillars = "", checkState = "";
	boolean showNotices = false;
	
	String custState = "3",custPillar = "HOP"; 
	
	try {

		obj = (JSONObject) parser.parse(new FileReader(new File(
				"D:/workspace/files/notice-params.json")));

		showNotices = ((Boolean)obj.get("showNotice")).booleanValue();
		notices = (JSONArray) obj.get("notices");

		//out.print(notices);

	} catch (Exception e) {
		e.printStackTrace();
	}
%>

</head>
<body>

	<%
		if (showNotices) {
			boolean stateCheck = false,pillarCheck=false;
			for (int i = 0; i < notices.size(); i++) {
				JSONObject jsonObj = (JSONObject) notices.get(i);
				JSONArray states = (JSONArray) jsonObj.get("states");
				JSONArray pillars = (JSONArray) jsonObj.get("pillars");
				out.print(states + " comparing " + custState);
				stateCheck = false;pillarCheck=false;

				for (int j = 0; j < states.size(); j++) {
					if (states.get(j).toString().equals(custState)) {
						stateCheck = true;
						break;
					}
				}

				for (int j = 0; j < pillars.size(); j++) {
					if (pillars.get(j).toString().equals(custPillar)) {
						pillarCheck = true;
						break;
					}
				}
				if (stateCheck && pillarCheck) {
	%>
	<table>
		<tr>
			<table width="100%" cellspacing="0" cellpadding="1" border="0">
				<tbody>
					<tr>
						<td valign="top" width="100%" class="heading3bb" align="left">
							<p style="color: red">*************************************************************************************************************************************************</p>
							<p style="color: red">Dear Customers,</p>
							<p style="color: red">
								<%
									out.print(jsonObj.get("message"));
								%>
								<!-- 								I.T. OUTAGE. PLEASE BE ADVISED THAT DUE TO METCASH I.T. -->
								<!-- 								MAINTENANCE ANY ORDERS<br /> PLACED BETWEEN 8PM AEST SATURDAY -->
								<!-- 								04/08/2018 TILL MIDNIGHT WILL SHOW AS <b>STATUS = PENDING</b><br /> -->
								<!-- 								ONCE MAINTENANCE IS COMPLETE YOUR ORDER WILL FLOW THROUGH AS PER -->
								<!-- 								NORMAL. -->
							</p>
							<p style="color: red">*************************************************************************************************************************************************</p>
						</td>
					</tr>
				</tbody>
			</table>
		</tr>
	</table>
	<%
				}
			}
		} else {
	%>
	Hello
	<%
		}
	%>
</body>
</html>