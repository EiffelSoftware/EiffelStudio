indexing
	description: 
		"Eiffel Vision tooltipable. Mswindows implementation."
	status: "See notice at end of class"
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_TOOLTIPABLE_IMP
	
inherit
	
	EV_TOOLTIPABLE_I
		redefine
			interface
		end

feature -- Initialization

	tooltip: STRING is
			-- Pixmap that has been set.
		local
		do
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		local
		do
			check to_be_implementated: False end
		end

	remove_tooltip is
			-- Assign Void to `tooltip'.
		do
			check to_be_implementated: False end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE

end -- EV_TOOLTIPABLE_IMP

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
--| Revision 1.2  2000/06/07 17:27:56  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.1.2.3  2000/05/10 23:10:00  king
--| Integrated tooltipable changes
--|
--| Revision 1.1.2.2  2000/05/04 19:14:05  brendel
--| Removed inheritance of non-existent EV_ANY_IMP.
--|
--| Revision 1.1.2.1  2000/05/04 19:00:52  king
--| initial
--|
--| Revision 1.1.2.2  2000/05/04 18:50:31  king
--| Corrected set_tooltip
--|
--| Revision 1.1.2.1  2000/05/03 19:08:41  oconnor
--| mergred from HEAD
--|
--| Revision 1.1  2000/05/02 22:15:40  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
