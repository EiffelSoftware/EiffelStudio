note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class HANDLE_USE

inherit
	DATABASE_SESSION_MANAGER_ACCESS

feature -- Qeury

	is_database_set: BOOLEAN
			-- Is database set?
		do
			Result := handle.is_database_set
		end

feature {NONE} -- Status report

	handle: HANDLE
			-- Shared handle to switchable database implementations
		do
			Result := manager.current_session.handle
		end

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




end -- class HANDLE_USE



