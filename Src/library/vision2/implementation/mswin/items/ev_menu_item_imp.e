indexing
	description: "Eiffel Vision menu item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_ITEM_IMP

inherit
	EV_MENU_ITEM_I
		redefine
			interface,
			parent
		end
		
	EV_ITEM_IMP
		undefine
			parent
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			text
		end

	EV_ID_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the menu item.
		do
			base_make (an_interface)
			make_id
		end

	initialize is
			-- Initialize `is_sensitive' True.
		do
			is_sensitive := True
			is_initialized := True
		end

feature -- Access

	text: STRING is
			-- Text displayed in label.
		do
			Result := wel_text
			if Result.empty then	
				Result := Void
			end
		end 

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			wel_set_text (a_text)
		end

feature -- Status report

	is_sensitive: BOOLEAN
			-- Can this item be clicked on?
			--| is not a function because we do not want to block the
			-- user from setting the sensitive state while unparented.

feature -- Status setting

	enable_sensitive is
   			-- Set current item sensitive.
		do
			is_sensitive := True
			if has_parent then
				parent_imp.enable_item (id)
			end
   		end

	disable_sensitive is
   			-- Set current item insensitive.
		do
			is_sensitive := False
			if has_parent then
				parent_imp.disable_item (id)
			end
   		end

feature -- Element change

	set_parent (a_parent: like parent) is
			-- Make `a_parent' the parent of the menu-item.
		do
			if a_parent /= Void then
				parent_imp ?= a_parent.implementation
			else
				parent_imp := Void
			end
		end

feature {NONE} -- Implementation

	wel_text: STRING is
			-- Caption of the menu item.
			--| For the specification given in the note of EV_MENU_ITEM,
			--| we do not have to take any special action.
			--| Does not return internal toolkit string because it is possible
			--| to set the string without parent.
		do
			Result := clone (real_text)
			if Result = Void then
				Result := ""
			end
		end

	real_text: STRING

	wel_set_text (a_text: STRING) is
			-- Set `text' to `a_txt'. See `wel_text'.
		do
			real_text := clone (a_text)
			if has_parent then
				parent_imp.modify_string (a_text, id)
			end
		end

	parent_imp: EV_MENU_ITEM_LIST_IMP
			-- The menu or menu-bar this item is in.

	parent: EV_MENU_ITEM_LIST is
			-- Item list containing `Current'.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			end
		end

	has_parent: BOOLEAN is
			-- Is this menu item in a menu?
		do
			Result := parent_imp /= Void and then 
				      parent_imp.item_exists (id)
		end

feature {NONE} -- Inapplicable

	set_capture is
			-- Grab user input.
		do
			check
				inapplicable: False
			end
		end

	release_capture is
			-- Release grab.
		do
			check
				inapplicable: False
			end
		end

	set_heavy_capture is
			-- Grap user input
		do
			check
				inapplicable: False
			end
		end

	release_heavy_capture is
			-- Release user input
		do
			check
				inapplicable: False
			end
		end

feature {EV_ANY_I} -- Implementation

	on_activate is
			-- `Current' has been clicked on.
		do
			interface.select_actions.call ([])
		end

	interface: EV_MENU_ITEM

invariant
	has_parent_implies_consistent_sensitive_state:
		has_parent implies is_sensitive = parent_imp.item_enabled (id)

end -- class EV_MENU_ITEM_IMP

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
--| Revision 1.36  2000/04/07 22:31:51  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.35  2000/03/29 20:36:26  brendel
--| Modified text handling in compliance with new EV_TEXTABLE_IMP.
--|
--| Revision 1.34  2000/03/28 16:33:08  rogers
--| Changed press_actions to select_actions in on_activate.
--|
--| Revision 1.33  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.32  2000/03/27 21:52:46  pichery
--| implemented new deferred features from EV_PICK_AND_DROPPABLE_IMP
--| `set_heavy_capture' and `release_heavy_capture'.
--|
--| Revision 1.31  2000/03/10 00:32:20  rogers
--| Added set_capture and release_capture with a fixme and a check False so they
--| compile. They need to be fixed.
--|
--| Revision 1.30  2000/02/25 20:28:49  brendel
--| Added function has_parent. Calls with target parent_imp are now protected
--| using this conditional.
--|
--| Revision 1.29  2000/02/24 01:44:43  brendel
--| Fixed parenting.
--|
--| Revision 1.28  2000/02/23 02:14:35  brendel
--| Revised. Implemented.
--|
--| Revision 1.27  2000/02/22 19:16:21  brendel
--| Added callback to interface.press_actions.
--|
--| Revision 1.26  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.25  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.6.8  2000/02/05 02:08:06  brendel
--| Cleanup.
--| Events need to be implemented!
--|
--| Revision 1.24.6.7  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.24.6.6  2000/02/03 17:19:05  brendel
--| Implemented *sensitive features.
--|
--| Revision 1.24.6.5  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.6.4  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.24.6.3  1999/12/22 19:29:51  rogers
--| pixmap_size_ok is no longer undefined, as this feature no longer exists.
--|
--| Revision 1.24.6.2  1999/12/17 17:34:39  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--|
--| Revision 1.24.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
