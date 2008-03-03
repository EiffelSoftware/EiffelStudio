indexing
	description: "Carbon implementation for EV_PIXEL_BUFFER_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXEL_BUFFER_IMP

inherit
	EV_PIXEL_BUFFER_I

	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create with size.
		do
			create internal_pixmap.make_with_size (a_width, a_height)
		end

	make (an_interface: EV_PIXEL_BUFFER) is
			-- Creation method.
		do
			base_make (an_interface)
			make_with_size (1, 1)
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP) is
			-- Create with `a_pixmap''s image data.
		do
		end

	initialize is
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Command

	set_with_named_file (a_file_name: STRING) is
			-- Load pixel data file `a_file_name'.
		do
			internal_pixmap.set_with_named_file (a_file_name)
		end

	save_to_named_file (a_file_name: STRING) is
			-- Save pixel data to file `a_file_name'.
		do
		end


	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP is
			-- Draw Current to `a_drawable'
		do
			-- TODO!
			create Result
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER is
			-- Create a new sub pixel buffer object.
		do
			create Result
		end

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32 is
			-- Get RGBA value at `a_y', `a_y'.
		do
		end

	set_pixel (a_x, a_y, rgba: NATURAL_32) is
			-- Set RGBA value at `a_x', `a_y' to `rgba'.
		do
		end

	draw_text (a_text: STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE) is
			-- Draw `a_text' using `a_font' at `a_point'.
		do
			check not_implemented: False end
		end

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_rect: EV_RECTANGLE) is
			-- Draw `a_pixel_buffer' to current at `a_rect'.
		do
		end

feature -- Query

	width: INTEGER is
			-- Width of buffer in pixels.
		do
		end

	height: INTEGER is
			-- Height of buffer in pixels.
		do
		end

	draw_pixel_buffer_with_x_y (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Draw `a_pixel_buffer' at `a_x', `a_y'.
		local
			l_pixel_buffer_imp: EV_PIXEL_BUFFER_IMP
		do
		end

feature {EV_PIXEL_BUFFER_IMP, EV_POINTER_STYLE_IMP, EV_PIXMAP_IMP} -- Implementation

	reusable_managed_pointer: MANAGED_POINTER
		-- Managed pointer used for inspecting current.

	internal_pixmap: EV_PIXMAP
		-- Pixmap used for fallback implementation on gtk 1.2

	set_internal_pixmap (a_pixmap: like internal_pixmap) is
			-- Set `internal_pixmap' to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_pixmap := a_pixmap
		end

	destroy is
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_is_destroyed (True)
		end

feature {NONE} -- Dispose

	dispose is
			-- Dispose current.
		do
		end

indexing
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end
