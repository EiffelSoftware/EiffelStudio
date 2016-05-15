note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SPLIT_VIEW

inherit
	NS_VIEW
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSSplitView

	set_vertical_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_vertical_ (item, a_flag)
		end

	is_vertical: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_vertical (item)
		end

	set_divider_style_ (a_divider_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_divider_style_ (item, a_divider_style)
		end

	divider_style: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_divider_style (item)
		end

	set_autosave_name_ (a_autosave_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_autosave_name__item: POINTER
		do
			if attached a_autosave_name as a_autosave_name_attached then
				a_autosave_name__item := a_autosave_name_attached.item
			end
			objc_set_autosave_name_ (item, a_autosave_name__item)
		end

	autosave_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_autosave_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like autosave_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like autosave_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_delegate_ (a_delegate: detachable NS_SPLIT_VIEW_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_SPLIT_VIEW_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	draw_divider_in_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_divider_in_rect_ (item, a_rect.item)
		end

	divider_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_divider_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like divider_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like divider_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	divider_thickness: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_divider_thickness (item)
		end

	adjust_subviews
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_adjust_subviews (item)
		end

	is_subview_collapsed_ (a_subview: detachable NS_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_subview__item: POINTER
		do
			if attached a_subview as a_subview_attached then
				a_subview__item := a_subview_attached.item
			end
			Result := objc_is_subview_collapsed_ (item, a_subview__item)
		end

	min_possible_position_of_divider_at_index_ (a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_min_possible_position_of_divider_at_index_ (item, a_divider_index)
		end

	max_possible_position_of_divider_at_index_ (a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_possible_position_of_divider_at_index_ (item, a_divider_index)
		end

	set_position__of_divider_at_index_ (a_position: REAL_64; a_divider_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_position__of_divider_at_index_ (item, a_position, a_divider_index)
		end

feature {NONE} -- NSSplitView Externals

	objc_set_vertical_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSplitView *)$an_item setVertical:$a_flag];
			 ]"
		end

	objc_is_vertical (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSplitView *)$an_item isVertical];
			 ]"
		end

	objc_set_divider_style_ (an_item: POINTER; a_divider_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSplitView *)$an_item setDividerStyle:$a_divider_style];
			 ]"
		end

	objc_divider_style (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSplitView *)$an_item dividerStyle];
			 ]"
		end

	objc_set_autosave_name_ (an_item: POINTER; a_autosave_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSplitView *)$an_item setAutosaveName:$a_autosave_name];
			 ]"
		end

	objc_autosave_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSplitView *)$an_item autosaveName];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSplitView *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSplitView *)$an_item delegate];
			 ]"
		end

	objc_draw_divider_in_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSplitView *)$an_item drawDividerInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_divider_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSplitView *)$an_item dividerColor];
			 ]"
		end

	objc_divider_thickness (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSplitView *)$an_item dividerThickness];
			 ]"
		end

	objc_adjust_subviews (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSplitView *)$an_item adjustSubviews];
			 ]"
		end

	objc_is_subview_collapsed_ (an_item: POINTER; a_subview: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSplitView *)$an_item isSubviewCollapsed:$a_subview];
			 ]"
		end

	objc_min_possible_position_of_divider_at_index_ (an_item: POINTER; a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSplitView *)$an_item minPossiblePositionOfDividerAtIndex:$a_divider_index];
			 ]"
		end

	objc_max_possible_position_of_divider_at_index_ (an_item: POINTER; a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSplitView *)$an_item maxPossiblePositionOfDividerAtIndex:$a_divider_index];
			 ]"
		end

	objc_set_position__of_divider_at_index_ (an_item: POINTER; a_position: REAL_64; a_divider_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSplitView *)$an_item setPosition:$a_position ofDividerAtIndex:$a_divider_index];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSplitView"
		end

end
