--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision tree item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
		redefine
			parent_imp,
			interface
		select
			parent
		end

	EV_SIMPLE_ITEM_IMP
		rename
			parent as old_simple_parent
		undefine
			set_pointer_style
		redefine
			parent_imp,
			destroy,
			interface,
			pnd_press,
			set_pixmap,
			on_parented,
			on_orphaned
		end

	EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM]
		redefine
			initialize,
			interface
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

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the item.
		do
			base_make (an_interface)
			wel_make
			set_mask (Tvif_text + Tvif_state + Tvif_handle)
			create real_text.make (0)
		end

	initialize is
			-- Do post creation initialization.
		do
			Precursor
			create internal_children.make (1)
			create ev_children.make (1)
			is_initialized := True
		end

feature -- {EV_TREE_IMP}

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
			-- Possible PND status modification.
		local
			tree_imp: EV_TREE_IMP
		do
			tree_imp ?= top_parent_imp
			check
				parent_not_void: tree_imp /= Void
			end
			if press_action = Ev_pnd_start_transport then
				start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, 
				a_screen_y)
				tree_imp.set_parent_source_true
				tree_imp.set_item_source (Current)
				tree_imp.set_item_source_true
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button)
				tree_imp.set_parent_source_false
				tree_imp.set_item_source (Void)
				tree_imp.set_item_source_false
			else
				tree_imp.set_parent_source_false
				tree_imp.set_item_source (Void)
				tree_imp.set_item_source_false
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to `parent_imp' pointer style.
		do
			if top_parent_imp /= Void then
				top_parent_imp.set_pointer_style (c)
			end
		end

	set_pixmap (p: EV_PIXMAP) is
			-- Assign `p' to the displayed pixmap.
		require else
			pixmap_not_void: pixmap /= Void
		do
			if pixmap = Void then
				create pixmap
			end
			pixmap.copy (p)
				-- We copy `p' into pixmap.
			if top_parent_imp /= Void then
				-- If the item is currently contained in the tree then
				set_pixmap_in_parent
					-- Update the parent's image list.
			end
		end

	on_parented is
			-- `Current' has just been parented.
			-- Because this message is only recieved when a tree item becomes 
			-- the child of a tree, we need to recurse through all children of 
			-- the item and send this message.
		local
			original_index: INTEGER
		do
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
			if pixmap /= Void then
				-- If `Current' has a pixmap 
				set_pixmap_in_parent
					-- Assign `pixmap' to tree. 
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
			remove_all_direct_references
		ensure then
			index_not_changed: ev_children.index = old ev_children.index
		end

	reduce_image_list_references (i: INTEGER) is
			-- Decrease any references to an image position > `i' by one.
		require else
			image_position_non_negative: i >= 0
		local
			original_index: INTEGER
		do
			original_index := ev_children.index
			from	
				ev_children.start
			until
				ev_children.off
			loop
				ev_children.item.reduce_image_list_references (i)
				ev_children.forth
			end
			ev_children.go_i_th (original_index)
				-- Restore original position in `ev_children'.
			if image_index > i then
				image_index := image_index - 1
					-- Reduce `image_index'
				set_image (image_index, image_index)
					-- Image used is now the image at position `image index' in
					-- the image list.
				top_parent_imp.set_tree_item (Current)
			end
		end

	remove_all_direct_references is
			-- Recurse through all children and update 
			--`top_parent_imp.current_image_list_info' removing images
			-- from image list as required.
		local	
			original_index: INTEGER
			loc_tuple: TUPLE[INTEGER, INTEGER]
			current_images: HASH_TABLE [TUPLE[INTEGER, INTEGER], INTEGER]
			item_value: INTEGER
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
			ev_children.go_i_th (original_index)
				-- Restore original position in `ev_children.
			if pixmap /= Void then
				-- If the item has a pixmap then 
				if pixmap_imp.icon.item /= Void then
					item_value := cwel_pointer_to_integer 
					(pixmap_imp.icon.item)
				else
					item_value := cwel_pointer_to_integer 
					(pixmap_imp.bitmap.item)
				end
				current_images := top_parent_imp.current_image_list_info
					-- Retrieve the information about the image list.
				loc_tuple := current_images.item (item_value)
					-- Retrieve the tuple of info correspoding to 
					-- the pixmap of the item.
				if loc_tuple.integer_item (2) > 0 then
					loc_tuple.enter (loc_tuple.integer_item (2) - 1, 2)
						-- Decrease and store the number of items referencing
						-- this image.
					if loc_tuple.integer_item (2) = 0 then
						top_parent_imp.reduce_image_list_references (
							image_index)
							-- Reduce all indices greater than `image_index' by
							-- one.
						top_parent_imp.image_list.remove_image 
							(loc_tuple.integer_item (1))
							-- Remove the icon from the image_list
						current_images.remove (item_value)
							-- Remove the image from our 
							-- current_image_list_info
					end
				end
			end
		end

	set_pixmap_in_parent is
			-- Add the pixmap to the parent by updating the parent's image 
			-- list.
		local
			p_imp: EV_PIXMAP_IMP
			loc_image_list: WEL_IMAGE_LIST
			loc_top_parent_imp :EV_TREE_IMP
			current_images: HASH_TABLE [TUPLE[INTEGER, INTEGER], INTEGER]
			item_value: INTEGER
			loc_tuple: TUPLE [INTEGER, INTEGER]
		do
			p_imp := pixmap_imp
			loc_top_parent_imp := top_parent_imp
			loc_image_list := loc_top_parent_imp.image_list
			current_images := loc_top_parent_imp.current_image_list_info
				-- Assign values to local variables for speed.

			if p_imp.icon /= Void then
				-- If the pixmap is an icon.
				item_value := cwel_pointer_to_integer (p_imp.icon.item)
					-- Assign `icon.item' to `item_value'
				If not current_images.has (item_value) then
					-- If `p_imp.icon' is not already in image_list then
					loc_image_list.add_icon (p_imp.icon)
					image_index := loc_image_list.last_position
					current_images.extend ([image_index, 1], item_value)	
					-- Add the icon to image_list and set image_index.
				else
					loc_tuple := current_images.item (item_value)
					image_index := loc_tuple.integer_item (1)
						-- `p_imp.icon' already in image list so set 
						-- `image_index' to this.
					loc_tuple.enter (loc_tuple.integer_item (2) + 1, 2)
						-- Increase and store the number of items referencing
						-- this image.
				end
			else
				--|--------------------------------------------------------
				--| FIXME ARNAUD: check that the image is not already in
				--| `current_images'. Can you do that Julian?
				--|--------------------------------------------------------
				if p_imp.bitmap.height > tree_view_pixmap_height or
					p_imp.bitmap.height > tree_view_pixmap_width then
					p_imp.stretch (16, 16)
				end
				if p_imp.mask_bitmap /= Void then
					loc_image_list.add_masked_bitmap(
						p_imp.bitmap, 
						p_imp.mask_bitmap
						)
				else
					loc_image_list.add_bitmap(p_imp.bitmap)
				end
						
				image_index := loc_image_list.last_position
			end
			io.put_string (image_index.out)
			set_image (image_index, image_index)
			loc_top_parent_imp.set_tree_item (Current)
		end

	image_index: INTEGER
		-- The index into `image_list' of `top_parent_imp' for the standard 
		-- displayed image.
	
	selected_image_index: INTEGER 
		-- The index into `image_list' of `top_parent_imp' for the selected 
		-- displayed image.

	tree_view_pixmap_height: INTEGER is 16
		-- The height of a pixmap in a windows tree view.
	
	tree_view_pixmap_width: INTEGER is 16
		-- The width of a pixmap in a windows tree view.

