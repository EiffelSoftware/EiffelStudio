indexing

	description:
		"Command to run the query specified by the user.";
	date: "$Date$";
	revision: "$Revision$"

class RUN_PROFILE_QUERY_CMD

inherit
	SHARED_QUERY_VALUES;
	COMMAND

creation
	make


feature {NONE} -- Initialization

	make (a_tool: PROFILE_TOOL) is
			-- Create Current.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		end

feature {NONE} -- Attributes

	tool: PROFILE_TOOL
			-- The profile tool

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute Current command.
		local
			profiler_query: PROFILER_QUERY;
			profiler_options: PROFILER_OPTIONS;
			st: STRUCTURED_TEXT;
			executer: E_SHOW_PROFILE_QUERY
		do
			if arg = Void then
					--| Run the query
				clear_values;
				tool.fill_values (Current);
				!! profiler_query;
				profiler_query.set_subqueries (subqueries);
				profiler_query.set_subquery_operators (subquery_operators);

				!! profiler_options;
				profiler_options.set_output_names (clone (output_names));
				profiler_options.set_filenames (clone (filenames));
				profiler_options.set_language_names (clone (language_names));

				!! st.make;
				!! executer.make (st, profiler_query, profiler_options);
				executer.execute;
				tool.show_new_window (st, profiler_query, profiler_options, executer.last_output)
			end
		end

end -- class RUN_PROFILE_QUERY_CMD
