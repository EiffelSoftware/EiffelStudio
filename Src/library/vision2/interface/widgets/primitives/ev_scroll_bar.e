indexing
	description:
		"Base class for interactive scrolling widgets.%N%
		%See EV_HORIZONTAL_SCROLL_BAR and EV_VERTICAL_SCROLL_BAR"
	status: "See notice at end of class."
	keywords: "scroll, bar, horizontal, vertical, gauge, leap, step, page"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR

inherit
	EV_GAUGE
		redefine
			implementation
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_SCROLL_BAR_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_SCROLL_BAR

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
