indexing
	description: "External methods for class MT_DB_CONTROL."

class 
	MT_DB_CONTROL_EXTERNAL 

inherit
	MT_RESULT_EXTERNAL

feature {NONE} 

	c_allocate_connection: INTEGER is
		external 
			"C"
		end
	
	c_free_connection (mt_connection: INTEGER)  is
		external 
			"C"
		end
	
	c_get_connection_option (mt_connection, option: INTEGER): INTEGER is
		external 
			"C"
		end
	
	c_set_connection_option (mt_connection, option, value: INTEGER) is
		external 
			"C"
		end
	
	c_connect_database (mt_connection: INTEGER host, db, user, passwd: POINTER) is
		external 
			"C"
		end
	
	c_current_connection: INTEGER is
		external 
			"C"
		end
		
	c_set_current_connection (mt_connection: INTEGER) is
		external 
			"C"
		end
	
	c_no_current_connection is
		external 
			"C"
		end
	

	c_disconnect_database (mt_connection: INTEGER) is
		external 
			"C"
		end

	c_start_transaction (priority: INTEGER) is
			-- Use MtStartTransaction.
		external 
			"C"
		end

	c_commit_transaction is
			-- Use MtCommitTransaction.
		external 
			"C"
		end

	c_rollback is
			-- Use MtAbortTransaction.
		external 
			"C"
		end

	c_start_version_access (time_name: POINTER) is
		external 
			"C"
		end

	c_end_version_access is
		external 
			"C"
		end 



feature {NONE}
		
	c_error: POINTER is
			-- Use MtError.
		external 
			"C"
		end

	c_is_ok: INTEGER is
			-- Use MtSuccess in C interface.
		external 
			"C"
		end

	c_get_invalid_object: INTEGER is
			-- Use MtInvalidObject.
		external 
			"C"
		end

	c_perror (c_head: POINTER) is
			-- Use MtPError.
		external 
			"C"
		end

	c_is_check_error: BOOLEAN is
			-- Use MtCheckErrorP.
		external 
			"C"
		end

	c_full_error: POINTER is
			-- Use ErrorStr.
		external 
			"C"
		end

	c_failure: INTEGER is
			-- Use Failure.
		external 
			"C"
		end

feature {NONE} -- Constants

	Mt_Server_Execution_Priority: INTEGER is 0
	Mt_Lock_Wait_Time: INTEGER is 1
	Mt_Data_Access_Mode: INTEGER is	2
	
end
