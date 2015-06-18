note
	description: "Abstract class to handle a database connection"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATABASE_CONNECTION

inherit

	DATABASE_CONFIG

feature {NONE} -- Initialization

	login (a_username: STRING; a_password: STRING; a_hostname: STRING; a_database_name: STRING; connection: BOOLEAN)

			-- Create a database handler with user `a_username', password `a_password',
			-- host `a_hostname', database_name `a_database_name', and keep_connection `connection'.
		require
			username_not_void: a_username /= Void
			username_not_empty: not a_username.is_empty
			password_not_void: a_password /= Void
			hostname_not_void: a_hostname /= Void
			hotname_not_empty: not a_hostname.is_empty
			database_name_not_void: a_database_name /= Void
			database_name_not_empty: not a_database_name.is_empty
		deferred
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
		end

	login_with_connection_string (a_connection_string: STRING)
			-- Login with `a_connection_string'
			-- and immediately connect to database.
		deferred
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
		end

	login_with_default
			-- Create a database handler with common settings.
		deferred
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
		end

	login_with_database_name ( a_database_name: STRING)
			-- Create a database handler with common settings and
 			-- set database_name with `a_database_name'.
		require
			database_name_not_void: a_database_name /= Void
			database_name_not_empty: not a_database_name.is_empty
		deferred
		ensure
			db_application_not_void: db_application /= Void
			db_control_not_void: db_control /= Void
		end

feature -- Database Setup

	db_application: DATABASE_APPL [DATABASE]
			-- Database application.

	db_control: DB_CONTROL
			-- Database control.

	keep_connection: BOOLEAN
			-- Keep connection alive?

feature -- Transactions

	begin_transaction
			-- Start a transaction which will be terminated by a call to `rollback' or `commit'.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if db_control.is_ok then
					db_control.begin
				else
					database_error_handler.add_database_error (db_control.error_message_32, db_control.error_code)
				end
			end
		rescue
			rescued := True
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			db_control.reset
			retry
		end

	commit
			-- Commit updates in the database.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if db_control.is_ok then
					db_control.commit
				else
					database_error_handler.add_database_error (db_control.error_message_32, db_control.error_code)
				end
			end
		rescue
			rescued := True
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			db_control.reset
			retry
		end

	rollback
			-- Rollback updates in the database.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if db_control.is_ok then
					db_control.rollback
				else
					database_error_handler.add_database_error (db_control.error_message_32, db_control.error_code)
				end
			end
		rescue
			rescued := True
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			db_control.reset
			retry
		end

feature -- Change Element

	not_keep_connection
		do
			keep_connection := False
		end

feature -- Conection

	connect
			-- Connect to the database.
		require else
			db_control_not_void: db_control /= Void
		do
			if not is_connected then
				db_control.connect
			end
		end

	disconnect
			-- Disconnect from the database.
		require else
			db_control_not_void: db_control /= Void
		do
			db_control.disconnect
		end

	is_connected: BOOLEAN
			-- True if connected to the database.
		require else
			db_control_not_void: db_control /= Void
		do
			Result := db_control.is_connected
		end

feature -- Error Handling

	database_error_handler: DATABASE_ERROR_HANDLER
			-- Error handler.

feature -- Status Report

	has_error: BOOLEAN
			-- Has error?
		do
			Result := database_error_handler.has_error
		end

feature -- Helper

	exception_as_error (a_exception: like {EXCEPTION_MANAGER}.last_exception)
			-- Record exception `a_exception' as an error.
		do
			if a_exception /= Void and then attached a_exception.trace as l_trace then
				database_error_handler.add_error_details (a_exception.code, once "Exception", l_trace)
			end
		end


end
