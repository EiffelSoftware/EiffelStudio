indexing
	description: "Operations to simulate binary operations on an integer."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BIT_OPERATIONS_I

feature -- Basic operations

	bit_set (flags, mask: INTEGER): BOOLEAN is
			-- Is the `mask' set in `flags'?
			-- Both `flags' and `mask' are decimal numbers.
		do
			Result := (flags // mask) \\ 2 = 1
		end

	set_bit (flags, mask: INTEGER; state: BOOLEAN): INTEGER is
			-- Return flags with `boo' as the new state of the
			-- bit `mask' in flags.
		do
			if bit_set (flags, mask) and not state then
				Result := flags - mask
			elseif not bit_set (flags, mask) and state then
				Result := flags + mask
			else
				Result := flags
			end
		end

end -- class EV_BIT_OPERATIONS_I

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
--| Revision 1.6  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.2  2000/08/17 22:03:30  rogers
--| Removed fixme not reviewed. Description.
--|
--| Revision 1.3.4.1  2000/05/03 19:09:00  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/02/22 18:39:42  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:36  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.3  2000/02/04 04:04:54  oconnor
--| released
--|
--| Revision 1.3.6.2  2000/01/27 19:29:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:30:07  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
