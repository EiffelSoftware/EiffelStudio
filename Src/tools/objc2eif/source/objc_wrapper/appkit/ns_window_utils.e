note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WINDOW_UTILS

inherit
	NS_RESPONDER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSWindow

	frame_rect_for_content_rect__style_mask_ (a_c_rect: NS_RECT; a_style: NATURAL_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			create Result.make
			objc_frame_rect_for_content_rect__style_mask_ (l_objc_class.item, Result.item, a_c_rect.item, a_style)
		end

	content_rect_for_frame_rect__style_mask_ (a_f_rect: NS_RECT; a_style: NATURAL_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			create Result.make
			objc_content_rect_for_frame_rect__style_mask_ (l_objc_class.item, Result.item, a_f_rect.item, a_style)
		end

	min_frame_width_with_title__style_mask_ (a_title: detachable NS_STRING; a_style: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_min_frame_width_with_title__style_mask_ (l_objc_class.item, a_title__item, a_style)
		end

	default_depth_limit: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_depth_limit (l_objc_class.item)
		end

	remove_frame_using_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_remove_frame_using_name_ (l_objc_class.item, a_name__item)
		end

	menu_changed_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_menu_changed_ (l_objc_class.item, a_menu__item)
		end

	standard_window_button__for_style_mask_ (a_b: NATURAL_64; a_style_mask: NATURAL_64): detachable NS_BUTTON
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_standard_window_button__for_style_mask_ (l_objc_class.item, a_b, a_style_mask)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like standard_window_button__for_style_mask_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like standard_window_button__for_style_mask_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_numbers_with_options_ (a_options: NATURAL_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_window_numbers_with_options_ (l_objc_class.item, a_options)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_numbers_with_options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_numbers_with_options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_number_at_point__below_window_with_window_number_ (a_point: NS_POINT; a_window_number: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_window_number_at_point__below_window_with_window_number_ (l_objc_class.item, a_point.item, a_window_number)
		end

feature {NONE} -- NSWindow Externals

	objc_frame_rect_for_content_rect__style_mask_ (a_class_object: POINTER; result_pointer: POINTER; a_c_rect: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(Class)$a_class_object frameRectForContentRect:*((NSRect *)$a_c_rect) styleMask:$a_style];
			 ]"
		end

	objc_content_rect_for_frame_rect__style_mask_ (a_class_object: POINTER; result_pointer: POINTER; a_f_rect: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(Class)$a_class_object contentRectForFrameRect:*((NSRect *)$a_f_rect) styleMask:$a_style];
			 ]"
		end

	objc_min_frame_width_with_title__style_mask_ (a_class_object: POINTER; a_title: POINTER; a_style: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object minFrameWidthWithTitle:$a_title styleMask:$a_style];
			 ]"
		end

	objc_default_depth_limit (a_class_object: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object defaultDepthLimit];
			 ]"
		end

	objc_remove_frame_using_name_ (a_class_object: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object removeFrameUsingName:$a_name];
			 ]"
		end

	objc_menu_changed_ (a_class_object: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object menuChanged:$a_menu];
			 ]"
		end

	objc_standard_window_button__for_style_mask_ (a_class_object: POINTER; a_b: NATURAL_64; a_style_mask: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object standardWindowButton:$a_b forStyleMask:$a_style_mask];
			 ]"
		end

	objc_window_numbers_with_options_ (a_class_object: POINTER; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object windowNumbersWithOptions:$a_options];
			 ]"
		end

	objc_window_number_at_point__below_window_with_window_number_ (a_class_object: POINTER; a_point: POINTER; a_window_number: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object windowNumberAtPoint:*((NSPoint *)$a_point) belowWindowWithWindowNumber:$a_window_number];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSWindow"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
