indexing

	Product: EiffelStore
	Database: Oracle

class DB_STATUS_MAT

inherit

	DB_STATUS_I
		redefine
			error_message, warning_message, is_ok_mat
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

	is_ok_mat : BOOLEAN is
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

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------

