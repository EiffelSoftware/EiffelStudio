note
	description: "Tree navigation key shortcut support"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TREE_NAVIGATOR

feature -- Shortcut/Status report

	is_shortcut_registered (a_shortcut: ES_KEY_SHORTCUT): BOOLEAN
			-- Is `a_shortcut' registered?
		require
			a_shortcut_attached: a_shortcut /= Void
		do
			Result := key_table.has (a_shortcut)
		end

feature -- Shortcut/Access

	shortcut_actions (a_shortcut: ES_KEY_SHORTCUT): detachable LIST [PROCEDURE]
			-- Trigger agent for `a_shortcut'
			-- Void if no agent is registered for `a_shortcut'.
		do
			Result := key_table.item (a_shortcut)
		ensure
			good_result: is_shortcut_registered (a_shortcut) implies Result /= Void
		end

feature -- Call

	call_shortcut_actions (a_shortcut: ES_KEY_SHORTCUT)
			-- Call registered actions for `a_shortcut'.
		require
			a_shortcut_attached: a_shortcut /= Void
			a_shortcut_registered: is_shortcut_registered (a_shortcut)
		do
			if attached shortcut_actions (a_shortcut) as l_agent_list then
				from
					l_agent_list.start
				until
					l_agent_list.after
				loop
					l_agent_list.item.call (Void)
					l_agent_list.forth
				end
			end
		end

feature -- Shortcut/Register key shortcuts

	register_shortcut (a_shortcut: ES_KEY_SHORTCUT; a_agent: PROCEDURE)
			-- Register `a_agent' for `a_shortcut'.
		require
			a_shortcut_attached: a_shortcut /= Void
			a_agent_attached: a_agent /= Void
		local
			l_agent_list: detachable LIST [PROCEDURE]
		do
			if key_table.has_key (a_shortcut) then
				l_agent_list := key_table.found_item
				check found_item: l_agent_list /= Void end
			else
				create {LINKED_LIST [PROCEDURE]} l_agent_list.make
				key_table.put (l_agent_list, a_shortcut)
			end
			if l_agent_list /= Void then
				l_agent_list.extend (a_agent)
			else
				check found_agent_list: False end
			end
		ensure
			shortcut_registered: is_shortcut_registered (a_shortcut) and then
						attached shortcut_actions (a_shortcut) as l_acts and then
						l_acts.has (a_agent)
		end

	deregister_shortcut (a_shortcut: ES_KEY_SHORTCUT)
			-- Remove registered shortcut key along with its trigger agent.
		require
			a_shortcut_attached: a_shortcut /= Void
			a_shortcut_registered: is_shortcut_registered (a_shortcut)
		do
			key_table.remove (a_shortcut)
		ensure
			shortcut_deregistered: not is_shortcut_registered (a_shortcut)
		end

feature -- Access

	expand_selected_rows_agent: detachable PROCEDURE
			-- Agent to be performed when expanding rows retrieved from `selected_rows_function'.			

	expand_selected_rows_recursive_agent: detachable PROCEDURE
			-- Agent to be performed when recursively expanding rows retrieved from `selected_rows_function'.		

	collapse_selected_rows_agent: detachable PROCEDURE
			-- Agent to be performed when collapsing rows retrieved from `selected_rows_function'.

	collapse_selected_rows_recursive_agent: detachable PROCEDURE
			-- Agent to be performed when recursively collapsing rows retrieved from `selected_rows_function'.

feature -- Setting

	set_expand_selected_rows_agent (a_agent: like expand_selected_rows_agent)
			-- Set `expand_selected_rows_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			expand_selected_rows_agent := a_agent
		ensure
			expand_selected_rows_agent_set: expand_selected_rows_agent = a_agent
		end

	set_expand_selected_rows_recursive_agent (a_agent: like expand_selected_rows_recursive_agent)
			-- Set `expand_selected_rows_recursive_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			expand_selected_rows_recursive_agent := a_agent
		ensure
			expand_selected_rows_recursive_agent_set: expand_selected_rows_recursive_agent = a_agent
		end

	set_collapse_selected_rows_agent (a_agent: like collapse_selected_rows_agent)
			-- Set `collapse_selected_rows_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			collapse_selected_rows_agent := a_agent
		ensure
			collapse_selected_rows_agent_set: collapse_selected_rows_agent = a_agent
		end

	set_collapse_selected_rows_recursive_agent (a_agent: like collapse_selected_rows_recursive_agent)
			-- Set `collapse_selected_rows_recursive_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			collapse_selected_rows_recursive_agent := a_agent
		ensure
			collapse_selected_rows_recursive_agent_set: collapse_selected_rows_recursive_agent = a_agent
		end

	enable_default_tree_navigation_behavior (a_expand, a_expand_recursive, a_collapse, a_collapse_recursive: BOOLEAN)
			-- Enable default tree navigation behavior.
			-- `a_expand' indicates if expanding a node should be enabled.
			-- `a_expand_recursive' indicates if expanding a node recursively should be enabled.
			-- `a_collapse' indicates if collapsing a node should be enabled.
			-- `a_collapse_recursive' indicates if collapsing a node recursively should be enabled.
		deferred
		end

feature -- Access

	default_expand_rows_shortcuts: ARRAYED_LIST [ES_KEY_SHORTCUT]
			-- List of shortcuts used to expand selected rows
		once
			create Result.make (2)
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_numpad_add), False, False, False))
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_right), False, False, False))
		ensure
			result_attached: Result /= Void
		end

	default_expand_rows_recursive_shortcuts: ARRAYED_LIST [ES_KEY_SHORTCUT]
			-- List of shortcuts used to recursively expand selected rows
		once
			create Result.make (1)
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_numpad_multiply), False, False, False))
		ensure
			result_attached: Result /= Void
		end

	default_collapse_rows_shortcuts: ARRAYED_LIST [ES_KEY_SHORTCUT]
			-- List of shortcuts used to expand selected rows
		once
			create Result.make (2)
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_numpad_subtract), False, False, False))
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_left), False, False, False))
		ensure
			result_attached: Result /= Void
		end

	default_collapse_rows_recursive_shortcuts: ARRAYED_LIST [ES_KEY_SHORTCUT]
			-- List of shortcuts used to recursively expand selected rows
		once
			create Result.make (2)
			Result.extend (create {ES_KEY_SHORTCUT}.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_numpad_divide), False, False, False))
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Shortcut/Implementation

	key_table: HASH_TABLE [LIST [PROCEDURE], ES_KEY_SHORTCUT]
			-- Table of actions to be performed indexed by the key shortcut to trigger that action
		local
			l_key_table_internal: like key_table_internal
		do
			l_key_table_internal := key_table_internal
			if l_key_table_internal = Void then
				create l_key_table_internal.make (10)
				key_table_internal := l_key_table_internal
			end
			Result := l_key_table_internal
		ensure
			result_attached: Result /= Void
		end

	key_table_internal: detachable like key_table;
			-- Implementation of `key_table'	

note
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

