indexing
	description: 
		"Eiffel Vision horizontal box for use in EV_AGGREGATE_WIDGET only.%N%
		%Implementation interface"
	status: "See notice at end of class"
	keywords: "container, horizontal, box"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_AGGREGATE_BOX_I

inherit
	EV_HORIZONTAL_BOX_I
		redefine			
			parent,
			screen_x,
			screen_y
		end

--create
--	make
	
feature -- Access

	parent: EV_CONTAINER is
			-- Always Void to isolate components of aggregate.
		do
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		do 
			Result := x_position + real_parent.screen_x
		end

		screen_y: INTEGER is
			-- Vertical offset relative to screen.
		do
			Result := y_position + real_parent.screen_y
		end

	real_parent: EV_AGGREGATE_WIDGET_IMP is
			-- Contains `Current'.
		--local
		--	c_parent: POINTER
		--do
		--	c_parent := C.gtk_widget_struct_parent (c_object)
		--	check
		--		c_parent_not_void: c_parent /= Void
		--	end
		--	Result ?= eif_object_from_c (c_parent)
		--ensure
		--	not_void: Result /= Void
		deferred
		end

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
--| Revision 1.3  2000/02/15 19:23:18  rogers
--| Now deferred, inherits EV_HORIZONTAL_BOX_I, made parent deferred. Removed creation.
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/01/28 21:32:04  oconnor
--| fixed problem with screen_[x|y]
--|
--| Revision 1.1.2.1  2000/01/28 20:16:42  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
