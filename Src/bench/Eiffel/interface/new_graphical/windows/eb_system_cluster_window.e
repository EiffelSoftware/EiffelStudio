indexing
	description: "Display a cluster selection dialog to add a cluster"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_CLUSTER_WINDOW

inherit
	EV_DIALOG
	
	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	LACE_AST_FACTORY
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization
	
	make (image: EV_TREE) is
			-- Initialize current window with `image'.
		require
			image_not_void: image /= Void
		do
			default_create
			set_title ("Create New Cluster")
			create clusters_names.make (10)
			build_widgets
			initialize_tree_with (image)
			is_selected := False
		end

feature -- Access

	parent_cluster: STRING
			-- Name of cluster in which added cluster belongs to.
			-- If Void, it is a top cluster.
			
	cluster_name: STRING is
			-- Name of added cluster
		require
			cluster_added: is_selected
		do
			Result := name_field.text
			Result.to_lower
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

	cluster_path: STRING is
			-- Path of added cluster
		require
			cluster_added: is_selected
		do
			Result := path_field.path
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature -- Status

	is_selected: BOOLEAN
			-- Has a new cluster been selected for addition?
			
feature {NONE} -- Access

	tree: EV_TREE
			-- Tree representing hierarchy of clusters.
			
	name_field: EV_TEXT_FIELD
			-- Name of new cluster.

	path_field: EV_PATH_FIELD
			-- Path of new cluster.

feature {NONE} -- Implementation

	build_widgets is
			-- Create widget layout.
		local
			label: EV_LABEL
			vbox1, vbox2: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			ok_button, cancel_button: EV_BUTTON
		do
			create vbox1
			vbox1.set_padding (Layout_constants.Small_padding_size)
			vbox1.set_border_width (Layout_constants.Large_border_size)
			
				-- Name of cluster
			create vbox2
			vbox2.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Name: ")
			label.align_text_left
			vbox2.extend (label)
			vbox2.disable_item_expand (label)
			
			create name_field
			vbox2.extend (name_field)
			vbox2.disable_item_expand (name_field)
			vbox1.extend (vbox2)
			vbox1.disable_item_expand (vbox2)

			create path_field.make_with_text_and_parent ("Cluster path: ", Current)
			vbox1.extend (path_field)
			vbox1.disable_item_expand (path_field)

			create vbox2
			vbox2.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Select where to place the new cluster: ")
			label.align_text_left
			vbox2.extend (label)
			vbox2.disable_item_expand (label)
			
			create tree
			tree.set_minimum_height (150)
			vbox2.extend (tree)
			vbox1.extend (vbox2)
			
			create hbox
			hbox.set_padding (Layout_constants.Small_padding_size)
			
			hbox.extend (create {EV_CELL})
			
			create ok_button.make_with_text_and_action ("Ok", ~close_dialog (True))
			ok_button.set_minimum_width (Layout_constants.Default_button_width)
			hbox.extend (ok_button)
			hbox.disable_item_expand (ok_button)
			
			create cancel_button.make_with_text_and_action ("Cancel", ~close_dialog (False))
			cancel_button.set_minimum_width (Layout_constants.Default_button_width)
			hbox.extend (cancel_button)
			hbox.disable_item_expand (cancel_button)
			
			vbox1.extend (hbox)
			vbox1.disable_item_expand (hbox)
			
			extend (vbox1)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
		end

	initialize_tree_with (image: EV_TREE) is
			-- Initialize `tree' with `image'.
		require
			image_not_void: image /= Void
		local
			root, tree_item: EV_TREE_ITEM
		do
				-- Create root for tree.
			create root.make_with_text (root_name)
			root.set_pixmap (Pixmaps.Icon_cluster_symbol @ 1)
			tree.extend (root)
			
			from
				image.start
			until
				image.after
			loop
				tree_item ?= image.item
				check
					tree_item_not_void: tree_item /= Void
				end
				recursive_traversal (root, tree_item)
				image.forth
			end

			if root.is_expandable then
				root.expand
			end
			root.enable_select
		end

feature -- Action

	close_dialog (created: BOOLEAN) is
			-- Close dialog. If `created' then `OK' button has been selected,
			-- otherwise `Cancel' button has been selected.
		local
			error_dialog: EB_WARNING_DIALOG
		do
			is_selected := created
			if created then
				if not valid_identifier (name_field.text) then
					create error_dialog.make_with_text (Warning_messages.w_cluster_name_not_valid)
					error_dialog.show_modal_to_window (Current)
				elseif clusters_names.has (name_field.text) then
					create error_dialog.make_with_text (Warning_messages.w_cluster_with_name_exists)
					error_dialog.show_modal_to_window (Current)
				else
					parent_cluster := tree.selected_item.text
					if parent_cluster.is_equal (root_name) then
						parent_cluster := Void
					end
					hide
				end
			else
				parent_cluster := Void
				name_field.remove_text
				hide
			end
		end

feature {NONE} -- Implementation
	
	root_name: STRING is "Lace root"
			-- Name of root of tree displaying list of existing clusters.

	clusters_names: SEARCH_TABLE [STRING]
			-- Memorize all cluster names to make sure it is valid.
			
	recursive_traversal (parent_node: EV_TREE_NODE_CONTAINER; tree_item: EV_TREE_ITEM) is
		require
			parent_node_not_void: parent_node /= Void
			tree_item_not_void: tree_item /= Void
		local
			parent_tree, node: EV_TREE_ITEM
			l_tree: EV_TREE
		do
			create node.make_with_text (tree_item.text)
			clusters_names.put (tree_item.text)
			node.set_pixmap (Pixmaps.Icon_cluster_symbol @ 1)
			parent_tree ?= parent_node
			if parent_tree /= Void then
				parent_tree.extend (node)
			else
				l_tree ?= parent_node
				check
					l_tree_not_void: l_tree /= Void
				end
				l_tree.extend (node)
			end

			parent_tree := node

			from
				tree_item.start
			until
				tree_item.after
			loop
				node ?= tree_item.item
				check
					node_not_void: node /= Void
				end
				recursive_traversal (parent_tree, node)
				tree_item.forth
			end
		end

invariant
	has_name_field: name_field /= Void
	has_tree: tree /= Void
	
end -- class EB_SYSTEM_CLUSTER_WINDOW
