note
	description: "Wrapper for NSColorSpace."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR_SPACE

inherit
	NS_OBJECT

create
	device_rgb_color_space,
	generic_rgb_color_space

feature {NONE} -- Creation

	device_rgb_color_space
		do
			item := color_space_device_rgb_color_space
		end

	generic_rgb_color_space
		do
			item := color_space_generic_rgb_color_space
		end

feature {NONE} -- Implementation

	frozen color_space_device_rgb_color_space: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColorSpace deviceRGBColorSpace];"
		end

	frozen color_space_generic_rgb_color_space: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColorSpace genericRGBColorSpace];"
		end
end
