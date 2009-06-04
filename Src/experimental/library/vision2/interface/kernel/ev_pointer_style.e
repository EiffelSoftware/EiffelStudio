note
	description:
		"Apearance of a screen pointer cursor, typically moved by a mouse."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POINTER_STYLE

inherit
	EV_ANY
		redefine
			implementation, copy, is_equal
		end

create
	default_create,
	make_predefined,
	make_with_pixel_buffer,
	make_with_pixmap,
	make_with_cursor

convert
	make_with_cursor ({EV_CURSOR})

feature {NONE} -- Initlization

	make_predefined (a_contants: INTEGER)
			-- Make a predefined pointer style
		require
			valid: (create {EV_POINTER_STYLE_CONSTANTS}).is_valid (a_contants)
		do
			default_create
			implementation.init_predefined (a_contants)
		end

	make_with_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_x, a_y: INTEGER)
			-- Create pointer style using `a_pixel_buffer' with hotspot (`a_x', `a_y').
		require
			a_pixel_buffer_not_void: a_pixel_buffer /= Void
		local
			l_temp_buffer: EV_PIXEL_BUFFER
		do
			default_create
			l_temp_buffer := a_pixel_buffer
			implementation.init_from_pixel_buffer (l_temp_buffer, a_x, a_y)
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP; a_x, a_y: INTEGER)
			-- Create pointer style using `a_pixmap' with hotspot (`a_x', `a_y').
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			default_create
			implementation.init_from_pixmap (a_pixmap, a_x, a_y)
		end

	make_with_cursor (a_cursor: EV_CURSOR)
			-- Initialize from `a_cursor'.
		local
			l_temp: EV_CURSOR
		do
			default_create
			-- We convert from EV_CURSOR, `a_cursor' maybe void.
			l_temp := a_cursor
			if l_temp /= Void then
				implementation.init_from_cursor (l_temp)
			end
		end

feature -- Command

	set_x_hotspot (a_x: INTEGER)
			-- Set `x_hotspot' to `a_x'.
		require
			not_destroyed: not is_destroyed
			valid: 0 <= a_x and a_x <= width
		do
			implementation.set_x_hotspot (a_x)
		ensure
			set: x_hotspot = a_x
		end

	set_y_hotspot (a_y: INTEGER)
			-- Set `y_hotspot' to `a_y'.
		require
			not_destoryed: not is_destroyed
			valid: 0 <= a_y and a_y <= height
		do
			implementation.set_y_hotspot (a_y)
		ensure
			set: y_hotspot = a_y
		end

feature -- Query

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot.
		do
			Result := implementation.x_hotspot
		ensure
			valid: Result <= width
		end

	y_hotspot: INTEGER
			-- Specifies he y-coordinate of a cursor's hot spot.
		do
			Result := implementation.y_hotspot
		ensure
			valid: Result <= height
		end

	width: INTEGER
			-- Width
		do
			Result := implementation.width
		end

	height: INTEGER
			-- Height
		do
			Result := implementation.height
		end

feature -- Duplication

	copy (other: like current)
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		do
			check
				not_destroyed: not is_destroyed
			end
			if implementation = Void then
				default_create
			end
				-- Copy the "pixmap part"
			implementation.copy_from_pointer_style (other)
			set_x_hotspot (other.x_hotspot)
			set_y_hotspot (other.y_hotspot)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does `other' have the same appearance as `Current'.
		do
			if other /= Void then
					-- Images are proportional.
				Result := (
					width * other.height = other.width * height and then (other.x_hotspot = x_hotspot and other.y_hotspot = y_hotspot)
				)
			end
		end

feature -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- Create `implementation'.
		do
			create {EV_POINTER_STYLE_IMP} implementation.make
		end

	implementation: EV_POINTER_STYLE_I;
			-- Implementation.

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
