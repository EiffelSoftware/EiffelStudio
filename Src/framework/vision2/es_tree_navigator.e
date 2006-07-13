indexing
	description: "Tree navigation key shortcut support"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TREE_NAVIGATOR

feature -- Access

	expand_selected_rows_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to be performed when expanding rows retrieved from `selected_rows_function'.
			-- Default is `expand_rows'. Use `set_expand_selected_rows_agent' to attach new behavior to it.

	expand_selected_rows_recursive_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to be performed when recursively expanding rows retrieved from `selected_rows_function'.
			-- Default is `expand_rows'. Use `set_expand_selected_recursive_rows_agent' to attach new behavior to it.


	collapse_selected_rows_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to be performed when collapsing rows retrieved from `selected_rows_function'.
			-- Default is `collapse_rows'. Use `set_collapse_selected_rows_agent' to attach new behavior to it.

	collapse_selected_rows_recursive_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to be performed when recursively collapsing rows retrieved from `selected_rows_function'.
			-- Default is `collapse_rows'. Use `set_collapse_selected_recursive_rows_agent' to attach new behavior to it.

	key_shortcuts: HASH_TABLE [PROCEDURE [ANY, TUPLE], ES_KEY_SHORTCUT]
			-- Registered key shortcuts
			-- If a key combination occurred in current grid can trigger a shortcut,
			-- Action of that shortcut will be invoked.

feature -- Setting

	set_expand_selected_rows_agent (a_agent: like expand_selected_rows_agent) is
			-- Set `expand_selected_rows_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			expand_selected_rows_agent := a_agent
		ensure
			expand_selected_rows_agent_set: expand_selected_rows_agent = a_agent
		end

	set_expand_selected_rows_recursive_agent (a_agent: like expand_selected_rows_recursive_agent) is
			-- Set `expand_selected_rows_recursive_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			expand_selected_rows_recursive_agent := a_agent
		ensure
			expand_selected_rows_recursive_agent_set: expand_selected_rows_recursive_agent = a_agent
		end

	set_collapse_selected_rows_agent (a_agent: like collapse_selected_rows_agent) is
			-- Set `collapse_selected_rows_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			collapse_selected_rows_agent := a_agent
		ensure
			collapse_selected_rows_agent_set: collapse_selected_rows_agent = a_agent
		end

	set_collapse_selected_rows_recursive_agent (a_agent: like collapse_selected_rows_recursive_agent) is
			-- Set `collapse_selected_rows_recursive_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			collapse_selected_rows_recursive_agent := a_agent
		ensure
			collapse_selected_rows_recursive_agent_set: collapse_selected_rows_recursive_agent = a_agent
		end

	setup_tree_view_behavior (a_expand, a_expand_recursive, a_collapse, a_collapse_recursive: LIST [ES_KEY_SHORTCUT]) is
			-- Setup shortcut keys and their behavior for tree view navigation.
			-- `a_expand' is a list of shortcuts used to expand selected rows.
			-- `a_expand_recursive' is a list of shortcuts used to recursively expand selected rows.
			-- `a_collapse' is a list of shortcuts used to collapse selected rows.
			-- `a_collapse_recursive' is a list of shortcuts used to recursively collapse selected rows.
		deferred
		end

	register_shortcut (a_shortcut: ES_KEY_SHORTCUT; a_agent: PROCEDURE [ANY, TUPLE]) is
			-- Register `a_shortcut' with `a_agent' in current.
		require
			a_shortcut_attached: a_shortcut /= Void
			a_agent_attached: a_agent /= Void
		do
			key_shortcuts.force (a_agent, a_shortcut)
		ensure
			shortcut_registered: key_shortcuts.has (a_shortcut)
		end

	remove_shortcut (a_shortcut: ES_KEY_SHORTCUT) is
			-- Remove `a_shortcut' from current.
		require
			a_shortcut_attached: a_shortcut /= Void
		do
			if key_shortcuts.has (a_shortcut) then
				key_shortcuts.remove (a_shortcut)
			end
		ensure
			shortcut_removed: not key_shortcuts.has (a_shortcut)
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

invariant
	key_shortcuts_attached: key_shortcuts /= Void


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
