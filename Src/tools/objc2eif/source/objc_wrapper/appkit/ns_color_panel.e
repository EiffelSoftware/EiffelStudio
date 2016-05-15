note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR_PANEL

inherit
	NS_PANEL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_content_rect__style_mask__backing__defer_,
	make_with_content_rect__style_mask__backing__defer__screen_,
	makeial_first_responder,
	make

feature -- NSColorPanel

	set_accessory_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_accessory_view_ (item, a_view__item)
		end

	accessory_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessory_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessory_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessory_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_continuous_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_continuous_ (item, a_flag)
		end

	is_continuous: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_continuous (item)
		end

	set_shows_alpha_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_alpha_ (item, a_flag)
		end

	shows_alpha: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_alpha (item)
		end

	set_mode_ (a_mode: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_mode_ (item, a_mode)
		end

	mode: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_mode (item)
		end

	set_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_color_ (item, a_color__item)
		end

	color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	alpha: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alpha (item)
		end

	set_action_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_set_action_ (item, a_selector__item)
		end

	set_target_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_target_ (item, an_object__item)
		end

	attach_color_list_ (a_color_list: detachable NS_COLOR_LIST)
			-- Auto generated Objective-C wrapper.
		local
			a_color_list__item: POINTER
		do
			if attached a_color_list as a_color_list_attached then
				a_color_list__item := a_color_list_attached.item
			end
			objc_attach_color_list_ (item, a_color_list__item)
		end

	detach_color_list_ (a_color_list: detachable NS_COLOR_LIST)
			-- Auto generated Objective-C wrapper.
		local
			a_color_list__item: POINTER
		do
			if attached a_color_list as a_color_list_attached then
				a_color_list__item := a_color_list_attached.item
			end
			objc_detach_color_list_ (item, a_color_list__item)
		end

feature {NONE} -- NSColorPanel Externals

	objc_set_accessory_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorPanel *)$an_item setAccessoryView:$a_view];
			 ]"
		end

	objc_accessory_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorPanel *)$an_item accessoryView];
			 ]"
		end

	objc_set_continuous_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorPanel *)$an_item setContinuous:$a_flag];
			 ]"
		end

	objc_is_continuous (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorPanel *)$an_item isContinuous];
			 ]"
		end

	objc_set_shows_alpha_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorPanel *)$an_item setShowsAlpha:$a_flag];
			 ]"
		end

	objc_shows_alpha (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorPanel *)$an_item showsAlpha];
			 ]"
		end

	objc_set_mode_ (an_item: POINTER; a_mode: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorPanel *)$an_item setMode:$a_mode];
			 ]"
		end

	objc_mode (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorPanel *)$an_item mode];
			 ]"
		end

	objc_set_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorPanel *)$an_item setColor:$a_color];
			 ]"
		end

	objc_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorPanel *)$an_item color];
			 ]"
		end

	objc_alpha (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorPanel *)$an_item alpha];
			 ]"
		end

	objc_set_action_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorPanel *)$an_item setAction:$a_selector];
			 ]"
		end

	objc_set_target_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorPanel *)$an_item setTarget:$an_object];
			 ]"
		end

	objc_attach_color_list_ (an_item: POINTER; a_color_list: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorPanel *)$an_item attachColorList:$a_color_list];
			 ]"
		end

	objc_detach_color_list_ (an_item: POINTER; a_color_list: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSColorPanel *)$an_item detachColorList:$a_color_list];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSColorPanel"
		end

end
