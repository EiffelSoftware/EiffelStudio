--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	" Routine notion of command. To create this kind of%
	% command any procedure with the following signature :%
	% execute (arg: EV_ARGUMENT; event_data: EV_EVENT_DATA)%
	% can be used."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ROUTINE_COMMAND

obsolete
	"Remove me?"

inherit
	EV_COMMAND

end -- class EV_ROUTINE_COMMAND

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
--| Revision 1.3  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.3  2000/01/27 19:30:45  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.2  2000/01/25 17:37:53  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.2.6.1  1999/11/24 17:30:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
