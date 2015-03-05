note
	description: "[
			Specific application launcher

			DO NOT EDIT THIS CLASS

			you can customize APPLICATION_LAUNCHER
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	APPLICATION_LAUNCHER_I

feature -- Execution

	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
			-- Launch Web Server Application using `a_service' and optionals `opts'.
		local
			l_id: like launcher_id
			launcher: WSF_SERVICE_LAUNCHER
		do
			l_id := launcher_id
			if l_id = Void then
{unless condition="$WIZ.connectors.use_standalone ~ $WIZ_YES"}{literal}
				io.error.put_string ("Application launcher not found!%N")
				(create {EXCEPTIONS}).die (-1){/literal}{/unless}
{if condition="$WIZ.connectors.use_standalone ~ $WIZ_YES"}{literal}
					-- Choose a default -> standalone
				create {WSF_NINO_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts){/literal}{/if}
{if condition="$WIZ.connectors.use_libfcgi ~ $WIZ_YES"}{literal}
			elseif is_libfcgi_launcher_id (l_id) then
				create {WSF_LIBFCGI_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts){/literal}{/if}
{if condition="$WIZ.connectors.use_cgi ~ $WIZ_YES"}{literal}
			elseif is_cgi_launcher_id (l_id) then
				create {WSF_CGI_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts){/literal}{/if}
{if condition="$WIZ.connectors.use_standalone ~ $WIZ_YES"}{literal}
			elseif is_nino_launcher_id (l_id) then
				create {WSF_NINO_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts){/literal}{/if}
{literal}
			else
				io.error.put_string ("Application launcher not found!%N")
				(create {EXCEPTIONS}).die (-1)
			end
		end

	launcher_id: detachable READABLE_STRING_GENERAL
			-- Launcher id based on the executable extension name if any.
			-- This can be redefine to customize for your application.
			--| ex: nino, cgi, libfcgi or Void.
		local
			sh_exec: SHARED_EXECUTION_ENVIRONMENT
		do
			create sh_exec
			if attached (create {PATH}.make_from_string (sh_exec.execution_environment.arguments.command_name)).extension as ext then
				Result := ext
			end
		end

feature -- Status report		
{/literal}
{if condition="$WIZ.connectors.use_standalone ~ $WIZ_YES"}
	is_nino_launcher_id (a_id: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := a_id.is_case_insensitive ("nino")
						or a_id.is_case_insensitive ("standalone")
		end{/if}

{if condition="$WIZ.connectors.use_cgi ~ $WIZ_YES"}
	is_cgi_launcher_id (a_id: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := a_id.is_case_insensitive ("cgi")
		end{/if}

{if condition="$WIZ.connectors.use_libfcgi ~ $WIZ_YES"}
	is_libfcgi_launcher_id (a_id: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := a_id.is_case_insensitive ("libfcgi")
						or a_id.is_case_insensitive ("fcgi")
		end{/if}


end

