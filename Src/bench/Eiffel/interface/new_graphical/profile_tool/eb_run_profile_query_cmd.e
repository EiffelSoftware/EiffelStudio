indexing

	description:
		"Command to run the query specified by the user."
	date: "$Date$"
	revision: "$Revision$"

class EB_RUN_PROFILE_QUERY_CMD

inherit
	SHARED_QUERY_VALUES
	EB_TOOL_COMMAND
		redefine
			tool
		end

creation
	make

feature {NONE} -- Attributes

	tool: EB_PROFILE_TOOL
			-- The profile tool

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current command.
		local
			profiler_query: PROFILER_QUERY
			profiler_options: PROFILER_OPTIONS
			st: STRUCTURED_TEXT
			executer: E_SHOW_PROFILE_QUERY
			error_dialog: EB_MESSAGE_WINDOW
--			mp: MOUSE_PTR
		do
			if arg = Void then
					--| Run the query
				clear_values
				if tool.fill_values (Current) then
					!! profiler_query
					profiler_query.set_subqueries (subqueries)
					profiler_query.set_subquery_operators (subquery_operators)

					!! profiler_options
					profiler_options.set_output_names (clone (output_names))
					profiler_options.set_filenames (clone (filenames))
					profiler_options.set_language_names (clone (language_names))
	
					!! st.make
--					!! mp.set_watch_cursor
					!! executer.make (st, profiler_query, profiler_options)
					executer.execute
					tool.show_new_window (st, profiler_query, profiler_options, executer.last_output)
--					mp.restore
				else
					!! error_dialog.make_default (tool.container, "Error", message) --"Query_syntax")
--					error_dialog.set_message (message)
					error_dialog.show
				end
			end
		end

feature {NONE} -- Help message

	message: STRING is
		once
			!! Result.make(0)
			Result.append ("Please enter a correct query:%N%N")
			Result.append ("Examples:%N%N")
			Result.append ("	featurename = WORD.t*%N")
			Result.append ("	featurename < WORD.mak?%N")
			Result.append ("	calls > 2%N")
			Result.append ("	self <= 3.4%N")
			Result.append ("	descendants in 23 - 34%N")
			Result.append ("	total >= 12.3%N")
			Result.append ("	percentage /= 2%N")
			Result.append ("	calls > avg%N")
			Result.append ("	self <= max%N")
			Result.append ("	total > min%N%N")
			Result.append ("You can combine subqueries with 'and' and 'or', for example:%N%N")
			Result.append ("	calls > 2 and self <= 3.4 or percentage in 2.3 - 3.5")
		end

end -- class EB_RUN_PROFILE_QUERY_CMD
