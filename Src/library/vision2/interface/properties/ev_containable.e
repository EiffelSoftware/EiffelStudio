indexing
	description:
		"Abstraction for objects that may be parented."
	status: "See notice at end of class"
	keywords: "parentable, containable, child"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_CONTAINABLE

inherit
	EV_ANY
		undefine
			create_action_sequences
		end
	
feature -- Status report

	parent: EV_ANY is
			-- The parent that `Current' is contained within, if any.
		deferred
		end

end -- class EV_CONTAINABLE

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
--| Revision 1.2  2000/06/07 17:28:07  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.1.2.1  2000/05/13 00:03:40  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
