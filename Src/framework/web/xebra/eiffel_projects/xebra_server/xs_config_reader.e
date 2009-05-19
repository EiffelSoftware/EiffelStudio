note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_CONFIG_READER

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XU_SHARED_OUTPUTTER
	XI_READER [XS_CONFIG]

create
	make

feature {NONE} -- Internal Access

	assume_webapps_are_running_name: STRING = "assume_webapps_are_running"
	finalize_webapps_name: STRING = "finalize_webapps"
	compiler_name: STRING = "compiler"
	translator_name: STRING = "translator"
	taglib_name: STRING = "taglib"
	webapps_root_name: STRING = "webapps_root"

feature -- Status report

	check_attributes (a_config: XS_CONFIG): detachable XS_CONFIG
			-- Checks if all attributes have been set
		require else
			a_config_attached: a_config /= Void
		local
			l_ok: BOOLEAN
		do
			l_ok := True
			if not a_config.webapps_root.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (webapps_root_name), false)
				l_ok := False
			end

			if not a_config.finalize_webapps.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (finalize_webapps_name), false)
				l_ok := False
			end

			if not a_config.translator.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (translator_name), false)
				l_ok := False
			end

			if not a_config.compiler.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (compiler_name), false)
				l_ok := False
			end

			if not a_config.assume_webapps_are_running.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (assume_webapps_are_running_name), false)
				l_ok := False
			end

			if not a_config.taglib.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (taglib_name), false)
				l_ok := False
			end

			if l_ok then
				Result := a_config
			end
		end

feature -- Status setting

	process_property (a_property: INI_PROPERTY; a_config: XS_CONFIG)
			-- Process document properties
		require else
			a_property_attached: a_property /= Void
			a_config_attached: a_config /= Void
		local
			l_name: STRING
			l_value: STRING
		do
			l_name := a_property.name.as_lower
			l_value := a_property.value

			if l_name.is_equal (assume_webapps_are_running_name) then
				if l_value.is_boolean then
					a_config.assume_webapps_are_running := l_value.to_boolean
				end
			elseif l_name.is_equal (finalize_webapps_name) then
				if l_value.is_boolean then
					a_config.finalize_webapps := l_value.to_boolean
				end
			elseif l_name.is_equal (compiler_name) then
					a_config.compiler := l_value
			elseif l_name.is_equal (translator_name) then
					a_config.translator := l_value
			elseif l_name.is_equal (webapps_root_name) then
					a_config.webapps_root := l_value
			elseif l_name.is_equal (taglib_name) then
					a_config.taglib := l_value
			else
				error_manager.add_error (create {XERROR_UNKNOWN_CONFIG_PROPERTY}.make (l_name), false)
			end
		end

end

