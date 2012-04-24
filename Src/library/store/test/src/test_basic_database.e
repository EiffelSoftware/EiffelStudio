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
		local
			l_login: like Manager.current_session.session_login
		do
			create base_stores.make (5)
			create repositories.make (5)
			set_connection_information (user_login, user_password, database_name)
			l_login := Manager.current_session.session_login
			l_login.set_application (database_name)	-- For MySQL
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
			if attached data_objects.item (a_table_name) as l_data then
					-- Create the table for book-objects.
				create l_repository.make (a_table_name)
				repositories.force (l_repository, a_table_name)
				l_repository.load

				if l_repository.exists then
					reset_data (a_table_name)
					l_repository.load
				end

				l_repository.allocate (l_data)
				l_repository.load

				create l_db_store.make
				l_db_store.set_repository (l_repository)
				base_stores.force (l_db_store, a_table_name)
			else
				assert ("No object found for table " + a_table_name, False)
			end
		end

	reset_data (a_table_name: STRING)
		do
			db_change.modify ("DROP TABLE " + a_table_name)
			assert ("Reset data failed: " + db_change.error_message_32, db_change.is_ok)
		end

end
