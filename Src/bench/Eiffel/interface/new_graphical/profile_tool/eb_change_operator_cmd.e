indexing

	description:
		"Command to change subquery operators of PROFILE_QUERY_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class EB_CHANGE_OPERATOR_CMD

inherit
	EV_COMMAND

creation
	make

feature -- Initialization

	make (a_query_window: EB_PROFILE_QUERY_WINDOW) is
			-- Create Current and set `query_window' to `a_query_window'.
		require
			a_query_window_not_void: a_query_window /= Void
		do
			query_window := a_query_window
		end

feature -- Command Execution

	execute (arg: EV_ARGUMENT1 [STRING]; data: EV_EVENT_DATA) is
			-- Execute Current
		local
			string_arg: STRING
			selected_subqueries: LINKED_LIST [EV_LIST_ITEM]
			selected_subquery: EB_SUBQUERY_ITEM
		do
			!! string_arg.make(0)
			string_arg := arg.first
			if query_window.active_query_window.count > 0 then
				from
					selected_subqueries ?= query_window.active_query_window.selected_items
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item
					check
						valid_entry: selected_subquery /= Void
					end
					if selected_subquery.index > 1 then
						query_window.all_operators.go_i_th (selected_subquery.index - 1)
						query_window.all_operators.item.change_operator (string_arg)
					end
					selected_subqueries.forth
				end
			end

			if query_window.inactive_subqueries_window.count > 0 then
				from
					selected_subqueries := query_window.inactive_subqueries_window.selected_items
					selected_subqueries.start
				until
					selected_subqueries.after
				loop
					selected_subquery ?= selected_subqueries.item
					check
						valid_entry: selected_subquery /= Void
					end	
					if selected_subquery.index > 1 then
						query_window.all_operators.go_i_th (selected_subquery.index - 1)
						query_window.all_operators.item.change_operator (string_arg)
					end
					selected_subqueries.forth
				end
			end

			query_window.update_query_form
		end

feature {NONE} -- Attributes

	query_window: EB_PROFILE_QUERY_WINDOW

end -- class EB_CHANGE_OPERATOR_CMD

