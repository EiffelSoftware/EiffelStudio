indexing
	description: "Eiffel Vision tree node. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_NODE_IMP

inherit
	EV_TREE_NODE_I
		redefine
			parent_imp,
			interface
		select
			interface
		end

	EV_ITEM_IMP
		rename
			parent as old_parent
		undefine
			set_pnd_original_parent
		redefine
			parent_imp,
			destroy,
			interface,
			set_pixmap,
			remove_pixmap,
			on_parented,
			on_orphaned,
			pixmap
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		rename
			interface as il_interface
		undefine
			pnd_press,
			check_drag_and_drop_release,
			escape_pnd
		redefine
			initialize
		end

	WEL_TREE_VIEW_ITEM
		rename
			text as wel_text,
			set_text as wel_set_text,
			make as wel_make,
			children as children_nb,
			item as wel_item
		redefine
			wel_set_text,
			wel_text
		end

	WEL_TVIS_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVI_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVM_CONSTANTS
		export
			{NONE} all
		end

	WEL_ILC_CONSTANTS
		export {NONE}
			all
		end

	EV_TREE_NODE_ACTION_SEQUENCES_IMP

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			create ev_children.make (1)
			create real_text.make (0)
			wel_make
			set_mask (Tvif_text + Tvif_state + Tvif_handle)

				-- By default, no image.
			has_pixmap := False
			image_index := 0
			set_image (image_index, image_index)
		end

	initialize is
			-- Perfrom post creation initialization on `Current'.
		do
			Precursor
			create internal_children.make (1)
			is_initialized := True
		end

feature {EV_ANY_I}-- Access

	parent_imp: EV_ITEM_LIST_IMP [EV_TREE_NODE]
			-- Parent implementation.

	top_parent_imp: EV_TREE_IMP is
			-- Implementation of `parent_tree'.
		local
			loc_parent_tree: like parent_tree
		do
			loc_parent_tree := parent_tree
			if loc_parent_tree /= Void then
				Result ?= loc_parent_tree.implementation
				check
					parent_tree_not_void: Result /= Void
				end
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap of `Current'.
		local
			pix_imp: EV_PIXMAP_IMP
			image_icon: WEL_ICON
			image_list: EV_IMAGE_LIST_IMP
		do
				-- Retrieve the pixmap from the imagelist
			if has_pixmap then
				if private_pixmap = Void then
					create private_pixmap
					pix_imp ?= private_pixmap.implementation
					check
						pix_imp /= Void
					end
					image_list := top_parent_imp.image_list
					image_icon := image_list.get_icon (image_index, Ild_normal)
					pix_imp.set_with_resource (image_icon)
				end
				Result := private_pixmap
			end
		end 

feature {EV_ANY_I} -- Status report

	ev_children: ARRAYED_LIST [EV_TREE_NODE_IMP]
			-- List of the direct children of `Current'.

	is_selected: BOOLEAN is
			-- Is `Current' selected?
		do
			Result := top_parent_imp.is_selected (Current)
		end

	is_expanded: BOOLEAN is
			-- is `Current' expanded ?
		do
			Result := top_parent_imp.is_expanded (Current)
		end

	is_parent: BOOLEAN is
			-- is `Current' the parent of other items?
		do
			if top_parent_imp /= Void then
				Result := top_parent_imp.is_parent (Current)
			else
				Result := (internal_children /= Void) and then 
				(internal_children.count > 0)
			end
		end

feature {EV_ANY_I} -- Status setting

	set_parent_imp (a_parent_imp: like parent_imp) is
			-- Make `a_parent_imp' the new parent of the widget.
			-- `a_parent_imp' can be Void then the parent is the screen.
		do
			if a_parent_imp /= Void then
				parent_imp := a_parent_imp
			else
				parent_imp := Void
			end
		end

	destroy is
			-- Destroy `Current'.
		do
			Precursor {EV_ITEM_IMP}
			internal_children := Void
		end

	enable_select is
			-- Select `Current'.
		do
			top_parent_imp.select_item (Current)
		end

	disable_select is
			-- Deselect `Current'.
		do
			if top_parent_imp /= Void then
				top_parent_imp.deselect_item (Current)	
			end
		end

	set_expand (flag: BOOLEAN) is
			-- Expand `Current' if `flag', else collapse `Current'.
		do
			if flag then
				top_parent_imp.expand_item (Current)
			else
				top_parent_imp.collapse_item (Current)
			end
		end
 
