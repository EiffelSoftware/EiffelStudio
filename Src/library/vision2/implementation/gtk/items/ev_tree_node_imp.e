indexing
	description: "Eiffel Vision tree node. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_NODE_IMP

inherit
	EV_TREE_NODE_I
		select
			interface
		end
	
	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		rename
			interface as item_list_interface
		redefine
			add_to_container,
			remove_i_th,
			reorder_child,
			i_th,
			count,
			list_widget,
			dispose
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_TREE_NODE_ACTION_SEQUENCES_IMP

	EV_TEXTABLE_IMP
		rename
			interface as textable_imp_interface
		redefine
			dispose
		end

	--EV_TOOLTIPABLE_IMP

	EV_PIXMAPABLE_IMP
		rename
			interface as pixmapable_imp_interface
		redefine
			set_pixmap,
			remove_pixmap,
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the tree item.
		do
			base_make (an_interface)
			textable_imp_initialize
			pixmapable_imp_initialize

			-- The following is a hack to ensure destruction of gtkobjects.
			dummy_hbox := C.gtk_hbox_new (False, 0)
			set_c_object (dummy_hbox)
			create ev_children.make (0)
		end

	initialize is
			-- Set up action sequence connection and `Precursor' initialization,
			-- create item box to hold label and pixmap.
		do
			C.gtk_container_add (dummy_hbox, pixmap_box)
			C.gtk_container_add (dummy_hbox, text_label)
			is_initialized := True
		end
		
	dummy_hbox: POINTER

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		do
			Result := parent_tree_imp.selected_item = interface
		end

	is_expanded: BOOLEAN
			-- is the item expanded?


feature -- Status setting

	enable_select is
			-- Select `Current' in its parent.
		do
			C.gtk_ctree_select (
				parent_tree_imp.list_widget,
				tree_node_ptr
			)
			
		end

	disable_select is
			-- Disable selection of `Current' in its parent.
		do
			C.gtk_ctree_unselect (
				parent_tree_imp.list_widget,
				tree_node_ptr
			)
		end
	
	set_expand (a_flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		do
			is_expanded := a_flag
			if a_flag then
				C.gtk_ctree_expand (
					parent_tree_imp.list_widget,
					tree_node_ptr
				)
			else
				C.gtk_ctree_collapse (
					parent_tree_imp.list_widget,
					tree_node_ptr
				)
			end
		end

feature -- Tooltipable

	tooltip: STRING

	set_tooltip (a_string: STRING) is do end

	remove_tooltip is do end

feature -- PND

	enable_transport is 
		do
			is_transport_enabled := True
			if parent_tree_imp /= Void then
				parent_tree_imp.update_pnd_status
			end
		end

	disable_transport is
		do
			is_transport_enabled := False
			if parent_tree_imp /= Void then
				parent_tree_imp.update_pnd_status
			end
		end

	draw_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	enable_capture is
		do
			check
				do_not_call: False
			end
		end

	disable_capture is
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER) is 
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER) is
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_CURSOR) is
		do
			check
				do_not_call: False
			end
		end

	is_transport_enabled_iterator: BOOLEAN is
		do
			if is_transport_enabled then
				Result := True
			else
				from
					ev_children.start
				until
					ev_children.after or else Result
				loop
					Result := ev_children.item.is_transport_enabled_iterator
					ev_children.forth
				end
			end
		end

feature {EV_TREE_IMP} -- Implementation

	set_pebble_void is
			-- Resets pebble from Tree_Imp.
		do
			pebble := Void
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is the row able to transport data with `a_button' click.
		do
			Result := is_transport_enabled and
			((a_button = 1 and mode_is_drag_and_drop) or
			(a_button = 3 and (mode_is_pick_and_drop or mode_is_target_menu)))
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end

