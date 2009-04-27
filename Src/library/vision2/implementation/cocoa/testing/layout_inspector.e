indexing
	description: "Objects that creates a window that lets the user inspect the vision layout of current application"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LAYOUT_INSPECTOR

inherit
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state
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
			window_list := env.application.windows
			from
				window_list.start
			until
				window_list.after
			loop
				io.output.put_string(window_list.item.title + "%N")
				output_info_rec (window_list.item, 1)
				io.output.put_string("----------%N")
				window_list.forth
			end
		end

	output_info_rec (a_widget: EV_WIDGET; ident: INTEGER)
			--
		local
			p: POINTER
			box: EV_BOX_IMP
			str, ident_str: STRING
			w: EV_WIDGET_IMP
			wlist: EV_WIDGET_LIST
			container: EV_CONTAINER
		do
			w ?= a_widget.implementation
			p := $a_widget
			create ident_str.make_filled (' ', ident*2)
			str :=
				"Type: " + w.generating_type + "%N" + ident_str +
				"Address: " + p.out + "%N" + ident_str +
				"Relative Position: " + a_widget.x_position.out + "x" + a_widget.y_position.out + "%N" + ident_str +
				"Screen Position: " + a_widget.screen_x.out + "x" + a_widget.screen_y.out + "%N" + ident_str +
				"Minimum Size: " + a_widget.minimum_width.out + "x" + a_widget.minimum_height.out + "%N" + ident_str +
				"Actual Size: "+ a_widget.width.out + "x" + a_widget.height.out + "%N" + ident_str +
				"Expandable: " + w.is_expandable.out + "%N"
			box ?= w
			if  box /= void then
				str.append ("%N" + ident_str +
				"Padding: " + box.padding.out + "%N"+ ident_str +
				"homogenous: " + box.is_homogeneous.out + "%N")
			end
			io.output.put_string (str)

			wlist ?= a_widget
			container ?= a_widget
			if wlist /= Void then
				from
					wlist.start
				until
					wlist.after
				loop
					output_info_rec (wlist.item, ident + 1)
					wlist.forth
				end
			elseif container /= Void then
				output_info_rec (container.item, ident + 1)
			end
		end


