
--| FIXME Not for release
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

end -- class EV_ID_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
