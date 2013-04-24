note
	description: "Stretch mode constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRETCH_MODE_CONSTANTS

feature -- Access

	frozen black_on_white, stretch_andscans: INTEGER = 1
			-- Performs a Boolean AND operation using the color values for the eliminated
			-- and existing pixels. If the bitmap is a monochrome bitmap, this mode
			-- preserves black pixels at the expense of white pixels.

	frozen color_on_color, stretch_deletescans: INTEGER = 3
			-- Deletes the pixels. This mode deletes all eliminated lines of
			-- pixels without trying to preserve their information.

	frozen white_on_black, stretch_orscans: INTEGER = 2

	frozen halftone, stretch_halftone: INTEGER = 4
			-- Maps pixels from the source rectangle into blocks of pixels in the
			-- destination rectangle. The average color over the destination block
			-- of pixels approximates the color of the source pixels.
			-- After setting the HALFTONE stretching mode, an application must call the
			-- SetBrushOrgEx function to set the brush origin. If it fails to do so,
			-- brush misalignment occurs.

feature -- Status report

	valid_stretch_mode_constant (c: INTEGER): BOOLEAN
			-- Is `c' a valid stretch mode constant?
		do
			Result := c = Stretch_andscans or else
				c = Stretch_deletescans or else
				c = Stretch_orscans or else
				c = stretch_halftone
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_STRETCH_MODE_CONSTANTS

