indexing
	description: 
		"Eiffel Vision tooltipable. Implementation interface."
	status: "See notice at end of class"
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_TOOLTIPABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Access

	tooltip: STRING is
			-- Tooltip displayed on `Current'.
		deferred
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		deferred
		end

	remove_tooltip is
			-- Make `tooltip' `Void'.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end -- class EV_TOOLTIPABLE_I

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
--| Revision 1.5  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.2.2  2000/05/05 15:49:47  brendel
--| Made deferred.
--|
--| Revision 1.2.2.1  2000/05/03 19:08:59  oconnor
--| mergred from HEAD
--|
--| Revision 1.2  2000/05/02 22:17:17  king
--| Cleaned up log
--|
--| Revision 1.1  2000/05/02 21:41:51  king
--| Initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
