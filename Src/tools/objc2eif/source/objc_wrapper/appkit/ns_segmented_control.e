note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SEGMENTED_CONTROL

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSSegmentedControl

	set_segment_count_ (a_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_segment_count_ (item, a_count)
		end

	segment_count: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_segment_count (item)
		end

	set_selected_segment_ (a_selected_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selected_segment_ (item, a_selected_segment)
		end

	selected_segment: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selected_segment (item)
		end

	select_segment_with_tag_ (a_tag: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_select_segment_with_tag_ (item, a_tag)
		end

	set_width__for_segment_ (a_width: REAL_64; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_width__for_segment_ (item, a_width, a_segment)
		end

	width_for_segment_ (a_segment: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_width_for_segment_ (item, a_segment)
		end

	set_image__for_segment_ (a_image: detachable NS_IMAGE; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_image__for_segment_ (item, a_image__item, a_segment)
		end

	image_for_segment_ (a_segment: INTEGER_64): detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_image_for_segment_ (item, a_segment)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_for_segment_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_for_segment_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_image_scaling__for_segment_ (a_scaling: NATURAL_64; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_image_scaling__for_segment_ (item, a_scaling, a_segment)
		end

	image_scaling_for_segment_ (a_segment: INTEGER_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_image_scaling_for_segment_ (item, a_segment)
		end

	set_label__for_segment_ (a_label: detachable NS_STRING; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_label__item: POINTER
		do
			if attached a_label as a_label_attached then
				a_label__item := a_label_attached.item
			end
			objc_set_label__for_segment_ (item, a_label__item, a_segment)
		end

	label_for_segment_ (a_segment: INTEGER_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_label_for_segment_ (item, a_segment)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like label_for_segment_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like label_for_segment_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_menu__for_segment_ (a_menu: detachable NS_MENU; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_set_menu__for_segment_ (item, a_menu__item, a_segment)
		end

	menu_for_segment_ (a_segment: INTEGER_64): detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_menu_for_segment_ (item, a_segment)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu_for_segment_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu_for_segment_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selected__for_segment_ (a_selected: BOOLEAN; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selected__for_segment_ (item, a_selected, a_segment)
		end

	is_selected_for_segment_ (a_segment: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_selected_for_segment_ (item, a_segment)
		end

	set_enabled__for_segment_ (a_enabled: BOOLEAN; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_enabled__for_segment_ (item, a_enabled, a_segment)
		end

	is_enabled_for_segment_ (a_segment: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_enabled_for_segment_ (item, a_segment)
		end

	set_segment_style_ (a_segment_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_segment_style_ (item, a_segment_style)
		end

	segment_style: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_segment_style (item)
		end

feature {NONE} -- NSSegmentedControl Externals

	objc_set_segment_count_ (an_item: POINTER; a_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setSegmentCount:$a_count];
			 ]"
		end

	objc_segment_count (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSegmentedControl *)$an_item segmentCount];
			 ]"
		end

	objc_set_selected_segment_ (an_item: POINTER; a_selected_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setSelectedSegment:$a_selected_segment];
			 ]"
		end

	objc_selected_segment (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSegmentedControl *)$an_item selectedSegment];
			 ]"
		end

	objc_select_segment_with_tag_ (an_item: POINTER; a_tag: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSegmentedControl *)$an_item selectSegmentWithTag:$a_tag];
			 ]"
		end

	objc_set_width__for_segment_ (an_item: POINTER; a_width: REAL_64; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setWidth:$a_width forSegment:$a_segment];
			 ]"
		end

	objc_width_for_segment_ (an_item: POINTER; a_segment: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSegmentedControl *)$an_item widthForSegment:$a_segment];
			 ]"
		end

	objc_set_image__for_segment_ (an_item: POINTER; a_image: POINTER; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setImage:$a_image forSegment:$a_segment];
			 ]"
		end

	objc_image_for_segment_ (an_item: POINTER; a_segment: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSegmentedControl *)$an_item imageForSegment:$a_segment];
			 ]"
		end

	objc_set_image_scaling__for_segment_ (an_item: POINTER; a_scaling: NATURAL_64; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setImageScaling:$a_scaling forSegment:$a_segment];
			 ]"
		end

	objc_image_scaling_for_segment_ (an_item: POINTER; a_segment: INTEGER_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSegmentedControl *)$an_item imageScalingForSegment:$a_segment];
			 ]"
		end

	objc_set_label__for_segment_ (an_item: POINTER; a_label: POINTER; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setLabel:$a_label forSegment:$a_segment];
			 ]"
		end

	objc_label_for_segment_ (an_item: POINTER; a_segment: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSegmentedControl *)$an_item labelForSegment:$a_segment];
			 ]"
		end

	objc_set_menu__for_segment_ (an_item: POINTER; a_menu: POINTER; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setMenu:$a_menu forSegment:$a_segment];
			 ]"
		end

	objc_menu_for_segment_ (an_item: POINTER; a_segment: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSegmentedControl *)$an_item menuForSegment:$a_segment];
			 ]"
		end

	objc_set_selected__for_segment_ (an_item: POINTER; a_selected: BOOLEAN; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setSelected:$a_selected forSegment:$a_segment];
			 ]"
		end

	objc_is_selected_for_segment_ (an_item: POINTER; a_segment: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSegmentedControl *)$an_item isSelectedForSegment:$a_segment];
			 ]"
		end

	objc_set_enabled__for_segment_ (an_item: POINTER; a_enabled: BOOLEAN; a_segment: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setEnabled:$a_enabled forSegment:$a_segment];
			 ]"
		end

	objc_is_enabled_for_segment_ (an_item: POINTER; a_segment: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSegmentedControl *)$an_item isEnabledForSegment:$a_segment];
			 ]"
		end

	objc_set_segment_style_ (an_item: POINTER; a_segment_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSegmentedControl *)$an_item setSegmentStyle:$a_segment_style];
			 ]"
		end

	objc_segment_style (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSegmentedControl *)$an_item segmentStyle];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSegmentedControl"
		end

end