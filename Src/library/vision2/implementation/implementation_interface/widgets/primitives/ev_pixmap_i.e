indexing
	description: "EiffelVision pixmap. Implementation interface."
	status: "See notice at end of class"
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAP_I 

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_PIXMAP_ACTION_SEQUENCES_I

feature -- Initialization

	read_from_named_file (file_name: STRING) is
			-- Load pixmap data from the file named `file_name'.
			-- Exceptions: "Unable to retrieve icon information"
		require
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
		deferred
		end

	set_with_default is
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
			--
			-- Exceptions "Unable to retrieve icon information"
		deferred
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the pixmap to `a_x' by `a_y' pixels.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		deferred	
		end

	stretch (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y' pixels.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		deferred
		end

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME) is
			-- Save `Current' to `a_filename' in `a_format' format.
		require
			a_format_not_void: a_format /= Void
			a_filename_not_void: a_filename /= Void
			a_filename_valid: a_filename.is_valid
		do
			a_format.save (raw_image_data, a_filename)
		end

feature -- Access

	raw_image_data: EV_RAW_IMAGE_DATA is
			-- RGBA representation of `Current'.
		deferred
		end

feature -- Basic operations

	flush is
			-- Execute any delayed calls to `expose_actions' without waiting
			-- for next idle.
		do
		end

feature -- Duplication

	copy_pixmap(other: EV_PIXMAP) is
			-- Update `Current' to have same appearence as `other'.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAP

end -- class EV_PIXMAP_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

