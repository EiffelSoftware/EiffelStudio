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
			list_widget
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_TREE_NODE_ACTION_SEQUENCES_IMP

	EV_TEXTABLE_IMP
		rename
			interface as textable_imp_interface
		end

	--EV_TOOLTIPABLE_IMP

	EV_PIXMAPABLE_IMP
		rename
			interface as pixmapable_imp_interface
		redefine
			set_pixmap,
			remove_pixmap
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

			-- The following is a hack to satisfy implementation invariants.
			set_c_object (text_label)
			create ev_children.make (0)
		end

	initialize is
			-- Set up action sequence connection and `Precursor' initialization,
			-- create item box to hold label and pixmap.
		do
			is_initialized := True
		end

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
		do
			C.gtk_label_get (text_label, $text_ptr)
			if gtk_pixmap /= NULL then
				C.gtk_pixmap_get (C.gtk_pixmap_struct_pixmap (gtk_pixmap), $gdkpix, $gdkmask)
				C.gtk_ctree_node_set_pixtext (
					parent_tree_imp.list_widget,
					tree_node_ptr,
					0,
					text_ptr,-- text,
					5, -- spacing
					gdkpix,
					gdkmask
				)
			end
		end

	set_item_and_children (parent_node: POINTER) is
			-- Used for setting items on addition and removal
		do
			if tree_node_ptr = NULL then
				-- Current has been added to tree
				set_tree_node (
					parent_tree_imp.insert_ctree_node (
						Current,
						parent_node,
						NULL
					)
				)
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
				-- Reset here as descendants access parent_imp in iteration.
				set_parent_imp (Void)
			end
		end

feature {NONE} -- Implementation

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
				if item_imp.pixmap /= Void then
					item_imp.insert_pixmap
				end
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

--	dispose is
--			-- 
--		do
--			Precursor
--		end
		

	list_widget: POINTER 
			-- Pointer to the items own gtktree.


end -- class EV_TREE_NODE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2001/06/29 20:00:04  king
--| Cosmetics
--|
--| Revision 1.5  2001/06/21 23:44:20  king
--| Removed unused local
--|
--| Revision 1.4  2001/06/21 22:30:35  king
--| Now updating parent pnd status
--|
--| Revision 1.3  2001/06/07 23:08:02  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.10  2001/05/10 22:28:41  king
--| Complete reimplementation of tree nodes
--|
--| Revision 1.1.2.9  2001/04/20 00:11:49  king
--| Implemented temporary hack to prevent seg fault on item disposal
--|
--| Revision 1.1.2.8  2000/09/06 23:18:39  king
--| Reviewed
--|
--| Revision 1.1.2.7  2000/07/24 21:33:39  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.1.2.6  2000/07/04 21:28:23  king
--| Replaced enable_select fixme with comment
--|
--| Revision 1.1.2.5  2000/07/04 00:49:24  king
--| Half fixed enable_select problem, root node with children raises gdk error
--|
--| Revision 1.1.2.4  2000/06/08 00:23:31  king
--| Implemented select signal connection
--|
--| Revision 1.1.2.3  2000/05/18 20:49:11  king
--| Renamed parent->old_parent
--|
--| Revision 1.1.2.2  2000/05/16 18:00:11  king
--| Made compilable
--|
--| Revision 1.1.2.1  2000/05/16 16:33:19  oconnor
--| mainly moved from ev_tree_item_imp.e
--|
--| Revision 1.28.4.3  2000/05/08 22:13:16  king
--| Corrected is_selecred, add comment to set_selected
--|
--| Revision 1.28.4.2  2000/05/05 22:18:47  king
--| Implemented to use insert_i_th
--|
--| Revision 1.28.4.1  2000/05/03 19:08:36  oconnor
--| mergred from HEAD
--|
--| Revision 1.55  2000/05/02 18:55:19  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.54  2000/04/20 18:07:37  oconnor
--| Removed default_translate where not needed in sognal connect calls.
--|
--| Revision 1.53  2000/04/12 18:49:55  brendel
--| Removed inheritance of EV_PICK_AND_DROPABLE_IMP (from EV_ITEM_IMP).
--| Removed inheritance of EV_C_UTIL (from EV_ANY_IMP).
--|
--| Revision 1.52  2000/04/07 22:35:53  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.51  2000/04/06 20:27:05  brendel
--| Uncommented list_widget.
--|
--| Revision 1.50  2000/04/06 02:04:30  brendel
--| Changed to comply with new EV_DYNAMIC_LIST_IMP.
--| Does not work yet!
--|
--| Revision 1.49  2000/04/04 20:50:19  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.48  2000/03/13 22:05:16  king
--| Added referencing handling for reorder child
--|
--| Revision 1.47  2000/03/10 23:51:57  king
--| Fixed dereferencing of list widget
--|
--| Revision 1.46  2000/03/08 22:21:41  king
--| Added set_parent_imp in addition/removal
--|
--| Revision 1.45  2000/03/01 23:41:57  king
--| Corrected select_callback, check falsed set_selection
--|
--| Revision 1.44  2000/03/01 18:09:22  oconnor
--| released
--|
--| Revision 1.43  2000/03/01 18:04:44  king
--| Changed on_select bug comment
--|
--| Revision 1.42  2000/02/29 22:28:55  king
--| Tidied up code, fixed gtk select callback bug
--|
--| Revision 1.41  2000/02/29 18:43:40  king
--| Tidied up code
--|
--| Revision 1.40  2000/02/29 00:57:41  king
--| Added fixme to set_selected
--|
--| Revision 1.39  2000/02/28 23:59:31  king
--| Added root_tree macro
--|
--| Revision 1.38  2000/02/26 01:27:46  king
--| Implemented to contain children even if item has no parent
--|
--| Revision 1.36  2000/02/24 20:52:13  king
--| Inheriting from pick and dropable
--|
--| Revision 1.35  2000/02/24 20:09:40  king
--| Added subtree handling on addition and removal of items
--|
--| Revision 1.34  2000/02/24 18:47:55  king
--| Redefined min_wid/hgt to avoid invariant violation that doesnt apply to
--| feature needed by the tree item
--|
--| Revision 1.33  2000/02/24 01:42:14  king
--| Implemented event handling
--|
--| Revision 1.32  2000/02/22 23:57:11  king
--| Added subtree_set boolean
--|
--| Revision 1.31  2000/02/22 21:36:42  king
--| Initial implementation to fit with new structure
--|
--| Revision 1.30  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.29  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.28.6.2  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.28.6.1  1999/11/24 17:29:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.28.2.3  1999/11/09 16:53:14  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.28.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
