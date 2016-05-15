note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCROLL_VIEW_UTILS

inherit
	NS_VIEW_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSScrollView

	frame_size_for_content_size__has_horizontal_scroller__has_vertical_scroller__border_type_ (a_c_size: NS_SIZE; a_h_flag: BOOLEAN; a_v_flag: BOOLEAN; a_type: NATURAL_64): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			create Result.make
			objc_frame_size_for_content_size__has_horizontal_scroller__has_vertical_scroller__border_type_ (l_objc_class.item, Result.item, a_c_size.item, a_h_flag, a_v_flag, a_type)
		end

	content_size_for_frame_size__has_horizontal_scroller__has_vertical_scroller__border_type_ (a_f_size: NS_SIZE; a_h_flag: BOOLEAN; a_v_flag: BOOLEAN; a_type: NATURAL_64): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			create Result.make
			objc_content_size_for_frame_size__has_horizontal_scroller__has_vertical_scroller__border_type_ (l_objc_class.item, Result.item, a_f_size.item, a_h_flag, a_v_flag, a_type)
		end

feature {NONE} -- NSScrollView Externals

	objc_frame_size_for_content_size__has_horizontal_scroller__has_vertical_scroller__border_type_ (a_class_object: POINTER; result_pointer: POINTER; a_c_size: POINTER; a_h_flag: BOOLEAN; a_v_flag: BOOLEAN; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(Class)$a_class_object frameSizeForContentSize:*((NSSize *)$a_c_size) hasHorizontalScroller:$a_h_flag hasVerticalScroller:$a_v_flag borderType:$a_type];
			 ]"
		end

	objc_content_size_for_frame_size__has_horizontal_scroller__has_vertical_scroller__border_type_ (a_class_object: POINTER; result_pointer: POINTER; a_f_size: POINTER; a_h_flag: BOOLEAN; a_v_flag: BOOLEAN; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(Class)$a_class_object contentSizeForFrameSize:*((NSSize *)$a_f_size) hasHorizontalScroller:$a_h_flag hasVerticalScroller:$a_v_flag borderType:$a_type];
			 ]"
		end

feature -- NSRulerSupport

	set_ruler_view_class_ (a_ruler_view_class: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_ruler_view_class__item: POINTER
		do
			if attached a_ruler_view_class as a_ruler_view_class_attached then
				a_ruler_view_class__item := a_ruler_view_class_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_ruler_view_class_ (l_objc_class.item, a_ruler_view_class__item)
		end

	ruler_view_class: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_ruler_view_class (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ruler_view_class} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ruler_view_class} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSRulerSupport Externals

	objc_set_ruler_view_class_ (a_class_object: POINTER; a_ruler_view_class: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setRulerViewClass:$a_ruler_view_class];
			 ]"
		end

	objc_ruler_view_class (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object rulerViewClass];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScrollView"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
