note
	description: "Summary description for {IRON_API_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_API_CONSTANTS

feature -- Access

	iron_variable_name: STRING = "IRON_PATH"

	version_variable_name: STRING = "IRON_VERSION"

feature -- Access: header

	iron_http_header_name: STRING = "Iron_Version"

feature -- Access: network related

	iron_proxy_variable_name: STRING = "IRON_PROXY"
			-- Proxy if any as "hostname:port"
			--| ex for fiddler debugging: "localhost:8888"
			-- see {IRON_REMOTE_NODE} for usage

	iron_connect_timeout_variable_name: STRING = "IRON_CONNECT_TIMEOUT"
			-- Environment variable allowing to set the "connect timeout" setting
			-- for http client communication with the iron server
			-- see {IRON_REMOTE_NODE} for usage

	iron_timeout_variable_name: STRING = "IRON_TIMEOUT"
			-- Environment variable allowing to set the "timeout" setting
			-- for http client communication with the iron server
			-- see {IRON_REMOTE_NODE} for usage

feature -- Version	

	major: NATURAL_16 = 0

	minor: NATURAL_16 = 1

	built: STRING = "0009"

	version: IMMUTABLE_STRING_8
		local
			s: STRING
		once
			create s.make (10)
			s.append_natural_16 (major)
			s.append_character ('.')
			s.append_natural_16 (minor)
			s.append_character ('.')
			s.append (built)

			create Result.make_from_string (s)
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
