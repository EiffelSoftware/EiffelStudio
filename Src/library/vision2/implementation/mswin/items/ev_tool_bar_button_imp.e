indexing
	description: " EiffelVision Toolbar button, mswindows implementation."
	note: " Menu-items have even ids and tool-bar buttons have%
		% odd ids because both use the on_wm_command."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			parent_imp, interface
		end

	EV_ITEM_IMP
		undefine
			parent
		redefine
			set_pixmap, parent_imp, interface, pixmap, remove_pixmap
		end

	EV_INTERNALLY_PROCESSED_TEXTABLE_IMP
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface, set_tooltip
		end

	WEL_ILC_CONSTANTS

	EV_ID_IMP

	EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_IMP

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			make_id
			create real_text.make (0)
		end

	initialize is
			-- Do post creation initialization.
		do
			is_sensitive := True
			is_initialized := True
		end

	parent_imp: EV_TOOL_BAR_IMP
		-- The parent of `Current'.

feature -- Access

	wel_text: STRING is
			-- Text of `Current'
		do
			Result := clone (real_text)
		end

	text_length: INTEGER is
			-- Number of characters of `real_text'.
		do
			Result := real_text.count
		end

	real_text: STRING
			-- Internal `text'. Not to be returned directly. Use clone.

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current) + 1
		end

	set_parent_imp (a_parent_imp: like parent_imp) is
			-- Make `a_parent_imp' the new parent of `Current'.
			-- `a_parent_imp' can be Void then the parent is the screen.
		do
			if a_parent_imp /= Void then
				parent_imp := a_parent_imp
				parent_imp.auto_size
			else
				parent_imp := Void
			end
		end

	gray_pixmap: EV_PIXMAP is
			-- Pixmap of `Current'.
		local
			pix_imp: EV_PIXMAP_IMP
			image_icon: WEL_ICON
			image_list: EV_IMAGE_LIST_IMP
		do
				-- Retrieve the pixmap from the imagelist
			if has_gray_pixmap then
				if private_gray_pixmap = Void then
					create Result
					pix_imp ?= Result.implementation
					check
						pix_imp /= Void
					end
					image_list := parent_imp.default_imagelist
					image_icon := image_list.get_icon (image_index, Ild_normal)
					pix_imp.set_with_resource (image_icon)
				else
					Result := private_gray_pixmap
				end
			end
		end 

	pixmap: EV_PIXMAP is
			-- Pixmap of `Current'.
		local
			pix_imp: EV_PIXMAP_IMP
			an_icon: WEL_ICON
		do
				-- Retrieve the pixmap from the imagelist
			if has_pixmap then
				if private_pixmap = Void then
					create Result
					pix_imp ?= Result.implementation
					check
						pix_imp /= Void
					end
					an_icon := parent_imp.hot_imagelist.get_icon (image_index, Ild_normal)
					an_icon.enable_reference_tracking
					pix_imp.set_with_resource (an_icon)
					an_icon.decrement_reference
				else
					Result := private_pixmap
				end
			end
		end 

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is `Current' sensitive?

	has_pixmap: BOOLEAN
			-- Has Current a pixmap?

	has_gray_pixmap: BOOLEAN
			-- Has Current a gray pixmap?

	image_index: INTEGER
			-- Index of the pixmaps in the imagelists.

