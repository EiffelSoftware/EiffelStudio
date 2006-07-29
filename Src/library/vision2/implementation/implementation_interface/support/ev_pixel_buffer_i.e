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
		redefine
			interface
		end

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

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32 is
			--
		deferred
		end

	set_pixel (a_x, a_y, argb: NATURAL_32) is
			--
		deferred
		end

	lock is
			-- Lock buffer for pixel iteration.
		do
			is_locked := True
		end

	unlock is
			-- Unlock buffer from pixel iteration.
		do
			is_locked := False
		end

feature -- Query

	is_locked: BOOLEAN
		-- Is buffer locked for pixel iteration?

	pixel_iterator: EV_PIXEL_BUFFER_ITERATOR
			-- Return a pixel buffer iterator.
		do
			if pixel_iterator_internal = Void then
				create pixel_iterator_internal.make_for_pixel_buffer (interface)
			end
			Result := pixel_iterator_internal
		end

	width: INTEGER is
			-- Width
		deferred
		end

	height: INTEGER is
			-- Height
		deferred
		end

feature {NONE} -- Implementation

	pixel_iterator_internal: EV_PIXEL_BUFFER_ITERATOR;
		-- Iteration object for pixels of `Current'.

	interface: EV_PIXEL_BUFFER;
		-- Interface object for `Current'.

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
