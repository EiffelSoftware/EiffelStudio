indexing

	description:
		"Command to run the query from a PROFILE_QUERY_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RUN_QUERY_CMD

inherit
	COMMAND
	SHARED_QUERY_VALUES

creation
	make

feature {NONE} -- Initialization

	make (a_tool: EB_PROFILE_QUERY_WINDOW) is
			-- Create Current and set `tool' to `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		end

feature -- Command Execution

	execute (arg: ANY) is
			-- Execute Current
		local
			profiler_query: PROFILER_QUERY
			st: STRUCTURED_TEXT
			executer: E_SHOW_PROFILE_QUERY
			mp: MOUSE_PTR
		do
			tool.update_profiler_query
			!! profiler_query
			profiler_query.merge (tool.profiler_query)
			if profiler_query.subqueries.count > 0 then
				!! mp.set_watch_cursor
				!! st.make
				!! executer.make (st, profiler_query, tool.profiler_options)
				executer.set_last_output (tool.profinfo)
				executer.execute
				tool.update_window (st, profiler_query, tool.profiler_options, executer.last_output)
				mp.restore
			end
		end

feature {NONE} -- Attributes

	tool: EB_PROFILE_QUERY_WINDOW

end -- class EB_RUN_QUERY_CMD
