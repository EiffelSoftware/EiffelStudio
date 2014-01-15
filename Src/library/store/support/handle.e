note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class HANDLE

inherit
	DATABASE_SESSION_MANAGER_ACCESS

feature -- Status report

	database: DB [DATABASE]
			-- Active database accessed through the handle
		require
			set: is_database_set
		do
			check attached manager.current_session.session_database as l_result then
				Result := l_result
			end
		end

	process: POINTER_REF
			-- Communication channel with database server
			-- (single or multiple depending on RDBMS)
		require
			set: is_process_set
		do
			check attached manager.current_session.session_process as l_result then
				Result := l_result
			end
		end

	status: DB_STATUS
			-- Status of active database
		require
			set: is_status_set
		do
			check attached manager.current_session.session_status as l_result then
				Result := l_result
			end
		end

	execution_type: DB_EXEC
			-- Immediate or non-immediate execution		
		require
			set: is_execution_type_set
		do
				-- Implied by precondition
			check attached manager.current_session.session_execution_type as l_result then
				Result := l_result
			end
		end

	login: LOGIN [DATABASE]
			-- Session login
		require
			set: is_login_set
		do
				-- Implied by precondition
			check attached manager.current_session.session_login as l_result then
				Result := l_result
			end
		end

	all_types: DB_ALL_TYPES
		require
			set: is_login_set
		do
				-- Implied by precondition
			check attached manager.current_session.all_types as l_result then
				Result := l_result
			end
		end

	is_database_set: BOOLEAN
			-- If `internal_database' attached?
		do
			Result := attached manager.current_session.session_database
		end

	is_process_set: BOOLEAN
			-- If `internal_process' attached?
		do
			Result := attached manager.current_session.session_process
		end

	is_status_set: BOOLEAN
			-- If `internal_status' attached?
		do
			Result := attached manager.current_session.session_status
		end

	is_execution_type_set: BOOLEAN
			-- If `internal_execution_type' attached?
		do
			Result := attached manager.current_session.session_execution_type
		end

	is_login_set: BOOLEAN
			-- If `internal_login' attached?
		do
			Result := attached manager.current_session.session_login
		end

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class HANDLE



