indexing
	description: 
		"Eiffel Vision horizontal box for use in EV_AGGREGATE_WIDGET only.%N%
		%`parent' is always Void to isolate components of the aggregate%N%
		%widget from the rest of the system."
	status: "See notice at end of class"
	keywords: "container, horizontal, box"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_AGGREGATE_BOX

inherit
	EV_HORIZONTAL_BOX
		redefine			
			implementation,
			create_implementation,
			parent
		end
	
create
	default_create	

feature -- Access

	parent: EV_CONTAINER is
			-- Always Void to isolate components of aggregate.
		do
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_AGGREGATE_BOX_I
			-- 	Responsible for interaction with the underlying
			-- native graphics toolkit.

	create_implementation is
			-- Create implmentation of aggregate box.
		do
			create {EV_AGGREGATE_BOX_IMP} implementation.make (Current)
		end

invariant
	parent_is_void: parent = Void
	
end -- class EV_AGGREGATE_BOX

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
--| Revision 1.3  2000/02/15 19:18:31  rogers
--| There is now an EV_AGGREGATE_BOX_IMP so create_implementation has been changed accordingly.
--|
--| Revision 1.2  2000/02/14 12:05:13  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.4  2000/01/28 21:32:00  oconnor
--| fixed problem with screen_[x|y]
--|
--| Revision 1.1.2.3  2000/01/28 20:16:57  oconnor
--| added invariant
--|
--| Revision 1.1.2.2  2000/01/28 19:28:55  oconnor
--| no need to redefine [create_]implementation
--|
--| Revision 1.1.2.1  2000/01/28 18:59:03  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