feature {EV_ANY_I} -- Element change

	wel_text: STRING is
			-- Text of `Current'.
		do
			Result := clone (real_text)
		end

	text_length: INTEGER is
			-- Number of characters in `text'.
		do
			Result := real_text.count
		end

	real_text: STRING
			-- Internal `text'.

	wel_set_text (txt: STRING) is
			-- Make `txt' the new label of `Current'.
		local
			tree: EV_TREE_IMP
		do
			real_text := clone (txt)
			set_mask (Tvif_text)
			Precursor (txt)
			tree := top_parent_imp
			if tree /= Void then
				tree.notify_item_info (Current)
			end
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	--| This is redundent in this class.
	--| The events are only propagated to the tree, not a tree node.
	--| These features are required by any parent of items, however, as
	--| in this case, the parent is an item as well, they will never
	--| recieve any events. Cannot see an easy way to get rid of this
	--| dependency without complicating the inheritance structure
	--| unecessarily for pick and drop. Julian

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
		-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
		do	
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER) is
		-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
		do
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_TREE_NODE_IMP is
			-- `Result' is tree node at pixel position `x_pos', `y_pos'.
		do
		end

	screen_x: INTEGER is
			-- Horizontal offset of `Current' relative to screen.
		do
		end

	screen_y: INTEGER is
			-- Vertical offset of `Current' relative to screen.
		do
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT is
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		do
		end

	disable_default_processing is
			-- Disable default window processing.
		do
		end

	on_parented is
			-- `Current' has just been parented.
			-- Because this message is only recieved when a tree item becomes 
			-- the child of a tree, we need to recurse through all children of 
			-- the item and send this message.
		local
			original_index: INTEGER
		do
				-- We process the message only if this item is linked to a tree,
				-- i.e. `top_parent' exists.
			if parent_tree /= Void then
				original_index := ev_children.index
				from
					ev_children.start
				until
					ev_children.off
				loop
					ev_children.item.on_parented
					ev_children.forth
				end
				ev_children.go_i_th (original_index)

					-- Assign `pixmap' to tree. 
				set_pixmap_in_parent
			end
		ensure then
			index_not_changed: ev_children.index = old ev_children.index
		end

	on_orphaned is
			-- `Current' has just been orphaned.
			-- Because this message is only recieved when a tree item becomes
			-- the child of a tree, we need to recurse through all children of 
			-- the item and send this message.
		do
				-- Retrieve the pixmap from the imagelist.
			if has_pixmap and then private_pixmap /= Void then
				private_pixmap := pixmap
			end

			remove_all_direct_references
		ensure then
			index_not_changed: ev_children.index = old ev_children.index
		end

 	remove_all_direct_references is
 			-- Recurse through all children and update 
 			--`top_parent_imp.current_image_list_info' removing images
 			-- from image list as required.
 		local	
 			original_index: INTEGER
 		do
 			original_index := ev_children.index
 			from
 				ev_children.start
 			until
 				ev_children.off
 			loop
 				ev_children.item.remove_all_direct_references
 				ev_children.forth
 			end
 				-- Restore original position in `ev_children.
 			ev_children.go_i_th (original_index)
 		end
 
feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Pixmap Handling

	has_pixmap: BOOLEAN
			-- Has `Current' a pixmap?

	image_index: INTEGER
			-- Index of pixmap assigned with Current in the imageList.

	set_pixmap (p: EV_PIXMAP) is
			-- Assign `p' to the displayed pixmap.
		do
				-- We must destroy the pixmap before we set a new one,
				-- to ensure that we free up Windows GDI objects
			if private_pixmap /= Void then
				private_pixmap.destroy
				private_pixmap := Void
			end
			private_pixmap := clone (p)
			has_pixmap := True

				-- If the item is currently contained in the tree then
			if top_parent_imp /= Void then
					-- Update the parent's image list.
				set_pixmap_in_parent
			end
		end

	remove_pixmap is
			-- Remove pixmap from `Current'.
		do
			if has_pixmap then
				has_pixmap := False
				if private_pixmap /= Void then
					private_pixmap.destroy
					private_pixmap := Void
				end

					-- If the item is currently contained in the tree then..
				if top_parent_imp /= Void then
						-- Update the parent's image list.
					remove_pixmap_in_parent
				end
			end
		end

	set_pixmap_in_parent is
			-- Add/Remove the pixmap to the parent by updating the 
			-- parent's image list.
		local
			image_list: EV_IMAGE_LIST_IMP
			root_imp: like top_parent_imp
		do
			root_imp := top_parent_imp
			if root_imp = Void then
				root_imp := top_parent_imp
			end

			if has_pixmap then
				image_list := root_imp.image_list
					-- Create the image list and associate it
					-- to the control if it's not already done.
				if image_list = Void then
					root_imp.setup_image_list
					image_list := root_imp.image_list
				end

				if private_pixmap /= Void then
					image_list.add_pixmap (private_pixmap)
					image_index := image_list.last_position
					private_pixmap.destroy
					private_pixmap := Void
				end
			else
				image_index := 0 -- transparent image.
			end
			set_image (image_index, image_index)
			root_imp.set_tree_item (Current)
		end

	remove_pixmap_in_parent is
			-- Remove the pixmap from the parent by updating the parent's image 
			-- list.
		do
			set_image (0, 0) -- 0 = transparent image.
			top_parent_imp.set_tree_item (Current)
		end

	general_reset_pixmap is
			-- Reset the pixmap
			--| For example: if the size of displayed has changed.
		local	
			c: like ev_children
		do
				-- Reset the current pixmap
			set_pixmap_in_parent

				-- Reset the pixmap of all children.
			c := ev_children
			from
				c.start
			until
				c.after
			loop
				c.item.general_reset_pixmap
				c.forth
			end
		end

feature {EV_TREE_IMP} -- Implementation, pick and drop

	set_pnd_original_parent is
			-- Assign `top_parent_imp' to `pnd_original_parent'.
			--| Redefined as the widget is not parent_imp for this
			--| item. See comment in this feature within
			--| EV_PICK_AND_DROPABLE_ITEM_IMP
		do
			pnd_original_parent := top_parent_imp
		end
	
feature {EV_TREE_IMP} -- Implementation

	internal_children: ARRAYED_LIST [EV_TREE_NODE_IMP]
			-- Holds the children of `Current'.
			--| May be void if `Current' is parented.

	set_internal_children (list: ARRAYED_LIST [EV_TREE_NODE_IMP]) is
			-- Make `list' the new list of children.
		do
			internal_children := list
		end

	relative_position: TUPLE [INTEGER, INTEGER] is
			-- `Result' is position relative to `parent_imp'.
		local
			loop_parent: EV_TREE_NODE_IMP
			counter: INTEGER
			sx: INTEGER
			sy: INTEGER
		do
			from
				loop_parent := Current
			until
				loop_parent = Void
			loop
				loop_parent ?= loop_parent.parent_imp
				counter := counter + 1
			end
			sx := top_parent_imp.indent * counter + 1
			--|FIXME The relative y_position is always returned as 0.
			sy := 0
			create Result.make
			Result.put (sx, 1)
			Result.put (sy, 2)
		end

feature {NONE} -- Implementation

	insert_item (item_imp: EV_TREE_NODE_IMP; pos: INTEGER) is
			-- Insert `item_imp' at the `index' position.
		do
			if top_parent_imp /= Void then
				if pos = 1 then
					top_parent_imp.general_insert_item 
					(item_imp, h_item, Tvi_first, pos)
				else
					top_parent_imp.general_insert_item
					(item_imp, h_item, (ev_children @ (pos - 1)).h_item, pos)                                                                   
				end
			else
				internal_children.go_i_th (pos)
				internal_children.put_left (item_imp)
			end
		end

	remove_item (item_imp: EV_TREE_NODE_IMP) is
			-- Remove `item_imp' from `Current'.
		do
			if top_parent_imp /= Void then
				top_parent_imp.general_remove_item (item_imp)
			else
				internal_children.prune_all (item_imp)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_NODE

