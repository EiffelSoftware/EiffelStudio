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


	session_database: DATABASE is
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
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
