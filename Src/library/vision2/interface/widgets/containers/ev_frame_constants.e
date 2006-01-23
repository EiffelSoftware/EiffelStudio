indexing
	description:
		"Constants for use by and with EV_FRAME."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			Result := a_code = Ev_frame_lowered or else
				a_code = Ev_frame_raised or else
				a_code = Ev_frame_etched_in or else
				a_code = Ev_frame_etched_out
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FRAME_CONSTANTS

