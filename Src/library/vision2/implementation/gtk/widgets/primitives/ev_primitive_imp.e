indexing
	description: 
		"EiffelVision primitive, GTK+ implementation."
	status: "See notice at end of class"
	keywords: "primitive, base, widget"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_PRIMITIVE_IMP
	
inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
	
	EV_WIDGET_IMP
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PRIMITIVE

end -- class EV_PRIMITIVE_IMP

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
--| Revision 1.7  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.5  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.6.6.4  2000/01/27 19:29:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.3  1999/12/15 16:18:08  oconnor
--| formatting
--|
--| Revision 1.6.6.2  1999/11/30 23:14:21  oconnor
--| rename widget to c_object
--| redefine interface to be of mreo refined type
--|
--| Revision 1.6.6.1  1999/11/24 17:29:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
