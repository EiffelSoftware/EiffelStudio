note
	description: "Objects that represents a enhanced EV_TREE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TREE

inherit
	EV_TREE
		redefine
			initialize
		end

	ES_TREE_NAVIGATOR
		undefine
			default_create,
			copy,
			is_equal
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy,
			is_equal
		end

create
	default_create

feature{NONE} -- Initialization

	initialize
			-- Mark `Current' as initialized.
			-- This must be called during the creation procedure
			-- to satisfy the `is_initialized' invariant.
			-- Descendants may redefine initialize to perform
			-- additional setup tasks.
		do
			Precursor
			key_press_actions.extend (agent on_key_pressed)
		end

feature -- Setting

	enable_default_tree_navigation_behavior (a_expand, a_expand_recursive, a_collapse, a_collapse_recursive: BOOLEAN)
			-- Enable default tree navigation behavior.
			-- `a_expand' indicates if expanding a node should be enabled.
			-- `a_expand_recursive' indicates if expanding a node recursively should be enabled.
			-- `a_collapse' indicates if collapsing a node should be enabled.
			-- `a_collapse_recursive' indicates if collapsing a node recursively should be enabled.
		local
			l_expand_selected_rows_agent: like expand_selected_rows_agent
			l_expand_selected_rows_recursive_agent: like expand_selected_rows_recursive_agent
			l_collapse_selected_rows_agent: like collapse_selected_rows_agent
			l_collapse_selected_rows_recursive_agent: like collapse_selected_rows_recursive_agent
		do
			if a_expand then
				l_expand_selected_rows_agent := expand_selected_rows_agent
				if l_expand_selected_rows_agent = Void then
					l_expand_selected_rows_agent := agent expand_selected_item (False)
					set_expand_selected_rows_agent (l_expand_selected_rows_agent)
				end
				default_expand_rows_shortcuts.do_all (agent register_shortcut (?, l_expand_selected_rows_agent))
			end
			if a_expand_recursive then
				l_expand_selected_rows_recursive_agent := expand_selected_rows_recursive_agent
				if l_expand_selected_rows_recursive_agent = Void then
					l_expand_selected_rows_recursive_agent := agent expand_selected_item (True)
					set_expand_selected_rows_recursive_agent (l_expand_selected_rows_recursive_agent)
				end
				default_expand_rows_recursive_shortcuts.do_all (agent register_shortcut (?, l_expand_selected_rows_recursive_agent))
			end
			if a_collapse then
				l_collapse_selected_rows_agent := collapse_selected_rows_agent
				if l_collapse_selected_rows_agent = Void then
					l_collapse_selected_rows_agent := agent collapse_selected_item (False)
					set_collapse_selected_rows_agent (l_collapse_selected_rows_agent)
				end
				default_collapse_rows_shortcuts.do_all (agent register_shortcut (?, l_collapse_selected_rows_agent))
			end
			if a_collapse_recursive then
				l_collapse_selected_rows_recursive_agent := collapse_selected_rows_recursive_agent
				if l_collapse_selected_rows_recursive_agent = Void then
					l_collapse_selected_rows_recursive_agent := agent collapse_selected_item (True)
					set_collapse_selected_rows_recursive_agent (l_collapse_selected_rows_recursive_agent)
				end
				default_collapse_rows_recursive_shortcuts.do_all (agent register_shortcut (?, l_collapse_selected_rows_recursive_agent))
			end
		end

feature {NONE} -- Actions

	on_key_pressed (a_key: EV_KEY)
			-- Action to be performed when `a_key' is pressed in Current
		local
			l_ev_application: like ev_application
			l_shortcut: ES_KEY_SHORTCUT
		do
			l_ev_application := ev_application
			create l_shortcut.make_with_key_combination (
					a_key,
					l_ev_application.ctrl_pressed,
					l_ev_application.alt_pressed,
					l_ev_application.shift_pressed
			)
			if is_shortcut_registered (l_shortcut) then
				call_shortcut_actions (l_shortcut)
			end
		end

	on_expand_item (a_recursive: BOOLEAN)
			-- Action to be performed when expanding selected item.
		do
			if not a_recursive then
				if attached expand_selected_rows_agent as agt then
					agt.call (Void)
				end
			else
				if attached expand_selected_rows_recursive_agent as agt then
					agt.call (Void)
				end
			end
		end

	on_collapse_item (a_recursive: BOOLEAN)
			-- Action to be performed when collapsing selected item.
		do
			if not a_recursive then
				if attached collapse_selected_rows_agent as agt then
					agt.call (Void)
				end
			else
				if attached collapse_selected_rows_recursive_agent as agt then
					agt.call (Void)
				end
			end
		end

feature {NONE} -- Tree view behavior

	expand_selected_item (a_recursive: BOOLEAN)
			-- Expand `selected_item'.
			-- If `a_recursive' is True, recursively expand the item.
		local
			l_item: like selected_item
		do
			l_item := selected_item
			if l_item /= Void then
				expand_item (l_item, a_recursive)
			end
		end

	collapse_selected_item (a_recursive: BOOLEAN)
			-- Collapse `selected_item'.
			-- If `a_recursive' is True, recursively collapse the item.
		local
			l_item: like selected_item
		do
			l_item := selected_item
			if l_item /= Void then
				collapse_item (l_item, a_recursive)
			end
		end

	expand_item (a_item: EV_TREE_NODE; a_recursive: BOOLEAN)
			-- Expand `a_item'.
			-- If `a_recursive' is True, recursively expand all subrows of `a_item'.
		require
			a_item_parented: a_item.parent_tree = Current
		local
			l_cursor: CURSOR
		do
			if a_item.is_expandable and then not a_item.is_expanded then
				a_item.expand
				if a_recursive and then a_item.count > 0 then
					l_cursor := a_item.cursor
					from
						a_item.start
					until
						a_item.after
					loop
						expand_item (a_item.item, a_recursive)
						a_item.forth
					end
					a_item.go_to (l_cursor)
				end
			end
		end

	collapse_item (a_item: EV_TREE_NODE; a_recursive: BOOLEAN)
			-- Collapse `a_item'.
			-- If `a_recursive' is True, recursively collapse all subrows of `a_item'.
		require
			a_item_parented: a_item.parent_tree = Current
		local
			l_cursor: CURSOR
		do
			if a_item.is_expandable and then a_item.is_expanded then
				a_item.collapse
				if a_recursive and then a_item.count > 0 then
					l_cursor := a_item.cursor
					from
						a_item.start
					until
						a_item.after
					loop
						collapse_item (a_item.item, a_recursive)
						a_item.forth
					end
					a_item.go_to (l_cursor)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
