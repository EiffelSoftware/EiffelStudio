note
	description: "Handle to actual database"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	HANDLE_SPEC [G -> DATABASE create default_create end]

inherit
	DATABASE_SESSION_MANAGER_ACCESS

feature -- Access

	db_spec: DATABASE
			-- Handle to actual database
		local
			l_database: detachable G
			l_session: DATABASE_SESSION
		do
			l_session := Manager.current_session
			if attached l_session.database as l_d then
				Result := l_d
			else
				create l_database
				l_session.set_database (l_database)
				Result := l_database
			end
		ensure
			not_void: Result /= Void
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




end -- class HANDLE_SPEC


