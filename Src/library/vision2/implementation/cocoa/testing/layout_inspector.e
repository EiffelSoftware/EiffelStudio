note
	description: "Lets the user inspect the vision2 widget layout of the current application"
	author: "Daniel Furrer"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	LAYOUT_INSPECTOR

inherit
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state,
			create_interface_objects
		end

create
	default_create

feature -- Console View

	output_info
			--
		local
			env: EV_ENVIRONMENT
			window_list: LINEAR [EV_WINDOW]
		do
			create env
			if attached env.application as l_app then
				window_list := l_app.windows
				from
					window_list.start
				until
					window_list.after
				loop
					io.output.put_string(window_list.item.title.to_string_8 + "%N")
					output_info_rec (window_list.item, 1)
					io.output.put_string("----------%N")
					window_list.forth
				end
			end
		end

	output_info_rec (a_widget: EV_WIDGET; ident: INTEGER)
			--
		local
			p: POINTER
			str, ident_str: STRING
		do
			if attached {EV_WIDGET_IMP} a_widget.implementation as w then
				p := $a_widget
				create ident_str.make_filled (' ', ident*2)
				str :=
					"Type: " + w.generating_type.name + "%N" + ident_str +
					"Address: " + p.out + "%N" + ident_str +
					"Relative Position: " + a_widget.x_position.out + "x" + a_widget.y_position.out + "%N" + ident_str +
					"Screen Position: " + a_widget.screen_x.out + "x" + a_widget.screen_y.out + "%N" + ident_str +
					"Minimum Size: " + a_widget.minimum_width.out + "x" + a_widget.minimum_height.out + "%N" + ident_str +
					"Actual Size: "+ a_widget.width.out + "x" + a_widget.height.out + "%N" + ident_str +
					"Expandable: " + w.is_expandable.out + "%N"
				if attached {EV_BOX_IMP} w as box then
					str.append ("%N" + ident_str +
					"Padding: " + box.padding.out + "%N"+ ident_str +
					"homogenous: " + box.is_homogeneous.out + "%N")
				end
				io.output.put_string (str)

				if attached {EV_WIDGET_LIST} a_widget as wlist then
					from
						wlist.start
					until
						wlist.after
					loop
						output_info_rec (wlist.item, ident + 1)
						wlist.forth
					end
				elseif attached {EV_CONTAINER} a_widget as container then
					output_info_rec (container.item, ident + 1)
				end
			end
		end


