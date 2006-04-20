indexing

	description:
		"Command to run the query from a PROFILE_QUERY_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RUN_QUERY_CMD

inherit
	EV_COMMAND
	SHARED_QUERY_VALUES

create
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
			executer: E_SHOW_PROFILE_QUERY
--			mp: MOUSE_PTR
		do
			query_window.update_profiler_query
			create profiler_query
			profiler_query.merge (query_window.profiler_query)
			if profiler_query.subqueries.count > 0 then
	--			create mp.set_watch_cursor
				create executer.make_simple (profiler_query, query_window.profiler_options)
				executer.set_last_output (query_window.profinfo)
				executer.execute
				query_window.update_window (profiler_query, query_window.profiler_options, executer.last_output)
	--			mp.restore
			end
		end

feature {NONE} -- Attributes

	query_window: EB_PROFILE_QUERY_WINDOW;
		-- The window where query results will be displayed.

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

end -- class EB_RUN_QUERY_CMD
