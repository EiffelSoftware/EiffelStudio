indexing
	description: 
		"Eiffel Vision aggregate widget. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_AGGREGATE_WIDGET_IMP
	
inherit
	EV_AGGREGATE_WIDGET_I
		redefine
			interface
		end

	EV_WIDGET_IMP
		redefine
			interface
		end

create
	make

feature -- initialization

	make (an_interface: like interface) is
			-- Connect interface, initialize `c_object' and make `box' visible
			-- in `Current'.
		local
			box_imp: EV_ANY_IMP
		do
			base_make (an_interface)
			set_c_object (C.gtk_hbox_new (False, 0))

			create {EV_AGGREGATE_BOX} box
			box_imp ?= box.implementation
			check
				box_imp_not_void: box_imp /= Void
			end
			C.gtk_container_add (c_object, box_imp.c_object)
		end

feature -- Implementation

	interface: EV_WIDGET
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_AGGREGATE_IMP

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
--| Revision 1.2  2000/02/14 12:05:08  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.4  2000/01/28 19:00:04  oconnor
--| changed to use EV_AGGREGATE_BOX
--|
--| Revision 1.1.2.3  2000/01/28 16:43:06  oconnor
--| added comments
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
