indexing

	Product: EiffelStore
	Database: Oracle

class DB_STATUS_MAT

inherit

	DB_STATUS_I
		redefine
			error_message, warning_message, is_ok
		end

	MATISSE_CONST
		export {NONE} all
		end

	MT_DB_STATUS_MAT_EXTERNAL
		export {NONE} all
		end

feature -- Access

	error_message,warning_message : STRING is
		-- Error message from database server
		do
			!! Result.make (10)
			Result.from_c(c_error)
		end -- error_message

	full_error_message : STRING is 
		-- Long error message
		do
			!! Result.make (512)
			Result.from_c(c_full_error)
		end -- full_error_message

	last_invalid_object : MT_OBJECT is
		-- Last object which generated an error
		do
			!!Result.make(c_invalid_object)
		end -- last_invalid_object

feature -- Status Report

	is_ok : BOOLEAN is
		-- Has last operation succeeded ?
		do
			Result := (c_result = Matisse_success)
		end -- is_ok

	is_not_ok : BOOLEAN is
		-- Has last operation failed
		do
			Result := c_failure /= 0
		end -- is_not_ok

	is_check_error : BOOLEAN is
		-- Is last error a check error ?
		do
			Result := c_is_check_error
		end -- is_check_error

feature -- Action

	print_error_on_stderr(head : STRING) is
		-- Print error on standard error output preceded by 'head' message
		local
			c_head : ANY
		do
			c_head := head.to_c
			c_perror($c_head)
		end -- print_error_on_stderr

end -- class DB_STATUS_MAT
