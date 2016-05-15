note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_PANEL

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

feature -- NSFontPanel

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

	set_panel_font__is_multiple_ (a_font_obj: detachable NS_FONT; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			objc_set_panel_font__is_multiple_ (item, a_font_obj__item, a_flag)
		end

	panel_convert_font_ (a_font_obj: detachable NS_FONT): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			result_pointer := objc_panel_convert_font_ (item, a_font_obj__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like panel_convert_font_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like panel_convert_font_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_enabled (item)
		end

	set_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_enabled_ (item, a_flag)
		end

	reload_default_font_families
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reload_default_font_families (item)
		end

feature {NONE} -- NSFontPanel Externals

	objc_accessory_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontPanel *)$an_item accessoryView];
			 ]"
		end

	objc_set_accessory_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontPanel *)$an_item setAccessoryView:$a_view];
			 ]"
		end

	objc_set_panel_font__is_multiple_ (an_item: POINTER; a_font_obj: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontPanel *)$an_item setPanelFont:$a_font_obj isMultiple:$a_flag];
			 ]"
		end

	objc_panel_convert_font_ (an_item: POINTER; a_font_obj: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontPanel *)$an_item panelConvertFont:$a_font_obj];
			 ]"
		end

	objc_is_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontPanel *)$an_item isEnabled];
			 ]"
		end

	objc_set_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontPanel *)$an_item setEnabled:$a_flag];
			 ]"
		end

	objc_reload_default_font_families (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontPanel *)$an_item reloadDefaultFontFamilies];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFontPanel"
		end

end
