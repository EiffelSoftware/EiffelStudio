indexing

	description:
		"Command to run the query specified by the user."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class RUN_PROFILE_QUERY_CMD

inherit
	SHARED_QUERY_VALUES;
	COMMAND

create
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
			error_dialog: MESSAGE_WINDOW
			mp: MOUSE_PTR
		do
			if arg = Void then
					--| Run the query
				clear_values;
				if tool.fill_values (Current) then
					create profiler_query;
					profiler_query.set_subqueries (subqueries);
					profiler_query.set_subquery_operators (subquery_operators);

					create profiler_options;
					profiler_options.set_output_names (clone (output_names));
					profiler_options.set_filenames (clone (filenames));
					profiler_options.set_language_names (clone (language_names));
	
					create st.make;
					create mp.set_watch_cursor
					create executer.make (st, profiler_query, profiler_options);
					executer.execute;
					tool.show_new_window (st, profiler_query, profiler_options, executer.last_output)
					mp.restore
				else
					create error_dialog.make ("Query_syntax", tool)
					error_dialog.set_message (message)
					error_dialog.popup
				end
			end
		end

feature {NONE} -- Help message

	message: STRING is
		once
			create Result.make(0)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class RUN_PROFILE_QUERY_CMD
