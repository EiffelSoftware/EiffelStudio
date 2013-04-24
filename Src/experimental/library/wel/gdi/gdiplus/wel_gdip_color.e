note
	description: "Color used by Gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_COLOR

create
	make_from_argb,
	make_from_rgb

feature {NONE} -- Initlization

	make_from_argb (a_alpha, a_red, a_green, a_blue: INTEGER)
			-- Creation method
			-- The minimum value for `a_alpha' is 0 which means total transparent.
			-- The maximum value for `a_alpha' is 255 which means opaque.
		require
			alpha_valid: is_channel_valid (a_alpha)
			red_valid: is_channel_valid (a_red)
			green_valid: is_channel_valid (a_green)
			blue_valid: is_channel_valid (a_blue)
		do
			item :=  ((((((a_red |<< 0x10) | (a_green |<< 0x8)) | a_blue) | (a_alpha |<< 0x18))) & 0xffffffff)
		end

	make_from_rgb (a_red, a_green, a_blue: INTEGER)
			-- Creation method
		require
			red_valid: is_channel_valid (a_red)
			green_valid: is_channel_valid (a_green)
			blue_valid: is_channel_valid (a_blue)
		do
			make_from_argb (255, a_red, a_green, a_blue)
		end

feature -- Query

	is_channel_valid (a_channel_value: INTEGER): BOOLEAN
			-- If `a_channel_vlaue' valid?
		do
			Result := 0 <= a_channel_value and a_channel_value <= 255
		end

feature {WEL_GDIP_ANY} -- Implementation

	item: INTEGER_64;
			-- Color data.

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
