indexing
	description: 
		"Eiffel Vision horizontal box for use in EV_AGGREGATE_WIDGET only."
	status: "See notice at end of class"
	keywords: "container, horizontal, box"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_AGGREGATE_BOX_IMP

inherit
	EV_AGGREGATE_BOX_I
		redefine
			interface
		end

	EV_HORIZONTAL_BOX_IMP
		undefine
			parent,
			screen_x,
			screen_y
		redefine
			interface
		end

create
	make

feature -- Access

	real_parent: EV_AGGREGATE_WIDGET_IMP is
			-- Contains `Current'.
		local
			c_parent: POINTER
		do
			c_parent := C.gtk_widget_struct_parent (c_object)
			check
				c_parent_not_void: c_parent /= Void
			end
			Result ?= eif_object_from_c (c_parent)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_BOX

invariant
	parent_is_void: parent = Void
	
end -- class EV_AGGREGATE_BOX_I

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
--| Revision 1.1  2000/02/15 19:43:04  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
