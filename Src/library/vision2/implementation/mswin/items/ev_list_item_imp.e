indexing
	description: "Eiffel Vision list item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			parent_imp, interface
		end

	EV_ITEM_IMP
		export
			{EV_LIST_IMP} pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		undefine
			parent
		redefine
			set_pixmap, pixmap, remove_pixmap, on_parented, on_orphaned,
			parent_imp, interface
		end

	EV_TEXTABLE_IMP
		undefine
			set_text, text
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface,
			set_tooltip
		end

	WEL_LVM_CONSTANTS
		export
			{NONE} all
		end

	WEL_ILC_CONSTANTS
		export {NONE}
			all
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_IMP
		export
			{EV_LIST_IMP, EV_COMBO_BOX_IMP} select_actions_internal, deselect_actions_internal
		end

create
	make


feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the widget with `par' as parent.
		do
			base_make (an_interface)
			--wel_make
			create internal_text.make (0)
		end

	initialize is
			-- Initialize `Current'.
		do
			create lv_item.make
			create cb_item.make
			is_initialized := True
		end

feature -- Access

	wel_set_text (a_string: STRING) is
			-- Set the text of the item to `a_string'
		do
			internal_text := clone (a_string)	
		end
	
	wel_text: STRING is
			-- Text of the item.
		do
			Result := clone (internal_text)
		end

	text_length: INTEGER is
			-- Length of text in characters.
		do
			Result := internal_text.count
		end

	text: STRING is
		do
			Result := lv_item.text
			if Result.is_empty then
				Result := Void
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap of `Current'.
		local
			pix_imp: EV_PIXMAP_IMP
			image_icon: WEL_ICON
		do
				-- Retrieve the pixmap from the imagelist
			if has_pixmap then
				if private_pixmap = Void then
					create Result
					pix_imp ?= Result.implementation
					check
						pix_imp /= Void
					end
					image_icon := parent_imp.image_list.get_icon (image_index, Ild_normal)
					image_icon.enable_reference_tracking
					pix_imp.set_with_resource (image_icon)
					image_icon.decrement_reference
				else
					Result := private_pixmap
				end
			end
		end 

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected?
		do
			if parent_imp /= Void then
				Result := parent_imp.internal_is_selected (Current)
			end
		end

feature -- Status setting

	set_text (a_text: STRING) is
		do
			wel_set_text (a_text)
			lv_item.set_text (a_text)
			cb_item.set_text (a_text)
			if parent_imp /= Void then
				parent_imp.refresh_item (Current)
			end
		end

	enable_select is
			-- Set `is_selected' `True'.
		do
				-- If `Current' is already selected, then
				-- there is no need to do anything.
			if not is_selected then
				parent_imp.internal_select_item (Current)	
			end
		end

	disable_select is
			-- Set `is_selected' `False'.
		do
				-- If `Current' is not seelcted then
				-- there is no need to do anything.
			if is_selected then
				parent_imp.internal_deselect_item (Current)	
			end
		end

feature {EV_ANY_I} -- Access

	index: INTEGER is
			-- One-based Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current)
		end

	parent_imp: EV_LIST_ITEM_LIST_IMP
		-- Parent of `Current'
	
	set_parent_imp (par_imp: like parent_imp) is
			-- Assign 'par_imp' to `parent_imp'.
		do
			if par_imp /= Void then
				parent_imp := par_imp
			else
				parent_imp := Void
			end
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation.

	relative_y: INTEGER is
			-- `Result' is relative y coordinate in pixels to parent.
		require
			parent_not_void: parent_imp /= Void
		do
			Result := parent_imp.get_item_position (index - 1).y
		end

	is_displayed: BOOLEAN is
			-- Can the user view `Current'?
		local
			local_index: INTEGER -- current index
			first_index: INTEGER -- first displayed index
			last_index: INTEGER	-- last displayed index
			combo_imp: EV_COMBO_BOX_IMP
			is_visible: BOOLEAN -- Is the list visible?
		do
			if parent_imp /= Void then -- otherwise...it's not displayed
				local_index := index - 1
				first_index := parent_imp.top_index
				last_index := first_index + parent_imp.visible_count

				combo_imp ?= parent_imp
				if combo_imp /= Void then
						-- The parent is not a combo. Is the list visible?
					is_visible := combo_imp.list_shown
				else
						-- The parent is not a combo, the list is
						-- always visible
					is_visible := True
				end

				Result := is_visible and then
						  local_index >= first_index and
						  local_index < last_index
			end
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Pixmap Handling

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

				-- If the item is currently contained in the list then
			if parent_imp /= Void then
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

					-- If the item is currently contained in the list then..
				if parent_imp /= Void then
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
		do
			if has_pixmap then
				image_list := parent_imp.image_list
					-- Create the image list and associate it
					-- to the control if it's not already done.
				if image_list = Void then
					parent_imp.setup_image_list
					image_list := parent_imp.image_list
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
			parent_imp.set_pixmap_of_child (Current, index, image_index)
		end

	remove_pixmap_in_parent is
			-- Remove pixmap of `Current'.
		do
			if parent_imp.image_list /= Void then
				parent_imp.remove_pixmap_of_child (Current, index)
			end
		end

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		do
			tooltip := clone (a_tooltip)
		end