feature {NONE} -- Graphical view

	initialize
			-- Initialize `Current' to set up tests.
		do
			Precursor {EV_TITLED_WINDOW}

			create horizontal_box
			create tree
			create vertical_box
			create refresh_button.make_with_text_and_action ("refresh", agent update_tree)
			create hide_button.make_with_text_and_action ("hide", agent hide_widget)
			create show_button.make_with_text_and_action ("show", agent show_widget)
			create info_label.default_create
			info_label.align_text_left
			info_label.set_minimum_height (100)
			horizontal_box.extend (tree)
			horizontal_box.extend (vertical_box)
			horizontal_box.disable_item_expand (vertical_box)
			vertical_box.set_minimum_width (175)
			vertical_box.extend (refresh_button)
			vertical_box.extend (hide_button)
			vertical_box.extend (show_button)
			vertical_box.extend (info_label)
			vertical_box.disable_item_expand (refresh_button)
			vertical_box.disable_item_expand (hide_button)
			vertical_box.disable_item_expand (show_button)
			extend (horizontal_box)

			set_title ("Layout Inspector")
			set_minimum_size (500, 300)
			set_x_position (600)
			update_tree
			show
		end

	update_tree
			-- Go through the items in the tree view, remove items already removed in the container structure and add the new children.
		local
			n: EV_TREE_NODE
			env: EV_ENVIRONMENT
			window_list: LINEAR [EV_WINDOW]
		do
			tree.do_all (agent check_removal)

			create env
			window_list := env.application.windows
			from
				window_list.start
			until
				window_list.after
			loop
				n := tree.retrieve_item_recursively_by_data (window_list.item, false)
				if n /= Void then
					n.set_text (window_list.item.title)
					update_recursive (n, window_list.item)
				else
					n := create {EV_TREE_ITEM}.make_with_text (window_list.item.title)
					n.select_actions.extend (agent show_info (window_list.item))
					n.set_data (window_list.item)
					tree.extend (n)
					add_recursive (n, window_list.item)
				end
				window_list.forth
			end
		end

	check_removal (a_node: EV_TREE_NODE)
			-- Removes widgets that were children of the container represented by 'a_node' from the tree if they are not there anymore.
		local
			widget: EV_WIDGET
		do
			from
				a_node.start
			until
				a_node.after
			loop
				widget ?= a_node.item.data
				if widget.parent = void then
					a_node.remove
				else
					check_removal (a_node.item)
					a_node.forth
				end
			end
		end


	add_element (an_element: EV_WIDGET; a_parent: EV_TREE_NODE): EV_TREE_NODE
			--
		local
			node: EV_TREE_NODE
		do
			node := create {EV_TREE_ITEM}.make_with_text (an_element.generating_type)
			node.set_data (an_element)
			a_parent.extend (node)
			node.select_actions.extend (agent show_info (an_element))
			Result := node
		end


	update_recursive (a_node: EV_TREE_NODE; a_container: EV_CONTAINER)
			-- If the item is already in the view just continue. If not add it.
		local
			node: EV_TREE_NODE
			splitarea: EV_SPLIT_AREA
			wlist: EV_WIDGET_LIST
			container: EV_CONTAINER
		do
			splitarea ?= a_container
			wlist ?= a_container
			if a_container = Void then
				-- Do nothing. no children to add to a_node
			elseif splitarea /= Void then
				-- The split area needs special treatment
				splitarea.go_to_first

				node := tree.retrieve_item_recursively_by_data (a_container.item, false)
				if node /= Void then
					container ?= node.data
					update_recursive(node, container)
				else
					node := add_element(a_container.item, a_node)
					container ?= a_container.item
					add_recursive(node, container)
				end

				splitarea.go_to_second
				node := tree.retrieve_item_recursively_by_data (a_container.item, false)
				if node /= Void then
					container ?= node.data
					update_recursive(node, container)
				else
					node := add_element(a_container.item, a_node)
					container ?= a_container.item
					add_recursive(node, container)
				end
			elseif wlist /= Void then
				-- Okay, we have a widget which can have several children
				from
					wlist.start
				until
					wlist.index > wlist.count
				loop
					node := tree.retrieve_item_recursively_by_data (wlist.item, false)
					if node /= Void then
						container ?= node.data
						update_recursive(node, container)
					else
						node := add_element(wlist.item, a_node)
						container ?= wlist.item
						add_recursive(node, container)
					end
					wlist.forth
				end
			elseif a_container.readable and then a_container.item /= Void then
				-- We have a container with a single child
				node := tree.retrieve_item_recursively_by_data (a_container.item, false)
				if node /= Void then
					container ?= node.data
					update_recursive (node, container)
				else
					node := add_element(a_container.item, a_node)
					container ?= a_container.item
					add_recursive(node, container)
				end
			end
		end


	add_recursive (a_node: EV_TREE_NODE; a_container: EV_CONTAINER)
			-- Add all the children of a_container to a_node (and then the children of the children, etc.)
		local
			node: EV_TREE_NODE
			splitarea: EV_SPLIT_AREA
			wlist: EV_WIDGET_LIST
			container: EV_CONTAINER
		do
			splitarea ?= a_container
			wlist ?= a_container
			if a_container = Void then
				-- Do nothing. no children to add to a_node
			elseif splitarea /= Void then
				-- The split area needs special treatment
				splitarea.go_to_first
				if a_container.item /= void then
					node := add_element(a_container.item, a_node)
					container ?= a_container.item
					if container /= Void then
						add_recursive(node, container)
					end
				end

				splitarea.go_to_second
				if a_container.item /= void then
					node := add_element(a_container.item, a_node)
					container ?= a_container.item
					if container /= Void then
						add_recursive(node, container)
					end
				end
			elseif wlist /= Void then
				-- Okay, we have a widget which can have several children
				from
					wlist.start
				until
					wlist.index > wlist.count
				loop
					node := add_element(wlist.item, a_node)
					container ?= wlist.item
					if container /= Void then
						add_recursive(node, container)
					end
					wlist.forth
				end
			elseif a_container.readable and then a_container.item /= Void then
				-- We have a container with a single child
				node := add_element(a_container.item, a_node)
				container ?= a_container.item
				if container /= Void then
					add_recursive(node, container)
				end
			end
		end

	show_info (a_widget: EV_WIDGET)
			-- Show the information for a_widget on the right side
		local
			ptr, parent_ptr: POINTER
			box: EV_BOX_IMP
			str: STRING
			w_imp: EV_WIDGET_IMP
			c: EV_CONTAINER
		do
			w_imp ?= a_widget.implementation
			selected_widget := a_widget
			ptr := $a_widget
			c := a_widget.parent
			parent_ptr := $c
			str :=
				a_widget.generating_type + "%N" +
				"Address: " + ptr.out + "%N" +
				"Parent: " + parent_ptr.out + "%N" +
				"%N" +
				"Relative Position: " + a_widget.x_position.out + "x" + a_widget.y_position.out + "%N" +
				"Screen Position: " + a_widget.screen_x.out + "x" + a_widget.screen_y.out + "%N" +
				"%N" +
				"Minimum Size: " + a_widget.minimum_width.out + "x" + a_widget.minimum_height.out + "%N" +
				"Actual Size: "+ a_widget.width.out + "x" + a_widget.height.out + "%N" +
				"%N" +
				"Expandable: " + w_imp.is_expandable.out
			box ?= w_imp
			if  box /= void then
				str.append ("%N" +
				"Border: " + box.border_width.out + "%N"+
				"Padding: " + box.padding.out + "%N"+
				"homogenous: " + box.is_homogeneous.out)
			end
			info_label.set_text (str)
		end

	selected_widget: EV_WIDGET

	show_widget
			--
		do
			if selected_widget /= Void then
				selected_widget.show
			end
		end

	hide_widget
			--
		do
			if selected_widget /= Void then
				selected_widget.hide
			end
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

	refresh_button: EV_BUTTON

	hide_button: EV_BUTTON

	show_button: EV_BUTTON

	info_label: EV_LABEL

end
