note
	description: "[
		JSON config file reader for server config files.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_JSON_CONFIG_READER

inherit
	XU_JSON_READER [XS_FILE_CONFIG]

feature {NONE} -- Internal Access

	finalize_webapps_name: STRING = "finalize_webapps"
	compiler_name: STRING = "compiler"
	translator_name: STRING = "translator"
	lib_name: STRING = "library"
	managed_webapps_name: STRING = "managed_webapps"
	compiler_flags_name: STRING = "compiler_flags"
	unmanaged_webapps_name: STRING = "unmanaged_webapps"
	uwa_name: STRING = "name"
	uwa_host: STRING = "host"
	uwa_port: STRING = "port"

feature -- Processing

	check_value (a_value: detachable JSON_VALUE; a_filename: STRING): detachable XS_FILE_CONFIG
			-- <Precursor>
		local
			l_util: XU_FILE_UTILITIES
			l_config: detachable XS_FILE_CONFIG
			l_resolved_path: STRING
			l_error_prefix: STRING
			l_buf_uwa_name: STRING
			l_buf_uwa_port: INTEGER
			l_buf_uwa_host: STRING
			l_ok: BOOLEAN
		do
			l_ok := True
			l_error_prefix := "In config file '" + a_filename + "': "
			create l_util

			if attached {JSON_OBJECT} a_value as l_root_element then
				create l_config.make_empty

					-- Check finalize_webapps
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (finalize_webapps_name)] as l_element then
					if l_element.item.is_boolean then
						l_config.set_finalize_webapps (l_element.item.to_boolean)
					else
						error_manager.add_error (create {XERROR_CONFIG_PROPERTY}.make (l_error_prefix + l_element.item), False)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + finalize_webapps_name), False)
					l_ok := False
				end

					-- Check compiler_name
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (compiler_name)] as l_element then
					l_resolved_path := l_util.resolve_env_vars (l_element.item, True)
					if l_util.is_executable_file (l_resolved_path) then
						l_config.set_compiler (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_error_prefix + compiler_name + ":'" + l_resolved_path + "'"), False)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + compiler_name), False)
					l_ok := False
				end

					-- Check translator
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (translator_name)] as l_element then
					l_resolved_path := l_util.resolve_env_vars (l_element.item, True)
					if l_util.is_executable_file (l_resolved_path) then
						l_config.set_translator (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_error_prefix + translator_name + ":'" + l_resolved_path + "'"), False)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + translator_name), False)
					l_ok := False
				end

					-- Check managed_webapps
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (managed_webapps_name)] as l_element then
					l_resolved_path := l_util.resolve_env_vars (l_element.item, True)
					if l_util.is_dir (l_resolved_path) then
						l_config.set_webapps_root (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (l_error_prefix + managed_webapps_name + ":'" + l_resolved_path + "'"), False)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + managed_webapps_name), False)
					l_ok := False
				end

					-- Check library					
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (lib_name)] as l_element then
					l_resolved_path := l_util.resolve_env_vars (l_element.item, True)
					if l_util.is_dir (l_resolved_path) then
						l_config.set_lib (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (l_error_prefix + lib_name + ":'" + l_resolved_path + "'"), False)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + lib_name), False)
					l_ok := False
				end

					-- Check compiler_flags
				if attached {JSON_STRING} l_root_element.map_representation [create {JSON_STRING}.make_json (compiler_flags_name)] as l_element then
					l_config.set_compiler_flags (l_element.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + compiler_flags_name), False)
					l_ok := False
				end


				-- Check unmanaged_webapps
				if attached {JSON_ARRAY} l_root_element.map_representation [create {JSON_STRING}.make_json (unmanaged_webapps_name)] as l_element then

					from
						l_element.array_representation.start
					until
						l_element.array_representation.after
					loop
						l_buf_uwa_name := ""
						l_buf_uwa_host := ""
						l_buf_uwa_port := 0

						if attached {JSON_OBJECT} l_element.array_representation.item_for_iteration as l_array_element then
								-- Check name
							if attached {JSON_STRING} l_array_element.map_representation [create {JSON_STRING}.make_json (uwa_name)] as l_array_element_element then
								l_buf_uwa_name := l_array_element_element.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + uwa_name + " in " + unmanaged_webapps_name), False)
								l_ok := False
							end

								-- Check host
							if attached {JSON_STRING} l_array_element.map_representation [create {JSON_STRING}.make_json (uwa_host)] as l_array_element_element then
								l_buf_uwa_host := l_array_element_element.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + uwa_host + " in " + unmanaged_webapps_name), False)
								l_ok := False
							end

								-- Check port
							if attached {JSON_STRING} l_array_element.map_representation [create {JSON_STRING}.make_json (uwa_port)] as l_array_element_element then
								if l_array_element_element.item.is_integer then
									l_buf_uwa_port := l_array_element_element.item.to_integer
								else
									error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + uwa_port + ": Invalid natural!  " + unmanaged_webapps_name), False)
									l_ok := False
								end
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + uwa_port + " in " + unmanaged_webapps_name), False)
								l_ok := False
							end
								-- If all attributes success, add to webapps
							if not (l_buf_uwa_name.is_equal ("") or l_buf_uwa_host.is_equal ("") or l_buf_uwa_port.is_equal (0) ) then
								l_config.webapps.force (create {XS_UNMANAGED_WEBAPP}.make_with_attributes (l_buf_uwa_name, l_buf_uwa_host, l_buf_uwa_port), l_buf_uwa_name)
							end
						end
						l_element.array_representation.forth
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + unmanaged_webapps_name), False)
					l_ok := False
				end
			end
			if l_ok then
				Result := l_config
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
