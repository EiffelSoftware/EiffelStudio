indexing
	description: 
		"Eiffel Vision cell, GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_CELL_IMP
	
inherit
	EV_CELL_I
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			replace
		end

create
	make

feature -- initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
		end
feature -- Access

	item: EV_WIDGET is
			-- Current item
		local
			p: POINTER
			imp: EV_ANY_IMP
		do
			p := C.gtk_container_children (c_object)
			if p/= Default_pointer then
				p := C.g_list_nth_data (p, 0)
				if p /= Default_pointer then
					imp := eif_object_from_c (p)
					check
						imp_not_void: imp /= Void
							-- C object should have Eiffel object.
					end
					Result ?= imp.interface
				end
			end
		end

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			i: EV_WIDGET
			imp: EV_WIDGET_IMP
		do
			i := item
			if i /= Void then
				imp ?= i.implementation
				C.gtk_container_remove (c_object, imp.c_object)
			end
			if v /= Void then
				imp ?= v.implementation
				C.gtk_container_add (c_object, imp.c_object)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_CELL_IMP

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
--| Revision 1.1.2.7  2000/02/08 09:30:38  oconnor
--| replaced put with replace
--|
--| Revision 1.1.2.6  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.1.2.5  2000/01/27 19:29:42  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.4  2000/01/20 18:47:16  oconnor
--| made non deferred
--|
--| Revision 1.1.2.3  2000/01/18 19:35:39  oconnor
--| added feature item
--|
--| Revision 1.1.2.2  2000/01/18 18:02:39  oconnor
--| redefined interface
--|
--| Revision 1.1.2.1  2000/01/18 18:01:48  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
