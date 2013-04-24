note
	description: "List of default colors used by the system. Cocoa implementation."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_COLORS_IMP

create
	default_create

feature --

	color_3d_face: EV_COLOR
			-- Used for dialog box background.
		local
			l_color: detachable NS_COLOR
		do
			create l_color.light_gray_color
			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			check l_color /= Void end
			create Result.make_with_rgb (l_color.red_component, l_color.green_component, l_color.blue_component)
		end

	color_dialog_fg: EV_COLOR
		local
			l_color: detachable NS_COLOR
		do
			create l_color.control_background_color
			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			check l_color /= Void end
			create Result.make_with_rgb (l_color.red_component, l_color.green_component, l_color.blue_component)
		end

	color_3d_highlight: EV_COLOR
			-- Used for 3D-effects (light color)
		local
			l_color: detachable NS_COLOR
		do
			create l_color.highlight_color
			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			check l_color /= Void end
			create Result.make_with_rgb (l_color.red_component, l_color.green_component, l_color.blue_component)
		end

	color_3d_shadow: EV_COLOR
			-- Used for 3D-effects (dark color)
		local
			l_color: detachable NS_COLOR
		do
			create l_color.shadow_color
			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			check l_color /= Void end
			create Result.make_with_rgb (l_color.red_component, l_color.green_component, l_color.blue_component)
		end

	color_read_only: EV_COLOR
			-- Used for background of editable when read-only.
		do
			create Result
		end

	color_read_write: EV_COLOR
			-- Used for background of editable when write/write enabled.
		do
			create Result
		end

	default_background_color: EV_COLOR
			-- Used for background of most widgets.
		local
			l_color: detachable NS_COLOR
		do
			create l_color.control_color
			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			if attached l_color then
				create Result.make_with_rgb (l_color.red_component, l_color.green_component, l_color.blue_component)
			else
				create Result.make_with_rgb ({REAL_32}0.929, {REAL_32}0.929, {REAL_32}0.929)
			end
		end

	default_foreground_color: EV_COLOR
			-- Used for foreground of most widgets.
		local
			l_color: detachable NS_COLOR
		do
			create l_color.control_text_color
			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			if attached l_color then
				create Result.make_with_rgb (l_color.red_component, l_color.green_component, l_color.blue_component)
			else
				create Result.make_with_rgb (0, 0, 0)
			end
		end

end -- class EV_STOCK_COLORS_IMP