feature {EV_ANY_I} -- Implementation

	set_parent_imp (par_imp: like parent_imp) is
		do
			parent_imp := par_imp
		end

	parent_imp: EV_ITEM_LIST_IMP [EV_TREE_NODE]

	parent_tree_imp: EV_TREE_IMP is
		do
			if parent_tree /= Void then
				Result ?= parent_tree.implementation
			end
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	expand_callback is
			-- Called when `Current' is expanded.
		do
			is_expanded := True
			expand_actions_internal.call ([])
		end

	collapse_callback is
			-- Called when `Current' is collapsed.
		do
			is_expanded := False
			collapse_actions_internal.call ([])
		end

	tree_node_ptr: POINTER

	set_tree_node (a_tree_node_ptr: POINTER) is
		do
			if a_tree_node_ptr /= NULL then
				parent_tree_imp.tree_node_ptr_table.put (Current, a_tree_node_ptr)
			end
			tree_node_ptr := a_tree_node_ptr
		end

	insert_pixmap is
		local
			gdkpix, gdkmask, text_ptr: POINTER
			is_leaf, is_expded: INTEGER
			success: INTEGER
		do
			C.gtk_label_get (text_label, $text_ptr)
			if gtk_pixmap /= NULL and then parent_tree_imp /= Void then
				C.gtk_pixmap_get (C.gtk_pixmap_struct_pixmap (gtk_pixmap), $gdkpix, $gdkmask)
				success := C.gtk_ctree_get_node_info (
					parent_tree_imp.list_widget,
					tree_node_ptr,
					NULL,
					NULL,
					NULL,
					NULL,
					NULL,
					NULL,
					$is_leaf,
					$is_expded
				)
				C.gtk_ctree_node_set_pixtext (
					parent_tree_imp.list_widget,
					tree_node_ptr,
					0,
					text_ptr,-- text,
					5, -- spacing
					gdkpix,
					gdkmask
				)
				C.gtk_ctree_set_node_info (
					parent_tree_imp.list_widget,
					tree_node_ptr,
					text_ptr,-- text,
					5, -- spacing
					gdkpix,
					gdkmask,
					gdkpix,
					gdkmask,
					is_leaf,
					is_expded
				)
			end
		end

	set_item_and_children (parent_node: POINTER) is
			-- Used for setting items on addition and removal
		do
			if tree_node_ptr = NULL then
					-- Current has been added to tree
				set_tree_node (parent_tree_imp.insert_ctree_node (Current, parent_node, NULL))
			else
					-- Current is being removed from tree.
				parent_tree_imp.tree_node_ptr_table.remove (tree_node_ptr)
				set_tree_node (NULL)
			end
			
			from
				ev_children.start
			until
				ev_children.after
			loop
				ev_children.item.set_item_and_children (tree_node_ptr)
				ev_children.forth
			end
			
			if tree_node_ptr = NULL then
					-- Reset here as descendants access `parent_imp' in iteration.
				set_parent_imp (Void)
			end
		end

feature {NONE} -- Implementation

	dispose is
			-- 
		do
			gtk_object_unref (dummy_hbox)
			Precursor
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
		do
			Precursor {EV_PIXMAPABLE_IMP} (a_pixmap)
			if tree_node_ptr /= NULL then
				insert_pixmap
			end
		end

	remove_pixmap is
		do
			Precursor {EV_PIXMAPABLE_IMP}
		end

	count: INTEGER is
		do
			Result := ev_children.count
		end
	
	i_th (i: INTEGER): EV_TREE_NODE is
		do
			Result := (ev_children @ i).interface
		end

	add_to_container (v: like item) is
			-- Add `v' to tree items tree at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
			par_t_imp: EV_TREE_IMP
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			ev_children.force (item_imp)

			-- Using a local prevents recalculation
			par_t_imp := parent_tree_imp
			if par_t_imp /= Void then
				item_imp.set_item_and_children (tree_node_ptr)
				par_t_imp.update_pnd_status
				item_imp.check_branch_pixmaps
			end
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position' in Current.
		do
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_NODE_IMP
			par_tree_imp: EV_TREE_IMP
		do
			item_imp := (ev_children @ (a_position))

			-- Remove from tree if present
			par_tree_imp := parent_tree_imp
			if par_tree_imp /= Void then
				if a_position = 1 and then count > 1 then
					C.gtk_ctree_remove_node (par_tree_imp.list_widget, item_imp.tree_node_ptr)
				end
				item_imp.set_item_and_children (NULL)
				-- This resets item and all children
				item_imp.set_parent_imp (Void)
			end

			-- remove the row from the `ev_children'
			ev_children.go_i_th (a_position)
			ev_children.remove

			if par_tree_imp /= Void then
				par_tree_imp.update_pnd_status
			end
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_pos: INTEGER) is
			-- Not needed in this class.
		do
			check dont_call: False end
		end

	ev_children: ARRAYED_LIST [EV_TREE_NODE_IMP]
			-- Container for all tree items.

feature {EV_ITEM_LIST_IMP} -- Implementation

	check_branch_pixmaps is
			-- if `Current' is attached to a GtkCTree, associate its pixmap
			-- to its corresponding GtkCTreeNode.
		local
			cnt: INTEGER
			itm_imp: EV_TREE_NODE_IMP
		do
			insert_pixmap
			cnt := count
			if parent_tree_imp /= Void and then cnt > 0 then
				from
					start
				until
					index > cnt
				loop
					itm_imp ?= item.implementation
					itm_imp.check_branch_pixmaps
					forth
				end
			end
		end

	list_widget: POINTER 
			-- Pointer to the items own gtktree.


end -- class EV_TREE_NODE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

