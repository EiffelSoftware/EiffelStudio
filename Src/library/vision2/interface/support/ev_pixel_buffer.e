note
	description: "Pixel buffer used for storing RGBA values."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXEL_BUFFER

inherit
	EV_ANY
		redefine
			implementation
		end
create
	default_create,
	make_with_size,
	make_with_pixmap

convert
	make_with_pixmap ({EV_PIXMAP})

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER)
			-- Create pixel buffer with width `a_width' and height `a_height'.
		require
			a_width_valid: a_width > 0
			a_height_valid: a_height > 0
		do
			default_create
			implementation.make_with_size (a_width, a_height)
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP)
			-- Create with `a_pixmap''s image data.
		require
			not_void: a_pixmap /= Void
		do
			default_create
			implementation.make_with_pixmap (a_pixmap)
		end

feature -- Command

	set_with_named_file (a_file_name: STRING)
			-- Load pixel data from file `a_file_name'
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			not_locked: not is_locked
		do
			implementation.set_with_named_file (a_file_name)
		end

	save_to_named_file (a_file_name: STRING)
			-- Save pixel data to file `a_file_name'.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			not_locked: not is_locked
		do
			implementation.save_to_named_file (a_file_name)
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP
			-- Return a pixmap region of `Current' represented by area `a_rect'.
		require
			not_void: a_rect /= Void
			not_locked: not is_locked
		do
			Result := implementation.sub_pixmap (a_rect)
		ensure
			result_not_void: Result /= Void
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER
			-- Return a sub pixel buffer of `Current' represented by area `a_rect'.
		require
			not_void: a_rect /= Void
			not_locked: not is_locked
		do
			Result := implementation.sub_pixel_buffer (a_rect)
		ensure
			result_not_void: Result /= Void
			result_not_current: Result /= Current
		end

	lock
			-- Lock pixel buffer for data access.
		require
			not_locked: not is_locked
		do
			implementation.lock
		ensure
			is_locked: is_locked
		end

	pixel_iterator: EV_PIXEL_BUFFER_ITERATOR
			-- Return a pixel buffer iterator covering.
		require
			is_locked: is_locked
		do
			Result := implementation.pixel_iterator
		ensure
			result_not_void: Result /= Void
		end

	unlock
			-- Unlock from data access with `pixel_iterator'.
		do
			implementation.unlock
		ensure
			not_locked: not is_locked
		end

	draw_pixel_buffer_with_x_y (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Draw `a_pixel_buffer' at `a_x', `a_y'.
		require
			not_void: a_pixel_buffer /= Void
			vaild: a_x >= 0 and a_y >= 0 and a_x < width and a_y < height
		do
			implementation.draw_pixel_buffer_with_x_y (a_x, a_y, a_pixel_buffer)
		end

	draw_text (a_text: STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE)
			-- Draw `a_text' with `a_font' at `a_rect'.
		require
			not_void: a_text /= Void
			not_void: a_font /= Void
			not_void: a_point /= Void
		do
			implementation.draw_text (a_text, a_font, a_point)
		end

	to_pixmap: EV_PIXMAP
			-- Convert to EV_PIXMAP.
		do
			create Result.make_with_pixel_buffer (Current)
		end

feature -- Query

	width: INTEGER
			-- Width of `Current' in pixels.
		do
			Result := implementation.width
		ensure
			valid_width: Result >= 0
		end

	height: INTEGER
			-- Height of `Current' in pixels.
		do
			Result := implementation.height
		ensure
			valid_height: Result >= 0
		end

	is_locked: BOOLEAN
			-- Is buffer locked for data access.
		do
			Result := implementation.is_locked
		end

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- Create implementation
		do
			create {EV_PIXEL_BUFFER_IMP} implementation.make
		end

feature -- Implementation

	implementation: EV_PIXEL_BUFFER_I;
			-- Implementation interface

feature -- Obsolete

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_rect: EV_RECTANGLE)
			-- Draw `a_pixel_buffer' at `a_rect'.
		obsolete
			"Use draw_pixel_buffer_with_x_y instead"
		do
			implementation.draw_pixel_buffer (a_pixel_buffer, a_rect)
		end

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

end
