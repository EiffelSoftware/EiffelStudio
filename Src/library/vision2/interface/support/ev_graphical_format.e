indexing
	description:
		"Base class for graphical formats"
	status: "See notice at end of class"
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

	file_extension: STRING is
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

end -- class EV_GRAPHICAL_FORMAT

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
