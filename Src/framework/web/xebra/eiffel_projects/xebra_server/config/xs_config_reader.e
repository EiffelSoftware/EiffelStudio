note
	description: "[
		Reads a server configuration file.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_CONFIG_READER

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XS_SHARED_SERVER_OUTPUTTER
	XI_READER [XS_FILE_CONFIG]

create
	make

feature {NONE} -- Internal Access

	finalize_webapps_name: STRING = "finalize_webapps"
	compiler_name: STRING = "compiler"
	translator_name: STRING = "translator"
	lib_name: STRING = "library"
	webapps_root_name: STRING = "webapps_root"
	compiler_flags_name: STRING = "compiler_flags"

feature -- Status report

	check_attributes (a_config: XS_FILE_CONFIG): detachable XS_FILE_CONFIG
			-- Checks if all attributes have been set
		require else
			a_config_attached: a_config /= Void
		local
			l_ok: BOOLEAN
			l_validator: XU_FILE_UTILITIES
		do
			create l_validator
			l_ok := True
			if not a_config.webapps_root.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (webapps_root_name), false)
				l_ok := False
			else
				if not l_validator.is_dir(a_config.webapps_root) then
					error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (webapps_root_name + ":'" + a_config.webapps_root.value + "'"), false)
					l_ok := False
				end
			end

			if not a_config.finalize_webapps.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (finalize_webapps_name), false)
				l_ok := False
			end

			if not a_config.translator.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (translator_name), false)
				l_ok := False
			else
				if not l_validator.is_executable_file (a_config.translator) then
					error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (translator_name + ":'" + a_config.translator.value + "'" ), false)
					l_ok := False
				end
			end

			if not a_config.compiler.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (compiler_name), false)
				l_ok := False
			else
				if not l_validator.is_executable_file (a_config.compiler) then
					error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (compiler_name + ":'"  + a_config.compiler.value + "'"), false)
					l_ok := False
				end
			end

			if not a_config.lib.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (lib_name), false)
				l_ok := False
			else
				if not  l_validator.is_dir(a_config.lib) then
					error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (lib_name+ ":'"  +  a_config.lib.value + "'"), false)
					l_ok := False
				end
			end

			if not a_config.compiler_flags.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (compiler_flags_name), false)
				l_ok := False
			end

			if l_ok then
				Result := a_config
			end
		end

feature -- Status setting

	process_property (a_property: INI_PROPERTY; a_config: XS_FILE_CONFIG)
			-- Process document properties
		require else
			a_property_attached: a_property /= Void
			a_config_attached: a_config /= Void
		local
			l_name: STRING
			l_value: STRING
			l_util: XU_FILE_UTILITIES
		do
			create l_util

			l_name := a_property.name.as_lower
			l_value := a_property.value

			if l_name.is_equal (finalize_webapps_name) then
				if l_value.is_boolean then
					a_config.set_finalize_webapps (l_value.to_boolean)
				end
			elseif l_name.is_equal (compiler_name) then
					a_config.set_compiler (l_util.resolve_env_vars (l_value,  True))
			elseif l_name.is_equal (translator_name) then
					a_config.set_translator (l_util.resolve_env_vars (l_value,  True))
			elseif l_name.is_equal (webapps_root_name) then
					a_config.set_webapps_root (l_util.resolve_env_vars (l_value,  True))
			elseif l_name.is_equal (lib_name) then
					a_config.set_lib (l_util.resolve_env_vars (l_value,  True))
			elseif l_name.is_equal (compiler_flags_name) then
					a_config.set_compiler_flags (l_util.resolve_env_vars (l_value,  True))
			else
				error_manager.add_error (create {XERROR_UNKNOWN_CONFIG_PROPERTY}.make (l_name), false)
			end
		end
end

