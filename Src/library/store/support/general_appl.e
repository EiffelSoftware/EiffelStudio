indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class GENERAL_APPL

inherit

	HANDLE_USE

feature {NONE} -- Status report

	session_database: DB [DATABASE] is
			-- Data base handle
		deferred
		end

	session_process: POINTER_REF
			-- A reference to a pointer object

	session_status: DB_STATUS
			-- A session management object reference
	
	session_execution_type: DB_EXEC
			-- An execution status object reference

end -- class GENERAL_APPL



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

