indexing
	description: "[
					Pixel buffer that always contain 32bits orignal pixmap pixels' datas.
					So alpha datas will not lose.
																							]"
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
			-- Initialize current with size.
		do
			default_create
			implementation.make_with_size (a_width, a_height)
		end

feature -- Command

	set_with_named_file (a_file_name: STRING) is
			-- Load pixel datas from `a_file_name'
			-- Pixmap type can be BMP, GIF, JPEG, PNG, TIFF, and EMF on Windows.
		do
			implementation.set_with_named_file (a_file_name)
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP is
			-- Draw Current to drawable surface `a_drawable'.
		require
			not_void: a_rect /= Void
		do
			Result := implementation.sub_pixmap (a_rect)
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER is
			-- Create a new sub pixel buffer object.
		require
			not_void: a_rect /= Void
		do
			Result := implementation.sub_pixel_buffer (a_rect)
		ensure
			not_void: Result /= Void
			not_current: Result /= Current
		end

feature -- Query

	width: INTEGER is
			-- Width
		do
			Result := implementation.width
		ensure
			valid: Result >= 0
		end

	height: INTEGER is
			-- Height
		do
			Result := implementation.height
		ensure
			valid: Result >= 0
		end

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation
		do
			create {EV_PIXEL_BUFFER_IMP}implementation
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
