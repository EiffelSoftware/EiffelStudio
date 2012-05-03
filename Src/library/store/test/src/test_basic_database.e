note
	description: "Utility class that handles preparation work for a basic database test"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_BASIC_DATABASE

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

	TESTING_HELPER
		undefine
			default_create
		end

	RDB_HANDLE
		undefine
			default_create
		end

	TEST_DATABASE_MANAGER
		undefine
			default_create
		end

feature {NONE} -- Prepare

	on_prepare
			-- On prepare
		do
			create base_stores.make (5)
			create repositories.make (5)
			set_connection_information (user_login, user_password, database_name)
			if attached Manager.current_session.session_login as l_login then
				l_login.set_application (database_name)	-- For MySQL
			end
		end

	reset_database
			-- Reset connection and errors if possible
		local
			l_session_control: DB_CONTROL
		do
			if is_database_set then
					-- To handle unset connection and errors in previous failing test,
					-- since the tests are possibly run in the same thread.
				create l_session_control.make
				if l_session_control.is_connected then
					l_session_control.disconnect
				end
				db_change.reset
			end
		end

feature {NONE} -- Implementation

	base_stores: HASH_TABLE [DB_STORE, STRING]
			-- Stores
			-- [store, table_name]

	repositories: HASH_TABLE [DB_REPOSITORY, STRING]
			-- Repositories
			-- [repository, table_name]

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
			-- [object, table_name]
		deferred
		end

feature {NONE}

	prepare_repository (a_table_name: STRING)
			-- Prepare repository
		local
			l_repository: DB_REPOSITORY
			l_db_store: DB_STORE
		do
				-- Drop the table first
			drop_repository (a_table_name)

				-- Create the table for data object relavant to the table name
			if attached data_objects.item (a_table_name) as l_data then
				create l_repository.make (a_table_name)
				l_repository.allocate (l_data)
				l_repository.load
				repositories.force (l_repository, a_table_name)

				create l_db_store.make
				l_db_store.set_repository (l_repository)
				base_stores.force (l_db_store, a_table_name)
			else
				assert ("No object found for table " + a_table_name, False)
			end
		end

	drop_repository (a_table_name: STRING)
			-- Drop repository
		local
			l_repository: DB_REPOSITORY
		do
			create l_repository.make (a_table_name)
			l_repository.load

			if l_repository.exists then
				reset_data (a_table_name)
			end
		end

	reset_data (a_table_name: STRING)
		do
			db_change.modify ("DROP TABLE " + a_table_name)
			assert ("Reset data failed: " + db_change.error_message_32, db_change.is_ok)
		end

end
