indexing
	description: "Eiffel Vision item id. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ID_IMP

feature {NONE} -- Initialization

	make_id is
			-- Generate new ID and assign it to `id'.
		do
			id := counter.item
			counter.set_item (id + 1)
		end

feature -- Access

	id: INTEGER
			-- Unique identifier within system.

feature {NONE} -- Implementation

	counter: INTEGER_REF is
			-- Counter to set unique id's to items.
		once
			create Result
			Result.set_item (1)
		end

invariant
	make_called: id > 0

end -- class EV_ID_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.6  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.8.2  2000/08/11 19:10:35  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.2.8.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/02/23 02:19:34  brendel
--| Added invariant.
--|
--| Revision 1.4  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.3  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.4  2000/02/05 02:13:13  brendel
--| Now provides the attribute `id'.
--| Call `make_id' to initialize it.
--|
--| Revision 1.2.10.3  2000/02/04 19:22:25  brendel
--| Revised. Now provides `id' as once feature, instead of deferred.
--|
--| Revision 1.2.10.2  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
