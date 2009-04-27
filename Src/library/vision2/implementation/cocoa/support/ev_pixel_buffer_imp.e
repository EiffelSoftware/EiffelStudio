indexing
	description: "Cocoa implementation for EV_PIXEL_BUFFER_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXEL_BUFFER_IMP

inherit
	EV_PIXEL_BUFFER_I

create
	make

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER)
			-- Create with size.
		do
		end

	make (an_interface: EV_PIXEL_BUFFER)
			-- Creation method.
		do
			base_make (an_interface)
			make_with_size (1, 1)
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP)
			-- Create with `a_pixmap''s image data.
		do
		end

	initialize
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Command

	set_with_named_file (a_file_name: STRING)
			-- Load pixel data file `a_file_name'.
		do
		end

	save_to_named_file (a_file_name: STRING)
			-- Save pixel data to file `a_file_name'.
		do
		end


	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP
			-- Draw Current to `a_drawable'
		do
			-- TODO!
			create Result
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER
			-- Create a new sub pixel buffer object.
		do
			create Result
		end

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32
			-- Get RGBA value at `a_y', `a_y'.
		do
		end

	set_pixel (a_x, a_y, rgba: NATURAL_32)
			-- Set RGBA value at `a_x', `a_y' to `rgba'.
		do
		end

	draw_text (a_text: STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE)
			-- Draw `a_text' using `a_font' at `a_point'.
		do
			check not_implemented: False end
		end

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_rect: EV_RECTANGLE)
			-- Draw `a_pixel_buffer' to current at `a_rect'.
		do
		end

feature -- Query

	width: INTEGER
			-- Width of buffer in pixels.
		do
		end

	height: INTEGER
			-- Height of buffer in pixels.
		do
		end

	draw_pixel_buffer_with_x_y (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Draw `a_pixel_buffer' at `a_x', `a_y'.
		do
		end

	data_ptr: POINTER
		-- needed by SD_CENTER... classes

feature {EV_PIXEL_BUFFER_IMP, EV_POINTER_STYLE_IMP, EV_PIXMAP_IMP} -- Implementation

	destroy
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_is_destroyed (True)
		end

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end
