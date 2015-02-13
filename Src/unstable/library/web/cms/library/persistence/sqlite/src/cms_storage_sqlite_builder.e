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
	CMS_STORAGE_BUILDER

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
			if attached (create {APPLICATION_JSON_CONFIGURATION_HELPER}).new_database_configuration (a_setup.layout.application_config_path) as l_database_config then
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
		do
			initialize_schema (a_setup, a_storage)
			initialize_data (a_setup, a_storage)
		end

	initialize_schema (a_setup: CMS_SETUP; a_storage: CMS_STORAGE_STORE_SQL)
		local
			p: PATH
			f: PLAIN_TEXT_FILE
			sql: STRING
		do
			p := a_setup.layout.path.extended ("scripts").extended ("sqlite.sql")
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				create sql.make (f.count)
				f.open_read
				from
					f.start
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (1_024)
					sql.append (f.last_string)
				end
				f.close
				a_storage.error_handler.reset
--				a_storage.sql_begin_transaction
				a_storage.sql_change (sql, Void)
--				a_storage.sql_commit_transaction
			end
		end

	initialize_data (a_setup: CMS_SETUP; a_storage: CMS_STORAGE_STORE_SQL)
		local
			u: CMS_USER
		do
			create u.make ("admin")
			u.set_password ("#admin#")
			u.set_email (a_setup.site_email)
			a_storage.new_user (u)
		end


end
