indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: status, error
	Product: EiffelStore
	Database: All_Bases

class DB_STATUS

inherit

	HANDLE_USE

creation -- Creation procedure

	make

feature -- Status report

	is_connected: BOOLEAN
			-- Has connection to the data base server succeeded?

	error_code: INTEGER
			-- Error code

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?

	error_message: STRING is
			-- SQL error message prompted by database server
		do
			Result := implementation.error_message
		end

	warning_message: STRING is
			-- SQL warning message prompted by database server
		do
			Result := implementation.warning_message
		end

	is_ok_mat : BOOLEAN is
			-- Has the last transaction successfully completed?
			-- Only for OODBMS (MATISSE)
		do
			Result := implementation.is_ok_mat
		end

feature -- Status setting

	set_connect (new_value: BOOLEAN) is
			-- Change state of connection.
		do
			is_connected := new_value
		ensure
			is_connected_reset: is_connected = new_value
		end

	set (new_value: INTEGER) is
			-- Set `ok' with `new_value'.
		do
			if error_code = 0 then
				error_code := new_value
			end
		ensure
			error_code_resetting: old error_code = 0 implies error_code = new_value
		end

	reset is
			-- Reset database status to default values.
		do
			error_code := 0
			found := false
		ensure then
			error_code_set_to_zero: error_code = 0
			found_set_to_false: not found
		end

	set_found (value: INTEGER) is
			-- Change state of `found'.
		do
			found := value > 0
		end

feature {NONE} -- Implementation

	implementation: DATABASE_STATUS [DATABASE]

feature {NONE} -- Initialization

	make is
			-- Create `implementation' handle.
		do
			implementation := handle.database.db_status
		end

invariant

	has_handle: implementation /= Void

end -- class DB_STATUS


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

