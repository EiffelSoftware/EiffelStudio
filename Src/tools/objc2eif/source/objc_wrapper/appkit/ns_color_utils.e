note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSColor

	color_with_calibrated_white__alpha_ (a_white: REAL_64; a_alpha: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_calibrated_white__alpha_ (l_objc_class.item, a_white, a_alpha)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_calibrated_white__alpha_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_calibrated_white__alpha_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_calibrated_hue__saturation__brightness__alpha_ (a_hue: REAL_64; a_saturation: REAL_64; a_brightness: REAL_64; a_alpha: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_calibrated_hue__saturation__brightness__alpha_ (l_objc_class.item, a_hue, a_saturation, a_brightness, a_alpha)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_calibrated_hue__saturation__brightness__alpha_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_calibrated_hue__saturation__brightness__alpha_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_calibrated_red__green__blue__alpha_ (a_red: REAL_64; a_green: REAL_64; a_blue: REAL_64; a_alpha: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_calibrated_red__green__blue__alpha_ (l_objc_class.item, a_red, a_green, a_blue, a_alpha)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_calibrated_red__green__blue__alpha_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_calibrated_red__green__blue__alpha_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_device_white__alpha_ (a_white: REAL_64; a_alpha: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_device_white__alpha_ (l_objc_class.item, a_white, a_alpha)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_device_white__alpha_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_device_white__alpha_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_device_hue__saturation__brightness__alpha_ (a_hue: REAL_64; a_saturation: REAL_64; a_brightness: REAL_64; a_alpha: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_device_hue__saturation__brightness__alpha_ (l_objc_class.item, a_hue, a_saturation, a_brightness, a_alpha)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_device_hue__saturation__brightness__alpha_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_device_hue__saturation__brightness__alpha_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_device_red__green__blue__alpha_ (a_red: REAL_64; a_green: REAL_64; a_blue: REAL_64; a_alpha: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_device_red__green__blue__alpha_ (l_objc_class.item, a_red, a_green, a_blue, a_alpha)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_device_red__green__blue__alpha_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_device_red__green__blue__alpha_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_device_cyan__magenta__yellow__black__alpha_ (a_cyan: REAL_64; a_magenta: REAL_64; a_yellow: REAL_64; a_black: REAL_64; a_alpha: REAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_device_cyan__magenta__yellow__black__alpha_ (l_objc_class.item, a_cyan, a_magenta, a_yellow, a_black, a_alpha)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_device_cyan__magenta__yellow__black__alpha_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_device_cyan__magenta__yellow__black__alpha_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_catalog_name__color_name_ (a_list_name: detachable NS_STRING; a_color_name: detachable NS_STRING): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_list_name__item: POINTER
			a_color_name__item: POINTER
		do
			if attached a_list_name as a_list_name_attached then
				a_list_name__item := a_list_name_attached.item
			end
			if attached a_color_name as a_color_name_attached then
				a_color_name__item := a_color_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_catalog_name__color_name_ (l_objc_class.item, a_list_name__item, a_color_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_catalog_name__color_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_catalog_name__color_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	color_with_color_space__components__count_ (a_space: detachable NS_COLOR_SPACE; a_components: UNSUPPORTED_TYPE; a_number_of_components: INTEGER_64): detachable NS_COLOR
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_space__item: POINTER
--			a_components__item: POINTER
--		do
--			if attached a_space as a_space_attached then
--				a_space__item := a_space_attached.item
--			end
--			if attached a_components as a_components_attached then
--				a_components__item := a_components_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_color_with_color_space__components__count_ (l_objc_class.item, a_space__item, a_components__item, a_number_of_components)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like color_with_color_space__components__count_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like color_with_color_space__components__count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	black_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_black_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like black_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like black_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dark_gray_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_dark_gray_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dark_gray_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dark_gray_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	light_gray_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_light_gray_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like light_gray_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like light_gray_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	white_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_white_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like white_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like white_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	gray_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_gray_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like gray_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like gray_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	red_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_red_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like red_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like red_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	green_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_green_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like green_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like green_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	blue_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_blue_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like blue_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like blue_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	cyan_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_cyan_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cyan_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cyan_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	yellow_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_yellow_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like yellow_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like yellow_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	magenta_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_magenta_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like magenta_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like magenta_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	orange_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_orange_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like orange_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like orange_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	purple_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_purple_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like purple_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like purple_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	brown_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_brown_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like brown_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like brown_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	clear_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_clear_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like clear_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like clear_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	control_shadow_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_control_shadow_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_shadow_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_shadow_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	control_dark_shadow_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_control_dark_shadow_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_dark_shadow_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_dark_shadow_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	control_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_control_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	control_highlight_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_control_highlight_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_highlight_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_highlight_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	control_light_highlight_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_control_light_highlight_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_light_highlight_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_light_highlight_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	control_text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_control_text_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	control_background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_control_background_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_control_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_selected_control_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_control_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_control_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	secondary_selected_control_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_secondary_selected_control_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like secondary_selected_control_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like secondary_selected_control_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_control_text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_selected_control_text_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_control_text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_control_text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	disabled_control_text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_disabled_control_text_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like disabled_control_text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like disabled_control_text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_text_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_text_background_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_selected_text_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_text_background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_selected_text_background_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_text_background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_text_background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	grid_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_grid_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like grid_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like grid_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	keyboard_focus_indicator_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_keyboard_focus_indicator_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like keyboard_focus_indicator_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like keyboard_focus_indicator_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_window_background_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	scroll_bar_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_scroll_bar_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like scroll_bar_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like scroll_bar_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	knob_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_knob_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like knob_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like knob_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_knob_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_selected_knob_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_knob_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_knob_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_frame_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_window_frame_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_frame_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_frame_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_frame_text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_window_frame_text_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_frame_text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_frame_text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_menu_item_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_selected_menu_item_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_menu_item_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_menu_item_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_menu_item_text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_selected_menu_item_text_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_menu_item_text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_menu_item_text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	highlight_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_highlight_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like highlight_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like highlight_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	shadow_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_shadow_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shadow_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shadow_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	header_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_header_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like header_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like header_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	header_text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_header_text_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like header_text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like header_text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	alternate_selected_control_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_alternate_selected_control_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like alternate_selected_control_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like alternate_selected_control_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	alternate_selected_control_text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_alternate_selected_control_text_color (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like alternate_selected_control_text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like alternate_selected_control_text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	control_alternating_row_background_colors: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_control_alternating_row_background_colors (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_alternating_row_background_colors} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_alternating_row_background_colors} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_for_control_tint_ (a_control_tint: NATURAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_for_control_tint_ (l_objc_class.item, a_control_tint)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_for_control_tint_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_for_control_tint_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	current_control_tint: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_current_control_tint (l_objc_class.item)
		end

	color_from_pasteboard_ (a_paste_board: detachable NS_PASTEBOARD): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_paste_board__item: POINTER
		do
			if attached a_paste_board as a_paste_board_attached then
				a_paste_board__item := a_paste_board_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_from_pasteboard_ (l_objc_class.item, a_paste_board__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_from_pasteboard_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_from_pasteboard_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	color_with_pattern_image_ (a_image: detachable NS_IMAGE): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_pattern_image_ (l_objc_class.item, a_image__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_pattern_image_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_pattern_image_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_ignores_alpha_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_ignores_alpha_ (l_objc_class.item, a_flag)
		end

	ignores_alpha: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_ignores_alpha (l_objc_class.item)
		end

feature {NONE} -- NSColor Externals

	objc_color_with_calibrated_white__alpha_ (a_class_object: POINTER; a_white: REAL_64; a_alpha: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithCalibratedWhite:$a_white alpha:$a_alpha];
			 ]"
		end

	objc_color_with_calibrated_hue__saturation__brightness__alpha_ (a_class_object: POINTER; a_hue: REAL_64; a_saturation: REAL_64; a_brightness: REAL_64; a_alpha: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithCalibratedHue:$a_hue saturation:$a_saturation brightness:$a_brightness alpha:$a_alpha];
			 ]"
		end

	objc_color_with_calibrated_red__green__blue__alpha_ (a_class_object: POINTER; a_red: REAL_64; a_green: REAL_64; a_blue: REAL_64; a_alpha: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithCalibratedRed:$a_red green:$a_green blue:$a_blue alpha:$a_alpha];
			 ]"
		end

	objc_color_with_device_white__alpha_ (a_class_object: POINTER; a_white: REAL_64; a_alpha: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithDeviceWhite:$a_white alpha:$a_alpha];
			 ]"
		end

	objc_color_with_device_hue__saturation__brightness__alpha_ (a_class_object: POINTER; a_hue: REAL_64; a_saturation: REAL_64; a_brightness: REAL_64; a_alpha: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithDeviceHue:$a_hue saturation:$a_saturation brightness:$a_brightness alpha:$a_alpha];
			 ]"
		end

	objc_color_with_device_red__green__blue__alpha_ (a_class_object: POINTER; a_red: REAL_64; a_green: REAL_64; a_blue: REAL_64; a_alpha: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithDeviceRed:$a_red green:$a_green blue:$a_blue alpha:$a_alpha];
			 ]"
		end

	objc_color_with_device_cyan__magenta__yellow__black__alpha_ (a_class_object: POINTER; a_cyan: REAL_64; a_magenta: REAL_64; a_yellow: REAL_64; a_black: REAL_64; a_alpha: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithDeviceCyan:$a_cyan magenta:$a_magenta yellow:$a_yellow black:$a_black alpha:$a_alpha];
			 ]"
		end

	objc_color_with_catalog_name__color_name_ (a_class_object: POINTER; a_list_name: POINTER; a_color_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithCatalogName:$a_list_name colorName:$a_color_name];
			 ]"
		end

--	objc_color_with_color_space__components__count_ (a_class_object: POINTER; a_space: POINTER; a_components: UNSUPPORTED_TYPE; a_number_of_components: INTEGER_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object colorWithColorSpace:$a_space components: count:$a_number_of_components];
--			 ]"
--		end

	objc_black_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object blackColor];
			 ]"
		end

	objc_dark_gray_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object darkGrayColor];
			 ]"
		end

	objc_light_gray_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object lightGrayColor];
			 ]"
		end

	objc_white_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object whiteColor];
			 ]"
		end

	objc_gray_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object grayColor];
			 ]"
		end

	objc_red_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object redColor];
			 ]"
		end

	objc_green_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object greenColor];
			 ]"
		end

	objc_blue_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object blueColor];
			 ]"
		end

	objc_cyan_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object cyanColor];
			 ]"
		end

	objc_yellow_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object yellowColor];
			 ]"
		end

	objc_magenta_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object magentaColor];
			 ]"
		end

	objc_orange_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object orangeColor];
			 ]"
		end

	objc_purple_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object purpleColor];
			 ]"
		end

	objc_brown_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object brownColor];
			 ]"
		end

	objc_clear_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object clearColor];
			 ]"
		end

	objc_control_shadow_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object controlShadowColor];
			 ]"
		end

	objc_control_dark_shadow_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object controlDarkShadowColor];
			 ]"
		end

	objc_control_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object controlColor];
			 ]"
		end

	objc_control_highlight_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object controlHighlightColor];
			 ]"
		end

	objc_control_light_highlight_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object controlLightHighlightColor];
			 ]"
		end

	objc_control_text_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object controlTextColor];
			 ]"
		end

	objc_control_background_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object controlBackgroundColor];
			 ]"
		end

	objc_selected_control_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object selectedControlColor];
			 ]"
		end

	objc_secondary_selected_control_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object secondarySelectedControlColor];
			 ]"
		end

	objc_selected_control_text_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object selectedControlTextColor];
			 ]"
		end

	objc_disabled_control_text_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object disabledControlTextColor];
			 ]"
		end

	objc_text_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object textColor];
			 ]"
		end

	objc_text_background_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object textBackgroundColor];
			 ]"
		end

	objc_selected_text_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object selectedTextColor];
			 ]"
		end

	objc_selected_text_background_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object selectedTextBackgroundColor];
			 ]"
		end

	objc_grid_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object gridColor];
			 ]"
		end

	objc_keyboard_focus_indicator_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object keyboardFocusIndicatorColor];
			 ]"
		end

	objc_window_background_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object windowBackgroundColor];
			 ]"
		end

	objc_scroll_bar_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object scrollBarColor];
			 ]"
		end

	objc_knob_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object knobColor];
			 ]"
		end

	objc_selected_knob_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object selectedKnobColor];
			 ]"
		end

	objc_window_frame_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object windowFrameColor];
			 ]"
		end

	objc_window_frame_text_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object windowFrameTextColor];
			 ]"
		end

	objc_selected_menu_item_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object selectedMenuItemColor];
			 ]"
		end

	objc_selected_menu_item_text_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object selectedMenuItemTextColor];
			 ]"
		end

	objc_highlight_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object highlightColor];
			 ]"
		end

	objc_shadow_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object shadowColor];
			 ]"
		end

	objc_header_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object headerColor];
			 ]"
		end

	objc_header_text_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object headerTextColor];
			 ]"
		end

	objc_alternate_selected_control_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object alternateSelectedControlColor];
			 ]"
		end

	objc_alternate_selected_control_text_color (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object alternateSelectedControlTextColor];
			 ]"
		end

	objc_control_alternating_row_background_colors (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object controlAlternatingRowBackgroundColors];
			 ]"
		end

	objc_color_for_control_tint_ (a_class_object: POINTER; a_control_tint: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorForControlTint:$a_control_tint];
			 ]"
		end

	objc_current_control_tint (a_class_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object currentControlTint];
			 ]"
		end

	objc_color_from_pasteboard_ (a_class_object: POINTER; a_paste_board: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorFromPasteboard:$a_paste_board];
			 ]"
		end

	objc_color_with_pattern_image_ (a_class_object: POINTER; a_image: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithPatternImage:$a_image];
			 ]"
		end

	objc_set_ignores_alpha_ (a_class_object: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setIgnoresAlpha:$a_flag];
			 ]"
		end

	objc_ignores_alpha (a_class_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object ignoresAlpha];
			 ]"
		end

feature -- NSQuartzCoreAdditions

	color_with_ci_color_ (a_color: detachable CI_COLOR): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_color_with_ci_color_ (l_objc_class.item, a_color__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color_with_ci_color_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color_with_ci_color_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSQuartzCoreAdditions Externals

	objc_color_with_ci_color_ (a_class_object: POINTER; a_color: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object colorWithCIColor:$a_color];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSColor"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
