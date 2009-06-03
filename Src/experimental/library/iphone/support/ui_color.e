note
	description: "Representation of colors."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_COLOR

inherit
	NS_OBJECT

create
	make_rgba

feature {NONE} -- Initialize

	make_rgba (a_red, a_green, a_blue, a_alpha: REAL)
			-- Initialize Current with RGB values.
		require
			red_valid: a_red >= 0.0 and a_red <= 1.0
			green_valid: a_green >= 0.0 and a_green <= 1.0
			blue_valid: a_blue >= 0.0 and a_blue <= 1.0
			alpha_valid: a_alpha >= 0.0 and a_alpha <= 1.0
		do
			make_from_pointer (c_new_rgb_color (a_red, a_green, a_blue, a_alpha))
		end

feature {NONE} -- Externals

	c_new_rgb_color (a_red, a_green, a_blue, a_alpha: REAL): POINTER
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return [[UIColor alloc] initWithRed:$a_red green:$a_green blue:$a_blue alpha:$a_alpha];"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
