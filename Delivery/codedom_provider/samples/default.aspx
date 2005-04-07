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
							samples_path := l_path
							samples_path := samples_path + "Samples"
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

		samples_path: STRING
				-- Installation path

		error_message: STRING
				-- Error message if any

		samples_path_found: BOOLEAN
				-- Was search for samples path successful?
	</SCRIPT>
	
	<BODY>
		<H1>ASP.NET Enabler</H1>
		<P>
			<%if samples_path_found then%>

				If you can read this then the installation of <B>ASP.NET Enabler</B> terminated successfully.<br>
				This page was written in Eiffel, the source for it can be found in folder
				<%=samples_path.to_cil%> (file <I>default.aspx</I>).

			<%elseif error_message /= Void then%>

				There seems to be a problem with your installation, the path to your installation could
				not be retrieved, the following error occured: <%=error_message.to_cil%>

			<%else%>

				There seems to be a problem with your installation, the path to your installation could
				not be retrieved...

			<%end%>
		</P>
		<P>
			<%if samples_path_found then%>
				A snapshot of the work in progress for the documentation is available for review
				<A HREF="<%=samples_path.to_cil%>\..\Docs\ecdp.chm">here</A>.
			<%end%>
		</P>
		<P>
			Additional documentation and samples will be available in the final release.
		</P>
<!--
		<P>
			If this is your first time using the ASP.NET Enabler you should probably check the
			documentation here.<br>
			There are several samples available that demonstrate different scenario in which Eiffel
			can be used to write ASP.NET pages.<br>
		</P>
-->
	</BODY>
</HTML>