--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision tree item, Mswindows implementation.";
	date: "$Date$";
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
			set_text,
			destroy,
			interface,
			pnd_press,
			set_pixmap
		end

	EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM]
		redefine
			interface
		end

	--EV_PICK_AND_DROPABLE_IMP
	--	undefine
	--		set_pointer_style
	--	redefine
	--		interface
	--	end

	WEL_TREE_VIEW_ITEM
		rename
			text as wel_text,
			make as wel_make,
			children as children_nb,
			item as wel_item
		redefine
			set_text
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
		end

	initialize is
			-- Do post creation initialization.
		do
			create internal_children.make (1)
			create ev_children.make (1)
			is_initialized := True
		end

feature -- {EV_TREE_IMP}

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		local
			tree_imp: EV_TREE_IMP
		do
			tree_imp ?= parent_imp
			check
				parent_not_void: tree_imp /= Void
			end
			if press_action = Ev_pnd_start_transport then
				start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y)
				tree_imp.set_source_true
				tree_imp.set_pnd_child_source (Current)
				tree_imp.set_t_item_true
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button)
				tree_imp.set_source_false
				tree_imp.set_pnd_child_source (Void)
				tree_imp.set_t_item_false
			else
				tree_imp.set_source_false
				tree_imp.set_pnd_child_source (Void)
				tree_imp.set_t_item_false
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
		local
			p_imp: EV_PIXMAP_IMP
			w: WEL_TREE_VIEW_ITEM
			loc_image_list: WEL_IMAGE_LIST
			loc_image_index: INTEGER
			loc_top_parent_imp: EV_TREE_IMP
		do
			create pixmap
			pixmap.copy (p)
				-- We copy `p' into pixmap.
			p_imp := pixmap_imp
			w ?= Current
			loc_top_parent_imp := top_parent_imp
			loc_image_list := loc_top_parent_imp.image_list
				-- Assign values to local variables for speed.

			if p_imp.icon /= Void then
				-- If the pixmap is an icon.
				loc_image_list.add_icon (p_imp.icon)
				loc_image_index := loc_image_list.last_position
					-- Add the icon to `top_parent_imp' image_list.	
			elseif p_imp.mask_bitmap /= Void and p_imp.bitmap /= Void then
				-- If the pixmap has a bitmap mask and a bitmap.
				loc_image_list.add_masked_bitmap (p_imp.bitmap, p_imp.mask_bitmap)
				loc_image_index := loc_image_list.last_position
					-- Add a bitmap and a bitmap mask to `top_parent_imp' image_list.
			else
				check
					-- If we reach here something is wrong with the pixmap.
					False
				end
			end
			set_image (loc_image_index, loc_image_index)
			loc_top_parent_imp.set_tree_item (w)
		end

	image_index: INTEGER
		-- The index into `image_list' of `top_parent_imp' for the standard displayed image.
	
	selected_image_index: INTEGER 
		-- The index into `image_list' of `top_parent_imp' for the selected displayed image.

feature -- Access

	parent_imp: EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM]
			-- Parent implementation

	text: STRING
			-- Item text.

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

	count: INTEGER is
			-- Number of direct children of the holder.
		do
			Result := ev_children.count
		end

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
				Result := (internal_children /= Void) and then (internal_children.count > 0)
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

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		local
			tree: EV_TREE_IMP
		do
			-- First we set localy the text
			set_mask (Tvif_text)
			text := clone (txt)
			Precursor (txt)
			-- Then, we update the graphical tree.
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
					top_parent_imp.general_insert_item (item_imp, h_item, Tvi_first, pos)
				else
					top_parent_imp.general_insert_item (item_imp, h_item, (ev_children @ (pos - 1)).h_item, pos)
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
--| Revision 1.39  2000/03/24 00:18:01  rogers
--| Implemented set_pixmap.
--|
--| Revision 1.38  2000/03/22 20:23:05  rogers
--| Removed repeated inheritance from EV_PICK_AND_DROPABLE_IMP. Added pnd_press and set_pointer_style.
--|
--| Revision 1.37  2000/03/17 23:25:18  rogers
--| Undefined set_pointer_style from EV_PICK_AND_AND_DROPABLE_IMP.
--|
--| Revision 1.36  2000/03/15 17:56:29  rogers
--| Removed old command association.
--|
--| Revision 1.35  2000/03/13 20:51:43  rogers
--| Added relative position which returns position of `Current' in relation to the tree.
--|
--| Revision 1.34  2000/03/09 20:24:51  rogers
--| Added text coment, removed add_item and removed commented lines from count.
--|
--| Revision 1.33  2000/03/09 17:28:33  rogers
--| Removed redundent commented code. Insert item now uses pos - 1 correctly, instead of index when the insertion position is not one.
--|
--| Revision 1.31  2000/03/08 17:33:44  rogers
--| Set_text from WEL_TREE_VIEW is now redefined. Redundent make_with_text has been removed. Set text now sets the text to a clone of the passed text. All calls to general_insert_item now take an index.
--|
--| Revision 1.30  2000/03/07 17:43:18  rogers
--| Now inherits from EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM] instead of EV_TREE_ITEM_HOLDER_IMP. The same type change has been implemented for parent_imp, and insert item now takes EV_TREE_ITEM_IMP instead of like item_type.
--|
--| Revision 1.29  2000/03/06 21:10:21  rogers
--| Is_initialized is now set to true in initialization, and internal_children is created. Re-implemented parent_imp.
--|
--| Revision 1.28  2000/03/06 19:07:22  rogers
--| Added text and also top_parent_imp which returns the implementation of parent_tree. Set text no longer calls the EV_SIMPLE_ITEM_IMP Precursor.
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
--| Altered to fit in with the review branch. Make takes an interface. Now inherits from EV_PICK_AND_dROPABLE_IMP.
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
