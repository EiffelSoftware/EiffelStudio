indexing
	description: "Gives all the methods to control a Matisse database."
	date: "$Date$"
	revision: "$Revision$"

class
	MT_DB_CONTROL

inherit
	MT_CONSTANTS

	MT_DB_CONTROL_EXTERNAL
	
	MEMORY
		redefine
			dispose
		end

creation
	make

feature -- Initialization

	make is
		do
			!! session_database.make
			allocate_connection
			session_database.set_mt_connection (mt_connection)
		end
		
feature -- Basic operations

	connect is
			-- Connect to database.
		local
			c_host_name, c_database_name, c_user_name, c_password: ANY
			temp_result: INTEGER
			an_exception: MT_EXCEPTIONS
			err_message: STRING
		do
			c_host_name := hostname.to_c
			c_database_name := database_name.to_c
			if user_name = Void then
				c_user_name := Void
			else
				c_user_name := user_name.to_c
			end
			if password = Void then
				c_password := Void
			else
				c_password := password.to_c
			end
			c_connect_database (mt_connection, $c_host_name, 
						$c_database_name, $c_user_name, $c_password)
			if c_result = MATISSE_SUCCESS then
				session_state := Mt_Inited
				set_connected
				session_database.connected
			else
				--Raise an exception
				!! an_exception
				!! err_message.make (100)
				err_message.from_c (c_error)
				an_exception.trigger_dev_exception (c_result, err_message)
			end
		ensure
			is_connected
		end

	disconnect is
			-- Disconnect from database.
		require
			connection_exists: is_connected
			session_state: session_state = Mt_Inited or session_state = Mt_Version
		local
			tmp: INTEGER
		do
			inspect session_state
			when Mt_Noconnection then
			when Mt_Inited then
				set_no_current_connection
				c_disconnect_database (mt_connection)
				session_state := Mt_Noconnection
			when Mt_Version then
				set_current_connection
				end_version_access
				set_no_current_connection
				c_disconnect_database (mt_connection)
				session_state := Mt_Noconnection
			when Mt_Transaction then
			end -- inspect
			session_database.disconnected
			is_connected := False
		ensure
			no_connection: not is_connected
		end

	commit is
			-- Commit work.
		require
			connection_exists: is_connected
			session_state_is_transaction: session_state = Mt_Transaction
		do
			set_current_connection
			session_database.flush_updated_objects
				-- Actually this is for MT_HASH_TABLE
			c_commit_transaction
			session_state := Mt_Inited
			session_database.transaction_committed
		end

	rollback, abort_transaction is
			-- Rollback work.
		require
			connection_exists: is_connected
			session_state_is_transaction: session_state = Mt_Transaction
		do
			set_current_connection
			c_rollback
			session_state := Mt_Inited
			session_database.transaction_aborted
		end

	begin, start_transaction is
			-- Start a new transaction.
		require
			connection_exists: is_connected
			session_state_is_inited: session_state = Mt_Inited
		do
			set_current_connection
			c_start_transaction (priority)
			session_state := Mt_Transaction
			session_database.transaction_started
		end



	start_version_access (version_name: STRING) is
		-- Start a new version access
		require
			connection_exists: is_connected
			session_state_is_inited: session_state = Mt_Inited
		local
			c_time_name: ANY
		do
			set_current_connection
			if version_name /= Void then 
				c_time_name := version_name.to_c
				c_start_version_access ($c_time_name)
			else
				c_start_version_access (Default_pointer)
			end
			session_state := Mt_Version
			session_database.version_access_started
		end
		
	end_version_access is
			-- Stop the current version access.
		require
			connection_exists: is_connected
			session_state_is_inited: session_state = Mt_Version
		do
			set_current_connection
			c_end_version_access			
			session_state := Mt_Inited
			session_database.version_access_ended
		end

feature		

	set_context, set_current_connection is
			-- Set the current context to Current.
		do
			c_set_current_connection (mt_connection)
			put_current_db (session_database)
		end
		
	set_no_current_connection is
		do
			c_no_current_connection
			put_current_db (Void)
		end

	is_connected: BOOLEAN
	
feature -- Status session

	set_hostname (a_hostname: STRING) is
		require
			not_void: a_hostname /= Void
			not_empty: not a_hostname.is_empty
		do
			hostname := clone (a_hostname)
		end
	
	set_database_name (a_db_name: STRING) is
		require
			not_void: a_db_name /= Void
			not_empty: not a_db_name.is_empty
		do
			database_name := clone (a_db_name)
		end

	set_user_name (a_name: STRING) is
		require
			not_void: a_name /= Void
			not_empty: not a_name.is_empty
		do
			user_name := clone (a_name)
		end
	
	set_password (a_word: STRING) is
		require
			not_void: a_word /= Void
			not_empty: not a_word.is_empty
		do
			password := clone (a_word)
		end
	
	set_priority (a_priority: INTEGER) is
		require
			valid_priority: a_priority <= Mt_Max_Server_Execution_Priority and
						a_priority >= Mt_Min_Server_Execution_Priority
		do
			c_set_connection_option (mt_connection, 
					Mt_Server_Execution_Priority, a_priority)
		end
	
	set_wait_time (a_sec: INTEGER) is
		require
			valid_wait_time: a_sec >= Mt_Wait_Forever
		do
			c_set_connection_option (mt_connection, Mt_Lock_Wait_Time, a_sec)
		end

	set_data_access_mode (a_mode: INTEGER) is
		require
			mode_type: a_mode = Mt_Data_Modification or
						a_mode = Mt_Data_Readonly or
						a_mode = Mt_Data_Definition
		do
			c_set_connection_option (mt_connection, Mt_Data_Access_Mode, a_mode)
		end
		
feature  -- Status

	hostname: STRING
	
	database_name: STRING
	
	user_name: STRING
	
	priority: INTEGER is
		do
			Result := c_get_connection_option (mt_connection, Mt_Server_Execution_Priority)
		end
	
	wait_time: INTEGER is
		do
			Result := c_get_connection_option (mt_connection, Mt_Lock_Wait_Time)
		end
	
	data_access_mode: INTEGER is
		do
			Result := c_get_connection_option (mt_connection, Mt_Data_Access_Mode)
		end

	session_state: INTEGER

feature {MATISSE_APPL}

	session_database: MATISSE

feature {NONE} -- Implementation

	set_connected is
		do
			is_connected := True
		end
	
	set_disconnected is
		do
			is_connected := False
		end

	password: STRING
	
	mt_connection: INTEGER
	
	allocate_connection is
		do
			mt_connection := c_allocate_connection
		end
	
	dispose is
			-- Redefinition of dispose of MEMORY.
			-- Free mt_connection_pointer.
		local
			current_connection: INTEGER
		do
		end

end -- class MT_DB_CONTROL
