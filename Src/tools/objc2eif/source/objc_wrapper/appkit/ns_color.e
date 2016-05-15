note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSColor

	highlight_with_level_ (a_val: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_highlight_with_level_ (item, a_val)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like highlight_with_level_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like highlight_with_level_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	shadow_with_level_ (a_val: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_shadow_with_level_ (item, a_val)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shadow_with_level_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shadow_with_level_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set (item)
		end

	set_fill
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_fill (item)
		end

	set_stroke
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_stroke (item)
		end

	color_space_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color_space_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_space_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_space_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_using_color_space_name_ (a_color_space: detachable NS_STRING): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_color_space__item: POINTER
		do
			if attached a_color_space as a_color_space_attached then
				a_color_space__item := a_color_space_attached.item
			end
			result_pointer := objc_color_using_color_space_name_ (item, a_color_space__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_using_color_space_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_using_color_space_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_using_color_space_name__device_ (a_color_space: detachable NS_STRING; a_device_description: detachable NS_DICTIONARY): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_color_space__item: POINTER
			a_device_description__item: POINTER
		do
			if attached a_color_space as a_color_space_attached then
				a_color_space__item := a_color_space_attached.item
			end
			if attached a_device_description as a_device_description_attached then
				a_device_description__item := a_device_description_attached.item
			end
			result_pointer := objc_color_using_color_space_name__device_ (item, a_color_space__item, a_device_description__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_using_color_space_name__device_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_using_color_space_name__device_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_using_color_space_ (a_space: detachable NS_COLOR_SPACE): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_space__item: POINTER
		do
			if attached a_space as a_space_attached then
				a_space__item := a_space_attached.item
			end
			result_pointer := objc_color_using_color_space_ (item, a_space__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_using_color_space_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_using_color_space_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	blended_color_with_fraction__of_color_ (a_fraction: REAL_64; a_color: detachable NS_COLOR): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			result_pointer := objc_blended_color_with_fraction__of_color_ (item, a_fraction, a_color__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like blended_color_with_fraction__of_color_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like blended_color_with_fraction__of_color_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_alpha_component_ (a_alpha: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color_with_alpha_component_ (item, a_alpha)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_alpha_component_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_alpha_component_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	catalog_name_component: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_catalog_name_component (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like catalog_name_component} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like catalog_name_component} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_name_component: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color_name_component (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_name_component} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_name_component} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_catalog_name_component: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_catalog_name_component (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_catalog_name_component} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_catalog_name_component} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_color_name_component: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_color_name_component (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_color_name_component} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_color_name_component} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	red_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_red_component (item)
		end

	green_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_green_component (item)
		end

	blue_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_blue_component (item)
		end

--	get_red__green__blue__alpha_ (a_red: UNSUPPORTED_TYPE; a_green: UNSUPPORTED_TYPE; a_blue: UNSUPPORTED_TYPE; a_alpha: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_red__item: POINTER
--			a_green__item: POINTER
--			a_blue__item: POINTER
--			a_alpha__item: POINTER
--		do
--			if attached a_red as a_red_attached then
--				a_red__item := a_red_attached.item
--			end
--			if attached a_green as a_green_attached then
--				a_green__item := a_green_attached.item
--			end
--			if attached a_blue as a_blue_attached then
--				a_blue__item := a_blue_attached.item
--			end
--			if attached a_alpha as a_alpha_attached then
--				a_alpha__item := a_alpha_attached.item
--			end
--			objc_get_red__green__blue__alpha_ (item, a_red__item, a_green__item, a_blue__item, a_alpha__item)
--		end

	hue_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hue_component (item)
		end

	saturation_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_saturation_component (item)
		end

	brightness_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_brightness_component (item)
		end

--	get_hue__saturation__brightness__alpha_ (a_hue: UNSUPPORTED_TYPE; a_saturation: UNSUPPORTED_TYPE; a_brightness: UNSUPPORTED_TYPE; a_alpha: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_hue__item: POINTER
--			a_saturation__item: POINTER
--			a_brightness__item: POINTER
--			a_alpha__item: POINTER
--		do
--			if attached a_hue as a_hue_attached then
--				a_hue__item := a_hue_attached.item
--			end
--			if attached a_saturation as a_saturation_attached then
--				a_saturation__item := a_saturation_attached.item
--			end
--			if attached a_brightness as a_brightness_attached then
--				a_brightness__item := a_brightness_attached.item
--			end
--			if attached a_alpha as a_alpha_attached then
--				a_alpha__item := a_alpha_attached.item
--			end
--			objc_get_hue__saturation__brightness__alpha_ (item, a_hue__item, a_saturation__item, a_brightness__item, a_alpha__item)
--		end

	white_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_white_component (item)
		end

--	get_white__alpha_ (a_white: UNSUPPORTED_TYPE; a_alpha: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_white__item: POINTER
--			a_alpha__item: POINTER
--		do
--			if attached a_white as a_white_attached then
--				a_white__item := a_white_attached.item
--			end
--			if attached a_alpha as a_alpha_attached then
--				a_alpha__item := a_alpha_attached.item
--			end
--			objc_get_white__alpha_ (item, a_white__item, a_alpha__item)
--		end

	cyan_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_cyan_component (item)
		end

	magenta_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_magenta_component (item)
		end

	yellow_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_yellow_component (item)
		end

	black_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_black_component (item)
		end

--	get_cyan__magenta__yellow__black__alpha_ (a_cyan: UNSUPPORTED_TYPE; a_magenta: UNSUPPORTED_TYPE; a_yellow: UNSUPPORTED_TYPE; a_black: UNSUPPORTED_TYPE; a_alpha: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_cyan__item: POINTER
--			a_magenta__item: POINTER
--			a_yellow__item: POINTER
--			a_black__item: POINTER
--			a_alpha__item: POINTER
--		do
--			if attached a_cyan as a_cyan_attached then
--				a_cyan__item := a_cyan_attached.item
--			end
--			if attached a_magenta as a_magenta_attached then
--				a_magenta__item := a_magenta_attached.item
--			end
--			if attached a_yellow as a_yellow_attached then
--				a_yellow__item := a_yellow_attached.item
--			end
--			if attached a_black as a_black_attached then
--				a_black__item := a_black_attached.item
--			end
--			if attached a_alpha as a_alpha_attached then
--				a_alpha__item := a_alpha_attached.item
--			end
--			objc_get_cyan__magenta__yellow__black__alpha_ (item, a_cyan__item, a_magenta__item, a_yellow__item, a_black__item, a_alpha__item)
--		end

	color_space: detachable NS_COLOR_SPACE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color_space (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_space} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_space} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_of_components: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_components (item)
		end

--	get_components_ (a_components: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_components__item: POINTER
--		do
--			if attached a_components as a_components_attached then
--				a_components__item := a_components_attached.item
--			end
--			objc_get_components_ (item, a_components__item)
--		end

	alpha_component: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alpha_component (item)
		end

	write_to_pasteboard_ (a_paste_board: detachable NS_PASTEBOARD)
			-- Auto generated Objective-C wrapper.
		local
			a_paste_board__item: POINTER
		do
			if attached a_paste_board as a_paste_board_attached then
				a_paste_board__item := a_paste_board_attached.item
			end
			objc_write_to_pasteboard_ (item, a_paste_board__item)
		end

	pattern_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_pattern_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pattern_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pattern_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	draw_swatch_in_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_swatch_in_rect_ (item, a_rect.item)
		end

feature {NONE} -- NSColor Externals

	objc_highlight_with_level_ (an_item: POINTER; a_val: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item highlightWithLevel:$a_val];
			 ]"
		end

	objc_shadow_with_level_ (an_item: POINTER; a_val: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item shadowWithLevel:$a_val];
			 ]"
		end

	objc_set (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColor *)$an_item set];
			 ]"
		end

	objc_set_fill (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColor *)$an_item setFill];
			 ]"
		end

	objc_set_stroke (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColor *)$an_item setStroke];
			 ]"
		end

	objc_color_space_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item colorSpaceName];
			 ]"
		end

	objc_color_using_color_space_name_ (an_item: POINTER; a_color_space: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item colorUsingColorSpaceName:$a_color_space];
			 ]"
		end

	objc_color_using_color_space_name__device_ (an_item: POINTER; a_color_space: POINTER; a_device_description: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item colorUsingColorSpaceName:$a_color_space device:$a_device_description];
			 ]"
		end

	objc_color_using_color_space_ (an_item: POINTER; a_space: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item colorUsingColorSpace:$a_space];
			 ]"
		end

	objc_blended_color_with_fraction__of_color_ (an_item: POINTER; a_fraction: REAL_64; a_color: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item blendedColorWithFraction:$a_fraction ofColor:$a_color];
			 ]"
		end

	objc_color_with_alpha_component_ (an_item: POINTER; a_alpha: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item colorWithAlphaComponent:$a_alpha];
			 ]"
		end

	objc_catalog_name_component (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item catalogNameComponent];
			 ]"
		end

	objc_color_name_component (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item colorNameComponent];
			 ]"
		end

	objc_localized_catalog_name_component (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item localizedCatalogNameComponent];
			 ]"
		end

	objc_localized_color_name_component (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item localizedColorNameComponent];
			 ]"
		end

	objc_red_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item redComponent];
			 ]"
		end

	objc_green_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item greenComponent];
			 ]"
		end

	objc_blue_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item blueComponent];
			 ]"
		end

