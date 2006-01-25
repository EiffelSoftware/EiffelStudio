<%@ Page Language="eiffel" debug="true" aspcompat=true Buffer="false" Description="Eiffel ASP.NET Test" %>
<html>
	<head>
	</head>
	<body>
		<span>This is an eiffel test:</span>
		<p>	
		
		<%
			--Uncomment to force a compile error and see generated code;

			response.write_string(("Dynamic content.<br>").to_cil)
		%>
		
		<%= ("Eiffel").to_cil %>
		
		<p>
		<span>Change this text to force re-compilation when reloading.</span>
	</body>
</html>
