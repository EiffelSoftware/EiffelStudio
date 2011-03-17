note
	description: "Summary description for {ER_SEPARATE_WINDOW_TAB_VISITOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SEPARATE_WINDOW_TAB_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_ribbon_tabs
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create application_modes.make
		end

feature -- Command

	visit_ribbon_tabs (a_ribbon_tabs: ER_XML_TREE_ELEMENT)
			--
		local
			l_root_items: ARRAYED_LIST [EV_TREE_ITEM]
			l_ribbon_tabs: ARRAYED_LIST [EV_TREE_NODE]
		do
				-- First find out how many application modes
			find_out_total_application_modes (a_ribbon_tabs)
				-- Prepare root node Ribbon.Tabs for each ribbon
			l_root_items := prepare_root_nodes
				-- Separate application mode to different ribbon_tabs
			l_ribbon_tabs := shared.layout_constructor_list.first.all_items_with (constants.ribbon_tabs)
			check l_ribbon_tabs.count = 1 end
			separate_different_ribbon_tabs (l_root_items, l_ribbon_tabs.first)

			build_layout_constructors (l_root_items)
		end

feature {NONE} -- Implementation

	separate_different_ribbon_tabs (a_root_ribbon_tabs: ARRAYED_LIST [EV_TREE_ITEM]; a_ribbon_tabs: EV_TREE_NODE)
			--
		local
			l_ribbon_item: EV_TREE_NODE
			l_search_result: INTEGER
			l_ribbon_tabs: detachable EV_TREE_ITEM
		do
					-- Separate application mode to different ribbon_tabs
			from
				a_ribbon_tabs.start
			until
				a_ribbon_tabs.after
			loop
				l_ribbon_item := a_ribbon_tabs.item
				if attached l_ribbon_item.parent as l_parent then
					l_parent.prune_all (l_ribbon_item)
				else
					check False end
				end
				a_ribbon_tabs.start

				if attached {ER_TREE_NODE_TAB_DATA} l_ribbon_item.data as l_tab_data then
					l_search_result := application_modes.index_of  (l_tab_data.application_mode, 1)
					check l_search_result /= 0 end
					l_ribbon_tabs := a_root_ribbon_tabs.i_th (l_search_result)
					l_ribbon_tabs.extend (l_ribbon_item)
				else
					-- No data, put to default
					a_root_ribbon_tabs.first.extend (l_ribbon_item)
				end

--				a_ribbon_tabs.forth
			end
		end

	find_out_total_application_modes (a_ribbon_tabs: ER_XML_TREE_ELEMENT)
			-- Find out how many application modes
		require
			not_void: a_ribbon_tabs /= Void
			valid: a_ribbon_tabs.name.same_string ({ER_XML_CONSTANTS}.ribbon_tabs)
		do
			from
				application_modes.wipe_out
				application_modes.extend (0) -- default application mode
				a_ribbon_tabs.start
			until
				a_ribbon_tabs.after
			loop
				if attached {ER_XML_TREE_ELEMENT} a_ribbon_tabs.item_for_iteration as l_group then
					from
						l_group.start
					until
						l_group.after
					loop
						if attached {XML_ATTRIBUTE} l_group.item_for_iteration as l_group_attribute then
							if l_group_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.application_mode) then
								if not application_modes.has (l_group_attribute.value.to_integer) then
									application_modes.extend (l_group_attribute.value.to_integer)
								end
							end
						end
						l_group.forth
					end

				end

				a_ribbon_tabs.forth
			end
		end

	application_modes: SORTED_TWO_WAY_LIST [INTEGER]
			--

	prepare_root_nodes: ARRAYED_LIST [EV_TREE_ITEM]
			--
		local
			l_ribbon_tabs: detachable EV_TREE_ITEM
		do
			create Result.make (application_modes.count)
			from
				application_modes.start
			until
				application_modes.after
			loop
				l_ribbon_tabs := shared.layout_constructor_list.first.tree_item_factory_method ({ER_XML_CONSTANTS}.ribbon_tabs)
				Result.extend (l_ribbon_tabs)

				application_modes.forth
			end
		end

	build_layout_constructors (a_root_ribbon_tabs: ARRAYED_LIST [EV_TREE_NODE])
			--
		require
			not_void: a_root_ribbon_tabs /= Void
		local
			l_layout_constructor: ER_LAYOUT_CONSTRUCTOR
			l_application_menu: detachable EV_TREE_NODE
		do
			check a_root_ribbon_tabs.count >= 1 end

			l_layout_constructor := shared.layout_constructor_list.first
			l_application_menu := record_application_menu
			l_layout_constructor.widget.wipe_out
			l_layout_constructor.widget.extend (a_root_ribbon_tabs.first)
			separate_application_menu (l_application_menu)
			l_layout_constructor.expand_tree

			if a_root_ribbon_tabs.count > 1 then
				-- Need to create new layout constructors
				from
					a_root_ribbon_tabs.go_i_th (2)
				until
					a_root_ribbon_tabs.after
				loop
					if attached shared.main_window_cell.item as l_win then
						l_win.new_ribbon_command.execute

						l_layout_constructor := shared.layout_constructor_list.i_th (a_root_ribbon_tabs.index)
						l_layout_constructor.widget.wipe_out
						l_layout_constructor.widget.extend (a_root_ribbon_tabs.item)
						l_layout_constructor.expand_tree
					end

					a_root_ribbon_tabs.forth
				end
			end
		end

	record_application_menu: detachable EV_TREE_NODE
			--
		local
			l_layout_constructor: ER_LAYOUT_CONSTRUCTOR
		do
			-- Add application menu to first
			-- FIXME: what about application menu for other windows?
			if shared.layout_constructor_list.first.widget.valid_index (2) and then
				attached shared.layout_constructor_list.first.widget.i_th (2) as l_application_menu then
				if attached l_application_menu.parent as l_parent then
					l_parent.prune_all (l_application_menu)
				end
				l_layout_constructor := shared.layout_constructor_list.first
				Result := l_application_menu
			end
		end

	separate_application_menu (a_application_menu: detachable EV_TREE_NODE)
			--
		local
			l_layout_constructor: ER_LAYOUT_CONSTRUCTOR
		do
			if attached a_application_menu as l_application_menu then
				l_layout_constructor := shared.layout_constructor_list.first
				remove_application_menu_node (a_application_menu)
				l_layout_constructor.widget.extend (l_application_menu)
				l_layout_constructor.expand_tree
			end
		end

	remove_application_menu_node (a_application_menu: EV_TREE_NODE)
			-- Remove ApplicationMenu node, move its items to upper level Ribbon.ApplicationMenu
		require
			not_void: a_application_menu /= Void
			valid: a_application_menu.text.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu)
		do
			check a_application_menu.count = 1 end
			if attached a_application_menu.i_th (1) as l_ribbon_menu then
				a_application_menu.wipe_out
				from
					l_ribbon_menu.start
				until
					l_ribbon_menu.after
				loop
					a_application_menu.extend (l_ribbon_menu.item)

					l_ribbon_menu.forth
				end
			end
		end
end
