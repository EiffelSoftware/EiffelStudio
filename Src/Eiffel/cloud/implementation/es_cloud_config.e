note
	description: "Configuration for the cloud api."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_CONFIG

create
	make,
	make_from_separate

feature {NONE} -- Initialization

	make (a_webapi_url: READABLE_STRING_8)
		local
			uri: URI
		do
			create uri.make_from_string (a_webapi_url)
			create root_endpoint.make_from_string (uri.path)
			uri.set_path ("")
			create server_url.make_from_string (uri.string)

			connection_timeout := 5 -- seconds
			timeout := 30 -- seconds
		end

	make_from_separate (cfg: separate ES_CLOUD_CONFIG)
		do
			create root_endpoint.make_from_string (cfg.root_endpoint)
			create server_url.make_from_string (cfg.server_url)
			connection_timeout := cfg.connection_timeout
			timeout := cfg.timeout
			if attached cfg.user_agent as ua then
				create {IMMUTABLE_STRING_8} user_agent.make_from_string (ua)
			end
		end

feature -- Access

	root_endpoint: IMMUTABLE_STRING_8

	server_url: IMMUTABLE_STRING_8

	secret_api_key: STRING_8 = "secret-722ddbcf1548405c83c6494451d96879"

	user_agent: detachable IMMUTABLE_STRING_8

feature -- Builtin settings	

	guest_period_in_days: INTEGER = 15
			-- Number of days as guest.

	default_session_heartbeat: NATURAL = 900 -- 15 * 60 s = 15 minutes
			-- Delay between two heartbeat to track session activity.

feature -- Settings	

	connection_timeout: INTEGER
			-- Connection timeout in seconds.

	timeout: INTEGER
			-- Timeout in seconds.			

feature -- Conversion

	import_settings (cfg: like Current)
		do
			connection_timeout := cfg.connection_timeout
			timeout := cfg.timeout
		end

feature -- Element change

	set_user_agent (ua: READABLE_STRING_8)
		do
			user_agent := ua
		end

	set_connection_timeout (a_secs: like connection_timeout)
		do
			connection_timeout := a_secs
		end

	set_timeout (a_secs: like timeout)
		do
			timeout := a_secs
		end

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
