note
	description:
		"Portable Network Graphics (PNG) Graphical Format Abstraction used by {EV_PIXMAP}.save_to_named_file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PNG_FORMAT

inherit
	EV_GRAPHICAL_FORMAT

feature {EV_PIXMAP_I} -- Access

	file_extension: STRING_32
			-- Three character file extension associated with format.
		once
			Result := {STRING_32} "png"
		end

	save (raw_image_data: EV_RAW_IMAGE_DATA; a_filepath: PATH)
			-- Save `raw_image_data' to file `a_filepath' in PNG format.
		do
			-- Implemented in pixmap implementation
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_PNG_FORMAT

