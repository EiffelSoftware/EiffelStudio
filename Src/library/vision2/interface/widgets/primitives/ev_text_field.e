indexing
	description: 
		"Input field for a single line of `text'."
	appearance:
		"+-------------+%N%
		%| 'text'      |%N%
		%+-------------+"
	status: "See notice at end of class"
	keywords: "input, text, field, query"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_TEXT_FIELD

inherit
	EV_TEXT_COMPONENT
		redefine
			implementation,
			create_action_sequences
		end

create
	default_create,
	make_with_text,
	make_for_test
	
feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
		end

feature -- Access

	capacity: INTEGER is
			-- Number of characters field can hold.
		do
			Result := implementation.capacity
		end

feature -- Element change

	set_capacity (a_capacity: INTEGER) is
			-- Assign `a_capacity' to `capacity'.
		require
			a_capacity_not_negative: a_capacity >= 0
		do
			implementation.set_capacity (a_capacity)
		end

feature -- Events

	return_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when return key is pressed.

feature {NONE} -- Implementation

	implementation: EV_TEXT_FIELD_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TEXT_FIELD_IMP} implementation.make (Current)
		end
			
	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_TEXT_COMPONENT} Precursor
			create return_actions
		end

invariant
	capacity_not_negative: capacity >= 0
	return_actions_not_void: return_actions /= Void

end -- class EV_TEXT_FIELD

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
--| Revision 1.23  2000/04/07 01:13:36  brendel
--| Added appearance clause.
--|
--| Revision 1.22  2000/03/21 19:10:39  oconnor
--| comments, formatting
--|
--| Revision 1.21  2000/03/01 03:27:30  oconnor
--| added make_for_test
--|
--| Revision 1.20  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.19  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.18.6.6  2000/02/01 01:32:04  brendel
--| Improved comments.
--|
--| Revision 1.18.6.5  2000/01/28 20:00:20  oconnor
--| released
--|
--| Revision 1.18.6.4  2000/01/27 19:30:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.18.6.3  2000/01/18 07:08:07  oconnor
--| Replaced commands with action sequences.
--| Formatting, comments.
--| renames maximum_length -> capacity
--|
--| Revision 1.18.6.2  1999/11/30 22:38:18  oconnor
--| removed make, added create_implementation
--|
--| Revision 1.18.6.1  1999/11/24 17:30:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.18.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.18.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
