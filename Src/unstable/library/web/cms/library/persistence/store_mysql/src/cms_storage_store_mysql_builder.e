note
	description: "[
			Interface responsible to instantiate CMS_STORAGE_STORE_MYSQL object.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_STORE_MYSQL_BUILDER

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

	storage (cfg: DATABASE_CONFIGURATION; a_setup: CMS_SETUP; a_error_handler: ERROR_HANDLER): detachable CMS_STORAGE_STORE_MYSQL
		local
			conn: detachable DATABASE_CONNECTION
			l_connection_string: READABLE_STRING_32
		do
			if cfg.driver.is_case_insensitive_equal ("mysql") then
				l_connection_string := cfg.connection_string

				if attached reuseable_connection.item as d then
					conn := d.conn
					if
						cfg.is_connection_reusable and
						l_connection_string.is_case_insensitive_equal_general (d.connection_string)
					then
							-- Keep `conn`
					else
						conn.disconnect
						conn := Void
						reuseable_connection.replace (Void)
					end
				end

				if conn = Void or else not conn.is_connected then
					create {DATABASE_CONNECTION_MYSQL} conn.login_with_connection_string (l_connection_string)
				end
				if conn.is_connected then
					create Result.make (conn)
					if cfg.is_connection_reusable then
						Result.set_is_reuseable (True)
						reuseable_connection.replace ([l_connection_string, conn])
					end
					set_map_zero_null_value (False)	--| This way we map 0 to 0, instead of Null as default.
					set_use_extended_types (True) --| Use extended types: STRING_32 etc.
					if Result.is_available then
						if not Result.is_initialized then
							initialize (a_setup, Result)
						end
					end
				else
					a_error_handler.add_custom_error (0, "Could not connect to the MySQL storage", Void)
				end
			else
				-- Wrong mapping between storage name and storage builder!
				a_error_handler.add_custom_error (0, "Wrong mapping between storage and builder!", Void)
			end
		end

	reuseable_connection: CELL [detachable TUPLE [connection_string: READABLE_STRING_GENERAL; conn: DATABASE_CONNECTION]]
		once
			create Result.put (Void)
		end

end
