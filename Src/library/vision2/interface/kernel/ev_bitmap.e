note
	description: "Bitmap object used for EV_PIXMAP masking"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BITMAP

inherit
	EV_DRAWABLE
		redefine
			implementation
		end

create
	default_create ,
	make_with_size

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER)
			-- Create with `a_width' and `a_height'.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			default_create
			set_size (a_width, a_height)
		ensure then
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

feature -- Status Setting

	set_size (a_width, a_height: INTEGER)
			-- Assign `a_width' and `a_height' to `width' and `weight'.
			-- Do not stretch image.
			-- May cause cropping.
		require
			not_destroyed: not is_destroyed
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			implementation.set_size (a_width, a_height)
		ensure
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

feature -- Access

	width: INTEGER
			-- Horizontal size in pixels.
		do
			Result := implementation.width
		ensure then
			bridge_ok: Result = implementation.width
			positive: Result > 0
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			Result := implementation.height
		ensure then
			bridge_ok: Result = implementation.height
			positive: Result > 0
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_BITMAP_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_BITMAP_IMP} implementation.make
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
