note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_MYSQL_BUILDER

inherit
	CMS_STORAGE_SQL_BUILDER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
		end

feature -- Factory

	storage (a_setup: CMS_SETUP): detachable CMS_STORAGE_MYSQL
		local
			conn: DATABASE_CONNECTION
		do
			if attached (create {APPLICATION_JSON_CONFIGURATION_HELPER}).new_database_configuration (a_setup.environment.application_config_path) as l_database_config then
				create {DATABASE_CONNECTION_MYSQL} conn.login_with_connection_string (l_database_config.connection_string)
				if conn.is_connected then
					create Result.make (conn)
				end
			end
		end


end
