indexing

	description:
		"Command to run the query from a PROFILE_QUERY_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RUN_QUERY_CMD

inherit
	EV_COMMAND
	SHARED_QUERY_VALUES

creation
	make

feature {NONE} -- Initialization

	make (a_query_window: EB_PROFILE_QUERY_WINDOW) is
			-- Create Current and set `query_window' to `a_query_window'.
		require
			a_query_window_not_void: a_query_window /= Void
		do
			query_window := a_query_window
		end

feature -- Command Execution

	execute is
			-- Extract the current query and display the results.
		local
			profiler_query: PROFILER_QUERY
			st: STRUCTURED_TEXT
			executer: E_SHOW_PROFILE_QUERY
--			mp: MOUSE_PTR
		do
			query_window.update_profiler_query
			create profiler_query
			profiler_query.merge (query_window.profiler_query)
			if profiler_query.subqueries.count > 0 then
	--			create mp.set_watch_cursor
				create st.make
				create executer.make (st, profiler_query, query_window.profiler_options)
				executer.set_last_output (query_window.profinfo)
				executer.execute
				query_window.update_window (st, profiler_query, query_window.profiler_options, executer.last_output)
	--			mp.restore
			end
		end

feature {NONE} -- Attributes

	query_window: EB_PROFILE_QUERY_WINDOW
		-- The window where query results will be displayed.

end -- class EB_RUN_QUERY_CMD
