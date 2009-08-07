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
	webapps_root_name: STRING = "webapps_root"
	compiler_flags_name: STRING = "compiler_flags"

feature -- Processing

	check_value (a_value: detachable JSON_VALUE; a_filename: STRING): detachable XS_FILE_CONFIG
			-- <Precursor>
		local
			l_util: XU_FILE_UTILITIES
			l_config: detachable XS_FILE_CONFIG
			l_resolved_path: STRING
			l_error_prefix: STRING
		do
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
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + finalize_webapps_name), false)
				end

					-- Check compiler_name
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (compiler_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_executable_file (l_resolved_path) then
						l_config.set_compiler (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_error_prefix + compiler_name + ":'" + l_resolved_path + "'"), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + compiler_name), false)
				end

					-- Check translator
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (translator_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_executable_file (l_resolved_path) then
						l_config.set_translator (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_error_prefix + translator_name + ":'" + l_resolved_path + "'"), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + translator_name), false)
				end

					-- Check webapps_root
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (webapps_root_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_dir (l_resolved_path) then
						l_config.set_webapps_root (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (l_error_prefix + webapps_root_name + ":'" + l_resolved_path + "'"), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + webapps_root_name), false)
				end

					-- Check library					
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (lib_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_dir (l_resolved_path) then
						l_config.set_lib (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (l_error_prefix + lib_name + ":'" + l_resolved_path + "'"), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + lib_name), false)
				end

					-- Check compiler_flags
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (compiler_flags_name)] as l_e then
					l_config.set_compiler_flags (l_e.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + compiler_flags_name), false)
				end
			end


			if not error_manager.has_errors then
				Result := l_config
			end
		end
end
