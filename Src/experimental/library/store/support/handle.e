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
		local
			l_result: detachable DB [DATABASE]
		do
			l_result := manager.current_session.session_database
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	process: POINTER_REF
			-- Communication channel with database server
			-- (single or multiple depending on RDBMS)
		require
			set: is_process_set
		local
			l_result: detachable POINTER_REF
		do
			l_result := manager.current_session.session_process
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	status: DB_STATUS
			-- Status of active database
		require
			set: is_status_set
		local
			l_result: detachable DB_STATUS
		do
			l_result := manager.current_session.session_status
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	execution_type: DB_EXEC
			-- Immediate or non-immediate execution		
		require
			set: is_execution_type_set
		local
			l_result: detachable DB_EXEC
		do
			l_result := manager.current_session.session_execution_type
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	login: LOGIN [DATABASE]
			-- Session login
		require
			set: is_login_set
		local
			l_result: detachable LOGIN [DATABASE]
		do
			l_result := manager.current_session.session_login
			check l_result /= Void end -- implied by precondition
			Result := l_result
		end

	all_types: DB_ALL_TYPES
		require
			set: is_login_set
		local
			l_result: detachable DB_ALL_TYPES
		do
			l_result := manager.current_session.all_types
			check l_result /= Void end -- implied by precondition
			Result := l_result
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HANDLE



