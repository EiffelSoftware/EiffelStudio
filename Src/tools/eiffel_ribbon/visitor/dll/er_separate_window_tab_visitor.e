note
	description: "[
					Different ribbon windows to different layout constructors
					vistor when using DLL
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SEPARATE_WINDOW_TAB_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_ribbon_tabs,
			visit_ribbon_application_menu
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do

		end

feature -- Command

	visit_ribbon_tabs (a_ribbon_tabs: ER_XML_TREE_ELEMENT; a_layout_constructor_index: INTEGER)
			-- <Precursor>
		do
			build_layout_constructors (a_layout_constructor_index)
		end

	visit_ribbon_application_menu (a_ribbon_application_menu: ER_XML_TREE_ELEMENT; a_layout_constructor_index: INTEGER)
			-- <Precursor>
		local
			l_ribbon_menu_groups: ARRAYED_LIST [EV_TREE_NODE]
			l_one_group: EV_TREE_NODE
			l_stop: BOOLEAN
		do
			l_ribbon_menu_groups := shared.layout_constructor_list.first.all_items_with (constants.menu_group)
			from
				l_ribbon_menu_groups.start
			until
				l_ribbon_menu_groups.after
			loop
				from
					l_stop := False
					l_one_group := l_ribbon_menu_groups.item
					l_one_group.start
				until
					l_one_group.after or l_stop
				loop
					if attached {ER_TREE_NODE_BUTTON_DATA} l_one_group.item.data as l_data then
						if l_data.application_mode /= 0 then
							l_stop := True
							move_menu_group_to_other_window (l_one_group, l_data.application_mode)
						end
					end
					if not l_stop then
						l_one_group.forth
					end
				end

				l_ribbon_menu_groups.forth
			end
		end

feature {NONE} -- Implementation

	move_menu_group_to_other_window (a_menu_group: EV_TREE_NODE; a_target_application_mode: INTEGER)
			-- Move menu group to differnt ribbon layout constructors
		require
			only_for_other_window: a_target_application_mode /= 0
		local
			l_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
			l_target: ER_LAYOUT_CONSTRUCTOR
			l_root: ARRAYED_LIST [EV_TREE_NODE]
			l_new_root: EV_TREE_NODE
		do
			l_list := shared.layout_constructor_list
			if l_list.valid_index (a_target_application_mode + 1) then
				if attached a_menu_group.parent as l_parent then
					l_parent.prune_all (a_menu_group)
				end

				l_target := l_list.i_th (a_target_application_mode + 1)
				l_root := l_target.all_items_with (constants.ribbon_application_menu)
				if l_root.count = 0 then
					l_new_root := l_target.tree_item_factory_method (constants.ribbon_application_menu)
					l_target.widget.extend (l_new_root)

					l_new_root.extend (a_menu_group)
				else
					check l_root.count = 1 end
					l_root.first.extend (a_menu_group)
				end

				l_target.expand_tree
			end

		end

	build_layout_constructors (a_layout_constructor_index: INTEGER)
			-- Build layout constructors for different ribbon windows
		local
			l_layout_constructor: ER_LAYOUT_CONSTRUCTOR
			l_application_menu: detachable EV_TREE_NODE
		do

			l_layout_constructor := shared.layout_constructor_list.i_th (a_layout_constructor_index)
			l_application_menu := record_application_menu (a_layout_constructor_index)
			separate_application_menu (l_application_menu, a_layout_constructor_index)
			l_layout_constructor.expand_tree

			if a_layout_constructor_index <= 1 then -- Only build new layout constructors when using ApplicationMode for separated ribbons

			end
		end

	record_application_menu (a_layout_constructor_index: INTEGER): detachable EV_TREE_NODE
			-- Find out application menu with `a_layout_constructor_index'
		local
			l_layout_constructor: ER_LAYOUT_CONSTRUCTOR
		do
			-- Add application menu to first
			-- FIXME: what about application menu for other windows?
			if shared.layout_constructor_list.i_th (a_layout_constructor_index).widget.valid_index (2) and then
				attached shared.layout_constructor_list.i_th (a_layout_constructor_index).widget.i_th (2) as l_application_menu then
				if attached l_application_menu.parent as l_parent then
					l_parent.prune_all (l_application_menu)
				end
				l_layout_constructor := shared.layout_constructor_list.i_th (a_layout_constructor_index)
				Result := l_application_menu
			end
		end

	separate_application_menu (a_application_menu: detachable EV_TREE_NODE; a_layout_constructor_index: INTEGER)
			-- Move application menu `a_application_menu' to applcation menu which index is `a_layout_constructor_index'
		local
			l_layout_constructor: ER_LAYOUT_CONSTRUCTOR
		do
			if attached a_application_menu as l_application_menu then
				l_layout_constructor := shared.layout_constructor_list.i_th (a_layout_constructor_index)
				remove_application_menu_node (a_application_menu)
				if not is_application_menu_empty (l_application_menu) then
					l_layout_constructor.widget.extend (l_application_menu)
					l_layout_constructor.expand_tree
				end
			end
		end

	remove_application_menu_node (a_application_menu: EV_TREE_NODE)
			-- Remove ApplicationMenu node, move its items to upper level Ribbon.ApplicationMenu
		require
			not_void: a_application_menu /= Void
			valid: a_application_menu.text.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu)
		local
			l_iterator: INDEXABLE_ITERATION_CURSOR [EV_TREE_NODE]
			l_item: EV_TREE_NODE
			l_items: ARRAYED_LIST [EV_TREE_NODE]
		do
--			check a_application_menu.count = 1 end
			if a_application_menu.valid_index (1) and then
				attached a_application_menu.i_th (1) as l_ribbon_menu then
				a_application_menu.wipe_out

				from
					create l_items.make (l_ribbon_menu.count)
					l_iterator := l_ribbon_menu.new_cursor
					l_iterator.start
				until
					l_iterator.after
				loop
					l_items.extend (l_iterator.item)

					l_iterator.forth
				end

				from
					l_items.start
				until
					l_items.after
				loop
					l_item := l_items.item
					if attached l_item.parent as l_parent then
						l_parent.prune_all (l_item)
					end

					if l_item.text.same_string ({ER_XML_CONSTANTS}.application_menu_recent_items) then
						-- Remove recent items node
					else
						a_application_menu.extend (l_item)
					end

					l_items.forth
				end

			end
		end

	is_application_menu_empty (a_application_menu: EV_TREE_NODE): BOOLEAN
			-- Is application menu empty?
		require
			not_void: a_application_menu /= Void
		local
			l_child: EV_TREE_NODE
		do
			if a_application_menu.count = 1 then
				l_child := a_application_menu.first
				if l_child.count = 0 then
					Result := True
				end
			elseif a_application_menu.count = 0 then
				Result := True
			else
				check not_possible: False end
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
