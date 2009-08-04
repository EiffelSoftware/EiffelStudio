note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_WEBAPP_JSON_CONFIG_READER

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

feature {NONE} -- Internal Access

	name_name: STRING = "name"
	host_name: STRING = "host"
	port_name: STRING = "port"

feature -- Processing

	process_file (a_file: STRING): detachable XC_WEBAPP_CONFIG
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


	check_value (a_value: detachable JSON_VALUE): detachable XC_WEBAPP_CONFIG
			-- Reads the values from JSON_VALUE into XC_WEBAPP_CONFIG and checks for errors
		local
			l_config: XC_WEBAPP_CONFIG
			l_resolved_path: STRING
		do

			if attached {JSON_OBJECT} a_value as l_v then
				create l_config.make_empty

					-- Check name
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (name_name)] as l_e then
						l_config.set_name (l_e.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (name_name), false)
				end

					-- Check host
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (host_name)] as l_e then
					l_config.set_host (l_e.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (host_name), false)
				end

					-- Check port
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (port_name)] as l_e then
					if l_e.item.is_integer_32  then
						l_config.set_port (l_e.item.to_integer_32)
					else
						error_manager.add_error (create {XERROR_CONFIG_PROPERTY}.make (l_e.item), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (port_name), false)
				end

				if not error_manager.has_errors then
					Result := l_config
				end
			else
				error_manager.add_error (create {XERROR_JSON_ERROR}.make ("Invalid structure"), false)
			end


		ensure
			not_result_but_errors: Result = Void implies error_manager.has_errors
		end

end


