indexing
	description: 
		"Horizontal linear widget container"
	appearance:
		"---------------%N%
		%|             |%N%
		%|   'first'   |%N%
		%|             |%N%
		%|-------------|%N%
		%|             |%N%
		%|     ...     |%N%
		%|             |%N%
		%|-------------|%N%
		%|             |%N%
		%|   `last'    |%N%
		%|             |%N%
		%---------------"
	status: "See notice at end of class"
	keywords: "container, box, vertical"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_VERTICAL_BOX

inherit
	EV_BOX
		redefine	
			implementation
		end

create
	default_create,
	make_for_test

feature {EV_ANY_I} -- Implementation
   
	implementation: EV_VERTICAL_BOX_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VERTICAL_BOX_IMP} implementation.make (Current)
		end

end -- class EV_VERTICAL_BOX

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
--| Revision 1.11  2000/03/18 00:52:23  oconnor
--| formatting, layout and comment tweaks
--|
--| Revision 1.10  2000/03/01 20:07:36  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.9  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.8  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.5  2000/01/28 20:00:14  oconnor
--| released
--|
--| Revision 1.6.6.4  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.3  1999/12/17 19:47:35  rogers
--| redefined implementation to be a a more refined type. Implementation is
--| now exported to EV_ANY_I.
--|
--| Revision 1.6.6.2  1999/12/15 18:33:05  oconnor
--| formatting
--|
--| Revision 1.6.6.1  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
