indexing
	description:
		"Displays `value' and two buttons that allow it to be adjusted up and%
		%down within `range'."
	status: "See notice at end of class"
	keywords: "gauge, edit, text, number, up, down"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON

inherit
	EV_GAUGE
		redefine
			create_implementation,
			create_action_sequences,
			implementation,
			is_in_default_state
		end

	EV_TEXT_FIELD
		rename
			change_actions as text_change_actions
		undefine
			make_for_test
		redefine
			create_implementation,
			create_action_sequences,
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_range,
	make_with_text,
	make_for_test

feature {NONE} -- Implementation

	implementation: EV_SPIN_BUTTON_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_SPIN_BUTTON_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_TEXT_FIELD} Precursor
			{EV_GAUGE} Precursor
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := {EV_GAUGE} Precursor and then
				{EV_TEXT_FIELD} Precursor
		end

end -- class EV_SPIN_BUTTON

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
--| Revision 1.7  2000/03/21 19:10:39  oconnor
--| comments, formatting
--|
--| Revision 1.6  2000/03/01 03:27:53  oconnor
--| added make_for_test
--|
--| Revision 1.5  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/15 16:33:52  brendel
--| Added `is_in_default_state'.
--|
--| Revision 1.3  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.4  2000/02/02 01:26:58  brendel
--| This interface is ready to release.
--|
--| Revision 1.2.6.3  2000/02/01 01:27:54  brendel
--| Revised.
--|
--| Revision 1.2.6.2  2000/01/27 19:30:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.1  1999/11/24 17:30:55  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
