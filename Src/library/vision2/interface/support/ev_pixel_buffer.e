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

feature -- Initlize

	make_with_size (a_width, a_height: INTEGER) is
			-- Create pixel buffer with width `a_width' and height `a_height'.
		do
			default_create
			implementation.make_with_size (a_width, a_height)
		end

feature -- Command

	set_with_named_file (a_file_name: STRING) is
			-- Load pixel data from file `a_file_name'
		do
			implementation.set_with_named_file (a_file_name)
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP is
			-- Return a pixmap region of `Current' represented by area `a_rect'.
		require
			not_void: a_rect /= Void
		do
			Result := implementation.sub_pixmap (a_rect)
		ensure
			result_not_void: Result /= Void
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER is
			-- Return a sub pixel buffer of `Current' represented by area `a_rect'.
		require
			not_void: a_rect /= Void
		do
			Result := implementation.sub_pixel_buffer (a_rect)
		ensure
			result_not_void: Result /= Void
			result_not_current: Result /= Current
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

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation
		do
			create {EV_PIXEL_BUFFER_IMP} implementation
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
