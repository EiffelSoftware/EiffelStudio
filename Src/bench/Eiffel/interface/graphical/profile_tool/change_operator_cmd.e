indexing

	description:
		"Command to change subquery operators of PROFILE_QUERY_WINDOW";
	date: "$Date$";
	revision: "$Revision$"

class CHANGE_OPERATOR_CMD

inherit
	COMMAND;

creation
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
			!! string_arg.make(0)
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

	tool: PROFILE_QUERY_WINDOW

end -- class ADD_SUBQUERY_CMD

