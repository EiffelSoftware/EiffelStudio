indexing
	description: 
		"Eiffel Vision label. Displays a textual label."
	status: "See notice at end of class"
	keywords: "label, text"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LABEL

inherit
	EV_PRIMITIVE
		redefine
			implementation
		end

	EV_TEXTABLE
		redefine
			implementation
		end
		
create
	default_create,
	make_with_text

feature {NONE} -- Implementation

	implementation: EV_LABEL_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of label.
		do
			create {EV_LABEL_IMP} implementation.make (Current)
		end
	
end -- class EV_LABEL

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.16  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.6.11  2000/02/05 05:49:56  oconnor
--| removed make_with_text
--|
--| Revision 1.15.6.10  2000/01/28 20:00:20  oconnor
--| released
--|
--| Revision 1.15.6.9  2000/01/27 19:30:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.6.8  2000/01/18 07:11:46  oconnor
--| removed redefine of create_action_sequences
--|
--| Revision 1.15.6.7  2000/01/17 02:48:04  oconnor
--| added keywords
--|
--| Revision 1.15.6.6  2000/01/17 02:33:47  oconnor
--| removed action sequence. Added comments.
--|
--| Revision 1.15.6.5  2000/01/15 02:25:24  oconnor
--| formatting
--|
--| Revision 1.15.6.4  2000/01/14 23:38:37  king
--| Made label inherit from textable
--|
--| Revision 1.15.6.3  2000/01/11 23:30:33  rogers
--| Undefined create_action_sequences.
--|
--| Revision 1.15.6.2  1999/12/17 19:41:35  rogers
--| Modified make_with_text, and added create_action_sequences and
--| create_implementation.
--|
--| Revision 1.15.6.1  1999/11/24 17:30:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
