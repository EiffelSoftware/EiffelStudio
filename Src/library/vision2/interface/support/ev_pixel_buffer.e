indexing
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
	make_with_size

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create pixel buffer with width `a_width' and height `a_height'.
		require
			a_width_valid: a_width > 0
			a_height_valid: a_height > 0
		do
			default_create
			implementation.make_with_size (a_width, a_height)
		end

feature -- Command

	set_with_named_file (a_file_name: STRING) is
			-- Load pixel data from file `a_file_name'
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			not_locked: not is_locked
		do
			implementation.set_with_named_file (a_file_name)
		end

	save_to_named_file (a_file_name: STRING) is
			-- Save pixel data to file `a_file_name'.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			not_locked: not is_locked
		do
			implementation.save_to_named_file (a_file_name)
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP is
			-- Return a pixmap region of `Current' represented by area `a_rect'.
		require
			not_void: a_rect /= Void
			not_locked: not is_locked
		do
			Result := implementation.sub_pixmap (a_rect)
		ensure
			result_not_void: Result /= Void
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER is
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

	lock is
			-- Lock pixel buffer for data access.
		require
			not_locked: not is_locked
		do
			implementation.lock
		ensure
			is_locked: is_locked
		end

	pixel_iterator: EV_PIXEL_BUFFER_ITERATOR is
			-- Return a pixel buffer iterator covering.
		require
			is_locked: is_locked
		do
			Result := implementation.pixel_iterator
		ensure
			result_not_void: Result /= Void
		end

	unlock is
			-- Unlock from data access with `pixel_iterator'.
		do
			implementation.unlock
		ensure
			not_locked: not is_locked
		end

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_rect: EV_RECTANGLE) is
			-- Draw `a_pixel_buffer' at `a_rect'.
		require
			not_void: a_pixel_buffer /= Void
			not_void: a_rect /= Void
		do
			implementation.draw_pixel_buffer (a_pixel_buffer, a_rect)
		end

	draw_text (a_text: STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE) is
			-- Draw `a_text' with `a_font' at `a_rect'.
		require
			not_void: a_text /= Void
			not_void: a_font /= Void
			not_void: a_point /= Void
		do
			implementation.draw_text (a_text, a_font, a_point)
		end

	to_pixmap: EV_PIXMAP is
			-- Convert to EV_PIXMAP.
		local
			l_rect: EV_RECTANGLE
		do
			create l_rect.make (0, 0, width, height)
			Result := sub_pixmap (l_rect)
		end

feature -- Query

	width: INTEGER is
			-- Width of `Current' in pixels.
		do
			Result := implementation.width
		ensure
			valid_width: Result >= 0
		end

	height: INTEGER is
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

	create_implementation is
			-- Create implementation
		do
			create {EV_PIXEL_BUFFER_IMP} implementation.make (Current)
		end

feature -- Implementation

	implementation: EV_PIXEL_BUFFER_I;
			-- Implementation interface

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

end
