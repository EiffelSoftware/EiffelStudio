indexing	
	description:
		"Item for use in EV_MENU."
	note:
		"Single ampersands in text are not shown in the actual%N%
		%widget. If you need an ampersand in your text,%N%
		%use && instead. The character following the & may%N%
		%be a shortcut to this widget (combined with Alt)%N%
		%&File -> File (Alt+F = shortcut)%N%
		%Fish && Chips -> Fish & Chips (no shortcut).%N%
		%N.B.: Not implemented on Unix platform."
	status: "See notice at end of class"
	keywords: "menu, item, dropdown, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_ITEM

inherit
	EV_ITEM
		redefine
			implementation,
			create_implementation,
			create_action_sequences
		end

	EV_TEXTABLE
		redefine
			implementation
		end

create
	default_create,
	make_with_text

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is `Current' sensitive to user actions?
		do
			Result := implementation.is_sensitive
		end

feature -- Status setting

	enable_sensitive is
   			-- Set `is_sensitive' `True'.
   		do
 			implementation.enable_sensitive
 		ensure
   			is_sensitive: is_sensitive
   		end

	disable_sensitive is
   			-- Set `is_sensitive' `False'.
   		do
 			implementation.disable_sensitive
 		ensure
   			not_is_sensitive: not is_sensitive
   		end

feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when selected.

feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_ITEM_I	
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_ITEM_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			Precursor
			create select_actions
		end

feature -- Obsolete

	press_actions: EV_NOTIFY_ACTION_SEQUENCE is
		obsolete
			"use select_actions"
		do
			Result := select_actions
		end

invariant
	select_actions_not_void: select_actions /= Void
 
end -- class EV_MENU_ITEM

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
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
--| Revision 1.36  2000/04/07 22:15:40  brendel
--| Removed EV_SIMPLE_ITEM from inheritance hierarchy.
--|
--| Revision 1.35  2000/03/27 18:02:48  brendel
--| Added note about ampersands in `text'.
--| Replaced press_actions with select_actions.
--|
--| Revision 1.34  2000/03/23 01:40:33  oconnor
--| comments, formatting
--|
--| Revision 1.33  2000/03/01 20:28:52  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.32  2000/02/29 18:09:07  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.31  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.30  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.29.6.7  2000/02/05 01:42:11  brendel
--| Changed export status of Implementation.
--|
--| Revision 1.29.6.6  2000/02/03 23:32:01  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.29.6.5  2000/02/02 00:06:45  oconnor
--| hacking menus
--|
--| Revision 1.29.6.4  2000/01/28 22:24:20  oconnor
--| released
--|
--| Revision 1.29.6.3  2000/01/27 19:30:36  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.29.6.2  1999/12/17 21:15:39  rogers
--| Advanced make procedures hav been removed, ready for re-implementation.
--|
--| Revision 1.29.6.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.29.2.3  1999/11/04 23:10:48  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.29.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
