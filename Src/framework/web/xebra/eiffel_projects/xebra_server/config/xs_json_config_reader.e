note
	description: "[
		Xebra Server run class
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_JSON_CONFIG_READER

inherit
	XS_SHARED_SERVER_OUTPUTTER

	ERROR_SHARED_MULTI_ERROR_MANAGER

feature {NONE} -- Internal Access

	finalize_webapps_name: STRING = "finalize_webapps"
	compiler_name: STRING = "compiler"
	translator_name: STRING = "translator"
	lib_name: STRING = "library"
	webapps_root_name: STRING = "webapps_root"
	compiler_flags_name: STRING = "compiler_flags"

feature -- Processing

	process_file (a_file: STRING): detachable XS_FILE_CONFIG
			--
		require
			a_file_attached: a_file /= Void
			a_file_not_empty: a_file /= Void
		local
			l_parser: JSON_PARSER
			l_util: XU_FILE_UTILITIES
		do
			create l_util
			if attached l_util.text_file_read_to_string (a_file) as l_content then
				create l_parser.make_parser (l_content)
				Result := check_value (l_parser.parse)
				from
					l_parser.errors.start
				until
					l_parser.errors.after
				loop
					error_manager.add_error (create {XERROR_JSON_ERROR}.make (l_parser.errors.item_for_iteration.out), False)
					l_parser.errors.forth
				end
			end
		end


	check_value (a_value: detachable JSON_VALUE): detachable XS_FILE_CONFIG
			-- Reads the values from JSON_VALUE into XS_FILE_CONFIG and checks for errors
		local
			l_util: XU_FILE_UTILITIES
			l_config: detachable XS_FILE_CONFIG
			l_resolved_path: STRING
		do
			create l_util

			if attached {JSON_OBJECT} a_value as l_v then
				create l_config.make_empty

					-- Check finalize_webapps
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (finalize_webapps_name)] as l_e then
					if l_e.item.is_boolean then
						l_config.set_finalize_webapps (l_e.item.to_boolean)
					else
						error_manager.add_error (create {XERROR_CONFIG_PROPERTY}.make (l_e.item), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (finalize_webapps_name), false)
				end

					-- Check compiler_name
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (compiler_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_executable_file (l_resolved_path) then
						l_config.set_compiler (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (compiler_name + ":'" + l_resolved_path + "'"), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (compiler_name), false)
				end

					-- Check translator
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (translator_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_executable_file (l_resolved_path) then
						l_config.set_translator (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (translator_name + ":'" + l_resolved_path + "'"), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (translator_name), false)
				end

					-- Check webapps_root
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (webapps_root_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_dir (l_resolved_path) then
						l_config.set_webapps_root (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (webapps_root_name + ":'" + l_resolved_path + "'"), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (webapps_root_name), false)
				end

					-- Check library					
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (lib_name)] as l_e then
					l_resolved_path := l_util.resolve_env_vars (l_e.item, True)
					if l_util.is_dir (l_resolved_path) then
						l_config.set_lib (l_resolved_path)
					else
						error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (lib_name + ":'" + l_resolved_path + "'"), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (lib_name), false)
				end

					-- Check compiler_flags
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (compiler_flags_name)] as l_e then
					l_config.set_compiler_flags (l_e.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (compiler_flags_name), false)
				end
			else
				error_manager.add_error (create {XERROR_JSON_ERROR}.make ("Invalid structure"), false)
			end

			if not error_manager.has_errors then
				Result := l_config
			end
		ensure
			not_result_but_errors: Result = Void implies error_manager.has_errors
		end
end
