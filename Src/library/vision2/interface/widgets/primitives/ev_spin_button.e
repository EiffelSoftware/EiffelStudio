indexing
	description:
		"Eiffel Vision spin button. Text fields with up and down buttons %N%
		%located on the right."
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
			implementation
		end

	EV_TEXT_FIELD
		rename
			change_actions as text_change_actions
		redefine
			create_implementation,
			create_action_sequences,
			implementation
		end

create
	default_create,
	make_with_range,
	make_with_text

feature {NONE} -- Implementation

	create_implementation is
		do
			create {EV_SPIN_BUTTON_IMP} implementation.make (Current)
		end

	create_action_sequences is
		do
			{EV_TEXT_FIELD} Precursor
			{EV_GAUGE} Precursor
		end

	implementation: EV_SPIN_BUTTON_I

end -- class EV_SPIN_BUTTON

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
