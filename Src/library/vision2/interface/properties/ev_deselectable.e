indexing
	description:
		"Abstraction for objects that may be selected/unselected."
	status: "See notice at end of class"
	keywords: "deselect, deselectable, select, selected, selectable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DESELECTABLE

inherit
	EV_SELECTABLE
		redefine
			implementation
		end
	
feature -- Status setting

	disable_select is
			-- Deselect the object.
		require
			is_deselectable: is_selectable
		do
			implementation.disable_select
		ensure
			unselected: not is_selected
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_DESELECTABLE_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_DESELECTABLE

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
--| Revision 1.1.2.2  2000/05/09 22:37:33  king
--| Integrated selectable, is_selectable for list items
--|
--| Revision 1.1.2.1  2000/05/09 20:27:49  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
