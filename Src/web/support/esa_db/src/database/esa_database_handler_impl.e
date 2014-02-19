note
	description: "Database handler for ODBC"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATABASE_HANDLER_IMPL

inherit
	ESA_DATABASE_HANDLER

	ESA_DATABASE_CONFIG

create
	make,
	make_common

feature {NONE} -- Initialization

	make_common
			-- Create a database hander for ODBC with common settings
		do
			create db_application.login (username, password)
			db_application.set_hostname (hostname)
			db_application.set_data_source (database_name)
			db_application.set_base

			create db_control.make
			create last_query.make_now
			keep_connection := is_keep_connection

			if keep_connection then
				connect
			end
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
			last_query_not_void: last_query /= Void
		end


	make (a_username: STRING; a_password: STRING; a_hostname : STRING; a_database_name: STRING; connection: BOOLEAN)

				-- Create a database handler for ODBC
		require
			username_not_void: a_username /= Void
			username_not_empty: not a_username.is_empty
			password_not_void: a_password /= Void
			hostname_not_void: a_hostname /= Void
			hotname_not_empty: not a_hostname.is_empty
			database_name_not_void: a_database_name /= Void
			database_name_not_empty: not a_database_name.is_empty
		do
			create db_application.login (a_username, a_password)
			db_application.set_hostname (a_hostname)
			db_application.set_data_source (a_database_name)
			db_application.set_base

			create db_control.make
			create last_query.make_now
			keep_connection := connection

			if keep_connection then
				connect
			end
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
			last_query_not_void: last_query /= Void
		end

feature -- Functionality

	execute_reader
			-- Execute stored procedure that returns data
		local
			container: ARRAYED_LIST[DB_RESULT]
			l_db_selection: DB_SELECTION
		do
			if not keep_connection then
				connect
			end

			if attached store as l_store then
				create l_db_selection.make
				db_selection := l_db_selection
				items := l_store.execute_reader (l_db_selection)
			end

			if not keep_connection then
				disconnect
			end
		end

	execute_writer
			-- Execute stored procedure that update/add data
		local
			container: ARRAYED_LIST[DB_RESULT]
			l_db_change: DB_CHANGE
		do
			if not keep_connection and not is_connected then
				connect
			end

			if attached store as l_store then
				create l_db_change.make
				db_update := l_db_change
				l_store.execute_writer (l_db_change)
				if not l_store.has_error then
					db_control.commit
				end
			end



			if not keep_connection then
				disconnect
			end
		end


feature -- Iteration

	start
			-- Set the cursor on first element
		do
			if attached db_selection as l_db_selection then
				l_db_selection.start
			end
		end

	forth
			-- Move cursor to next element
		do
			if attached db_selection as l_db_selection then
				l_db_selection.forth
			end
		end

	after: BOOLEAN
			-- True for the last element
		do
			if attached db_selection as l_db_selection then
				Result := l_db_selection.after
			end
		end


	item: detachable DB_TUPLE
			-- Current element
		do
			if attached db_selection as l_db_selection then
				if attached l_db_selection.cursor as l_cursor  then
					Result := create {DB_TUPLE}.copy (l_cursor)
				end
			end
		end

feature {NONE} -- Implementation

	db_application: DATABASE_APPL[ODBC]
		-- Database application
	db_control: DB_CONTROL
		-- Database control
	db_result: detachable DB_RESULT
		-- Database query result
	db_selection: detachable DB_SELECTION
		-- Database selection
	db_update: detachable DB_CHANGE
		-- Database modification	

	last_query: DATE_TIME
		-- Last time when a query was executed
	keep_connection: BOOLEAN
		-- Keep connection alive?

	connect
			-- Connect to the database
		require else
			db_control_not_void: db_control /= Void
		do
			if not is_connected then
				db_control.connect
			end
		end

	disconnect
			-- Disconnect from the database
		require else
			db_control_not_void: db_control /= Void
		do
			db_control.disconnect
		end

	is_connected: BOOLEAN
			-- True if connected to the database
		require else
			db_control_not_void: db_control /= Void
		do
			Result := db_control.is_connected
		end


	affected_row_count: INTEGER
			--  The number of rows changed, deleted, or inserted by the last statement
		do
			if attached db_update as l_update then
				Result := l_update.affected_row_count
			end
		end
feature -- Result

	items : detachable LIST[DB_RESULT]
		-- Query result

end
