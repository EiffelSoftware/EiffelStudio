note
	description: "EiffelVision pixmap. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	read_from_named_file (file_name: STRING_GENERAL)
			-- Load pixmap data from the file named `file_name'.
			-- Exceptions: "Unable to retrieve icon information"
		require
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
		deferred
		end

	set_with_default
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
			--
			-- Exceptions "Unable to retrieve icon information"
		deferred
		end

	set_size (a_x, a_y: INTEGER)
			-- Set the size of the pixmap to `a_x' by `a_y' pixels.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		deferred
		end

	reset_for_buffering (a_width, a_height: INTEGER)
			-- Resets the size of the pixmap without keeping original image or clearing background.
		require
			width_valid: a_width > 0
			height_valid: a_height > 0
		deferred
		end

	stretch (a_x, a_y: INTEGER)
			-- Stretch the image to fit in size `a_x' by `a_y' pixels.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		deferred
		end

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME)
			-- Save `Current' to `a_filename' in `a_format' format.
		require
			a_format_not_void: a_format /= Void
			a_filename_not_void: a_filename /= Void
			a_filename_valid: a_filename.is_valid
		do
			a_format.save (raw_image_data, a_filename)
		end

	set_mask (a_mask: EV_BITMAP)
			-- Assign `a_mask' to `pixmap'.
		require
			mask_not_void: a_mask /= Void
			mask_same_dimensions: a_mask.width = width and then a_mask.height = height
		deferred
		end

	init_from_pointer_style (a_pointer_style: EV_POINTER_STYLE)
			-- Initialize from `a_pointer_style'
		require
			not_void: a_pointer_style /= Void
		deferred
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Initialize from `a_pixel_buffer'
		require
			not_void: a_pixel_buffer /= Void
		deferred
		end

feature -- Access

	raw_image_data: EV_RAW_IMAGE_DATA
			-- RGBA representation of `Current'.
		deferred
		end

feature -- Basic operations

	flush
			-- Execute any delayed calls to `expose_actions' without waiting
			-- for next idle.
		do
		end

feature -- Duplication

	copy_pixmap(other: EV_PIXMAP)
			-- Update `Current' to have same appearence as `other'.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAP;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PIXMAP_I