feature -- Access

	parent_imp: EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM]
			-- Parent implementation

	top_parent_imp: EV_TREE_IMP is
			-- Implementation of `parent_tree'.
		do
			if parent_tree /= Void then
				Result ?= parent_tree.implementation
				check
					parent_tree_not_void: Result /= Void
				end
			end
		end

feature -- Status report

	ev_children: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			-- List of the direct children of the tree-item.

	is_selected: BOOLEAN is
			-- Is the item selected?
		
		do
			Result := top_parent_imp.is_selected (Current)
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		do
			Result := top_parent_imp.is_expanded (Current)
		end

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		do
			if top_parent_imp /= Void then
				Result := top_parent_imp.is_parent (Current)
			else
				Result := (internal_children /= Void) and then 
				(internal_children.count > 0)
			end
		end

feature -- Status setting

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if par /= Void then
				parent_imp ?= par.implementation
			else
				parent_imp := Void
			end
		end

	destroy is
			-- Destroy the current item
		do
			{EV_SIMPLE_ITEM_IMP} Precursor
			internal_children := Void
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				top_parent_imp.select_item (Current)
			else
				top_parent_imp.deselect_item (Current)
			end
		end

	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		do
			if flag then
				top_parent_imp.expand_item (Current)
			else
				top_parent_imp.collapse_item (Current)
			end
		end
 
feature -- Element change

	wel_text: STRING is
			-- Item text.
		do
			Result := clone (real_text)
		end

	real_text: STRING
			-- Internal `text'.

	wel_set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
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

	clear_items is
			-- Clear all the children of the tree-item.
			-- It destroys them.
		local
			c: ARRAYED_LIST [EV_TREE_ITEM_IMP]
		do
			c := ev_children
			from
				c.start
			until
				c.after
			loop
				c.item.destroy
				c.forth
			end
		end

feature {NONE} -- Implementation, pick and drop

	set_capture is
			-- Grab user input.
		do
			top_parent_imp.set_capture
		end

	release_capture is
			-- Release user input.
		do
			top_parent_imp.release_capture
		end

	set_heavy_capture is
			-- Grab user input.
		do
			top_parent_imp.set_heavy_capture
		end

	release_heavy_capture is
			-- Release user input.
		do
			top_parent_imp.release_heavy_capture
		end

feature {EV_TREE_IMP} -- Implementation

	internal_children: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			-- Void if there is a parent, store the children
			-- otherwise.

	set_internal_children (list: ARRAYED_LIST [EV_TREE_ITEM_IMP]) is
			-- Make `list' the new list of children
		do
			internal_children := list
		end

	relative_position: TUPLE [INTEGER, INTEGER] is
			-- `Result' is position relative to `parent_imp'.
		local
			tree_item_imp: EV_TREE_ITEM_IMP
			loop_parent: EV_TREE_ITEM_IMP
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

	insert_item (item_imp: EV_TREE_ITEM_IMP; pos: INTEGER) is
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
				-- We now add the child directly into ev_children.
			ev_children.go_i_th (pos - 1)
			ev_children.put_right (item_imp)

		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item_imp' from the children.
		do
			if top_parent_imp /= Void then
				top_parent_imp.general_remove_item (item_imp)
				ev_children.remove
			else
				internal_children.prune_all (item_imp)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_ITEM

invariant
		pixmap_image_list_index_non_negative: image_index >= 0

end -- class EV_TREE_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
