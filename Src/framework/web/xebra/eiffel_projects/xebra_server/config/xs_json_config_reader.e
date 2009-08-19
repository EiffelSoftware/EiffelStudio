note
	description: "[
		JSON config file reader for server config files.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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

			if attached {JSON_OBJECT} a_value as l_v then
				create l_config.make_empty

					-- Check finalize_webapps
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (finalize_webapps_name)] as l_e then
					if l_e.item.is_boolean then
						l_config.set_finalize_webapps (l_e.item.to_boolean)
					else
						error_manager.add_error (create {XERROR_CONFIG_PROPERTY}.make (l_error_prefix + l_e.item), false)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + finalize_webapps_name), false)
					l_ok := False
				end

					-- Check compiler_name
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (compiler_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_executable_file (l_resolved_path) then
						l_config.set_compiler (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_error_prefix + compiler_name + ":'" + l_resolved_path + "'"), false)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + compiler_name), false)
					l_ok := False
				end

					-- Check translator
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (translator_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_executable_file (l_resolved_path) then
						l_config.set_translator (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_error_prefix + translator_name + ":'" + l_resolved_path + "'"), false)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + translator_name), false)
					l_ok := False
				end

					-- Check managed_webapps
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (managed_webapps_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_dir (l_resolved_path) then
						l_config.set_webapps_root (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (l_error_prefix + managed_webapps_name + ":'" + l_resolved_path + "'"), false)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + managed_webapps_name), false)
					l_ok := False
				end

					-- Check library					
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (lib_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_dir (l_resolved_path) then
						l_config.set_lib (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (l_error_prefix + lib_name + ":'" + l_resolved_path + "'"), false)
						l_ok := False
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + lib_name), false)
					l_ok := False
				end

					-- Check compiler_flags
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (compiler_flags_name)] as l_e then
					l_config.set_compiler_flags (l_e.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + compiler_flags_name), false)
					l_ok := False
				end


				-- Check unmanaged_webapps
				if attached {JSON_ARRAY} l_v.map_representation [create {JSON_STRING}.make_json (unmanaged_webapps_name)] as l_e then

					from
						l_e.array_representation.start
					until
						l_e.array_representation.after
					loop
						l_buf_uwa_name := ""
						l_buf_uwa_host := ""
						l_buf_uwa_port := 0

						if attached {JSON_OBJECT} l_e.array_representation.item_for_iteration as l_ti then
								-- Check name
							if attached {JSON_STRING} l_ti.map_representation [create {JSON_STRING}.make_json (uwa_name)] as l_ti_i then
								l_buf_uwa_name := l_ti_i.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + uwa_name + " in " + unmanaged_webapps_name), false)
								l_ok := False
							end

								-- Check host
							if attached {JSON_STRING} l_ti.map_representation [create {JSON_STRING}.make_json (uwa_host)] as l_ti_i then
								l_buf_uwa_host := l_ti_i.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + uwa_host + " in " + unmanaged_webapps_name), false)
								l_ok := False
							end

								-- Check port
							if attached {JSON_STRING} l_ti.map_representation [create {JSON_STRING}.make_json (uwa_port)] as l_ti_i then
								if l_ti_i.item.is_integer then
									l_buf_uwa_port := l_ti_i.item.to_integer
								else
									error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + uwa_port + ": Invalid natural!  " + unmanaged_webapps_name), false)
									l_ok := False
								end
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + uwa_port + " in " + unmanaged_webapps_name), false)
								l_ok := False
							end
								-- If all attributes success, add to webapps
							if not (l_buf_uwa_name.is_equal ("") or l_buf_uwa_host.is_equal ("") or l_buf_uwa_port.is_equal (0) ) then
								l_config.webapps.force (create {XS_UNMANAGED_WEBAPP}.make_with_attributes (l_buf_uwa_name, l_buf_uwa_host, l_buf_uwa_port), l_buf_uwa_name)
							end
						end
						l_e.array_representation.forth
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + unmanaged_webapps_name), false)
					l_ok := False
				end
			end
			if l_ok then
				Result := l_config
			end
		end
end
