indexing

    Product: EiffelStore
    Database: matisse

class HANDLE_MAT

inherit

	MATISSE_CONST
		export {NONE} all;	
			{ANY} version_access, opened_transaction, no_selected_database, selected_database, no_mode
		end	

	MT_HANDLE_MAT_EXTERNAL

feature --  Access

	login: LOGIN_MATISSE -- Session login

	wait_time : INTEGER is
		-- Get wait time from Matisse
		do
			Result := wait
		end -- wait_time

	mode : INTEGER  -- Current working mode

	previous_mode : INTEGER -- Previous working mode

	wait : INTEGER  -- Max wait time in seconds

	priority : INTEGER -- Priority of transactions
	
	version : STRING  -- Current working version if any

feature {DB_CONTROL_MAT} -- Access

	host_name : STRING
	
	database_name : STRING

feature -- Status setting

	set_login (other: LOGIN_MATISSE) is
		-- Get `other' login for handle
		require
			login_not_void: other /= Void
		do
			login := other
		ensure
			login = other
		end -- set_login

	set_wait(wait_value: INTEGER) is
			-- Change wait time to 'wait'
		require
			wait_value_positive : wait_value >=0
		do
			wait := wait_value
			c_set_wait_time(wait_value)
		end -- set_wait
	
	set_priority(priority_value : INTEGER) is
			-- Change priority
		require
			priority_positive : priority_value >= 0
		do
			priority := priority_value
		end -- set_priority

	set_mode(mode_value : INTEGER) is
		-- Set current working mode in Matisse
		require 
			mode_is_correct : mode_value=VERSION_ACCESS or mode_value=OPENED_TRANSACTION or mode_value=NO_SELECTED_DATABASE or mode_value=SELECTED_DATABASE
		do
			mode := mode_value 
		end -- set_mode

	set_version(version_value : STRING) is
			-- Set current version string
		do
			version := version_value
		end -- set_version

feature {MATISSE_APPL} -- Status Setting

	set_names( host, database : STRING) is
		-- Set hostname and database name
		do
			host_name := Clone(host)
			database_name := Clone(database)
		end -- set_names

	set_previous_mode(mode_value : INTEGER) is
 		-- Set current working mode in Matisse
		require 
			mode_is_correct :   mode_value=VERSION_ACCESS or 
					mode_value=OPENED_TRANSACTION or 
					mode_value=NO_SELECTED_DATABASE or 
					mode_value=SELECTED_DATABASE or
					mode_value=NO_MODE
		do
			previous_mode := mode_value
		end -- set_mode

end -- class HANDLE_MAT


