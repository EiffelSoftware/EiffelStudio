note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WGI_NINO_HANDLER

inherit
	HTTP_CONNECTION_HANDLER
		redefine
			on_launched,
			on_stopped
		end

create
	make_with_callback

feature {NONE} -- Initialization

	make_with_callback (a_server: like server; a_callback: like callback)
			-- Initialize `Current'.
		do
			base := a_callback.base
			make (a_server)
			callback := a_callback
		end

	callback: WGI_NINO_CONNECTOR

feature -- Access

	base: detachable READABLE_STRING_8
			-- Root url base

feature -- Element change

	on_launched (a_port: INTEGER)
		do
			Precursor (a_port)
			callback.on_launched (a_port)
		end

	on_stopped
		do
			Precursor
			callback.on_stopped
		end

feature -- Element change

	set_base (a_uri: like base)
			-- Set `base' to `a_uri'
		do
			base := a_uri
		end

feature -- Request processing

	process_request (a_handler: HTTP_CONNECTION_HANDLER; a_socket: TCP_STREAM_SOCKET)
			-- Process request ...
		local
			env: HASH_TABLE [STRING, STRING]
			p: INTEGER
			l_request_uri, l_script_name, l_query_string, l_path_info: STRING
			l_server_name, l_server_port: detachable STRING
			a_headers_map: HASH_TABLE [STRING, STRING]
			vn: STRING

			e: EXECUTION_ENVIRONMENT
		do
			l_request_uri := a_handler.uri
			a_headers_map := a_handler.request_header_map
			create e
			if attached e.starting_environment_variables as vars then
				create env.make (vars.count)
				across
					vars as c
				loop
					env.force (c.item.to_string_8, c.key.to_string_8)
				end
			else
				create env.make (0)
			end

			--| for Any Abc-Def-Ghi add (or replace) the HTTP_ABC_DEF_GHI variable to `env'
			from
				a_headers_map.start
			until
				a_headers_map.after
			loop
				create vn.make_from_string (a_headers_map.key_for_iteration.as_upper)
				vn.replace_substring_all ("-", "_")
				if
					vn.starts_with ("CONTENT_") and then
					(vn.same_string_general ({WGI_META_NAMES}.content_type) or vn.same_string_general ({WGI_META_NAMES}.content_length))
				then
					--| Keep this name
				else
					vn.prepend ("HTTP_")
				end
				add_environment_variable (a_headers_map.item_for_iteration, vn, env)
				a_headers_map.forth
			end

			--| Specific cases

			p := l_request_uri.index_of ('?', 1)
			if p > 0 then
				l_script_name := l_request_uri.substring (1, p - 1)
				l_query_string := l_request_uri.substring (p + 1, l_request_uri.count)
			else
				l_script_name := l_request_uri.string
				l_query_string := ""
			end
			if attached a_headers_map.item ("Host") as l_host then
				check has_host: env.has ("HTTP_HOST") end
--				set_environment_variable (l_host, "HTTP_HOST", env)
				p := l_host.index_of (':', 1)
				if p > 0 then
					l_server_name := l_host.substring (1, p - 1)
					l_server_port := l_host.substring (p+1, l_host.count)
				else
					l_server_name := l_host
					l_server_port := "80" -- Default
				end
			else
				check host_available: False end
			end

			if attached a_headers_map.item ("Authorization") as l_authorization then
				check has_authorization: env.has ("HTTP_AUTHORIZATION") end
--				set_environment_variable (l_authorization, "HTTP_AUTHORIZATION", env)
				p := l_authorization.index_of (' ', 1)
				if p > 0 then
					set_environment_variable (l_authorization.substring (1, p - 1), "AUTH_TYPE", env)
				end
			end

			set_environment_variable ("CGI/1.1", "GATEWAY_INTERFACE", env)
			set_environment_variable (l_query_string, "QUERY_STRING", env)

			if attached a_handler.remote_info as l_remote_info then
				set_environment_variable (l_remote_info.addr, "REMOTE_ADDR", env)
				set_environment_variable (l_remote_info.hostname, "REMOTE_HOST", env)
				set_environment_variable (l_remote_info.port.out, "REMOTE_PORT", env)
--				set_environment_variable (Void, "REMOTE_IDENT", env)
--				set_environment_variable (Void, "REMOTE_USER", env)			
			end

			set_environment_variable (l_request_uri, "REQUEST_URI", env)
			set_environment_variable (a_handler.method, "REQUEST_METHOD", env)

			set_environment_variable (l_script_name, "SCRIPT_NAME", env)
			set_environment_variable (l_server_name, "SERVER_NAME", env)
			set_environment_variable (l_server_port, "SERVER_PORT", env)
			set_environment_variable (a_handler.version, "SERVER_PROTOCOL", env)
			set_environment_variable ({HTTP_SERVER_CONFIGURATION}.Server_details, "SERVER_SOFTWARE", env)

				--| Apply `base' value
			if attached base as l_base and then l_request_uri /= Void then
				if l_request_uri.starts_with (l_base) then
					l_path_info := l_request_uri.substring (l_base.count + 1, l_request_uri.count)
					p := l_path_info.index_of ('?', 1)
					if p > 0 then
						l_path_info.keep_head (p - 1)
					end
					env.force (l_path_info, "PATH_INFO")
					env.force (l_base, "SCRIPT_NAME")
				end
			end

			callback.process_request (env, a_handler.request_header, a_socket)
		end

	add_environment_variable (a_value: detachable STRING; a_var_name: STRING; env: HASH_TABLE [STRING, STRING])
			-- Add variable `a_var_name => a_value' to `env'
		do
			if a_value /= Void then
				if env.has_key (a_var_name) and then attached env.found_item as l_existing_value then
						--| Check http://www.ietf.org/rfc/rfc3875 4.1.18
					check find_proper_rewrite_for_same_header: False end
					env.force (l_existing_value + " " + a_value, a_var_name)
				else
					env.force (a_value, a_var_name)
				end
			end
		end

	set_environment_variable (a_value: detachable STRING; a_var_name: STRING; env: HASH_TABLE [STRING, STRING])
			-- Add variable `a_var_name => a_value' to `env'
		do
			if a_value /= Void then
				env.force (a_value, a_var_name)
			end
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