end -- class EV_TREE_NODE_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------


--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.5  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.4  2001/06/14 00:10:43  rogers
--| Undefined version of `escape_pnd' originally from EV_PICK_AND_DROPABLE_IMP,
--| we must now use the version from EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--|
--| Revision 1.3  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.30  2001/06/05 22:25:27  rogers
--| Improved comment in set_pixmap.
--|
--| Revision 1.1.2.29  2001/06/05 21:54:40  rogers
--| Set_pixmap now uses clone internally instead of copy. Saves creation line.
--|
--| Revision 1.1.2.28  2001/06/05 19:21:12  rogers
--| Moved creation of pixmap out of `if' statement in `set_pixmap'.
--|
--| Revision 1.1.2.27  2001/06/05 18:35:59  rogers
--| We now create `private_pixmap' during `set_pixmap' if Void.
--|
--| Revision 1.1.2.26  2001/06/04 17:11:17  rogers
--| Updated to use copy instead of ev_clone.
--|
--| Revision 1.1.2.25  2001/05/15 22:54:58  rogers
--| Removed toggle, as we now call interface.toggle.
--|
--| Revision 1.1.2.24  2001/02/06 01:49:56  rogers
--| Added find_item_at_position, screen_x and screen_y.
--|
--| Revision 1.1.2.23  2000/12/29 18:25:06  rogers
--| Added disable_default_processing.
--|
--| Revision 1.1.2.22  2000/11/09 17:05:36  pichery
--| Changed pixmap handling: `pixmap' now build an EV_PIXMAP
--| from the WEL_ICON extracted from the WEL_IMAGE_LIST
--| associated with the parent of this item.
--|
--| Revision 1.1.2.21  2000/10/19 23:16:50  rogers
--| Removed three fixmes and replaced with a detailed description of
--| why there are thre features that do nothing within this class.
--|
--| Revision 1.1.2.20  2000/10/12 15:50:22  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.1.2.19  2000/09/26 03:53:36  manus
--| Cosmetics.
--|
--| Revision 1.1.2.18  2000/09/26 00:33:05  rogers
--| Set_pixmap_in_parent no longer creates a temporary pixmap implementation,
--| it now directly inserts private_icon into the image_list. This reduces
--| temporary GDI use.
--|
--| Revision 1.1.2.17  2000/09/25 20:07:37  rogers
--| Now uses private icon. This drastically improves the number of GDI
--| objects used.
--|
--| Revision 1.1.2.16  2000/09/25 15:49:49  manus
--| Removed pixmap copy because we do not need the copy here since we use the pixmap just
--| for a minimal amount of time and then discard it (it saves us so manu GDI objects).
--|
--| Revision 1.1.2.15  2000/09/13 22:15:09  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.1.2.14  2000/08/18 19:33:00  rogers
--| Corrected comment for remove_pixmap.
--|
--| Revision 1.1.2.13  2000/08/11 19:19:47  rogers
--| Fixed copyright clause to use ! instead of |. Removed clear_items as it is
--| redundent.
--|
--| Revision 1.1.2.12  2000/08/11 01:00:00  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.1.2.11  2000/08/03 23:34:59  rogers
--| Changed type of parent_imp from
--| 	EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_NODE] to
--| 	EV_ITEM_LIST_IMP [EV_TREE_NODE]
--|
--| Revision 1.1.2.10  2000/08/02 22:47:43  rogers
--| Changed inheritence from EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_NODE] to
--| EV_ITEM_LIST_IMP [EV_TREE_NODE].
--|
--| Revision 1.1.2.9  2000/07/24 23:57:19  rogers
--| Now inherits EV_TREE_NODE_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.1.2.8  2000/07/01 09:00:45  pichery
--| Fixed bug in pixmap settings
--|
--| Revision 1.1.2.7  2000/06/19 21:45:52  manus
--| Now `pixmap' of `EV_PIXMAPABLE_IMP' returns a copy of the internal pixmap to
--| satisfy the Vision2 interface behavior.
--|
--| Revision 1.1.2.6  2000/06/09 20:10:15  rogers
--| Added internal_propagate_pointer_double_press
--|
--| Revision 1.1.2.5  2000/06/05 16:50:39  manus
--| Added `text_length' in `EV_TEXTABLE_IMP' to improve the performance of its
--| counterpart `text' in order to reduce creation of useless empty strings.
--|
--| Revision 1.1.2.4  2000/05/27 01:53:48  pichery
--| Cosmetics
--|
--| Revision 1.1.2.3  2000/05/18 23:07:05  rogers
--| Set_parent renamed to set_parent_imp and now takes parameter of type
--| parent_imp.
--|
--| Revision 1.1.2.2  2000/05/18 00:14:09  rogers
--| Chnaged passed parameter name.
--|
--| Revision 1.1.2.1  2000/05/16 20:25:08  king
--| Initial
--|
--| Revision 1.24.4.3  2000/05/11 00:03:38  king
--| Made tooltipable
--|
--| Revision 1.24.4.2  2000/05/09 23:00:08  king
--| Accounted for deselectable integration
--|
--| Revision 1.24.4.1  2000/05/03 19:09:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.68  2000/04/27 23:16:27  rogers
--| Undefined check_drag_and_drop_release from EV_ARRAYED_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.67  2000/04/26 04:05:20  pichery
--| EV_IMAGE_LIST_IMP.add_pixmap now
--| takes an EV_PIXMAP as parameter.
--| -->Adapting
--|
--| Revision 1.66  2000/04/26 00:03:10  pichery
--| Slight redesign of the pixmap handling in
--| trees and multi-column lists.
--|
--| Added `set_pixmaps_size', `pixmaps_width'
--| and `pixmaps_height' in the interfaces and
--| in the implementations.
--|
--| Fixed bugs in multi-column lists and trees.
--|
--| Revision 1.65  2000/04/25 01:16:35  pichery
--| Changed the handling of pixmaps.
--|
--| Revision 1.64  2000/04/21 21:54:55  rogers
--| Removed set_capture, release_capture, set_heavy_capture,
--| release_heavy_capture and set_pointer_style.
--|
--| Revision 1.63  2000/04/14 23:24:26  rogers
--| Removed re-definition of pnd_press as now only
--| set_pnd_original_parent is redefined.
--|
--| Revision 1.62  2000/04/14 21:33:44  rogers
--| Redefined pnd_press to call top_parent_imp.
--|
--| Revision 1.61  2000/04/14 17:37:15  rogers
--| Pnd_press is now inherited from EV_ITEM_IMP, previously
--| EV_ARRAYED_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.60  2000/04/11 19:04:02  rogers
--| Insert_item and remove_item no longer modify ev_children.
--|
--| Revision 1.59  2000/04/11 17:10:03  rogers
--| Removed pnd_press.
--|
--| Revision 1.58  2000/04/10 18:28:09  brendel
--| Modified creation sequence.
--|
--| Revision 1.57  2000/04/07 22:31:51  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.56  2000/04/05 21:16:11  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.55  2000/03/30 19:51:58  rogers
--| Changed all instances of:
--| 	set_source_true -> set_parent_source_true
--| 	set_pnd_child_source -> set_item_source
--| 	set_t_item_true -> set_item_source_true
--|
--| Revision 1.54.2.1  2000/04/03 18:07:52  brendel
--| Removed count.
--|
--| Revision 1.54  2000/03/30 18:31:58  rogers
--| Improved comments, added pre-conditions, added invariant
--|
--| Revision 1.53  2000/03/29 20:36:26  brendel
--| Modified text handling in compliance with new EV_TEXTABLE_IMP.
--|
--| Revision 1.52  2000/03/29 06:59:49  pichery
--| Improved the add of pixmaps in an item.
--|
--| Revision 1.51  2000/03/28 22:52:42  rogers
--| Fixed index alteration bug in orphaning a sub tree structure.
--| Simplified on_orphaned.
--|
--| Revision 1.50  2000/03/28 18:39:43  rogers
--| Pnd_press now uses top_parent_imp when retrieveing the parent.
--| Previously used parent_imp which was wrong.
--|
--| Revision 1.49  2000/03/28 17:32:23  rogers
--| on_orphaned now only reduces high indices if an image was removed
--| from the image list.
--|
--| Revision 1.48  2000/03/28 01:11:02  rogers
--| Added reduce_image_list_references.
--|
--|
--| Revision 1.47  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.46  2000/03/27 23:11:25  rogers
--| Formatting.
--|
--| Revision 1.42  2000/03/24 20:51:52  rogers
--| Added on_parented and set_pixmap_in_parent. This allows the pixmaps to be 
--| set before parenting the items.
--|
--| Revision 1.41  2000/03/24 19:16:20  rogers
--| Redefined initialize from EV_ARRAYED_LIST_ITEM_HOLDER_IMP. Removed 
--| commented PND inheritence.
--|
--| Revision 1.40  2000/03/24 17:15:36  rogers
--| Added tree_view_pixmap_height, tree_view_pixmap_width, and fixed 
--| set_pixmap so that repeated icons are shared internally in the image list.
--|
--| Revision 1.39  2000/03/24 00:18:01  rogers
--| Implemented set_pixmap.
--|
--| Revision 1.38  2000/03/22 20:23:05  rogers
--| Removed repeated inheritance from EV_PICK_AND_DROPABLE_IMP. Added 
--|pnd_press and set_pointer_style.
--|
--| Revision 1.37  2000/03/17 23:25:18  rogers
--| Undefined set_pointer_style from EV_PICK_AND_AND_DROPABLE_IMP.
--|
--| Revision 1.36  2000/03/15 17:56:29  rogers
--| Removed old command association.
--|
--| Revision 1.35  2000/03/13 20:51:43  rogers
--| Added relative position which returns position of `Current' in relation 
--|to the tree.
--|
--| Revision 1.34  2000/03/09 20:24:51  rogers
--| Added text coment, removed add_item and removed commented lines from count.
--|
--| Revision 1.33  2000/03/09 17:28:33  rogers
--| Removed redundent commented code. Insert item now uses pos - 1 correctly,
--| instead of index when the insertion position is not one.
--|
--| Revision 1.31  2000/03/08 17:33:44  rogers
--| Set_text from WEL_TREE_VIEW is now redefined. Redundent make_with_text has
--| been removed. Set text now sets the text to a clone of the passed text. 
--| All calls to general_insert_item now take an index.
--|
--| Revision 1.30  2000/03/07 17:43:18  rogers
--| Now inherits from EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM] instead 
--| of EV_TREE_ITEM_HOLDER_IMP. The same type change has been implemented for
--| parent_imp, and insert item now takes EV_TREE_ITEM_IMP instead of 
--| like item_type.
--|
--| Revision 1.29  2000/03/06 21:10:21  rogers
--| Is_initialized is now set to true in initialization, and internal_children
--| is created. Re-implemented parent_imp.
--|
--| Revision 1.28  2000/03/06 19:07:22  rogers
--| Added text and also top_parent_imp which returns the implementation of 
--| parent_tree. Set text no longer calls the EV_SIMPLE_ITEM_IMP Precursor.
--|
--| Revision 1.27  2000/02/19 06:34:12  oconnor
--| removed old command stuff
--|
--| Revision 1.26  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.25  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.6.4  2000/02/05 02:10:50  brendel
--| Removed feature `destroyed'.
--|
--| Revision 1.24.6.3  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.6.2  1999/12/17 17:29:52  rogers
--| Altered to fit in with the review branch. Make takes an interface. Now
--| inherits from EV_PICK_AND_dROPABLE_IMP.
--|
--| Revision 1.24.6.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
