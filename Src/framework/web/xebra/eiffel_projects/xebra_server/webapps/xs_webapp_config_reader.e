note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_CONFIG_READER

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XS_SHARED_SERVER_OUTPUTTER
	XI_READER [XC_WEBAPP_CONFIG]

create
	make

feature {NONE} -- Internal Access

	name_name: STRING = "name"
	port_name: STRING = "port"
	host_name: STRING = "host"

feature -- Status report


	check_attributes (a_config: XC_WEBAPP_CONFIG): detachable XC_WEBAPP_CONFIG
			-- Checks if all attributes have been set
		local
			l_ok: BOOLEAN
		do
			l_ok := True
			if not a_config.name.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (name_name), false)
				l_ok := False
			end

			if not a_config.port.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (port_name), false)
				l_ok := False
			end

			if not a_config.host.is_set then
				error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (host_name), false)
				l_ok := False
			end

			if l_ok then
				Result := a_config
			end
		end

feature -- Status setting

	process_property (a_property: INI_PROPERTY; a_config: XC_WEBAPP_CONFIG)
			-- Process document properties
		local
			l_name: STRING
			l_value: STRING
		do
			l_name := a_property.name.as_lower
			l_value := a_property.value

			if l_name.is_equal (name_name) then
				a_config.name := l_value
			elseif l_name.is_equal (port_name) then
				if l_value.is_integer_32 then
					a_config.port := l_value.to_integer_32
				end
			elseif l_name.is_equal (host_name) then
					a_config.host := l_value
--			else
--				error_manager.add_error (create {XERROR_UNKNOWN_CONFIG_PROPERTY}.make (l_name), false)
			end
		end

end


