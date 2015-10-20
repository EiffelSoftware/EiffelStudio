note
	description: "[
			Interface responsible to instantiate CMS_STORAGE_STORE_ODBC object.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_STORE_ODBC_BUILDER

inherit
	CMS_STORAGE_STORE_SQL_BUILDER

	GLOBAL_SETTINGS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
		end

feature -- Factory

	storage (a_setup: CMS_SETUP; a_error_handler: ERROR_HANDLER): detachable CMS_STORAGE_STORE_ODBC
		local
			s: detachable STRING
			conn: detachable DATABASE_CONNECTION
		do
			if
				attached (create {APPLICATION_JSON_CONFIGURATION_HELPER}).new_database_configuration (a_setup.environment.application_config_path) as l_database_config
			then
				if l_database_config.driver.is_case_insensitive_equal ("odbc") then
					s := l_database_config.database_string
					if attached reuseable_connection.item as d then
						if s.same_string (d.name) then
							conn := d.connection
						end
					end
					if conn = Void or else not conn.is_connected then
						create {DATABASE_CONNECTION_ODBC} conn.login_with_connection_string (s)
						reuseable_connection.replace ([s, conn])
					end
					if conn.is_connected then
						create Result.make_with_driver (conn, l_database_config.item ("Driver"))
						set_map_zero_null_value (False)	--| This way we map 0 to 0, instead of Null as default.
						set_use_extended_types (True) --| Use extended types: STRING_32 etc.
						if Result.is_available then
							if not Result.is_initialized then
								initialize (a_setup, Result)
							end
						end
					else
						a_error_handler.add_custom_error (0, "Could not connect to the ODBC storage", Void)
					end
				else
					-- Wrong mapping between storage name and storage builder!
				end
			end
		end

	reuseable_connection: CELL [detachable TUPLE [name: STRING; connection: DATABASE_CONNECTION]]
		once
			create Result.put (Void)
		end

end
