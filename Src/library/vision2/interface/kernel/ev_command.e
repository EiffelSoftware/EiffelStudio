--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"General notion of command (semantic unity).%
		%To write an actual command inherit from this%
		%class and implement the `execute' feature"
	status: "See notice at end of class"
	keywords: "execute, command, callback, routine"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COMMAND 

feature -- Basic operations

	--execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current command.
			-- `args' and `data' are automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
	--	deferred
	--	end

feature {EV_EVENT_HANDLER_IMP, EV_TIMEOUT_IMP} -- Implementation

	execute_address: POINTER is
			-- Address of feature execute 
		do
		--	Result := routine_address($execute)
		end

	routine_address (routine: POINTER): POINTER is
			--| FIXME please put some documentation here
			--| because this function seems to be doing nothing...
		do
		--	Result := routine
		end

end -- class EV_COMMAND

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
--| Revision 1.10  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.4.3  2000/01/27 19:30:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.4.2  2000/01/25 00:36:35  king
--| This file needs removing
--|
--| Revision 1.9.4.1  1999/11/24 17:30:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.3  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
