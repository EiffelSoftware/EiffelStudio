note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class GENERAL_APPL

inherit

	HANDLE_USE

feature {NONE} -- Status report

	session_database: detachable DB [DATABASE]
			-- Data base handle
		deferred
		end

	session_process: detachable POINTER_REF
			-- A reference to a pointer object

	session_status: detachable DB_STATUS
			-- A session management object reference

	session_execution_type: detachable DB_EXEC;
			-- An execution status object reference

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class GENERAL_APPL



