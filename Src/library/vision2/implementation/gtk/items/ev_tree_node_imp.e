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
			insert_i_th,
			remove_i_th,
			reorder_child,
			i_th,
			count,
			list_widget,
			initialize,
			dispose
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_TREE_NODE_ACTION_SEQUENCES_IMP
		
	EV_PND_DEFERRED_ITEM
		undefine
			copy,
			is_equal,
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the tree item.
		do
			base_make (an_interface)
			create ev_children.make (0)
		end

	initialize is
			-- Set up action sequence connection and `Precursor' initialization,
			-- create item box to hold label and pixmap.
		do
			{EV_ITEM_LIST_IMP} Precursor
			is_initialized := True
		end
		
	dispose is
			-- 
		do
			Precursor {EV_ITEM_LIST_IMP}
			if not is_in_final_collect then
				if gdk_pixmap /= NULL then
					C.gdk_pixmap_unref (gdk_pixmap)
				end
				if gdk_mask /= NULL then
					C.gdk_pixmap_unref (gdk_mask)
				end				
			end
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		local
			a_tree_imp: EV_TREE_IMP
		do
			a_tree_imp := parent_tree_imp
			if a_tree_imp /= Void then
				Result := a_tree_imp.selected_item = interface
			end
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
		
	set_text (a_text: STRING) is
			-- 
		do
			internal_text := clone (a_text)
			insert_pixmap
		end
		
	remove_text is
			-- 
		do
			internal_text := ""
			insert_pixmap
		end	

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
			remove_dummy_node
			is_expanded := True
			if expand_actions_internal /= Void then
				expand_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)
			end
		end

	collapse_callback is
			-- Called when `Current' is collapsed.
		do
			is_expanded := False
			if collapse_actions_internal /= Void then
				collapse_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)
			end
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
			a_gs: GEL_STRING
			is_leaf, is_expded: INTEGER
		do
			create a_gs.make (text)
			if parent_tree_imp /= Void then
				if pix_height > parent_tree_imp.row_height then
					C.gtk_clist_set_row_height (parent_tree_imp.list_widget, pix_height)
				end
				C.gtk_ctree_set_node_info (
					parent_tree_imp.list_widget,
					tree_node_ptr,
					a_gs.item,-- text,
					parent_tree_imp.spacing, -- spacing
					gdk_pixmap,
					gdk_mask,
					gdk_pixmap,
					gdk_mask,
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
		end
		
feature {EV_APPLICATION_IMP} -- Implementation
		
	pointer_over_widget (a_gdk_window: POINTER; a_x, a_y: INTEGER): BOOLEAN is
		-- Is mouse pointer over the row.
		local
			gdkwin_parent, clist_parent: POINTER
			par_tree_imp: EV_TREE_IMP
		do
			par_tree_imp := parent_tree_imp
			if par_tree_imp /= Void then
				gdkwin_parent := C.gdk_window_get_parent (a_gdk_window)
				clist_parent := C.gdk_window_get_parent (
					C.gtk_clist_struct_clist_window (par_tree_imp.list_widget)
				)
				if gdkwin_parent = clist_parent then
					if par_tree_imp.row_from_y_coord (a_y) = Current then
						Result := True
					end	
				end
			end
		end

feature {EV_TREE_IMP} -- Implementation

	parent_widget_is_displayed: BOOLEAN is
			--
		local
			temp_par_tree_imp: EV_TREE_IMP
		do
			temp_par_tree_imp := parent_tree_imp
			if temp_par_tree_imp /= Void then
				Result := temp_par_tree_imp.is_displayed
			end
		end
		
	text: STRING is
			-- Text displayed.
		do
			if internal_text = Void then
				Result := ""
			else
				Result := clone (internal_text)
			end
		ensure
			text_not_void: Result /= Void
		end

	tooltip: STRING is
			-- Tooltip if any.
		do
			if internal_tooltip = Void then
				Result := ""
			else
				Result := clone (internal_tooltip)
			end
		ensure
			tooltip_not_void: Result /= Void
		end

	internal_text: STRING
		-- Internal representation of `text'.
	
	internal_tooltip: STRING
		-- Internal representation of `tooltip'.

	set_tooltip (a_text: STRING) is
			-- Set `a_text' to `tooltip'.
		do
			internal_tooltip := a_text
		end

	remove_tooltip is
			-- Remove text of `tooltip'.
		do
			internal_tooltip := ""		
		end
	
	align_text_left is do  end
	
	align_text_center is do  end
	
	align_text_right is do end

	alignment: EV_TEXT_ALIGNMENT	
	
	set_pixmap (a_pixmap: EV_PIXMAP) is
		local
			a_pix_imp: EV_PIXMAP_IMP
		do
			--| FIXME An intelligent image list needs to be implemented instead of
			--| just retaining a pointer to passed pixmap.
			a_pix_imp ?= a_pixmap.implementation
			gdk_pixmap := C.gdk_pixmap_ref (a_pix_imp.drawable)
			if a_pix_imp.mask /= NULL then
				gdk_mask := C.gdk_bitmap_ref (a_pix_imp.mask)
			end
			pix_width := a_pix_imp.width
			pix_height := a_pix_imp.height
			
			if tree_node_ptr /= NULL then
				insert_pixmap
			end
		end
		
	pix_width, pix_height: INTEGER

	remove_pixmap is
		do
			--| FIXME Remove pixmap from tree and reset pix attributes.
		end
		
	pixmap: EV_PIXMAP is
			-- 
		local
			pix_imp: EV_PIXMAP_IMP
		do
			if gdk_pixmap /= NULL then
				create Result
				pix_imp ?= Result.implementation
				pix_imp.copy_from_gdk_data (gdk_pixmap, gdk_mask, pix_width, pix_height)				
			end
		end

	gdk_pixmap, gdk_mask: POINTER
		-- Stored gdk pixmap data.

	count: INTEGER is
		do
			Result := ev_children.count
		end
	
	i_th (i: INTEGER): EV_TREE_NODE is
		do
			Result := (ev_children @ i).interface
		end

	add_to_container (v: like item; v_imp: EV_ITEM_IMP) is
			-- Add `v' to tree items tree at position `i'.
		do
			check
				do_not_call: False
			end
		end

	reorder_child (v: like item; v_imp: EV_ITEM_IMP; a_position: INTEGER) is
			-- Move `v' to `a_position' in Current.
		do
			check
				do_not_call: False
			end
		end
		
	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
			par_t_imp: EV_TREE_IMP
		do
			--add_to_container (v, v_imp)
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			ev_children.force (item_imp)


			-- Using a local prevents recalculation
			par_t_imp := parent_tree_imp
			if par_t_imp /= Void then
				item_imp.set_item_and_children (tree_node_ptr)
				if item_imp.is_transport_enabled_iterator then
					par_t_imp.update_pnd_connection (True)
				end	
				item_imp.check_branch_pixmaps
			end			
	
			child_array.go_i_th (i)
			child_array.put_left (v)
			if i < count then
				--reorder_child (v, v_imp, i)
				ev_children.prune_all (item_imp)
				ev_children.go_i_th (i)
				ev_children.put_left (item_imp)
			end
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
				if count = 1 and then not is_expanded then
					--| Hack needed to prevent seg fault on removal if last item in collapse_actions.
					remove_on_expand_node := item_imp.tree_node_ptr
					a_timeout_imp ?= (create {EV_TIMEOUT}).implementation
					a_timeout_imp.interface.actions.extend (agent remove_dummy_node)
					a_timeout_imp.set_interval_kamikaze (0)
				else
					C.gtk_ctree_remove_node (par_tree_imp.list_widget, item_imp.tree_node_ptr)
				end
				item_imp.set_item_and_children (NULL)
				-- This resets item and all children
				item_imp.set_parent_imp (Void)
			end

			-- remove the row from the `ev_children'
			ev_children.go_i_th (a_position)
			ev_children.remove
			
			child_array.go_i_th (a_position)
			child_array.remove

			if par_tree_imp /= Void then
				par_tree_imp.update_pnd_status
			end
		end
		
	a_timeout_imp: EV_TIMEOUT_IMP
			-- Timeout used for expand node removal hack.
		
	remove_on_expand_node: POINTER
			-- Pointer used as hack to prevent gtk sigsegv on removal of last item.
	
	remove_dummy_node is
			--
		local
			a_d_node: POINTER
		do
			a_d_node := remove_on_expand_node
			if remove_on_expand_node /= NULL then
				remove_on_expand_node := NULL
				C.gtk_ctree_remove_node (parent_tree_imp.list_widget, a_d_node)		
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
		do
			insert_pixmap
			cnt := ev_children.count
			if cnt > 0 then
				from
					ev_children.start
				until
					ev_children.index > cnt
				loop
					ev_children.item.check_branch_pixmaps
					ev_children.forth
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

