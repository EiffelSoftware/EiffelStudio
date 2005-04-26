<%@ Page Language="Eiffel" Description="ASP.NET Enabler Welcome" %>

<HTML>
	<HEAD>
		<LINK REL="stylesheet" HREF="default.css">
		<TITLE>ASP.NET Enabler</TITLE>
	</HEAD>

	<SCRIPT RUNAT="server">
		inherit
			WEB_PAGE
				redefine
					on_load
				end
	</SCRIPT>

	<SCRIPT RUNAT="server">
		on_load (e: EVENT_ARGS) is
				-- Search path to installation folder of ASP.NET Enabler.
				-- Set `samples_path' with result if any.
				-- Set `error_message' with error message if any.
			local
				l_key: REGISTRY_KEY
				l_path: SYSTEM_STRING
				l_retried: BOOLEAN
			do
				if not l_retried then
					l_key := feature {REGISTRY}.local_machine.open_sub_key ("Software\ISE\Eiffel CodeDom Provider\Setup", False)
					if l_key /= Void then
						l_path ?= l_key.get_value ("InstallDir")
						if l_path /= Void then
							install_path := l_path
							samples_path := l_path + "Samples"
							samples_path_found := True
						else
							error_message := "No 'InstallDir' key in 'HKEY_LOCAL_MACHINE\Software\ISE\Eiffel CodeDom Provider\Setup'"
						end
					else
						error_message := "Could not open key HKEY_LOCAL_MACHINE\Software\ISE\Eiffel CodeDom Provider\Setup'"
					end
				end
			rescue
				error_message := feature {ISE_RUNTIME}.last_exception.out
				l_retried := True
				retry
			end

		install_path: STRING
				-- Installation folder path

		samples_path: STRING
				-- Samples folder path

		error_message: STRING
				-- Error message if any

		samples_path_found: BOOLEAN
				-- Was search for samples path successful?
	</SCRIPT>
	
	<BODY>
		<H1>Eiffel for ASP.NET</H1>
		<P>
			<%if samples_path_found then%>

				The installation of <B>Eiffel for ASP.NET</B> terminated successfully.<br>
				This page was written in Eiffel, the source for it can be found in 
				<%=samples_path.to_cil%>\default.aspx.

			<%elseif error_message /= Void then%>

				There seems to be a problem with your installation, the path to your installation could
				not be retrieved, the following error occured: <%=error_message.to_cil%>

			<%else%>

				There seems to be a problem with your installation, the path to your installation could
				not be retrieved...

			<%end%>
		</P>
		<%if samples_path_found then%>
			<P>
				The documentation can be found in
				<%=install_path.to_cil%>\Documentation\Eiffel for ASP.NET.chm.
			</P>
			<P>
				The following samples demonstrate different scenarios in which Eiffel
				can be used to write ASP.NET pages:
			</P>
			<UL>
				<LI>The <A HREF="validation.aspx">validation</A> sample uses validation controls to validate
				the content of user inputs.</LI>
				<LI>The <A HREF="data_bind.aspx">data binding</A> sample uses data binding to fill a data 
				list.</LI>
			</UL>
			<P>
				The sources for the samples are available in <%=samples_path.to_cil%>\Samples.<br/>
				Enjoy Eiffel for ASP.NET!<br/><br/>
				The Eiffel for ASP.NET Team.
			</P>
		<%end%>		
	</BODY>
</HTML>