feature -- Status setting

	enable_sensitive is
			 -- Enable `Current'.
		do
			is_sensitive := True
			if parent_imp /= Void then
				parent_imp.enable_button (id)	
			end
		end

	disable_sensitive is
			 -- Disable `Current'.
		do
			is_sensitive := False
			if parent_imp /= Void then
				parent_imp.disable_button (id)
			end
		end

	parent_is_sensitive: BOOLEAN is
			-- Is parent of `Current' sensitive?
		do
			if parent_imp /= Void and then parent_imp.is_sensitive then
				result := True
			end
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			if parent_imp /= Void then
				result := True
			end
		end

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		do
			tooltip := clone (a_tooltip)
		end


feature -- Element change

	wel_set_text (txt: STRING) is
			-- Make `txt' the new label of `Current'.
		do
			real_text := clone (txt)
			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
				parent_imp.auto_size
			end
		end

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

				-- If the item is currently contained in the toolbar then
			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
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

					-- If the item is currently contained in the toolbar then
				if parent_imp /= Void then
					parent_imp.internal_reset_button (Current)
				end
			end
		end

	set_gray_pixmap (p: EV_PIXMAP) is
			-- Assign `p' to the displayed gray pixmap.
		do
			if private_gray_pixmap /= Void then
				private_gray_pixmap.destroy
				private_gray_pixmap := Void
			end
			private_gray_pixmap.copy (p)
			
			has_gray_pixmap := True

				-- If the item is currently contained in the toolbar then
			if has_pixmap and parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
			end
		end

	remove_gray_pixmap is
			-- Remove pixmap from `Current'.
		do
			if has_gray_pixmap then
				has_gray_pixmap := False
				if private_gray_pixmap /= Void then
					private_gray_pixmap.destroy
					private_gray_pixmap := Void
				end

					-- If the item is currently contained in the toolbar then
				if parent_imp /= Void then
					parent_imp.internal_reset_button (Current)
				end
			end
		end

	set_pixmap_in_parent is
			-- Add the pixmap to the parent by updating the 
			-- parent's image list.
		require
			button_has_pixmap: has_pixmap
		local
			default_imagelist: EV_IMAGE_LIST_IMP
			hot_imagelist: EV_IMAGE_LIST_IMP
			local_pixmap: EV_PIXMAP
			local_gray_pixmap: EV_PIXMAP
			gray_pixmap_position: INTEGER
			pixmap_position: INTEGER
		do
			default_imagelist := parent_imp.default_imagelist
				-- Create the image list and associate it
				-- to the control if it's not already done.
			if default_imagelist = Void then
				parent_imp.setup_image_list (private_pixmap.width, private_pixmap.height)
			end

			if private_pixmap = Void and private_gray_pixmap = Void then
				-- image_index is already up-to-date.
			else
				default_imagelist := parent_imp.default_imagelist
				hot_imagelist := parent_imp.hot_imagelist

				local_pixmap := private_pixmap
				if local_pixmap = Void then
					local_pixmap := pixmap
				end

				if has_gray_pixmap then
					local_gray_pixmap := private_gray_pixmap
					if local_gray_pixmap = Void then
						local_gray_pixmap := gray_pixmap
					end
				else
						-- No gray pixmap, so both normal and hot state will
						-- have the same bitmap.
					local_gray_pixmap := local_pixmap
				end

					-- Look for `gray_pixmap' and `pixmap' in the imagelist
				default_imagelist.pixmap_position (local_gray_pixmap)
				hot_imagelist.pixmap_position (local_pixmap)
				gray_pixmap_position := default_imagelist.last_position
				pixmap_position := hot_imagelist.last_position

				if pixmap_position = gray_pixmap_position and then
				   pixmap_position /= -1
				then
						-- Add pixmap. Take cached versions into account.
					default_imagelist.add_pixmap (local_gray_pixmap)
					hot_imagelist.add_pixmap (local_pixmap)
				else
						-- Add pixmap. Do not take cached versions into account.
					default_imagelist.extend_pixmap (local_gray_pixmap)
					hot_imagelist.extend_pixmap (local_pixmap)
				end
				check
					hot_and_default_imagelist_synchronized: 
						default_imagelist.last_position = hot_imagelist.last_position
				end
				image_index := default_imagelist.last_position

					-- Destroy the pixmaps.
				if private_pixmap /= Void then
					private_pixmap.destroy
					private_pixmap := Void
				end
				if private_gray_pixmap /= Void then
					private_gray_pixmap.destroy
					private_gray_pixmap := Void
				end
			end
		end
		
	enabled_before: BOOLEAN
		-- Was `Current' enabled before `update_for_pick_and_drop' modified
		-- the current state.
		
	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		local
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			create env
			app_imp ?= env.application.implementation
			if starting then
				if not interface.drop_actions.accepts_pebble (app_imp.pick_and_drop_source.pebble) then	
					enabled_before := is_sensitive
					disable_sensitive
				end
			else
				if enabled_before then
					enable_sensitive	
				end
			end
		end
		
