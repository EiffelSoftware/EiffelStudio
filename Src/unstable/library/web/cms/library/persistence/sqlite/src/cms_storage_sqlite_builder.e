note
	description: "[
			Interface responsible to instantiate CMS_STORAGE_SQLITE object.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_SQLITE_BUILDER

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

	storage (a_setup: CMS_SETUP): detachable CMS_STORAGE_SQLITE
		local
			s: STRING
			conn: detachable DATABASE_CONNECTION
		do
			if
				attached (create {APPLICATION_JSON_CONFIGURATION_HELPER}).new_database_configuration (a_setup.environment.application_config_path) as l_database_config
			then
				s := "Driver=SQLite3 ODBC Driver;Database="
				if attached l_database_config.database_name as db_name then
					s.append (db_name)
				end
				s.append (";LongNames=0;Timeout=1000;NoTXN=0;SyncPragma=NORMAL;StepAPI=0;")
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
					create Result.make (conn)
					set_map_zero_null_value (False)	--| This way we map 0 to 0, instead of Null as default.
					if Result.is_available then
						if not Result.is_initialized then
							initialize (a_setup, Result)
						end
					end
				end
			end
		end

	reuseable_connection: CELL [detachable TUPLE [name: STRING; connection: DATABASE_CONNECTION]]
		once
			create Result.put (Void)
		end

end
