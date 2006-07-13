indexing
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

	initialize is
			-- Mark `Current' as initialized.
			-- This must be called during the creation procedure
			-- to satisfy the `is_initialized' invariant.
			-- Descendants may redefine initialize to perform
			-- additional setup tasks.
		do
			Precursor
			create key_shortcuts.make (10)
			set_expand_selected_rows_agent (agent expand_selected_item (False))
			set_expand_selected_rows_recursive_agent (agent expand_selected_item (True))
			set_collapse_selected_rows_agent (agent collapse_selected_item (False))
			set_collapse_selected_rows_recursive_agent (agent collapse_selected_item (True))
			key_press_actions.extend (agent on_key_pressed)
		ensure then
			key_shortcuts_attached: key_shortcuts /= Void
		end

feature -- Setting

	setup_tree_view_behavior (a_expand, a_expand_recursive, a_collapse, a_collapse_recursive: LIST [ES_KEY_SHORTCUT]) is
			-- Setup shortcut keys and their behavior for tree view navigation.
			-- `a_expand' is a list of shortcuts used to expand selected rows.
			-- `a_expand_recursive' is a list of shortcuts used to recursively expand selected rows.
			-- `a_collapse' is a list of shortcuts used to collapse selected rows.
			-- `a_collapse_recursive' is a list of shortcuts used to recursively collapse selected rows.
		do
			if a_expand /= Void and then not a_expand.is_empty then
				a_expand.do_all (agent register_shortcut (?, agent on_expand_item (False)))
			end
			if a_expand_recursive /= Void and then not a_expand_recursive.is_empty then
				a_expand_recursive.do_all (agent register_shortcut (?, agent on_expand_item (True)))
			end
			if a_collapse /= Void and then not a_collapse.is_empty then
				a_collapse.do_all (agent register_shortcut (?, agent on_collapse_item (False)))
			end
			if a_collapse_recursive /= Void and then not a_collapse_recursive.is_empty then
				a_collapse_recursive.do_all (agent register_shortcut (?, agent on_collapse_item (True)))
			end
		end

feature {NONE} -- Actions

	on_key_pressed (a_key: EV_KEY) is
			-- Action to be performed when `a_key' is presses in Current
		local
			l_ev_application: like ev_application
			l_agent: PROCEDURE [ANY, TUPLE]
		do
			l_ev_application := ev_application
			l_agent := key_shortcuts.item (create {ES_KEY_SHORTCUT}.make_with_key_combination (a_key, l_ev_application.ctrl_pressed, l_ev_application.alt_pressed, l_ev_application.shift_pressed))
			if l_agent /= Void then
				l_agent.call ([])
			end
		end

	on_expand_item (a_recursive: BOOLEAN) is
			-- Action to be performed when expanding selected item.
		do
			if not a_recursive then
				if expand_selected_rows_agent /= Void then
					expand_selected_rows_agent.call ([])
				end
			else
				if expand_selected_rows_recursive_agent /= Void then
					expand_selected_rows_recursive_agent.call ([])
				end
			end
		end

	on_collapse_item (a_recursive: BOOLEAN) is
			-- Action to be performed when collapsing selected item.
		do
			if not a_recursive then
				if collapse_selected_rows_agent /= Void then
					collapse_selected_rows_agent.call ([])
				end
			else
				if collapse_selected_rows_recursive_agent /= Void then
					collapse_selected_rows_recursive_agent.call ([])
				end
			end
		end

feature {NONE} -- Tree view behavior

	expand_selected_item (a_recursive: BOOLEAN) is
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

	collapse_selected_item (a_recursive: BOOLEAN) is
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

	expand_item (a_item: EV_TREE_NODE; a_recursive: BOOLEAN) is
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

	collapse_item (a_item: EV_TREE_NODE; a_recursive: BOOLEAN) is
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
