note
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

feature -- Initialization

	make_with_size (a_width, a_height: INTEGER)
			-- Make Current with size.
		require
			width_valid: a_width > 0
			height_valid: a_height > 0
		deferred
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP)
			-- Create with `a_pixmap''s image data.
		require
			not_void: a_pixmap /= Void
		deferred
		end

feature -- Command

	set_with_named_path (a_file_name: PATH)
			-- Load pixel data from `a_file_name'.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
		deferred
		end

	set_with_pointer (a_pointer: POINTER; a_size: INTEGER)
			-- Load pixel data from `a_pointer'
			-- `a_size': size in bytes
		require
		deferred
		end

	save_to_named_path (a_file_name: PATH)
			-- Save pixel data to file `a_file_name'.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
		deferred
		end

	save_to_pointer: detachable MANAGED_POINTER
			-- Save pixel data to `a_pointer'
		deferred
		end

	stretched (a_width, a_height: INTEGER): EV_PIXEL_BUFFER
			-- Stretched copy of `Current' of dimension `a_width' x `a_height'.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
			not_locked: not is_locked
		deferred
		ensure
			result_not_void: Result /= Void
			result_width_set: Result.width = a_width
			result_height_set: Result.height = a_height
		end

	sub_pixmap (a_rect: EV_RECTANGLE): EV_PIXMAP
			-- Create a new sub pixmap from Current.
		deferred
		end

	sub_pixel_buffer (a_rect: EV_RECTANGLE): EV_PIXEL_BUFFER
			-- Create a new sub pixel buffer object.
		deferred
		end

	draw_pixel_buffer_with_x_y (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Draw `a_pixel_buffer' at `a_x', `a_y'.
		deferred
		end

	draw_text (a_text: READABLE_STRING_GENERAL; a_font: EV_FONT; a_point: EV_COORDINATE)
			-- Draw `a_text' with `a_font' at `a_rect'.
		deferred
		end

	lock
			-- Lock buffer for pixel iteration.
		do
			is_locked := True
		end

	unlock
			-- Unlock buffer from pixel iteration.
		do
			is_locked := False
		end

feature {EV_PIXEL_BUFFER_PIXEL} -- Implementation

	get_pixel (a_x, a_y: NATURAL_32): NATURAL_32
			-- Get the platform dependent pixel value at `a_x', `a_y' (zero based for speed)
		require
			a_x_valid: a_x < width.as_natural_32
			a_y_valid: a_y <= height.as_natural_32
		deferred
		end

	set_pixel (a_x, a_y, rgba: NATURAL_32)
			-- Set the platform dependent pixel value at `a_x', `a_y' (zero based for speed) to `rgba'.
		require
			a_x_valid: a_x < width.as_natural_32
			a_y_valid: a_y <= height.as_natural_32
		deferred
		ensure
			pixel_set: get_pixel (a_x, a_y) = rgba
		end

feature -- Query

	is_locked: BOOLEAN
		-- Is buffer locked for pixel iteration?

	pixel_iterator: EV_PIXEL_BUFFER_ITERATOR
			-- Return a pixel buffer iterator.
		do
			if pixel_iterator_internal = Void then
				create pixel_iterator_internal.make_for_pixel_buffer (attached_interface)
			end
			Result := pixel_iterator_internal
		end

	width: INTEGER
			-- Width
		deferred
		end

	height: INTEGER
			-- Height
		deferred
		end

	area: EV_RECTANGLE
			-- Dimension of Current as an instance of EV_RECTANGLE.
		do
			create Result.make (0, 0, width, height)
		ensure
			definition: Result.x = 0 and Result.y = 0 and Result.width = width and Result.height = height
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PIXEL_BUFFER note option: stable attribute end;
		-- Interface object for `Current'.

feature {NONE} -- Implementation

	pixel_iterator_internal: detachable EV_PIXEL_BUFFER_ITERATOR note option: stable attribute end;
		-- Iteration object for pixels of `Current'.

feature -- Obsolete

	draw_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_rect: EV_RECTANGLE)
			-- Draw `a_pixel_buffer' at `a_rect'.
		obsolete
			"Use draw_pixel_buffer_with_x_y instead [2017-05-31]"
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
