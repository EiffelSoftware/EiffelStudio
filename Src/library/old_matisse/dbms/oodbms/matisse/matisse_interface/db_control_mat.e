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

feature -- Status setting and report

	connect: INTEGER is
		-- Connection status returned by database server
		local
			c_host_name, c_database_name, c_time_name : ANY
		do
			inspect handle_mat.previous_mode 
			when NO_MODE then
				c_host_name := handle_mat.host_name.to_c
				c_database_name := handle_mat.database_name.to_c
				c_connect($c_host_name,$c_database_name)
				inspect handle_mat.mode
				when NO_SELECTED_DATABASE then
				when VERSION_ACCESS then
					c_set_context
					if handle_mat.version /= Void then 
						c_time_name := handle_mat.version.to_c
						c_set_time($c_time_name)
					else
						c_set_time(Default_pointer)
					end --if
				when SELECTED_DATABASE then
					c_set_context
				when OPENED_TRANSACTION then
					c_set_context
					c_start_transaction(handle_mat.priority)
				end -- inspect
			when NO_SELECTED_DATABASE then
				inspect handle_mat.mode
				when NO_SELECTED_DATABASE then
				when VERSION_ACCESS then
					c_set_context
 					if handle_mat.version /= Void then 
						c_time_name := handle_mat.version.to_c
						c_set_time($c_time_name)
					else
						c_set_time(Default_pointer)
					end -- if
				when SELECTED_DATABASE then
					c_set_context
				when OPENED_TRANSACTION then
					c_set_context
					c_start_transaction(handle_mat.priority)
				end -- inspect			
			when VERSION_ACCESS then
				inspect handle_mat.mode
				when NO_SELECTED_DATABASE then
					c_end_time
					c_set_no_context
				when VERSION_ACCESS then
					c_end_time
					if handle_mat.version /= Void then 
						c_time_name := handle_mat.version.to_c
						c_set_time($c_time_name)
					else
						c_set_time(Default_pointer)
					end -- if
				when SELECTED_DATABASE then
					c_end_time
				when OPENED_TRANSACTION then
					c_set_context
					c_start_transaction(handle_mat.priority)
				end -- inspect		
			when SELECTED_DATABASE then
				inspect handle_mat.mode
 				when NO_SELECTED_DATABASE then
					c_set_no_context
				when VERSION_ACCESS then
					c_time_name := handle_mat.version.to_c
					c_set_time($c_time_name)
				when SELECTED_DATABASE then
					-- Do nothing
				when OPENED_TRANSACTION then
					c_start_transaction(handle_mat.priority)
				end     -- inspect   
			when OPENED_TRANSACTION then
				inspect handle_mat.mode
				when NO_SELECTED_DATABASE then
					c_commit_transaction
					c_set_no_context
				when VERSION_ACCESS then
					c_commit_transaction
					if handle_mat.version /= Void then 
						c_time_name := handle_mat.version.to_c
						c_set_time($c_time_name)
					else
						c_set_time(Default_pointer)
					end -- if
				when SELECTED_DATABASE then
					c_commit_transaction
				when OPENED_TRANSACTION then
					c_commit_transaction
					c_start_transaction(handle_mat.priority)
				end -- inspect
			end
			Result := c_result
		end -- connect

	disconnect: INTEGER is
		-- Disconnection status returned from database server
		require else
			connection_exists: is_connected
		do
			inspect handle_mat.mode 
			when NO_MODE then
			when NO_SELECTED_DATABASE then
			when VERSION_ACCESS then
				c_end_time
				c_set_no_context
			when SELECTED_DATABASE then
				c_set_no_context
			when OPENED_TRANSACTION then
				c_commit_transaction
				c_set_no_context
			end -- inspect
			c_disconnect
			Result := c_result
		end -- disconnect

	commit: INTEGER is
		-- Commit status
		require else
			connection_exists: is_connected
		do
			c_commit_transaction
			Result := c_result
		end -- commit

	rollback: INTEGER is
            -- Rollback status
		require else
			connection_exists: is_connected
		do
			c_rollback
			Result := c_result
		end -- rollback

	begin: INTEGER is
		-- Start a new transaction 
		do
			c_start_transaction(handle_mat.priority)
			Result := c_result
		end -- begin

	transaction_count: INTEGER is
            -- Transactions opened
		do
			Result := c_transaction_count
		end  --  transaction_count         

end -- class DB_CONTROL_MAT

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

