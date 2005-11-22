indexing
	description: "Algorithm of color calculating."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_COLOR_HELPER

feature -- Saturation

	build_color_with_lightness (a_color: EV_COLOR; a_lightness_increase: REAL): EV_COLOR is
			-- Make new color with `a_color', and new `a_saturation'.
		require
			a_lightness_valid: a_lightness_increase <= 1 and a_lightness_increase >= -1
			a_color_attached: a_color /= Void
		local
			new_r, new_g, new_b: INTEGER
		do
			if a_lightness_increase > 0 then
				new_r := light_increase (a_color.red_8_bit, a_lightness_increase)
				new_g := light_increase (a_color.green_8_bit, a_lightness_increase)
				new_b := light_increase (a_color.blue_8_bit, a_lightness_increase)
			else
				new_r := light_decrease (a_color.red_8_bit, a_lightness_increase)
				new_g := light_decrease (a_color.green_8_bit, a_lightness_increase)
				new_b := light_decrease (a_color.blue_8_bit, a_lightness_increase)
			end
			create Result.make_with_8_bit_rgb (new_r, new_g, new_b)
		end

feature {NONE} -- Implementation

	light_increase (a_color: INTEGER; a_lightness_increase: REAL): INTEGER is
			-- Increas light.
		do
			Result := (a_color * (1 - a_lightness_increase) + 255 * a_lightness_increase).rounded
		end

	light_decrease (a_color: INTEGER; a_lightness_increase: REAL): INTEGER is
			-- Decrease light.
		do
			Result := a_color * (1 - a_lightness_increase).rounded
		end
end
