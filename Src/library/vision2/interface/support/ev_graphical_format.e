indexing
	description:
		"Base class for graphical formats"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GRAPHICAL_FORMAT

feature -- Access

	scale_width: INTEGER
		-- Width to scale graphic to, 0 means no scaling.
	
	scale_height: INTEGER
		-- Height to scale graphic to, 0 means no scaling.

	color_mode: INTEGER
		-- Color output mode of `Current'

	file_extension: STRING_32 is
			-- 3 character file extension associated with format.
		deferred
		end

feature -- Status Setting

	set_scale_width (a_width: INTEGER) is
			-- Scale the graphic width to `a_width'.
		require
			a_width_not_negative: a_width >= 0
		do
			scale_width := a_width
		ensure
			scale_width_set: scale_width = a_width
		end

	set_scale_height (a_height: INTEGER) is
			-- Scale the graphic height to `a_height'.
		require
			a_height_not_negative: a_height >= 0
		do
			scale_height := a_height
		ensure
			scale_height_set: scale_height = a_height
		end
		
	set_truecolor is
			-- Set `color_mode' to truecolor.
		do
		end
	
	set_greyscale is
			-- Set `color_mode' to grayscale.
		do
		end

	set_paletted is
			-- Set `color_mode' to paletted mode.
		do
		end
		
feature {EV_PIXMAP_I} -- Access

	save (raw_image_data: EV_RAW_IMAGE_DATA; a_filename: FILE_NAME) is
			-- Save `raw_image_data' in `Current' format to `a_filename'.
		deferred
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




end -- class EV_GRAPHICAL_FORMAT

