indexing
	description: "Implementation interface for EV_PIXEL_BUFFER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXEL_BUFFER_I

inherit
	EV_ANY_I

feature -- Initlization

	make_with_size (a_width, a_height: INTEGER) is
			-- Make Current with size.
		require
			valid: a_width >= 0
			valid: a_height >= 0
		deferred
		end

feature -- Command

	set_with_named_file (a_file_name: STRING) is
			-- Load pixel datas from a_file_name'.
		deferred
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP is
			-- Create a new sub pixmap from Current.
		deferred
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER is
			-- Create a new sub pixel buffer object.
		deferred
		end

feature -- Query

	width: INTEGER is
			-- Width
		deferred
		end

	height: INTEGER is
			-- Height
		deferred
		end

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
