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
			parent_imp,
			interface
		end

	EV_ITEM_IMP
		undefine
			parent
		redefine
			set_pixmap,
			parent_imp,
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

	EV_ID_IMP

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current'.
		do
			base_make (an_interface)
			make_id
			create real_text.make (0)
		end

	initialize is
			-- Do post creation initialization.
		do
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

	real_text: STRING
			-- Internal `text'. Not to be returned directly. Use clone.

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current) + 1
		end

	set_parent (a_parent: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if a_parent /= Void then
				parent_imp ?= a_parent.implementation
				parent_imp.auto_size
			else
				parent_imp := Void
			end
		end

	gray_pixmap: EV_PIXMAP
		-- The gray_pixmap of `Current'.

	gray_pixmap_imp: EV_PIXMAP_IMP is
			-- Implementation of the gray pixmap contained 
		do
			if gray_pixmap /= Void then
				Result ?= gray_pixmap.implementation
			end
		end

feature -- Status report

	type: INTEGER is
			-- Type of the button.
			-- Numeric value which the tool_bar_can use to
			-- Identify the button type. Avoids reverse
			-- assignment to identify actual type.
		do
			Result := 1
		end

	is_sensitive: BOOLEAN is
			-- Is `Current' insensitive?
		do
			Result := parent_imp.button_enabled (id)
		end

feature -- Status setting

	enable_sensitive is
			 -- Enable `Current'.
		do
			parent_imp.enable_button (id)
		end

	disable_sensitive is
			 -- Disable `Current'.
		do
			parent_imp.disable_button (id)
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

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of `Current'.
			-- We need to destroy the dc that comes with it,
			-- because a bitmap can be linked to only one dc
			-- at a time.
		do
			{EV_ITEM_IMP} Precursor (pix)
			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
			end
		end

	set_gray_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of `Current'.
			-- We need to destroy the dc that comes with it,
			-- because a bitmap can be linked to only one dc
			-- at a time.
		do
 			remove_gray_pixmap
 			create gray_pixmap
 			gray_pixmap.copy (pix)

			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
			end
		end

	remove_gray_pixmap is
			-- Make `gray_pixmap' `Void'.
		do
			gray_pixmap := Void
		end

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport.
		do
			Result := parent_imp
		end

feature {EV_ANY_I} -- Interface

	interface: EV_TOOL_BAR_BUTTON

end -- class EV_TOOL_BAR_BUTTON_IMP

--|-----------------------------------------------------------------------------
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
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
