--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description:
		"EiffelVision Combo-box. A combo-box contains a %
		% text field and a button. When the button is    %
		% pressed, a list of possible choices is opened."
	note: "The `height' of a combo-box is the one of the text  %
		% field. To have the height of the text field plus the %
		% list, use extended_height."
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_COMBO_BOX


inherit
	EV_TEXT_FIELD
		undefine
			make_for_test
		redefine
			create_action_sequences,
			implementation,
			create_implementation
		end

	EV_LIST	
		export
			{NONE} enable_multiple_selection, multiple_selection_enabled
			{NONE} selected_items
		redefine
			implementation,
			create_implementation,
			create_action_sequences
		end

create	
	default_create,
	make_for_test

feature -- Access

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		require
		do
			Result := implementation.extended_height
		end

feature -- Element change

	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		require
			valid_value: value >= 0
		do
			implementation.set_extended_height (value)
		end

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of combo box.
		do
			create {EV_COMBO_BOX_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- Create action sequences of combo box.
		do
			{EV_LIST} Precursor
			{EV_TEXT_FIELD} Precursor
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_COMBO_BOX_I

end -- class EV_COMBO_BOX

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
--| Revision 1.30  2000/03/02 18:00:35  rogers
--| Undefined make_from_test from ev_text_field, so it uses the make_from_test inherited from ev_list.
--|
--| Revision 1.29  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.28  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.27  2000/02/29 18:09:10  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.26  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.25  2000/02/17 02:20:37  oconnor
--| released
--|
--| Revision 1.24  2000/02/15 19:26:52  king
--| Exporting interface to ev_any
--|
--| Revision 1.23  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.22.6.6  2000/02/11 00:56:36  king
--| Redefine action sequences to call both precursors
--|
--| Revision 1.22.6.5  2000/01/27 19:30:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.22.6.4  2000/01/17 20:07:42  rogers
--| Added default_create
--|
--| Revision 1.22.6.3  2000/01/15 00:54:19  oconnor
--| renamed set_multiple_selection, is_multiple_selection to enable_multiple_selection, multiple_selection_enabled
--|
--| Revision 1.22.6.2  1999/11/30 22:24:20  oconnor
--| removed make, added create_implementation
--|
--| Revision 1.22.6.1  1999/11/24 17:30:53  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.22.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.22.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
