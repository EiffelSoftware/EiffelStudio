indexing
	description: "External functions for SQL queries";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_SQL_EXTERNAL

feature
	c_sql_exec (statement: POINTER): INTEGER is
			-- Execute a select query.
			-- (returns an ID of selection)
		external 
			"C"
		end

	c_open_selection_stream (selection_id: INTEGER): INTEGER is
			-- Return type is MtStream which is actually mts_int32
		external 
			"C"
		end
	
	c_sql_get_selection (selection_name: POINTER): INTEGER is
			-- Execute MtSQLGetSelection ()
		external 
			"C"
		end
	
	c_sql_get_instance_number (selection_id: INTEGER): INTEGER is
		external 
			"C"
		end
	
	c_sql_free_selection (selection_id: INTEGER) is
		external 
			"C"
		end
	
	c_get_selection_name (selection_id: INTEGER): POINTER is
		external 
			"C"
		end
	
end -- class MT_SQL_EXTERNAL
