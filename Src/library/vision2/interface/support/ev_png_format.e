indexing
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

	file_extension: STRING is
			-- Three character file extension associated with format.
		once
			Result := "png"
		end

	save (raw_image_data: EV_RAW_IMAGE_DATA; a_filename: FILE_NAME) is
			-- Save `raw_image_data' to file `a_filename' in PNG format.
		do
			-- Implemented in pixmap implementation
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




end -- class EV_PNG_FORMAT

