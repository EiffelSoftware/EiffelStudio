indexing
	description: "Implementation of DB_STATUS";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_STATUS [G -> DATABASE create default_create end]

inherit

	DB_STATUS_USE
		export
			{DB_STATUS} error_message, error_code, warning_message, is_ok_mat, reset
		redefine
			error_message, error_code, warning_message, is_ok_mat, reset
		end

	HANDLE_SPEC [G]

feature -- Status report

	is_error_updated: BOOLEAN is
			-- Has an Oracle/ODBC function been called since last update which may have
			-- updated error code, error message or warning message?
		do
			Result := db_spec.is_error_updated
		end	

	error_message: STRING is
			-- Error message from database server
		do
			!! Result.make (10)
			Result.from_c (db_spec.get_error_message)
		end

	error_code: INTEGER is
			-- Error code from database server
		do
			Result := db_spec.get_error_code
		end

	warning_message: STRING is
			-- Warning message from database server
		do
			!! Result.make (10)
			Result.from_c (db_spec.get_warn_message)
		end

	is_ok_mat: BOOLEAN is
			-- Is last SQL statement ok?
			-- Only for OODBMS (MATISSE)
		do
			Result := db_spec.is_ok_mat
		end

	found: BOOLEAN is
			-- Is there any record matching the last
			-- selection condition used ?
		do
			Result := db_spec.found
		end

	reset is
			--Reset database error status.
		do
			db_spec.clear_error
		end

end -- class DATABASE_STATUS 

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
