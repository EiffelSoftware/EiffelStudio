indexing
	description: 
		"Button that toggles between states each time it is pressed."
	appearance:
		" ------------ %N%
		%|   `text'   |%N%
		% ============"
	status: "See notice at end of class"
	keywords: "toggle, button"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_TOGGLE_BUTTON

inherit
	EV_BUTTON
		redefine
			implementation,
			create_implementation
		end

	EV_DESELECTABLE
		redefine
			implementation
		end

create
	default_create,
	make_with_text,
	make_with_text_and_action,
	make_for_test
	
feature -- Status setting

	toggle is
			-- Change `is_selected'.
		do
			implementation.toggle
		ensure
			is_selected_changed: is_selected /= old is_selected
		end
	
feature {NONE} -- Implementation

	implementation: EV_TOGGLE_BUTTON_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			Create {EV_TOGGLE_BUTTON_IMP} implementation.make (Current)
		end
	
end -- class EV_TOGGLE_BUTTON

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
--| Revision 1.25  2000/06/07 17:28:13  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.17.2.3  2000/05/10 00:01:42  king
--| Corrected make to make toggle button instead of button
--|
--| Revision 1.17.2.2  2000/05/09 20:31:09  king
--| Integrated selectable/deselectable
--|
--| Revision 1.17.2.1  2000/05/03 19:10:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.24  2000/03/21 19:10:39  oconnor
--| comments, formatting
--|
--| Revision 1.23  2000/03/01 03:27:16  oconnor
--| added make_for_test
--|
--| Revision 1.22  2000/02/25 21:28:16  brendel
--| Formatting.
--|
--| Revision 1.21  2000/02/24 18:16:24  oconnor
--| New inheritance structure for buttons with state.
--| New class EV_SELECT_BUTTON provides `is_selected' and `enable_select'.
--| RADIO_BUTTON inherits this, as does TOGGLE_BUTTON which adds
--| `disable_select' and `toggle'.
--|
--| Revision 1.20  2000/02/23 20:20:41  rogers
--| Corrected spelling mistake in keywords, removed smiley face from comment on
--| is_selected.
--|
--| Revision 1.19  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.18  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.4.8  2000/01/28 20:00:21  oconnor
--| released
--|
--| Revision 1.17.4.7  2000/01/27 19:30:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.4.6  2000/01/20 18:49:50  oconnor
--| added make_with_text_and_action to create clause
--|
--| Revision 1.17.4.5  2000/01/19 08:35:26  oconnor
--| renamed select -> enable_selected
--| renamed deselect -> disable_selected
--| because of confict with reserved word select
--|
--| Revision 1.17.4.4  2000/01/19 08:31:45  oconnor
--| renamed state -> is_selected
--| added select and deselect.
--| reformatted.
--| added comments.
--|
--| Revision 1.17.4.3  2000/01/06 18:44:24  king
--| Reverted toggle_actions to press_actions
--|
--| Revision 1.17.4.2  1999/12/23 01:39:34  king
--| Implemented to fit in with new structure
--|
--| Revision 1.17.4.1  1999/11/24 17:30:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.15.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
