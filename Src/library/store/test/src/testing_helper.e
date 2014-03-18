note
	description: "Summary description for {TESTING_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TESTING_HELPER

inherit
	ANY

	SPEC_TESTING_SETTINGS

feature {NONE} -- Events

	load_list_from_selection (a_selection: DB_SELECTION; s: READABLE_STRING_GENERAL; an_obj: ANY): ARRAYED_LIST [like an_obj]
			-- Load list of objects whose type are the same as `an_obj',
			-- following the SQL query `s'.
		require
			a_selection_set: a_selection /= Void
			not_void: an_obj /= Void
			meaningful_select: s /= Void
		local
			db_actions: DB_ACTION [like an_obj]
			l_session_control: DB_CONTROL
			l_result: detachable ARRAYED_LIST [like an_obj]
			l_db_selection: DB_SELECTION
		do
			create l_session_control.make
			l_session_control.reset
			l_db_selection := a_selection
			l_db_selection.object_convert (an_obj)
			l_db_selection.set_query (s)
			create db_actions.make (l_db_selection, an_obj)
			l_db_selection.set_action (db_actions)
			l_db_selection.execute_query
			if l_db_selection.is_ok then
				l_db_selection.load_result
				if l_db_selection.is_ok then
					l_result := db_actions.list
				end
			end
			l_db_selection.terminate
			if l_result /= Void then
				Result := l_result
			else
				create Result.make (0)
			end
		ensure
			result_not_void: Result /= Void
		end

	load_list_from_executed_selection (a_selection: DB_SELECTION; an_obj: ANY): ARRAYED_LIST [like an_obj]
			-- Load list of objects whose type are the same as `an_obj',
			-- following the SQL query `s'.
		require
			a_selection_set: a_selection /= Void
			not_void: an_obj /= Void
		local
			db_actions: DB_ACTION [like an_obj]
			l_result: detachable ARRAYED_LIST [like an_obj]
			l_db_selection: DB_SELECTION
		do
			l_db_selection := a_selection
			create db_actions.make (l_db_selection, an_obj)
			l_db_selection.set_action (db_actions)
			if l_db_selection.is_ok then
				l_db_selection.load_result
				if l_db_selection.is_ok then
					l_result := db_actions.list
				end
			end
			if l_result /= Void then
				Result := l_result
			else
				create Result.make (0)
			end
		ensure
			result_not_void: Result /= Void
		end

end
