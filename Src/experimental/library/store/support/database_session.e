note
	description: "Database session. Multiple connections are represented by this class"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_SESSION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			create handle
		end

feature {HANDLE_SPEC, HANDLE} -- Element Change

	set_database (l_database: like database)
			-- Set `database' with `database'
		do
			database := l_database
		ensure
			database_set: database = l_database
		end

	set_session_database (l_session_database: like session_database)
			-- Set `session_database' with `session_database'
		do
			session_database := l_session_database
		ensure
			session_database_set: session_database = l_session_database
		end

	set_session_login (l_session_login: like session_login)
			-- Set `session_login' with `session_login'
		do
			session_login := l_session_login
		ensure
			session_login_set: session_login = l_session_login
		end

	set_session_process (l_session_process: like session_process)
			-- Set `session_process' with `session_process'
		do
			session_process := l_session_process
		ensure
			session_process_set: session_process = l_session_process
		end

	set_session_status (l_session_status: like session_status)
			-- Set `session_status' with `session_status'
		do
			session_status := l_session_status
		ensure
			session_status_set: session_status = l_session_status
		end

	set_session_execution_type (l_session_execution_type: like session_execution_type)
			-- Set `session_execution_type' with `session_execution_type'
		do
			session_execution_type := l_session_execution_type
		ensure
			session_execution_type_set: session_execution_type = l_session_execution_type
		end

	set_all_types (l_all_types: like all_types)
			-- Set `all_types' with `all_types'
		do
			all_types := l_all_types
		ensure
			all_types_set: all_types = l_all_types
		end

feature {HANDLE_USE, HANDLE_SPEC, HANDLE, DB} -- Implementation

	database: detachable DATABASE
			-- Database object

	handle: HANDLE
			-- Handle to the connection context

	session_database: detachable DB [DATABASE]
			-- Data Base

	session_login: detachable LOGIN [DATABASE]
		-- Login information

	session_process: detachable POINTER_REF
			-- A reference to a pointer object

	session_status: detachable DB_STATUS
			-- A session management object reference

	session_execution_type: detachable DB_EXEC
			-- An execution status object reference

	all_types: detachable DB_ALL_TYPES
			-- All types

end
