note
	description: "Wrapper for NSColor."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR

inherit
	NS_OBJECT

create
	blue_color,
	white_color,
	light_gray_color,
	control_color,
	control_background_color,
	control_text_color,
	shadow_color,
	highlight_color,
	color_with_calibrated_red_green_blue_alpha,
	color_with_pattern_image,
	selected_text_color,
	selected_text_background_color,
	keyboard_focus_indicator_color
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature {NONE} -- Creating an NSColor with Preset Components

	blue_color
		do
			item := {NS_COLOR_API}.blue_color
		end

	white_color
		do
			item := {NS_COLOR_API}.white_color
		end

	light_gray_color
		do
			item := {NS_COLOR_API}.light_gray_color
		end

feature {NONE} -- Creating a System Color - an NSColor Whose Value Is Specified by User Preferences

	control_color
		do
			item := {NS_COLOR_API}.control_color
		end

	control_background_color
		do
			item := {NS_COLOR_API}.control_background_color
		end

	control_text_color
		do
			item := {NS_COLOR_API}.control_text_color
		end

	shadow_color
		do
			item := {NS_COLOR_API}.shadow_color
		end

	highlight_color
		do
			item := {NS_COLOR_API}.highlight_color
		end

	color_with_calibrated_red_green_blue_alpha (r, g, b, a: REAL)
		do
			item := {NS_COLOR_API}.color_with_calibrated_red_green_blue_alpha (r, g, b, a)
		end

	color_with_pattern_image (a_image: NS_IMAGE)
		do
			item := {NS_COLOR_API}.color_with_pattern_image (a_image.item)
		end

	selected_text_color
		do
			item := {NS_COLOR_API}.selected_text_color
		end

	selected_text_background_color
		do
			item := {NS_COLOR_API}.selected_text_background_color
		end

	keyboard_focus_indicator_color
		do
			item := {NS_COLOR_API}.keyboard_focus_indicator_color
		end

feature -- Creation

	color_using_color_space (a_color_space: NS_COLOR_SPACE): NS_COLOR
		do
			Result := create {NS_COLOR}.make_from_pointer ({NS_COLOR_API}.color_using_color_space (item, a_color_space.item))
		end

	color_using_color_space_name (a_color_space: NS_STRING): NS_COLOR
		do
			Result := create {NS_COLOR}.make_from_pointer ({NS_COLOR_API}.color_using_color_space_name (item, a_color_space.item))
		end

feature -- Retrieving Individual Components

-- TODO:
--		require
--			-- Color is of the right type
--		ensure
--			0.0 <= Result and Result <= 1.0


	alpha_component: REAL
			-- Returns the receiver`s alpha (opacity) component.
		do
			Result := {NS_COLOR_API}.alpha_component (item)
		end

	black_component: REAL
			-- Returns the receiver`s black component.
		do
			Result := {NS_COLOR_API}.black_component (item)
		end

	blue_component: REAL
			-- Returns the receiver`s blue component.
		do
			Result := {NS_COLOR_API}.blue_component (item)
		end

	brightness_component: REAL
			-- Returns the brightness component of the HSB color equivalent to the receiver.
		do
			Result := {NS_COLOR_API}.brightness_component (item)
		end

	catalog_name_component: NS_STRING
			-- Returns the name of the catalog containing the receiver`s name.
		do
			create Result.share_from_pointer ({NS_COLOR_API}.catalog_name_component (item))
		end

	color_name_component: NS_STRING
			-- Returns the receiver`s name.
		do
			create Result.share_from_pointer ({NS_COLOR_API}.color_name_component (item))
		end

	cyan_component: REAL
			-- Returns the receiver`s cyan component.
		do
			Result := {NS_COLOR_API}.cyan_component (item)
		end

	green_component: REAL
			-- Returns the receiver`s green component.
		do
			Result := {NS_COLOR_API}.green_component (item)
		end

	hue_component: REAL
			-- Returns the hue component of the HSB color equivalent to the receiver.
		do
			Result := {NS_COLOR_API}.hue_component (item)
		end

	localized_catalog_name_component: NS_STRING
			-- Returns the name of the catalog containing the receiver`s name as a localized string.
		do
			create Result.share_from_pointer ({NS_COLOR_API}.localized_catalog_name_component (item))
		end

	localized_color_name_component: NS_STRING
			-- Returns the name of the receiver as a localized string.
		do
			create Result.share_from_pointer ({NS_COLOR_API}.localized_color_name_component (item))
		end

	magenta_component: REAL
			-- Returns the receiver`s magenta component.
		do
			Result := {NS_COLOR_API}.magenta_component (item)
		end

	red_component: REAL
			-- Returns the receiver`s red component.
		do
			Result := {NS_COLOR_API}.red_component (item)
		end

	saturation_component: REAL
			-- Returns the saturation component of the HSB color equivalent to the receiver.
		do
			Result := {NS_COLOR_API}.saturation_component (item)
		end

	white_component: REAL
			-- Returns the receiver`s white component.
		do
			Result := {NS_COLOR_API}.white_component (item)
		end

	yellow_component: REAL
			-- Returns the receiver`s yellow component.
		do
			Result := {NS_COLOR_API}.yellow_component (item)
		end

feature -- Changing the Color

	blended_color_with_fraction_of_color (a_fraction: REAL; a_color: NS_COLOR): NS_COLOR
			-- Creates and returns an <code>NSColor</code> object whose component values are a weighted sum of the receiver`s and the specified color object`s.
		do
			create Result.share_from_pointer ({NS_COLOR_API}.blended_color_with_fraction_of_color (item, a_fraction.item, a_color.item))
		end

	color_with_alpha_component (a_alpha: REAL): NS_COLOR
			-- Creates and returns an <code>NSColor</code> object that has the same color space and component values as the receiver, but the specified alpha component.
		do
			create Result.share_from_pointer ({NS_COLOR_API}.color_with_alpha_component (item, a_alpha.item))
		end

	highlight_with_level (a_val: REAL): NS_COLOR
			-- Returns an <code>NSColor</code> object that represents a blend between the receiver and the highlight color returned by <code>highlightColor</code>.
		do
			create Result.share_from_pointer ({NS_COLOR_API}.highlight_with_level (item, a_val.item))
		end

	shadow_with_level (a_val: REAL): NS_COLOR
			-- Returns an <code>NSColor</code> object that represents a blend between the receiver and the shadow color returned by <code>shadowColor</code>.
		do
			create Result.share_from_pointer ({NS_COLOR_API}.shadow_with_level (item, a_val.item))
		end

feature -- Drawing

	draw_swatch_in_rect (a_rect: NS_RECT)
			-- Draws the current color in the given rectangle.
		do
			{NS_COLOR_API}.draw_swatch_in_rect (item, a_rect.item)
		end

	set
			-- Sets the color of subsequent drawing to the color that the receiver represents.
		do
			{NS_COLOR_API}.set (item)
		end

	set_fill
			-- Sets the fill color of subsequent drawing to the receiver`s color.
		do
			{NS_COLOR_API}.set_fill (item)
		end

	set_stroke
			-- Sets the stroke color of subsequent drawing to the receiver`s color.
		do
			{NS_COLOR_API}.set_stroke (item)
		end

end
