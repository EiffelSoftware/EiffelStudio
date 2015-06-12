note
	description: "Summary description for {IRON_NODE_SERVER_LAUNCHER_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_NODE_SERVER_LAUNCHER_I

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature {NONE} -- Initialization

	launcher_nature: detachable READABLE_STRING_8
			-- Initialize the launcher nature
			-- either cgi, libfcgi, or nino.
			--| We could extend with more connector if needed.
			--| and we could use WSF_DEFAULT_SERVICE_LAUNCHER to configure this at compilation time.
		local
			p: PATH
			ext: detachable READABLE_STRING_32
		do
			create p.make_from_string (execution_environment.arguments.command_name)
			if attached p.entry as l_entry then
				ext := l_entry.extension
			end
			if ext /= Void then
				if ext.same_string (nature_nino) then
					Result := nature_nino
				end
--				if ext.same_string (nature_cgi) then
--					Result := nature_cgi
--				end
				if ext.same_string (nature_libfcgi) or else ext.same_string ("fcgi") then
					Result := nature_libfcgi
				end
			end
		end

feature {NONE} -- nino		

	nature_nino: STRING = "nino"

	launch_nino (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_NINO_SERVICE_LAUNCHER
		do
			create {WSF_NINO_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts)
		end

feature {NONE} -- cgi

--	nature_cgi: STRING = "cgi"

--	launch_cgi (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
--		local
--			launcher: WSF_CGI_SERVICE_LAUNCHER
--		do
--			create {WSF_CGI_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts)
--		end

feature {NONE} -- libfcgi

	nature_libfcgi: STRING = "libfcgi"

	launch_libfcgi (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_LIBFCGI_SERVICE_LAUNCHER
		do
			create launcher.make_and_launch (a_service, opts)
		end

feature {WSF_SERVICE} -- Launcher

	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			nature: like launcher_nature
		do
			nature := launcher_nature
			if nature = Void or else nature = nature_nino then
				launch_nino (a_service, opts)
--			elseif nature = nature_cgi then
--				launch_cgi (a_service, opts)
			elseif nature = nature_libfcgi then
				launch_libfcgi (a_service, opts)
			else
				-- bye bye
				(create {EXCEPTIONS}).die (-1)
			end
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

