indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database : All_Bases

class DB_STATUS_USE

inherit

	HANDLE_USE

feature -- error status

	message_error: STRING

	message_warning: STRING

	code_error: INTEGER

feature -- Error handling

	error_code: INTEGER is
			-- Error code of last transaction
		do
			Result := handle.status.error_code
		end

	error_message: STRING is
			-- SQL error message prompted by database server
		do
			Result := handle.status.error_message
		end

feature {NONE} -- Status report

	is_connected: BOOLEAN is
			-- Has connection to the data base server succeeded?
		do
			Result := handle.status.is_connected
		end


	is_ok: BOOLEAN is
			-- Is last SQL statement ok ?
		do
			if handle.status.is_ok_mat /= Void then
				Result := handle.status.error_code = 0 or handle.status.is_ok_mat
			else 
				Result := handle.status.error_code = 0
			end
		end

	is_ok_mat: BOOLEAN is
			-- Is last SQL statement ok ?
			-- Only for OODBMS (MATISSE)
		do
			Result := handle.status.is_ok_mat
		end

	
	warning_message: STRING is
			-- SQL warning message prompted by database server
		do
			Result := handle.status.warning_message
			message_warning:= Result
		end

feature {NONE} -- Status setting

	reset is
			-- Reset `is_ok' and `error_code' after error occurred
		do
			handle.status.reset
		ensure
			is_ok: is_ok
			no_error: error_code = 0
		end

end -- class DB_STATUS_USE


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

