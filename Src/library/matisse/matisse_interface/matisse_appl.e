indexing

	description: "Gives all the method to use a Matisse database."
	Product: EiffelStore
	Database: Matisse

class 
	MATISSE_APPL

inherit
	MT_CONSTANTS
		export 
			{NONE} all;	
		end

creation
	set_login, make

feature -- Initialization

	set_login, make (a_hostname, db_name: STRING) is
			-- Set login information to database server under `a_hostname' with `db_name'.
		require
			arguments_exist: a_hostname /= Void and db_name /= Void
			arguments_not_empty: not (a_hostname.is_empty or db_name.is_empty)
		do
			!! session_control.make
			session_control.set_hostname (a_hostname)
			session_control.set_database_name (db_name)
		end -- login

feature -- Setting

	set_hostname (a_hostname: STRING) is
		do
			session_control.set_hostname (a_hostname)
		end
		
	set_database_name (a_db_name: STRING) is
		do
			session_control.set_database_name (a_db_name)
		end
	
	set_user_name (a_name: STRING) is
		do
			session_control.set_user_name (a_name)
		end
	
	set_password (a_word: STRING) is
		do
			session_control.set_password (a_word)
		end
	
	set_wait (sec: INTEGER) is
			-- Set wait Time
		require
			sec_positive_or_null: sec >= 0
			--session_control_not_void: session_control /= Void
		do
			session_control.set_wait_time (sec)
		end

	set_priority (a_priority: INTEGER) is
			-- Set priority of transactions
		require
			a_priority_positive_or_null: a_priority >= 0
		do
			session_control.set_priority (a_priority)
		end

feature -- Status Report

	is_transaction_open: BOOLEAN is
		do
			Result := session_control.session_state = Mt_transaction
		end
	
	is_version_access_open: BOOLEAN is
		do
			Result := session_control.session_state = Mt_version
		end
	
	is_access_open: BOOLEAN is
			-- Is a transaction or a version access open?
		do
			Result := session_control.session_state = Mt_version or
					session_control.session_state = Mt_transaction
		end
		
	host_name: STRING is
		do
			Result := clone (session_control.hostname)
		end
	
	database_name: STRING is
		do
			Result := clone (session_control.database_name)
		end

feature -- Database session

	begin, start_transaction is
		do
			session_control.start_transaction
		end
		
	commit, commit_transaction is
		do
			session_control.commit
		end
		
	connect is
		do
			session_control.connect
		end
		
	disconnect is
		do
			session_control.disconnect
		end
		
	rollback, abort_transaction is
		do
			session_control.abort_transaction
		end

	start_version_access is
		do
			session_control.start_version_access (Void)
		end
	
	start_version_access_name (version_name: STRING) is
		do
			session_control.start_version_access (version_name)
		end
	
	end_version_access is
		do
			session_control.end_version_access
		end
	
feature -- Status setting

	set_base is
			-- Initialize Matisse database server
			-- after a handle change.
		require
			is_logged_to_base: is_logged_to_base
		do
		end
		
	set_current_connection is
			-- Initialize or re-activate Matisse database server
			-- after a handle change.
		require
			is_logged_to_base: is_logged_to_base
		do
		end

	set_no_current_connection, set_no_base is
		do
			set_current_connection
			session_control.set_no_current_connection
		end
		
feature -- Status report

	is_connected, is_logged_to_base: BOOLEAN is
			-- Is current handle logged to Matisse server?
		do
			Result := session_control /= Void
		ensure
			Result = (session_control /= Void)
		end -- is_logged_to_base

feature {NONE} -- Implementation

	session_control: MT_DB_CONTROL
	
end -- class MATISSE_APPL
