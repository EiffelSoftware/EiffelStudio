indexing
	description:
		"Constants for use by and with EV_FRAME."
	status: "See notice at end of class"
	keywords: "frame, bevel, outline, raised, lowered" 
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FRAME_CONSTANTS

feature -- Constants

	Ev_frame_lowered: INTEGER is unique
			-- Inward bevel.

	Ev_frame_raised: INTEGER is unique
			-- Outward bevel.

	Ev_frame_etched_in: INTEGER is unique
			-- Sunken groove.

	Ev_frame_etched_out: INTEGER is unique
			-- Raised ridge.

feature -- Contract support

	valid_frame_border (a_code: INTEGER): BOOLEAN is
			-- Is `a_code' a valid code ?
		do
			Result := a_code = Ev_frame_lowered or
				a_code = Ev_frame_raised or
				a_code = Ev_frame_etched_in or
				a_code = Ev_frame_etched_out
		end

end -- class EV_FRAME_CONSTANTS

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
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
