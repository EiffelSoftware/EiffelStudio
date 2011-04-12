note
	description: "[
					Eiffel wrapper for UI_HSBCOLOR
					UI_HSBCOLOR is a type defined in UIRibbon.h that is composed of 
  					three component values: hue, saturation and brightness, respectively.
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_HSB_COLOR

create
	make_with_hsb,
	make_with_value

feature {NONE} -- Initilaization

	make_with_hsb (a_hue: NATURAL_8; a_saturation: NATURAL_8; a_brightness: NATURAL_8)
			-- Creation method
		do
			value := (a_hue.as_natural_32 | (a_saturation.as_natural_32 |<< 8) | (a_brightness.as_natural_32 |<< 16))
		end

	make_with_value (a_value: NATURAL_32)
			-- Creattion method
		do
			value := a_value
		ensure
			set: value = a_value
		end

feature -- Query

	value: NATURAL_32
			-- Color value

	hue: NATURAL_8
			--
		do
			Result := value.as_natural_8
		end

	saturation: NATURAL_8
			--
		do
			Result := (value |>> 8).as_natural_8
		end

	brightness: NATURAL_8
			--
		do
			Result := (value |>> 16).as_natural_8
		end
end
