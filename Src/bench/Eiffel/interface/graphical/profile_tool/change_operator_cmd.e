indexing

	description:
		"Command to change subquery operators of PROFILE_QUERY_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CHANGE_OPERATOR_CMD

inherit
	COMMAND;

create
	make

feature -- Initialization

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
			string_arg: STRING
			selected_subqueries: LINKED_LIST [SCROLLABLE_LIST_ELEMENT]
			selected_subquery: SCROLLABLE_SUBQUERY
		do
			create string_arg.make(0)
			string_arg ?= arg
			if tool.active_query_window.selected_count > 0 then
				from
					selected_subqueries ?= tool.active_query_window.selected_items
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item
					check
						valid_entry: selected_subquery /= Void
					end
					if selected_subquery.index > 1 then
						tool.all_operators.go_i_th (selected_subquery.index - 1)
						tool.all_operators.item.change_operator (string_arg)
					end
					selected_subqueries.forth
				end
			end

			if tool.inactive_subqueries_window.selected_count > 0 then
				from
					selected_subqueries := tool.inactive_subqueries_window.selected_items
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item
					check
						valid_entry: selected_subquery /= Void
					end	
					if selected_subquery.index > 1 then
						tool.all_operators.go_i_th (selected_subquery.index - 1)
						tool.all_operators.item.change_operator (string_arg)
					end
					selected_subqueries.forth
				end
			end

			tool.update_query_form
		end

feature {NONE} -- Attributes

	tool: PROFILE_QUERY_WINDOW;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ADD_SUBQUERY_CMD

