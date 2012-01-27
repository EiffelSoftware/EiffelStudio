<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<%@ page language="Eiffel"%>

<html>
	<head>
		<link rel="stylesheet" href="default.css">
		<title>Eiffel for ASP.NET Installation Summary</title>

		<script runat="server">
			indexing
				description: "Installation summary"
				precompile_definition_file: "$ISE_CODEDOM\Samples\code_behind\ace.ace"
		</script>

		<script runat="server">
			inherit
				WEB_PAGE
					redefine
						on_load
					end
		</script>

		<script runat="server">
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
						l_key := feature {REGISTRY}.local_machine.open_sub_key (setup_key, False)
						if l_key /= Void then
							l_path ?= l_key.get_value ("InstallDir")
							if l_path /= Void then
								install_path := l_path
								samples_path := l_path + "Samples"
								samples_path_found := True
							end
						end
						if not samples_path_found then
							error_message := no_setup_key
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
			
			setup_key: STRING is "Software\ISE\Eiffel CodeDom Provider\5.6\Setup"
					-- Path to registry key containing 'InstallDir' value
			
			no_setup_key: STRING is "Installation corrupt or access to registry keys denied."
					-- Error message shown when 'InstallDir' value cannot be retrieved
		</script>
	</head>
	
	<body>
		<div class="title">
			<h1>Eiffel for ASP.NET Samples</h1>
		</div>
		<div class="description">
			<p>
				<%if samples_path_found then%>

					The installation of <b>Eiffel for ASP.NET</b> terminated successfully.
					</p><p>
					This page was written in Eiffel, the source for it can be found in 
					<%=samples_path.to_cil%>\default.aspx.

				<%elseif error_message /= Void then%>

					There seems to be a problem with your installation, the path to your installation could
					not be retrieved, the following error occured: <%=error_message.to_cil%>

				<%else%>

					There seems to be a problem with your installation, the path to your installation could
					not be retrieved...

				<%end%>
			</p>
			<%if samples_path_found then%>
				<p>
					The documentation can be found in
					<%=install_path.to_cil%>\Documentation\Eiffel for ASP.NET.chm.
				</p>
				<p>
					Samples and their source code can be viewed from <a href="show_sample.aspx">this page</a>.
				</p>
				<p>
					The sources for the samples are available in <%=samples_path.to_cil%>\Samples.
				</p>
				<p>
					Enjoy Eiffel for ASP.NET!
				</p>
				<p>
					--<br />
					The Eiffel for ASP.NET Team.
				</p>
			<%end%>
		</div>
	</body>
</html>

<!--
--+--------------------------------------------------------------------
--| Eiffel for ASP.NET 5.6
--| Copyright (c) 2005-2006 Eiffel Software
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
-->
