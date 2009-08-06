note
	description: "[
			JSON config file reader for webapp config files.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_WEBAPP_JSON_CONFIG_READER

inherit
	XU_JSON_READER [XC_WEBAPP_CONFIG]

feature {NONE} -- Internal Access

	ecf_name: STRING = "ecf"
	name_name: STRING = "name"
	host_name: STRING = "host"
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
		do
			l_error_prefix := "'" + a_filename + "': "

			if attached {JSON_OBJECT} a_value as l_v then
				create l_config.make_empty

					-- Check ecf
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (ecf_name)] as l_e then
						l_config.set_ecf (l_e.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + ecf_name), false)
				end

					-- Check name
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (name_name)] as l_e then
						l_config.set_name (l_e.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + name_name), false)
				end

					-- Check host
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (host_name)] as l_e then
					l_config.set_host (l_e.item)
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + host_name), false)
				end

					-- Check port
				if attached {JSON_STRING} l_v.map_representation [create {JSON_STRING}.make_json (port_name)] as l_e then
					if l_e.item.is_integer_32  then
						l_config.set_port (l_e.item.to_integer_32)
					else
						error_manager.add_error (create {XERROR_CONFIG_PROPERTY}.make (l_error_prefix + l_e.item), false)
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + port_name), false)
				end

					-- Check taglibs
				if attached {JSON_ARRAY} l_v.map_representation [create {JSON_STRING}.make_json (taglibs_name)] as l_e then

					from
						l_e.array_representation.start
					until
						l_e.array_representation.after
					loop
						l_buf_tl_name := ""
						l_buf_tl_ecf := ""
						l_buf_tl_path := ""

						if attached {JSON_OBJECT} l_e.array_representation.item_for_iteration as l_ti then
								-- Check taglib name
							if attached {JSON_STRING} l_ti.map_representation [create {JSON_STRING}.make_json (tl_name_name)] as l_ti_i then
								l_buf_tl_name := l_ti_i.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + tl_name_name + " in " + taglibs_name), false)
							end

								-- Check taglib ecf
							if attached {JSON_STRING} l_ti.map_representation [create {JSON_STRING}.make_json (tl_ecf_name)] as l_ti_i then
								l_buf_tl_ecf := l_ti_i.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + tl_ecf_name + " in " + taglibs_name), false)
							end

								-- Check taglib path
							if attached {JSON_STRING} l_ti.map_representation [create {JSON_STRING}.make_json (tl_path_name)] as l_ti_i then
								l_buf_tl_path := l_ti_i.item
							else
								error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + tl_path_name + " in " + taglibs_name), false)
							end
								-- If all attributes success, add to taglibs
							if not (l_buf_tl_name.is_equal ("") or l_buf_tl_ecf.is_equal ("") or l_buf_tl_path.is_equal ("") ) then
								l_config.taglibs.force ([l_buf_tl_name, l_buf_tl_ecf, l_buf_tl_path])
							end
						end
						l_e.array_representation.forth
					end
				else
					error_manager.add_error (create {XERROR_MISSING_CONFIG_PROPERTY}.make (l_error_prefix + taglibs_name), false)
				end
				if not error_manager.has_errors then
					Result := l_config
				end
			end
		end
end


