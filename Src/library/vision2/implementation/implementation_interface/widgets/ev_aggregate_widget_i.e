indexing
	description: 
		"Eiffel Vision aggregate widget. Implementation interface.%N%
		%Provides a `box' which can contain other widgets to make up a%N%
		%aggregate widget. `box' is only accessable from the implementation%N%
		%, not the interface.%N%
		%This class serves a base for widgets that are implemented in Vision%N%
		%rather than being implemented in a platform specific way.%N%
		%The interface class of such a widget inherits EV_WIDGET while the%N%
		%implementation class inherits EV_AGGREGATE_WIDGET_IMP and packs%N%
		%other Vision widgets into `box' as needed."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_AGGREGATE_WIDGET_I

inherit
	EV_WIDGET_I

feature {EV_ANY_I} -- Access

	box: EV_HORIZONTAL_BOX
			-- Contains elements displayed.

end -- class EV_AGGREGATE_WIDGET_I

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
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.3  2000/01/28 16:43:47  oconnor
--| added missing quote
--|
--| Revision 1.1.2.2  2000/01/28 16:41:45  oconnor
--| added comments
--|
--| Revision 1.1.2.1  2000/01/28 16:34:30  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