feature {NONE} -- Graphical view

	create_interface_objects
		do
			create horizontal_box
			create tree
			create vertical_box
			create hide_button.make_with_text ("hide")
			create show_button.make_with_text ("show")
			create debug_button.make_with_text ("debug")
			create info_label.default_create
		end

	initialize
			-- Initialize `Current' to set up tests.
		local
			refresh_button: EV_BUTTON
		do
			Precursor {EV_TITLED_WINDOW}

			create refresh_button.make_with_text_and_action ("refresh", agent update_tree)

			hide_button.select_actions.extend (agent hide_widget)
			show_button.select_actions.extend (agent show_widget)
			debug_button.select_actions.extend (agent debug_widget)

			refresh_button.set_tooltip ("Testing tooltips")
			--hide_button.disable_sensitive
			--show_button.disable_sensitive
			debug_button.disable_sensitive
			info_label.align_text_left
			info_label.set_minimum_height (100)
			horizontal_box.extend (tree)
			horizontal_box.extend (vertical_box)
			horizontal_box.disable_item_expand (vertical_box)
			vertical_box.set_minimum_width (200)
			vertical_box.extend (refresh_button)
			vertical_box.extend (hide_button)
			vertical_box.extend (show_button)
			vertical_box.extend (debug_button)
			vertical_box.extend (info_label)
			vertical_box.disable_item_expand (refresh_button)
			vertical_box.disable_item_expand (hide_button)
			vertical_box.disable_item_expand (show_button)
			vertical_box.disable_item_expand (debug_button)
			extend (horizontal_box)

			set_title ("Layout Inspector")
			set_minimum_size (600, 400)
			set_position (700, 100)
			update_tree
			show
		end

	update_tree
			-- Go through the items in the tree view, remove items already removed in the container structure and add the new children.
		local
			n: detachable EV_TREE_NODE
			env: EV_ENVIRONMENT
			window_list: LINEAR [EV_WINDOW]
		do
			tree.do_all (agent check_removal)

			create env
			if attached env.application as l_app then
				window_list := l_app.windows
				from
					window_list.start
				until
					window_list.after
				loop
					n := tree.retrieve_item_recursively_by_data (window_list.item, false)
					if attached n then
						n.set_text (window_list.item.title)
						update_recursive (n, window_list.item, 0)
					else
						n := create {EV_TREE_ITEM}.make_with_text (window_list.item.title)
						n.select_actions.extend (agent show_info (window_list.item))
						n.set_data (window_list.item)
						tree.extend (n)
						add_recursive (n, window_list.item, 0)
					end
					window_list.forth
				end
			end
		end

	check_removal (a_node: EV_TREE_NODE)
			-- Removes widgets that were children of the container represented by 'a_node' from the tree if they are not there anymore.
		do
			from
				a_node.start
			until
				a_node.after
			loop
				if attached {EV_WIDGET} a_node.item.data as widget then
					if widget.parent = void then
						a_node.remove
					else
						check_removal (a_node.item)
						a_node.forth
					end
				end
			end
		end


	add_element (a_element: detachable EV_WIDGET; a_parent: EV_TREE_NODE): EV_TREE_NODE
			-- Add the widget `a_element' in the tree under node `a_parent'
		local
			node: EV_TREE_ITEM
		do
			if attached a_element then
				create node.make_with_text (a_element.generating_type.name_32)
				node.set_data (a_element)
				a_parent.extend (node)
				node.select_actions.extend (agent show_info (a_element))
			else
				create node.make_with_text ("VOID")
			end
			Result := node
		end


	update_recursive (a_node: EV_TREE_NODE; a_container: EV_CONTAINER; a_depth: INTEGER)
			-- If the item is already in the view just continue. If not add it.
		local
			node: detachable EV_TREE_NODE
		do
			if a_container = Void then
				-- Do nothing. no children to add to a_node
			elseif attached {EV_SPLIT_AREA} a_container as l_splitarea then
				-- The split area needs special treatment
				if attached l_splitarea.first as child then
					node := tree.retrieve_item_recursively_by_data (child, false)
					if attached node then
						if attached {EV_CONTAINER} node.data as l_container then
							update_recursive (node, l_container, a_depth+1)
						end
					else
						node := add_element (child, a_node)
						if attached {EV_CONTAINER} child as l_container then
							add_recursive (node, l_container, a_depth+1)
						end
					end
				end

				if attached l_splitarea.second as child then
					node := tree.retrieve_item_recursively_by_data (child, false)
					if attached node then
						if attached {EV_CONTAINER} node.data as l_container then
							update_recursive (node, l_container, a_depth+1)
						end
					else
						node := add_element (child, a_node)
						if attached {EV_CONTAINER} child as l_container then
							add_recursive (node, l_container, a_depth+1)
						end
					end
				end
			elseif attached {EV_WIDGET_LIST} a_container as wlist then
				-- Okay, we have a widget which can have several children
				from
					wlist.start
				until
					wlist.index > wlist.count
				loop

					if attached wlist.item then
						node := tree.retrieve_item_recursively_by_data (wlist.item, false)
						if attached node then
							if attached {EV_CONTAINER} node.data as l_container then
								update_recursive (node, l_container, a_depth+1)
							end
						else
							node := add_element (wlist.item, a_node)
							if attached {EV_CONTAINER} wlist.item as l_container then
								add_recursive (node, l_container, a_depth+1)
							end
						end
					end
					wlist.forth
				end
			elseif a_container.readable and then attached a_container.item then
				-- We have a container with a single child
				node := tree.retrieve_item_recursively_by_data (a_container.item, false)
				if attached node then
					if attached {EV_CONTAINER} node.data as l_container then
						update_recursive (node, l_container, a_depth+1)
					end
				else
					node := add_element(a_container.item, a_node)
					if attached {EV_CONTAINER} a_container.item as l_container then
						add_recursive (node, l_container, a_depth+1)
					end
				end
			end
		end

	max_depth: INTEGER = 10

	add_recursive (a_node: EV_TREE_NODE; a_widget: detachable EV_WIDGET; a_depth: INTEGER)
			-- Add all the children of a_container to a_node (and then the children of the children, etc.)
		local
			node: EV_TREE_NODE
		do
			if a_widget = Void then
				-- Do nothing. no children to add to a_node
			elseif attached {EV_WINDOW} a_widget as l_window then
				node := add_element (l_window.item, a_node)
				add_recursive (node, l_window.item, a_depth+1)
