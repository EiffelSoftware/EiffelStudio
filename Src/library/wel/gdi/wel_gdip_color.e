indexing
	description: "Color used by Gdi+."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_COLOR

create
	make_from_argb

feature {NONE} -- Initlization

	make_from_argb (a_alpha, a_red, a_green, a_blue: INTEGER) is
			-- Creation method
		require
			alpha_valid: is_channel_valid (a_alpha)
			red_valid: is_channel_valid (a_red)
			green_valid: is_channel_valid (a_green)
			blue_valid: is_channel_valid (a_blue)
		do
			item :=  ((((((a_red |<< 0x10) | (a_green |<< 0x8)) | a_blue) | (a_alpha |<< 0x18))) & 0xffffffff)
		end

feature -- Query

	is_channel_valid (a_channel_value: INTEGER): BOOLEAN is
			-- If `a_channel_vlaue' valid?
		do
			Result := 0 <= a_channel_value and a_channel_value <= 255
		end

feature {WEL_GDIP_ANY} -- Implementation

	item: INTEGER_64
	
end