feature {EV_ITEM_LIST_I} -- Implementation

	on_parented is
		do
			if parent_imp /= Void then
				set_pixmap_in_parent
			end
		end

	on_orphaned is
			-- `Current' has just been orphaned.
		do
				-- Retrieve the pixmap from the imagelist.
			if has_pixmap and then private_pixmap /= Void then
				private_pixmap := pixmap
			end
		end

feature {NONE} -- Implementation

	internal_text: STRING
			-- Text of `Current'.

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	lv_item: WEL_LIST_VIEW_ITEM
		-- An internal WEL_LIST_VIEW item

	cb_item: WEL_COMBO_BOX_EX_ITEM
		-- An internal WEL_COMBO_BOX_EX item

feature {EV_ANY_I} -- Implementation

	interface: EV_LIST_ITEM

end -- class EV_LIST_ITEM_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.54  2001/06/07 23:08:11  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.24.4.31  2001/06/05 22:25:26  rogers
--| Improved comment in set_pixmap.
--|
--| Revision 1.24.4.30  2001/06/05 21:54:39  rogers
--| Set_pixmap now uses clone internally instead of copy. Saves creation line.
--|
--| Revision 1.24.4.29  2001/06/05 18:35:58  rogers
--| We now create `private_pixmap' during `set_pixmap' if Void.
--|
--| Revision 1.24.4.28  2001/06/04 17:11:17  rogers
--| Updated to use copy instead of ev_clone.
--|
--| Revision 1.24.4.27  2001/05/29 18:05:03  rogers
--| Enable_select and disable_select now only call the parent if they are
--| not in the desired state. This fixes problems with select actions being
--| called too many times.
--|
--| Revision 1.24.4.26  2001/03/04 22:10:49  pichery
--| Added reference tracking
--|
--| Revision 1.24.4.25  2001/01/29 16:27:45  rogers
--| Redefined set_tooltip and implemented.
--|
--| Revision 1.24.4.23  2000/12/12 22:34:43  rogers
--| is_selected now only queries parent_imp if parent_imp /= Void.
--|
--| Revision 1.24.4.22  2000/11/29 00:47:37  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.24.4.21  2000/11/09 17:00:37  pichery
--| Changed pixmap handling: `pixmap' now build an EV_PIXMAP
--| from the WEL_ICON extracted from the WEL_IMAGE_LIST
--| associated with the parent of this item.
--|
--| Revision 1.24.4.20  2000/08/29 23:04:12  rogers
--| Removed unreferenced locals from set_pixmap and remove_pixmap.
--|
--| Revision 1.24.4.19  2000/08/21 20:26:44  rogers
--| Set_pixmap and Remove_pixmap no longer need to query the type of their
--| parent, and perform different actions to remove the pixmap dependent
--| on their parent type. THey now call set_pixmap_in_parent and
--| remove_pixmap_in_parent, directly on the parent which then performs the old
--| functionality.
--|
--| Revision 1.24.4.17  2000/08/11 19:18:44  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.24.4.16  2000/08/08 00:35:23  manus
--| Added missing export clauses of some internal action sequences to EV_LIST_IMP
--| and EV_COMBO_BOX_IMP:
--| - select_actions_internal
--| - deselect_actions_internal
--|
--| `Text' now returns `Void' when `text' is empty.
--|
--| Revision 1.24.4.15  2000/07/28 02:42:04  pichery
--| Fixed bug in `set_text' of EV_LIST_ITEM_IMP (changes
--| were not reflected in the parent if the item was already in a
--| list).
--|
--| Revision 1.24.4.14  2000/07/24 22:46:01  rogers
--| Now inherits EV_LIST_ITEM_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.24.4.13  2000/07/18 20:36:56  rogers
--| Changed export of pixmap features to EV_LIST_ITEM_LIST_IMP.
--|
--| Revision 1.24.4.12  2000/07/18 19:31:00  rogers
--| Set_pixmap_in_parent now calls set_selected_image on the
--| WEL_COMBO_BOX_EX_ITEM. This fixes a bug where the selected item was not
--| visible.
--|
--| Revision 1.24.4.11  2000/07/18 00:07:38  rogers
--| Removed inheritence from WEL_LIST_VIEW_ITEM as `Current' can be contained
--| in a WEL_COMBO_BOX_EX as well. Added lv_item: WEL_LIST_VIEW_ITEM and
--| cb_item: WEL_COMBO_BOX_EX_ITEM to replace the inheritence. Modified
--| text and set_text appropriately. Re-implemented set_pixmap_in_parent.
--|
--| Revision 1.24.4.10  2000/07/17 18:44:59  rogers
--| Initial implementation of remove_pixmap_in_parent.
--| Fixed bug in set_pixmap_in_parent.
--|
--| Revision 1.24.4.8  2000/07/14 17:45:39  rogers
--| Set_pixmap_in_parent now associates the image_list with the parent if
--| not already associated.
--|
--| Revision 1.24.4.7  2000/07/14 17:25:07  rogers
--| Redfined set_pixmap, remove_pixmap and on_parented ready to handle
--| assition of pixmaps. Added set_pixmap_in_parent and
--| remove_pixmap_in_parent to be implemented."
--|
--| Revision 1.24.4.6  2000/06/12 16:08:52  rogers
--| Comments, formatting.
--|
--| Revision 1.24.4.5  2000/06/05 16:50:39  manus
--| Added `text_length' in `EV_TEXTABLE_IMP' to improve the performance of its
--| counterpart `text' in order to reduce creation of useless empty strings.
--|
--| Revision 1.24.4.4  2000/05/30 15:52:18  rogers
--| Removed unreferenced variables from relative_y.
--|
--| Revision 1.24.4.3  2000/05/18 23:11:38  rogers
--| Set_parent renamed to set_parent_imp and now takes a parameter of type
--| parent_imp.
--|
--| Revision 1.24.4.2  2000/05/10 23:45:57  king
--| Made tooltipable
--|
--| Revision 1.24.4.1  2000/05/03 19:09:10  oconnor
--| mergred from HEAD
--|
--| Revision 1.52  2000/04/21 22:27:10  rogers
--| Removed redefined pnd_press.
--|
--| Revision 1.51  2000/04/21 22:09:26  rogers
--| Removed set_capture, release_capture, set_heavy_capture,
--| release_heavy_capture and set_pointer_style.
--|
--| Revision 1.50  2000/04/20 19:00:18  brendel
--| Redefined wel_text and wel_set_text.
--| Initialized internal_text to "".
--|
--| Revision 1.49  2000/04/20 01:01:56  pichery
--| - internal_select -> internal_select_item
--| - internal_deselect -> internal_deselect_item
--| - Cosmetics
--| - Some change to take into account that
--|   the elements can be added in a COMBO_BOX.
--|
--| Revision 1.48  2000/04/19 01:28:05  pichery
--| Fixed bugs...
--|
--| Revision 1.47  2000/04/18 21:19:47  pichery
--| Changed the implementation of EV_LIST_IMP. It now
--| inherit from WEL_LIST_VIEW instead of WEL_LIST_BOX.
--|
--| Adapted EV_LIST_ITEM to take that into account. Added
--| inheritance from WEL_LIST_VIEW_ITEM.
--|
--| Revision 1.46  2000/04/07 22:31:51  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.45  2000/03/30 19:51:35  rogers
--| Changed all instances of:
--| 	set_source_true -> set_parent_source_true
--| 	set_pnd_child_source -> set_item_source
--| 	set_t_item_true -> set_item_source_true
--|
--| Revision 1.44  2000/03/30 17:46:30  brendel
--| Changed type of parent_imp to EV_LIST_ITEM_LIST_IMP.
--| `relative_y' now uses `displayed_index'.
--|
--| Revision 1.43  2000/03/30 16:35:52  rogers
--| Changed parent_imp from EV_LIST_IMP to
--| EV_ITEM_LIST_IMP [EV_LIST_ITEM]
--|
--| Revision 1.42  2000/03/29 22:13:09  brendel
--| Implemented `set_text'.
--| Clean-up.
--|
--| Revision 1.41  2000/03/29 20:25:17  brendel
--| Implemented using new _I.
--| To be cleaned up.
--|
--| Revision 1.40  2000/03/29 02:17:16  brendel
--| Commented out features that have no routine body anyway.
--| To be implemented.
--|
--| Revision 1.39  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.38  2000/03/27 21:52:46  pichery
--| implemented new deferred features from EV_PICK_AND_DROPPABLE_IMP
--| `set_heavy_capture' and `release_heavy_capture'.
--|
--| Revision 1.37  2000/03/22 20:24:29  rogers
--| Removed press_action := ev_pnd_start_transport from initialize.
--|
--| Revision 1.36  2000/03/21 01:20:53  rogers
--| Redefined set_pointer_style, so the parent_imp pointer style is called.
--|
--| Revision 1.35  2000/03/20 22:34:12  rogers
--| Renamed set_child_source -> set_pnd_child_source.
--|
--| Revision 1.34  2000/03/17 23:29:01  rogers
--| Implemented pnd_press, set_capture and release_capture.
--|
--| Revision 1.33  2000/03/15 17:17:02  rogers
--| Improved comments and removed old command association.
--|
--| Revision 1.32  2000/03/15 16:51:53  rogers
--| Removed commented out destroyed;. Added relative_y which returns the
--| relative coordinate of the item to its parent.
--|
--| Revision 1.31  2000/03/10 00:32:00  rogers
--| Added set_capture and release_capture with a fixme and a check False so
--| they compile. They need to be fixed.
--|
--| Revision 1.30  2000/03/02 16:58:33  rogers
--| Set_text now sets the text to a clone of the passed text.
--|
--| Revision 1.29  2000/03/01 16:37:54  rogers
--| Changed type of parent_imp from EV_LIST_IMP to EV_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.28  2000/02/25 17:44:27  rogers
--| Removed call to precursor in set_text, and replaced with text := txt as
--| text is now an attribute of this class directly.
--|
--| Revision 1.27  2000/02/19 06:23:05  oconnor
--| removed command stuff
--|
--| Revision 1.26  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.25  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.6.6  2000/02/07 19:04:15  king
--| Commented out useless destroy feature
--|
--| Revision 1.24.6.5  2000/02/02 21:08:45  rogers
--| Removed commented make_with_text references. changed the type of
--| parent_imp from EV_LIST_ITEM_HOLDER_IMP to EV_LIST_IMP.
--|
--| Revision 1.24.6.4  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.6.3  2000/01/18 23:39:01  rogers
--| The body of set_text had been commented out. It has been uncommented as it
--| is required.
--|
--| Revision 1.24.6.2  1999/12/17 17:35:07  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--|
--| Revision 1.24.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