--			elseif attached {EV_ITEM_LIST} a_widget as l_list then
--				node := add_element (l_window.item, a_node)
--				add_recursive (node, l_window.item)
			elseif attached {EV_GRID} a_widget as l_grid then
				node := add_element (l_grid.implementation.cell_item, a_node)
				add_recursive (node, l_grid.implementation.cell_item, a_depth+1)
			elseif attached {EV_SPLIT_AREA} a_widget as l_splitarea then
				-- The split area needs special treatment
				if attached l_splitarea.first as child then
					node := add_element (child, a_node)
					add_recursive (node, child, a_depth+1)
				end

				if attached l_splitarea.second as child then
					node := add_element (child, a_node)
					add_recursive (node, child, a_depth+1)
				end
			elseif attached {EV_WIDGET_LIST} a_widget as wlist then
				-- Okay, we have a widget which can have several children
				from
					wlist.start
				until
					wlist.index > wlist.count
				loop
					node := add_element (wlist.item, a_node)
					add_recursive (node, wlist.item, a_depth+1)
					wlist.forth
				end
			elseif attached {EV_TABLE} a_widget as table then
				from
					table.start
				until
					table.after
				loop
					node := add_element (table.item_for_iteration, a_node)
					add_recursive (node, table.item_for_iteration, a_depth+1)
					table.forth
				end
			elseif attached {EV_CELL} a_widget as l_cell then
				-- We have a container with a single child
				if l_cell.readable and then attached l_cell.item then
					node := add_element (l_cell.item, a_node)
					add_recursive (node, l_cell.item, a_depth+1)
				end
--			elseif attached {SD_TOOL_BAR} a_widget as toolbar and then attached toolbar.items as items then
--				from
--					items.start
--				until
--					items.start
--				loop
--					node := add_element (items.item, a_node)
--					add_recursive (node, items.item)
--					table.forth
--				end
			end
		end

	show_info (a_widget: EV_WIDGET)
			-- Show the information for a_widget on the right side
		local
			ptr, parent_ptr: POINTER
			str: STRING_32
		do
			selected_widget := a_widget
			ptr := $a_widget
			if attached a_widget.parent as c then
				parent_ptr := $c
			end
			str :=
				a_widget.generating_type.name_32 + "%N" +
				"Address: " + ptr.out + "%N" +
				"Parent: " + parent_ptr.out + "%N" +
				"%N" +
				"Relative Position: " + a_widget.x_position.out + "x" + a_widget.y_position.out + "%N" +
				"Screen Position: " + a_widget.screen_x.out + "x" + a_widget.screen_y.out + "%N" +
				"%N" +
				"Minimum Size: " + a_widget.minimum_width.out + "x" + a_widget.minimum_height.out + "%N" +
				"Actual Size: "+ a_widget.width.out + "x" + a_widget.height.out + "%N"
			if attached {EV_BOX} a_widget.parent as box then
				str.append ("%N" + "Expandable: " + box.is_item_expanded (a_widget).out + "%N")
			end
			if attached {EV_BOX} a_widget as box then
				str.append ("%N" +
				"Border: " + box.border_width.out + "%N" +
				"Padding: " + box.padding.out + "%N"+
				"homogenous: " + box.is_homogeneous.out)
			end
			if attached {EV_TEXTABLE} a_widget as textable then
				str.append ("%N" +
				"Text: " + textable.text.out + "%N")
			end
			if attached {EV_VIEWPORT} a_widget as viewport then
				str.append ("%N" + "offsets: x: " + viewport.x_offset.out + "  y: " + viewport.x_offset.out + "%N")
			end
			if
				attached {EV_WIDGET_IMP} a_widget.implementation as a_widget_imp and then
				attached {NS_VIEW} a_widget_imp.cocoa_view as a_view
			then
				str.append ("%N" + "isFlipped: " + a_view.is_flipped.out + "%N")
			end
			info_label.set_text (str)
			show_overlay (a_widget)

			-- Update buttons
