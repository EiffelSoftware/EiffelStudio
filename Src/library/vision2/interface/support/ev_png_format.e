indexing
	description:
		"Portable Network Graphics (PNG) Graphical Format Abstraction used by {EV_PIXMAP}.save_to_named_file"
	status: "See notice at end of class"
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
		local
			a_fn, char_array: ANY
			a_width, a_height: INTEGER
		do
			a_fn := a_filename.to_c
			char_array := raw_image_data.to_c
			if scale_height /= 0 then
				a_height := scale_height
			else
				a_height := raw_image_data.height
			end

			if scale_width /= 0 then
				a_width := scale_width
			else
				a_width := raw_image_data.width
			end

			c_ev_save_png ($char_array, $a_fn, raw_image_data.width, raw_image_data.height, a_width, a_height, color_mode)
		end

feature {NONE} -- External

	c_ev_save_png (char_array, path: POINTER;
			array_width,
			array_height,
			a_scale_width,
			a_scale_height,
			a_colormode: INTEGER) is
		external
			"C | %"load_pixmap.h%""
		end

end -- class EV_PNG_FORMAT

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
