--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description:
		" EiffelVision vertical range, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_RANGE_IMP

inherit
	EV_HORIZONTAL_RANGE_I
		redefine
			interface
		select
			interface
		end

	EV_RANGE_IMP
		rename
			interface as range_interface
		redefine
			set_default_minimum_size,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a spin-button with 0 as minimum,
			-- 100 as maximum and `par' as parent.
		do
			base_make (an_interface)
			make_horizontal (default_parent, 0, 0, 0, 0, 0)
		end

	initialize is
			-- Initialize range.
		do
			{EV_RANGE_IMP} Precursor
			set_range (1, 100)
		end

feature -- Status setting

   	set_default_minimum_size is
   			-- Platform dependant initializations.
   		do
			internal_set_minimum_height (30)
			internal_set_minimum_width (10)
 		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_RANGE

end -- class EV_HORIZONTAL_RANGE_IMP

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
--| Revision 1.3  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.4  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.2.10.3  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.2  2000/01/11 17:24:02  rogers
--| Altered to comply in with the major vision2 changes. See diff for redefinitions. Make now takes an interface, make and make_with_range no longer takes a parent. Minimum dimensions have been altered. Added interface.
--|
--| Revision 1.2.10.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
