note
	description: "[
			JSON config file reader for webapp config files.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_WEBAPP_JSON_CONFIG_READER

inherit
	XU_JSON_READER [XC_WEBAPP_CONFIG]

feature {NONE} -- Internal Access

	ecf_name: STRING = "ecf"
	name_name: STRING = "name"
	server_host_name: STRING = "server_host"
	port_name: STRING = "port"
	taglibs_name: STRING = "taglibs"
	tl_name_name: STRING = "name"
	tl_ecf_name: STRING = "ecf"
	tl_path_name: STRING = "path"

feature -- Processing

	check_value (a_value: detachable JSON_VALUE; a_filename: STRING): detachable XC_WEBAPP_CONFIG
			-- Reads the values from JSON_VALUE into XC_WEBAPP_CONFIG and checks for errors
		local
			l_config: XC_WEBAPP_CONFIG
			l_resolved_path: STRING
			l_error_prefix: STRING
			l_buf_tl_name: STRING
			l_buf_tl_ecf: STRING
			l_buf_tl_path: STRING
			l_util: XU_FILE_UTILITIES
			l_ok: BOOLEAN
		do
			l_ok := True

			create l_util
			l_error_prefix := "In config file '" + a_filename + "': "

			if attached {JSON_OBJECT} a_value as l_root_element then
				create l_config.make_empty

					-- Check ecf
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (ecf_name)] as l_element then
				l_resolved_path := l_util.resolve_env_vars (l_element.item, True)
					if l_util.is_readable_file (l_resolved_path) then
						l_config.set_ecf (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_error_prefix + ecf_name + ":'" + l_resolved_path + "'"), False)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + ecf_name), False)
					l_ok := False
				end

					-- Check name
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (name_name)] as l_element then
						l_config.set_name (l_element.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + name_name), False)
					l_ok := False
				end

					-- Check server_host
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (server_host_name)] as l_element then
					l_config.set_server_host (l_element.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + server_host_name), False)
					l_ok := False
				end

					-- Check port
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (port_name)] as l_element then
					if l_element.item.is_integer_32  then
						l_config.set_port (l_element.item.to_integer_32)
					else
						error_manager.add_error (create {XERROR_CONFIG_PROPERTY}.make (l_error_prefix + l_element.item), False)
					l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + port_name), False)
					l_ok := False
				end

					-- Check taglibs
				if attached {JSON_ARRAY} l_root_element.map_representation [create {JSON_STRING}.make_json (taglibs_name)] as l_element then

					from
						l_element.array_representation.start
					until
						l_element.array_representation.after
					loop
						l_buf_tl_name := ""
						l_buf_tl_ecf := ""
						l_buf_tl_path := ""

						if attached {JSON_OBJECT} l_element.array_representation.item_for_iteration as l_array_element then
								-- Check taglib name
							if attached {JSON_STRING} l_array_element.map_representation [create {JSON_STRING}.make_json (tl_name_name)] as l_array_element_element then
								l_buf_tl_name := l_array_element_element.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + tl_name_name + " in " + taglibs_name), False)
								l_ok := False
							end

								-- Check taglib ecf
							if attached {JSON_STRING} l_array_element.map_representation [create {JSON_STRING}.make_json (tl_ecf_name)] as l_array_element_element then
								l_buf_tl_ecf := l_array_element_element.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + tl_ecf_name + " in " + taglibs_name), False)
								l_ok := False
							end

								-- Check taglib path
							if attached {JSON_STRING} l_array_element.map_representation [create {JSON_STRING}.make_json (tl_path_name)] as l_array_element_element then
								l_buf_tl_path := l_array_element_element.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + tl_path_name + " in " + taglibs_name), False)
								l_ok := False
							end
								-- If all attributes success, add to taglibs
							if not (l_buf_tl_name.is_equal ("") or l_buf_tl_ecf.is_equal ("") or l_buf_tl_path.is_equal ("") ) then
								l_config.taglibs.force ([l_buf_tl_name, l_buf_tl_ecf, l_buf_tl_path])
							end
						end
						l_element.array_representation.forth
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + taglibs_name), False)
					l_ok := False
				end

					-- Set webapp_host to localhost for all managed webapps
				l_config.set_webapp_host ("localhost")
				if l_ok then
					Result := l_config
				end
			end
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


