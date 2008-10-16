indexing
	description: "[
		The interface used to launch URIs in the platform's default browser.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	URI_LAUNCHER_I

feature -- Basic operations

	launch (a_uri: !READABLE_STRING_GENERAL): BOOLEAN
			-- Launches a URI in the system's default web-browser.
			--
			-- `a_uri': The URI to launch.
			-- `Result': True if the URI was launched; False otherwise.
		require
			not_a_uri_is_empty: not a_uri.is_empty
		deferred
		end

	launch_with_default_app (a_uri: !READABLE_STRING_GENERAL; a_default_app: !READABLE_STRING_GENERAL): BOOLEAN
			-- Launches a URI in the system's default web-browser, or if that fails, then the supplied
			-- default application.
			--
			-- `a_uri'        : The URI to launch.
			-- `a_default_app': The default application to use in case of system default failure.
			-- `Result'       : True if the URI was launched; False otherwise.
		require
			not_a_uri_is_empty: not a_uri.is_empty
			not_a_default_app_is_empty: not a_default_app.is_empty
		do
			Result := launch (a_uri)
			if not Result then
				Result := launch_with_app (a_uri, a_default_app)
			end
		end

feature {NONE} -- Basic operations

	launch_with_app (a_uri: !READABLE_STRING_GENERAL; a_app: !READABLE_STRING_GENERAL): BOOLEAN
			-- Launches a URI in the system's default web-browser, or if that fails, then the supplied
			-- default application.
			--
			-- `a_uri'        : The URI to launch.
			-- `a_default_app': The default application to use in case of system default failure.
			-- `Result'       : True if the URI was launched; False otherwise.
		require
			not_a_uri_is_empty: not a_uri.is_empty
			not_a_app_is_empty: not a_app.is_empty
		local
			l_process: PROCESS
			l_cmd: STRING
			l_uri: STRING
			i: INTEGER
		do
				-- Build command string.
			l_cmd := a_app.as_string_8.as_lower
			i := l_cmd.substring_index ("$url", 1)
			if i > 0 then
					-- Use URL replacement.

					-- Peek to see if the URL uses quotations.
				create l_uri.make (a_uri.count + 2)
				if i = 1 or else l_cmd.item (i - 1) /= '%"' then
					l_uri.append_character ('%"')
				end
				l_uri.append_string_general (a_uri)
				if i + 3 = l_cmd.count or else l_cmd.item (i + 4) /= '%"' then
					l_uri.append_character ('%"')
				end
				create l_cmd.make (a_app.count + l_uri.count)
				l_cmd.append_string_general (a_app)
				l_cmd.replace_substring (l_uri.as_string_8, i, i + 3)
			else
					-- No url token, just append the
				create l_cmd.make (256)
				l_cmd.append_string_general (a_app)
				l_cmd.append (" %"")
				l_cmd.append_string_general (a_uri)
				l_cmd.append_character ('%"')
			end

				-- Execute command string.
			l_process := (create {PROCESS_FACTORY}).process_launcher_with_command_line (l_cmd, Void)
			l_process.set_detached_console (True)
			l_process.set_hidden (True)
			l_process.launch
			l_process.wait_for_exit
			Result := l_process.exit_code = 0
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
