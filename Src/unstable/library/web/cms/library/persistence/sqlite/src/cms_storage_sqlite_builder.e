note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_SQLITE_BUILDER

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

	storage (a_setup: CMS_SETUP): detachable CMS_STORAGE_SQLITE
		local
			s: STRING
		do
			if attached (create {APPLICATION_JSON_CONFIGURATION_HELPER}).new_database_configuration (a_setup.environment.application_config_path) as l_database_config then
				s := "Driver=SQLite3 ODBC Driver;Database="
				if attached l_database_config.database_name as db_name then
					s.append (db_name)
				end
				s.append (";LongNames=0;Timeout=1000;NoTXN=0;SyncPragma=NORMAL;StepAPI=0;")
				create Result.make (create {DATABASE_CONNECTION_ODBC}.login_with_connection_string (s))
				--create Result.make (create {DATABASE_CONNECTION_ODBC}.login_with_connection_string (l_database_config.connection_string))
				if Result.is_available then
					if not Result.is_initialized then
						initialize (a_setup, Result)
					end
				end
			end
		end

	initialize (a_setup: CMS_SETUP; a_storage: CMS_STORAGE_STORE_SQL)
		local
			u: CMS_USER
			r: CMS_USER_ROLE
		do
				-- Schema
			a_storage.sql_execute_file_script (a_setup.environment.path.extended ("scripts").extended ("core.sql"))

				-- Data	
				-- Users
			create u.make ("admin")
			u.set_password ("istrator#")
			u.set_email (a_setup.site_email)
			a_storage.new_user (u)

				-- Roles
			create r.make ("anonymous")
			a_storage.save_user_role (r)
			create r.make ("authenticated")
			r.add_permission ("create page")
			r.add_permission ("edit page")
			a_storage.save_user_role (r)

				-- Test custom value

			a_storage.set_custom_value ("abc", "123", "test")
			a_storage.set_custom_value ("abc", "OK", "test")
		end

end
