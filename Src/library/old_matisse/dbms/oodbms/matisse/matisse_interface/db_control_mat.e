indexing

	Product: EiffelStore
	Database: Matisse

class DB_CONTROL_MAT

inherit

	DB_CONTROL_I

	HANDLE_USE_MAT
		export {NONE} all
	end

	MATISSE_CONST
		export {NONE} all
	end

	MT_DB_CONTROL_MAT_EXTERNAL
		export {NONE} all
	end


	IND_STORER_TRANS_TBL
		rename
			make as trans_tbl_make,
			create as trans_tbl_create,
			restore as trans_tbl_restore,
			exists as trans_tbl_exists,
			filename as trans_tbl_filename
		end

feature -- Status setting and report

	connect: INTEGER is
			-- Connection status returned by database server
		do
			c_set_no_context

			Result := change_mode
		end

	change_mode:INTEGER is
		local
			c_host_name, c_database_name: ANY
		do
			debug("matisse-db")
				io.put_string("++++++++ MATISSE Mode Change from mode ") io.put_integer(mode) io.put_string(" to mode ") io.put_integer(handle_mat.mode) io.put_string(" ++++++++%N")
			end
			inspect mode -- previous mode recorded in this session
			when NO_MODE then
				c_host_name := handle_mat.host_name.to_c
				c_database_name := handle_mat.database_name.to_c
				c_admin_connect($c_host_name,$c_database_name)		-- FIXME probably should be in own function
				c_db_connect($c_host_name,$c_database_name)

				inspect handle_mat.mode
				when NO_SELECTED_DATABASE then
				when VERSION_ACCESS then
					c_set_context
				when SELECTED_DATABASE then
					c_set_context
				when OPENED_TRANSACTION then
					c_set_context
					c_start_transaction(handle_mat.priority)
				end

			when NO_SELECTED_DATABASE then
				reset_mt_context
				inspect handle_mat.mode
				when NO_SELECTED_DATABASE then
					c_set_no_context
				when VERSION_ACCESS then
				when SELECTED_DATABASE then
				when OPENED_TRANSACTION then
					c_start_transaction(handle_mat.priority)
				end
			
			when VERSION_ACCESS then
				reset_mt_context
				inspect handle_mat.mode
				when NO_SELECTED_DATABASE then
					c_set_no_context
				when VERSION_ACCESS then
				when SELECTED_DATABASE then
				when OPENED_TRANSACTION then
					c_set_context
					c_start_transaction(handle_mat.priority)
				end		

			when SELECTED_DATABASE then
				reset_mt_context
				inspect handle_mat.mode
 				when NO_SELECTED_DATABASE then
					c_set_no_context
				when VERSION_ACCESS then
				when SELECTED_DATABASE then
				when OPENED_TRANSACTION then
					c_start_transaction(handle_mat.priority)
				end   

			when OPENED_TRANSACTION then
				reset_mt_context
				c_commit_transaction

				inspect handle_mat.mode
				when NO_SELECTED_DATABASE then
					c_set_no_context
				when VERSION_ACCESS then
				when SELECTED_DATABASE then
				when OPENED_TRANSACTION then
					c_start_transaction(handle_mat.priority)
				end
			end
			Result := c_result

			-- save current mode
			mode := handle_mat.mode

			-- save database context
			save_mt_context
		end


	disconnect: INTEGER is
			-- Disconnection status returned from database server
		require else
			connection_exists: is_connected
		do
			reset_mt_context

			inspect handle_mat.mode 
			when NO_MODE then
			when NO_SELECTED_DATABASE then
			when VERSION_ACCESS then
				c_set_no_context
			when SELECTED_DATABASE then
				c_set_no_context
			when OPENED_TRANSACTION then
				c_commit_transaction
				c_set_no_context
			end

			c_disconnect
			c_admin_disconnect		-- FIXME probably should be in own function

			Result := c_result
		end

	begin, begin_transaction: INTEGER is
			-- Start a new transaction 
		do
			if mode /= SELECTED_DATABASE then
				handle_mat.set_mode(SELECTED_DATABASE)
			end
			Result := change_mode

			c_start_transaction(handle_mat.priority)
			Result := c_result
			transaction_count := c_transaction_count
		ensure then
			In_selected_mode: mode = SELECTED_DATABASE
		end

	commit, commit_transaction: INTEGER is
			-- Commit status
		do
			reset_mt_context

			c_commit_transaction
			Result := c_result
			transaction_count := c_transaction_count
		end

	rollback, rollback_transaction: INTEGER is
			-- Rollback status
		do
			reset_mt_context

			c_rollback
			Result := c_result
			transaction_count := c_transaction_count
		end

	begin_version_access(version:STRING):INTEGER is
			-- do a Matisse version access
		local
			c_time_name:ANY
		do
			if mode /= VERSION_ACCESS then
				handle_mat.set_mode(VERSION_ACCESS)
			end
			Result := change_mode

	--	FIXME: necessary? We are using the idea that a the version in use is only extant for
	--	a particular version access, not just in VERSION_ACCESS mode. THis is sensible from
	--	the point of view of resource usage.
	--		handle_mat.set_version(version)

-- FIXME: obviously the constant "latest" should go somewhere, but I'm not sure where....
-- not in MATISSE_CONST, since (in theory) that represents values defined by them, whereas
-- "latest" is an invention of this binding.
			if not version.is_equal("latest") then
				c_time_name := version.to_c
				c_set_time($c_time_name)
			else
				c_set_time(Default_pointer)
			end
		ensure then
			In_version_mode: mode = VERSION_ACCESS		-- FIXME: should be in interface class
		end

	end_version_access:INTEGER is
			-- end Matisse version access; effect is to release resources
		do
			reset_mt_context
			c_end_time
		end

feature {NONE} -- session state
	transaction_count: INTEGER
            -- Transactions opened.
		  -- must be updated by any mt_support.c call which changes
		  -- transaction_count in C. Currently: begin, commit, rollback.
		  -- Must be written back before c_set_context call.

	mode:INTEGER
		-- current mode of this session
		-- must be updated after connect call; must be written back before 
		-- c_set_context call.

	database: POINTER
		-- must be updated after connect call; must be written back before 
		-- c_set_context call.

	admin_handle: POINTER
		-- must be updated after connect call; must be written back before 
		-- c_set_context call.

	save_mt_context is
			-- save the current database context
		do
			database := c_database
			admin_handle := c_admin_handle
			transaction_count := 0
		end

	reset_mt_context is
			-- call MtSetContext to switch db to context saved by this session
		do
			if c_database /= database then
				debug("matisse-db")
					io.put_string("++++++++ MATISSE Context Swap ++++++++")
				end

				c_set_database(database)
				c_set_transaction_count(transaction_count)
				c_set_context

				c_set_admin_handle(admin_handle)

				-- restore translation table for this db
				trans_tbl_restore
			end
		end

end
