indexing

	description:
		"Command to run a subquery from a PROFILE_QUERY_WINDOW";
	date: "$Date$";
	revision: "$Revision$"

class RUN_SUBQUERY_CMD

inherit
	COMMAND;
	SHARED_QUERY_VALUES

creation
	make

feature {NONE} -- Initialization

	make (a_tool: PROFILE_QUERY_WINDOW) is
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
			parser: QUERY_PARSER;
			txt: STRING;
			profiler_query: PROFILER_QUERY;
			st: STRUCTURED_TEXT;
			executer: E_SHOW_PROFILE_QUERY
			is_parsed: BOOLEAN
			operator: SUBQUERY_OPERATOR
		do
			txt := tool.subquery
			if txt /= Void and then not txt.empty then 
				clear_values;
				!! parser;
				if parser.parse (txt, Current) and then tool.profiler_query.subqueries.count > 0 then
					!! profiler_query;
					profiler_query.merge (tool.profiler_query)
					profiler_query.append_subqueries (subqueries)
					--|
					if tool.and_toggle.state then
						!! operator.make ( "and" )
						profiler_query.extend_subquery_operator ( operator )
					else
						!! operator.make ( "or" )
						profiler_query.extend_subquery_operator ( operator )
					end --| Guillaume - 09/23/97
					profiler_query.append_subquery_operators (subquery_operators)

					!! st.make;
					!! executer.make (st, profiler_query, tool.profiler_options);
					executer.set_last_output (tool.profinfo);
					executer.execute;
					tool.update_window (st, profiler_query, tool.profiler_options, executer.last_output)
				end
			elseif txt.empty and then tool.profiler_query.subqueries.count > 0 then
				clear_values
				!! profiler_query
				profiler_query.merge (tool.profiler_query)
				!! st.make;
				!! executer.make (st, profiler_query, tool.profiler_options)
				executer.set_last_output (tool.profinfo)
				executer.execute
				tool.update_window (st, profiler_query, tool.profiler_options, executer.last_output)
			end
		end

feature {NONE} -- Attributes

	tool: PROFILE_QUERY_WINDOW

end -- class RUN_SUBQUERY_CMD
