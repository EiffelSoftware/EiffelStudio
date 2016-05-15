note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR_PANEL_UTILS

inherit
	NS_PANEL_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSColorPanel

	shared_color_panel: detachable NS_COLOR_PANEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_shared_color_panel (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_color_panel} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_color_panel} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	shared_color_panel_exists: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_shared_color_panel_exists (l_objc_class.item)
		end

	drag_color__with_event__from_view_ (a_color: detachable NS_COLOR; a_the_event: detachable NS_EVENT; a_source_view: detachable NS_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_color__item: POINTER
			a_the_event__item: POINTER
			a_source_view__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			if attached a_source_view as a_source_view_attached then
				a_source_view__item := a_source_view_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_drag_color__with_event__from_view_ (l_objc_class.item, a_color__item, a_the_event__item, a_source_view__item)
		end

	set_picker_mask_ (a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_picker_mask_ (l_objc_class.item, a_mask)
		end

	set_picker_mode_ (a_mode: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_picker_mode_ (l_objc_class.item, a_mode)
		end

feature {NONE} -- NSColorPanel Externals

	objc_shared_color_panel (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object sharedColorPanel];
			 ]"
		end

	objc_shared_color_panel_exists (a_class_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object sharedColorPanelExists];
			 ]"
		end

	objc_drag_color__with_event__from_view_ (a_class_object: POINTER; a_color: POINTER; a_the_event: POINTER; a_source_view: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object dragColor:$a_color withEvent:$a_the_event fromView:$a_source_view];
			 ]"
		end

	objc_set_picker_mask_ (a_class_object: POINTER; a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setPickerMask:$a_mask];
			 ]"
		end

	objc_set_picker_mode_ (a_class_object: POINTER; a_mode: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setPickerMode:$a_mode];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSColorPanel"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