feature {NONE} -- Implementation

	private_gray_pixmap: EV_PIXMAP
			-- Internal gray pixmap for Current. Void if none.

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport.
		do
			Result := parent_imp
		end

feature {EV_ANY_I} -- Interface

	interface: EV_TOOL_BAR_BUTTON

end -- class EV_TOOL_BAR_BUTTON_IMP

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
--| Revision 1.29  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.9.4.29  2001/06/05 22:25:27  rogers
--| Improved comment in set_pixmap.
--|
--| Revision 1.9.4.28  2001/06/05 21:54:40  rogers
--| Set_pixmap now uses clone internally instead of copy. Saves creation line.
--|
--| Revision 1.9.4.27  2001/06/05 18:35:59  rogers
--| We now create `private_pixmap' during `set_pixmap' if Void.
--|
--| Revision 1.9.4.26  2001/06/04 17:29:47  rogers
--| Removed redundent precondition from `remove_pixmap'.
--|
--| Revision 1.9.4.25  2001/06/04 17:11:17  rogers
--| Updated to use copy instead of ev_clone.
--|
--| Revision 1.9.4.24  2001/04/24 16:01:29  rogers
--| Changed inheritence from ev_textable_imp to
--| ev_internally_processed_textable.
--|
--| Revision 1.9.4.23  2001/03/16 19:24:55  rogers
--| Added update_for_pick_and_drop and `enabled_before'.
--|
--| Revision 1.9.4.22  2001/03/04 22:16:22  pichery
--| Added reference tracking
--|
--| Revision 1.9.4.21  2000/11/17 18:23:49  pichery
--| Fixed bug when someone wanted to change an existing
--| pixmap.
--|
--| Revision 1.9.4.20  2000/11/17 00:40:29  rogers
--| ev_tool_bar_button_imp.e
--|
--| Revision 1.9.4.19  2000/11/09 17:18:28  pichery
--| - Changed pixmap handling,
--| 1. it is now done as in EV_LIST_IMP and EV_TREE_IMP.
--|     i.e. much of the work is done in
--|     EV_TOOL_BAR_BUTTON_IMP instead of EV_TOOL_BAR_IMP
--| 2. `pixmap' now build an EV_PIXMAP from the WEL_ICON
--|     extracted from the WEL_IMAGE_LIST associated with the
--|     parent of this item.
--|
--| Revision 1.9.4.18  2000/10/13 19:00:45  manus
--| pixmap_gray should return Void if there is no internal gray pixmap.
--|
--| Revision 1.9.4.17  2000/10/12 15:50:21  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.9.4.16  2000/09/13 22:15:09  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.9.4.15  2000/08/17 17:23:50  rogers
--| Comment.
--|
--| Revision 1.9.4.14  2000/08/17 00:26:32  rogers
--| Added parent_is_sensitive and has_parent.
--|
--| Revision 1.9.4.13  2000/08/11 19:17:01  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.9.4.12  2000/08/09 20:57:11  oconnor
--| use ev_clone instead of clone as per instructions of manus
--|
--| Revision 1.9.4.11  2000/08/08 20:39:59  rogers
--| Replaced use of ev_clone with clone.
--|
--| Revision 1.9.4.10  2000/08/08 00:33:52  manus
--| Removed non-used local variable.
--|
--| Revision 1.9.4.9  2000/07/24 22:48:10  rogers
--| Now inherits EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.9.4.8  2000/07/20 23:22:33  rogers
--| Added set_tooltip.
--|
--| Revision 1.9.4.7  2000/06/28 19:43:17  rogers
--| Initialize noe assigns `True' to `is_sensitive'.
--|
--| Revision 1.9.4.6  2000/06/12 17:21:52  rogers
--| Fixed bug where changing the sensitivity of a button required it to be
--| parented. Changed is_sensitive to an attribute. Added a check that
--| parent_imp is not Void in enable_sensitive and disable_sensitive.
--|
--| Revision 1.9.4.5  2000/06/05 16:50:39  manus
--| Added `text_length' in `EV_TEXTABLE_IMP' to improve the performance of its
--| counterpart `text' in order to reduce creation of useless empty strings.
--|
--| Revision 1.9.4.4  2000/05/18 23:08:23  rogers
--| Set_parent renamed to set_parent_imp and now takes a paramenter of type
--| parent_imp.
--|
--| Revision 1.9.4.3  2000/05/10 23:09:59  king
--| Integrated tooltipable changes
--|
--| Revision 1.9.4.2  2000/05/05 22:29:06  pichery
--| Replaced (Create + Copy) with `ev_clone'
--|
--| Revision 1.9.4.1  2000/05/03 19:09:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.27  2000/04/26 22:20:36  rogers
--| Removed type as now redundent.
--|
--| Revision 1.26  2000/04/25 22:00:24  rogers
--| Comments, formatting.
--|
--| Revision 1.25  2000/04/24 21:23:15  rogers
--| Removed FIXME_NOT_REVIEWED.
--|
--| Revision 1.24  2000/04/21 21:56:19  rogers
--| Removed set_capture, release_capture, set_heavy_capture and
--| release_heavy_capture.
--|
--| Revision 1.23  2000/04/11 19:12:18  rogers
--| Removed repeated inheritance from EV_PICK_AND_DROPABLE_ITEM_IMP.
--|
--| Revision 1.22  2000/04/11 19:06:26  rogers
--| Now inherits EV_PICK_AND_DROPABLE_ITEM_IMP. Removed pnd_press
--| and set_pointer_Style as they are now inherited.
--|
--| Revision 1.21  2000/04/07 22:31:51  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.20  2000/04/07 00:03:20  rogers
--| Removed on_activate as it does nothing.
--|
--| Revision 1.19  2000/04/06 18:47:47  rogers
--| Removed old command association.
--|
--| Revision 1.18  2000/03/31 19:13:49  rogers
--| Removed inheritance from EV_PICK_AND_DROPABLE_IMP.
--| Added pnd_press and set_pointer_Style.
--|
--| Revision 1.17  2000/03/29 20:36:26  brendel
--| Modified text handling in compliance with new EV_TEXTABLE_IMP.
--|
--| Revision 1.16  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.15  2000/03/27 22:28:33  rogers
--| Added set_heavy_capture and release_heavy_capture.
--|
--| Revision 1.14  2000/03/20 23:34:56  pichery
--| - Added gray pixmap notion. Added the possibility to attach a gray pixmap
--|   to a button.
--|
--| Revision 1.13  2000/02/23 02:18:53  brendel
--| Removed redefine of `set_text'. Added feature `text'.
--|
--| Revision 1.12  2000/02/19 06:34:12  oconnor
--| removed old command stuff
--|
--| Revision 1.11  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.10  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.10  2000/02/05 02:10:50  brendel
--| Removed feature `destroyed'.
--|
--| Revision 1.9.6.9  2000/02/04 19:24:04  brendel
--| Removed feature `id' since it is now defined in EV_ID_IMP.
--|
--| Revision 1.9.6.8  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.7  2000/01/27 01:10:56  rogers
--| renamed is_insensitive to is_sensitive, and replaced set_insensitive with
--| enable_sensitive and disable_sensitive.
--|
--| Revision 1.9.6.6  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.9.6.5  2000/01/20 20:33:47  rogers
--| Added a better explanation of type.
--|
--| Revision 1.9.6.4  2000/01/20 17:04:48  rogers
--| In make, base make now is passed an_interface, and initialize is
--| implemented.
--|
--| Revision 1.9.6.3  1999/12/22 18:21:15  rogers
--| Removed undefinition of pixmap_size_ok, as it is no longer inherited at all.
--|
--| Revision 1.9.6.2  1999/12/17 17:30:28  rogers
--| Altered to fit in with the review branch. Make takes an interface. Now
--| inherits from EV_PICK_AND_DROPABLE_IMP.
--|
--| Revision 1.9.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