--	objc_get_red__green__blue__alpha_ (an_item: POINTER; a_red: UNSUPPORTED_TYPE; a_green: UNSUPPORTED_TYPE; a_blue: UNSUPPORTED_TYPE; a_alpha: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSColor *)$an_item getRed: green: blue: alpha:];
--			 ]"
--		end

	objc_hue_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item hueComponent];
			 ]"
		end

	objc_saturation_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item saturationComponent];
			 ]"
		end

	objc_brightness_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item brightnessComponent];
			 ]"
		end

--	objc_get_hue__saturation__brightness__alpha_ (an_item: POINTER; a_hue: UNSUPPORTED_TYPE; a_saturation: UNSUPPORTED_TYPE; a_brightness: UNSUPPORTED_TYPE; a_alpha: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSColor *)$an_item getHue: saturation: brightness: alpha:];
--			 ]"
--		end

	objc_white_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item whiteComponent];
			 ]"
		end

--	objc_get_white__alpha_ (an_item: POINTER; a_white: UNSUPPORTED_TYPE; a_alpha: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSColor *)$an_item getWhite: alpha:];
--			 ]"
--		end

	objc_cyan_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item cyanComponent];
			 ]"
		end

	objc_magenta_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item magentaComponent];
			 ]"
		end

	objc_yellow_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item yellowComponent];
			 ]"
		end

	objc_black_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item blackComponent];
			 ]"
		end

--	objc_get_cyan__magenta__yellow__black__alpha_ (an_item: POINTER; a_cyan: UNSUPPORTED_TYPE; a_magenta: UNSUPPORTED_TYPE; a_yellow: UNSUPPORTED_TYPE; a_black: UNSUPPORTED_TYPE; a_alpha: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSColor *)$an_item getCyan: magenta: yellow: black: alpha:];
--			 ]"
--		end

	objc_color_space (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item colorSpace];
			 ]"
		end

	objc_number_of_components (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item numberOfComponents];
			 ]"
		end

--	objc_get_components_ (an_item: POINTER; a_components: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSColor *)$an_item getComponents:];
--			 ]"
--		end

	objc_alpha_component (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColor *)$an_item alphaComponent];
			 ]"
		end

	objc_write_to_pasteboard_ (an_item: POINTER; a_paste_board: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColor *)$an_item writeToPasteboard:$a_paste_board];
			 ]"
		end

	objc_pattern_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColor *)$an_item patternImage];
			 ]"
		end

	objc_draw_swatch_in_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColor *)$an_item drawSwatchInRect:*((NSRect *)$a_rect)];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSColor"
		end

end
