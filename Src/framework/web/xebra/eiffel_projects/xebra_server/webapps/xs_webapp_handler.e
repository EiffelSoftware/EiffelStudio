note
	description: "[
			Knows how to handle webapps
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_HANDLER

inherit
	XS_SHARED_SERVER_CONFIG

	XS_SHARED_SERVER_OUTPUTTER

feature -- Status Change

	stop_managed_apps
			-- Terminates all process from webapps
		do
			from
				config.file.webapps.start
			until
				config.file.webapps.after
			loop
				if attached {XS_MANAGED_WEBAPP}config.file.webapps.item_for_iteration as l_managed_webapp then
					l_managed_webapp.shutdown_all
				end
				config.file.webapps.forth
			end
		end

feature  -- Basic Operations

	forward_request (a_request_message: STRING): XC_COMMAND_RESPONSE
			-- Creates a temp request object from the request message, validates it and sends the request message to the appropriate webapplication
		local
			l_response: XH_RESPONSE
			l_request_parser: XH_REQUEST_MINI_PARSER
			l_uri_webapp_name: STRING
			l_req_buf: detachable XH_MINI_REQUEST
		do
			create l_request_parser.make
			l_req_buf := l_request_parser.request (a_request_message)
	        if attached {XH_MINI_REQUEST} l_req_buf as l_request then
				if not l_request.post_too_big then
					if attached {XS_WEBAPP} config.file.webapps[l_request.webapp] as l_webapp then
						Result := l_webapp.send (create {XCWC_HTTP_REQUEST}.make_with_request (a_request_message))
					else
						Result := (create {XER_CANNOT_FIND_APP}.make ("")).render_to_command_response
					end
				else
					Result := (create {XER_POST_TOO_BIG}.make ("")).render_to_command_response
				end
            else
            	Result := (create {XER_CANNOT_DECODE}.make ("")).render_to_command_response
            end
		end

	search_webapps (a_path: STRING; a_unmanaged: BOOLEAN): HASH_TABLE [XS_WEBAPP, STRING]
			-- Traverses folders to find config files which define managed webapps
			--
			-- `a_path': The path to start scanning for webapp config files
			-- `a_unmanaged': If true, unmanaged webapps will be created, managed webapps otherwise
			-- `Result': A hash table of webapps and the webapps names
		require
			not_a_path_is_detached_or_empty: a_path /= Void and then not a_path.is_empty
		local
			l_files: LIST [STRING]
			l_f_utils: XU_FILE_UTILITIES
			l_webapp_config_reader: XC_WEBAPP_JSON_CONFIG_READER
			l_ex: LINKED_LIST [STRING]
			l_inc: LINKED_LIST [STRING]
		do
			create l_ex.make
			create l_inc.make
			l_ex.force ({XU_CONSTANTS}.Dir_eifgen)
			l_ex.force ({XU_CONSTANTS}.Dir_svn)
			l_inc.force ({XU_CONSTANTS}.Webapp_config_file)
			create Result.make (1)
			create l_f_utils
			create l_webapp_config_reader

			l_files := l_f_utils.scan_for_files (a_path, -1, l_inc, l_ex)
			from
				l_files.start
			until
				l_files.after
			loop
				if attached {XC_WEBAPP_CONFIG} l_webapp_config_reader.process_file (l_files.item_for_iteration) as l_webapp then
					if a_unmanaged then
						Result.force (create {XS_UNMANAGED_WEBAPP}.make_with_attributes (l_webapp.name, l_webapp.webapp_host, l_webapp.port) , l_webapp.name )
					else
						Result.force (create {XS_MANAGED_WEBAPP}.make_with_config (l_webapp), l_webapp.name)
					end
				end

				l_files.forth
			end
		ensure
			Result_attached: Result /= Void
		end
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