--			if a_widget.is_show_requested then
--				show_button.disable_sensitive
--				hide_button.enable_sensitive
--			else
--				show_button.enable_sensitive
--				hide_button.disable_sensitive
--			end
			debug_button.enable_sensitive
		end

	show_overlay (a_widget: EV_WIDGET)
		local
			x1, y1, x2, y2: INTEGER
		do
			if
				attached {EV_WIDGET_IMP} a_widget.implementation as w_imp and then
				attached w_imp.top_level_window_imp as w and then
				attached w.screen as l_screen
			then
				x1 := a_widget.screen_x - 1
				y1 := (l_screen.frame.size.height.rounded - a_widget.screen_y - a_widget.height) - 1
				x2 := a_widget.screen_x + a_widget.width + 1
				y2 := (l_screen.frame.size.height.rounded - a_widget.screen_y) + 1

				x1 := x1.min(l_screen.frame.size.width.rounded).max(0)
				y1 := y1.min(l_screen.frame.size.height.rounded).max(0)
				x2 := x2.min(l_screen.frame.size.width.rounded).max(0)
				y2 := y2.min(l_screen.frame.size.height.rounded).max(0)
				overlay.animator.set_frame (create {NS_RECT}.make_rect (x1, y1, x2-x1, (y2-y1).abs), True)
				if attached {NS_WINDOW} implementation as win_imp then
					overlay.set_parent_window (win_imp)
					-- Not working as expected :(
				else
					check False end
				end
			end
		end

	overlay: NS_WINDOW
		once
			create Result.make (
			create {NS_RECT}.make,
				{NS_WINDOW}.borderless_window_mask, False)
			Result.set_background_color (create {NS_COLOR}.blue_color)
			Result.set_alpha_value ({REAL_32}0.3)
			Result.make_key_and_order_front (overlay)
			Result.set_ignores_mouse_events (True)
			Result.set_level ({NS_WINDOW}.floating_window_level)
		end

	selected_widget: detachable EV_WIDGET

	show_widget
			--
		do
			if attached selected_widget as widget then
				widget.show
			end
		end

	hide_widget
			--
		do
			if attached selected_widget as widget then
				widget.hide
			end
		end

	debug_widget
		local
			rescued: BOOLEAN
		do
			if attached selected_widget as widget and not rescued then
--				if attached {EV_WIDGET_IMP} widget.implementation as widget_imp then
--				end
				check False then end
			end
		rescue
			rescued := True
			retry
		end


feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
			-- Currently do not care about this check, so we
			-- are turning it off.
		do
			Result := True
		end

	horizontal_box: EV_HORIZONTAL_BOX

	vertical_box: EV_VERTICAL_BOX

	tree: EV_TREE

	hide_button: EV_BUTTON

	show_button: EV_BUTTON

	debug_button: EV_BUTTON

	info_label: EV_LABEL

;note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
