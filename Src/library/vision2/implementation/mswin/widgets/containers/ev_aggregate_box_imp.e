indexing
	description:
		"Eiffel Vision aggregate box. Mswindows implementation."
	status: "See notice at end of class"
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

	real_parent: EV_AGGREGATE_WIDGET_IMP
			-- Contains `Current'.

feature {EV_AGGREGATE_WIDGET_IMP} -- Element change

	set_real_parent (a_parent: EV_AGGREGATE_WIDGET_IMP) is
			-- Assign `a_parent' to `real_parent'.
		require
			a_parent_not_void: a_parent /= Void
		do
			real_parent := a_parent
		ensure
			a_parent_assigned: real_parent = a_parent
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_AGGREGATE_BOX
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_AGGREGATE_BOX_IMP

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
--| Revision 1.4  2000/05/03 16:08:52  brendel
--| Added indexing clause.
--| Fixed feature clauses.
--| Added comments and assertions.
--| Added copyright notice and CVS Log.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

