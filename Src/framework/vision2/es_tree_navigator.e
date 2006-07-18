indexing
	description: "Tree navigation key shortcut support"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TREE_NAVIGATOR

inherit
	ES_KEY_POOL

feature -- Access

	expand_selected_rows_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent to be performed when expanding rows retrieved from `selected_rows_function'.
			-- Use `set_expand_selected_rows_agent' to attach behavior to it.			
		do
			Result := key_action (expand_node_action_index)
		end

	expand_selected_rows_recursive_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent to be performed when recursively expanding rows retrieved from `selected_rows_function'.
			-- Use `set_expand_selected_recursive_rows_agent' to attach behavior to it.
		do
			Result := key_action (expand_node_recursive_action_index)
		end

	collapse_selected_rows_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to be performed when collapsing rows retrieved from `selected_rows_function'.
			-- Use `set_collapse_selected_rows_agent' to attach behavior to it.
		do
			Result := key_action (collapse_node_action_index)
		end

	collapse_selected_rows_recursive_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent to be performed when recursively collapsing rows retrieved from `selected_rows_function'.
			-- Use `set_collapse_selected_recursive_rows_agent' to attach behavior to it.
		do
			Result := key_action (collapse_node_recursive_action_index)
		end

feature -- Setting

	set_expand_selected_rows_agent (a_agent: like expand_selected_rows_agent) is
			-- Set `expand_selected_rows_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			add_key_action (a_agent, expand_node_action_index)
		end

	set_expand_selected_rows_recursive_agent (a_agent: like expand_selected_rows_recursive_agent) is
			-- Set `expand_selected_rows_recursive_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			add_key_action (a_agent, expand_node_recursive_action_index)
		end

	set_collapse_selected_rows_agent (a_agent: like collapse_selected_rows_agent) is
			-- Set `collapse_selected_rows_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			add_key_action (a_agent, collapse_node_action_index)
		end

	set_collapse_selected_rows_recursive_agent (a_agent: like collapse_selected_rows_recursive_agent) is
			-- Set `collapse_selected_rows_recursive_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			add_key_action (a_agent, collapse_node_recursive_action_index)
		end

	enable_default_tree_navigation_behavior (a_expand, a_expand_recursive, a_collapse, a_collapse_recursive: BOOLEAN) is
			-- Enable default tree navigation behavior.
			-- `a_expand' indicates if expanding a node should be enabled.
			-- `a_expand_recursive' indicates if expanding a node recursively should be enabled.
			-- `a_collapse' indicates if collapsing a node should be enabled.
			-- `a_collapse_recursive' indicates if collapsing a node recursively should be enabled.
		deferred
		end

feature -- Access

	default_expand_rows_shortcuts: ARRAYED_LIST [ES_KEY_SHORTCUT] is
			-- List of shortcuts used to expand selected rows
		once
			create Result.make (2)
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_numpad_add), False, False, False))
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_right), False, False, False))
		ensure
			result_attached: Result /= Void
		end

	default_expand_rows_recursive_shortcuts: ARRAYED_LIST [ES_KEY_SHORTCUT] is
			-- List of shortcuts used to recursively expand selected rows
		once
			create Result.make (1)
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_numpad_multiply), False, False, False))
		ensure
			result_attached: Result /= Void
		end

	default_collapse_rows_shortcuts: ARRAYED_LIST [ES_KEY_SHORTCUT] is
			-- List of shortcuts used to expand selected rows
		once
			create Result.make (2)
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_numpad_subtract), False, False, False))
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_left), False, False, False))
		ensure
			result_attached: Result /= Void
		end

	default_collapse_rows_recursive_shortcuts: ARRAYED_LIST [ES_KEY_SHORTCUT] is
			-- List of shortcuts used to recursively expand selected rows
		once
			create Result.make (2)
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_numpad_divide), False, False, False))
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	expand_node_action_index: INTEGER is 1
			-- Action index for expand a node

	expand_node_recursive_action_index: INTEGER is 2
			-- Action index for expand a node recursively

	collapse_node_action_index: INTEGER is 3
			-- Action index for collapse a node

	collapse_node_recursive_action_index: INTEGER is 4;
			-- Action index for collapse a node recursively

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

end
