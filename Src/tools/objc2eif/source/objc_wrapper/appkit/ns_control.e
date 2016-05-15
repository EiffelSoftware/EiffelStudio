note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONTROL

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

feature -- NSControl

	size_to_fit
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_size_to_fit (item)
		end

	calc_size
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_calc_size (item)
		end

	cell: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_cell_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_cell_ (item, a_cell__item)
		end

	selected_cell: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	target: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_target (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like target} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like target} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
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

	action: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_action (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
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

	set_tag_ (an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tag_ (item, an_int)
		end

	selected_tag: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selected_tag (item)
		end

	set_ignores_multi_click_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_ignores_multi_click_ (item, a_flag)
		end

	ignores_multi_click: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_ignores_multi_click (item)
		end

	send_action_on_ (a_mask: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_send_action_on_ (item, a_mask)
		end

	is_continuous: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_continuous (item)
		end

	set_continuous_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_continuous_ (item, a_flag)
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

	alignment: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alignment (item)
		end

	set_alignment_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alignment_ (item, a_mode)
		end

	font: detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_font_ (a_font_obj: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			objc_set_font_ (item, a_font_obj__item)
		end

	set_formatter_ (a_new_formatter: detachable NS_FORMATTER)
			-- Auto generated Objective-C wrapper.
		local
			a_new_formatter__item: POINTER
		do
			if attached a_new_formatter as a_new_formatter_attached then
				a_new_formatter__item := a_new_formatter_attached.item
			end
			objc_set_formatter_ (item, a_new_formatter__item)
		end

	formatter: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_formatter (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like formatter} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like formatter} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_object_value_ (a_obj: detachable NS_COPYING_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_object_value_ (item, a_obj__item)
		end

	set_string_value_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_string_value_ (item, a_string__item)
		end

	set_int_value_ (an_int: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_int_value_ (item, an_int)
		end

	set_float_value_ (a_float: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_float_value_ (item, a_float)
		end

	set_double_value_ (a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_double_value_ (item, a_double)
		end

	object_value: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_value: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	int_value: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_int_value (item)
		end

	float_value: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_float_value (item)
		end

	double_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_double_value (item)
		end

	set_needs_display
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_display (item)
		end

	update_cell_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_update_cell_ (item, a_cell__item)
		end

	update_cell_inside_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_update_cell_inside_ (item, a_cell__item)
		end

	draw_cell_inside_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_draw_cell_inside_ (item, a_cell__item)
		end

	draw_cell_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_draw_cell_ (item, a_cell__item)
		end

	select_cell_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_select_cell_ (item, a_cell__item)
		end

	send_action__to_ (a_the_action: detachable OBJC_SELECTOR; a_the_target: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_action__item: POINTER
			a_the_target__item: POINTER
		do
			if attached a_the_action as a_the_action_attached then
				a_the_action__item := a_the_action_attached.item
			end
			if attached a_the_target as a_the_target_attached then
				a_the_target__item := a_the_target_attached.item
			end
			Result := objc_send_action__to_ (item, a_the_action__item, a_the_target__item)
		end

	take_int_value_from_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_take_int_value_from_ (item, a_sender__item)
		end

	take_float_value_from_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_take_float_value_from_ (item, a_sender__item)
		end

	take_double_value_from_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_take_double_value_from_ (item, a_sender__item)
		end

	take_string_value_from_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_take_string_value_from_ (item, a_sender__item)
		end

	take_object_value_from_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_take_object_value_from_ (item, a_sender__item)
		end

	current_editor: detachable NS_TEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_editor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_editor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_editor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	abort_editing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_abort_editing (item)
		end

	validate_editing
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_validate_editing (item)
		end

	base_writing_direction: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_base_writing_direction (item)
		end

	set_base_writing_direction_ (a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_base_writing_direction_ (item, a_writing_direction)
		end

	integer_value: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_integer_value (item)
		end

	set_integer_value_ (an_integer: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_integer_value_ (item, an_integer)
		end

	take_integer_value_from_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_take_integer_value_from_ (item, a_sender__item)
		end

feature {NONE} -- NSControl Externals

	objc_size_to_fit (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item sizeToFit];
			 ]"
		end

	objc_calc_size (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item calcSize];
			 ]"
		end

	objc_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item cell];
			 ]"
		end

	objc_set_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setCell:$a_cell];
			 ]"
		end

	objc_selected_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item selectedCell];
			 ]"
		end

	objc_target (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item target];
			 ]"
		end

	objc_set_target_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setTarget:$an_object];
			 ]"
		end

	objc_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item action];
			 ]"
		end

	objc_set_action_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setAction:$a_selector];
			 ]"
		end

	objc_set_tag_ (an_item: POINTER; an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setTag:$an_int];
			 ]"
		end

	objc_selected_tag (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item selectedTag];
			 ]"
		end

	objc_set_ignores_multi_click_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setIgnoresMultiClick:$a_flag];
			 ]"
		end

	objc_ignores_multi_click (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item ignoresMultiClick];
			 ]"
		end

	objc_send_action_on_ (an_item: POINTER; a_mask: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item sendActionOn:$a_mask];
			 ]"
		end

	objc_is_continuous (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item isContinuous];
			 ]"
		end

	objc_set_continuous_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setContinuous:$a_flag];
			 ]"
		end

	objc_is_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item isEnabled];
			 ]"
		end

	objc_set_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setEnabled:$a_flag];
			 ]"
		end

	objc_alignment (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item alignment];
			 ]"
		end

	objc_set_alignment_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setAlignment:$a_mode];
			 ]"
		end

	objc_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item font];
			 ]"
		end

	objc_set_font_ (an_item: POINTER; a_font_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setFont:$a_font_obj];
			 ]"
		end

	objc_set_formatter_ (an_item: POINTER; a_new_formatter: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setFormatter:$a_new_formatter];
			 ]"
		end

	objc_formatter (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item formatter];
			 ]"
		end

	objc_set_object_value_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setObjectValue:$a_obj];
			 ]"
		end

	objc_set_string_value_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setStringValue:$a_string];
			 ]"
		end

	objc_set_int_value_ (an_item: POINTER; an_int: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setIntValue:$an_int];
			 ]"
		end

	objc_set_float_value_ (an_item: POINTER; a_float: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setFloatValue:$a_float];
			 ]"
		end

	objc_set_double_value_ (an_item: POINTER; a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setDoubleValue:$a_double];
			 ]"
		end

	objc_object_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item objectValue];
			 ]"
		end

	objc_string_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item stringValue];
			 ]"
		end

	objc_int_value (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item intValue];
			 ]"
		end

	objc_float_value (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item floatValue];
			 ]"
		end

	objc_double_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item doubleValue];
			 ]"
		end

	objc_set_needs_display (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setNeedsDisplay];
			 ]"
		end

	objc_update_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item updateCell:$a_cell];
			 ]"
		end

	objc_update_cell_inside_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item updateCellInside:$a_cell];
			 ]"
		end

	objc_draw_cell_inside_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item drawCellInside:$a_cell];
			 ]"
		end

	objc_draw_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item drawCell:$a_cell];
			 ]"
		end

	objc_select_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item selectCell:$a_cell];
			 ]"
		end

	objc_send_action__to_ (an_item: POINTER; a_the_action: POINTER; a_the_target: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item sendAction:$a_the_action to:$a_the_target];
			 ]"
		end

	objc_take_int_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item takeIntValueFrom:$a_sender];
			 ]"
		end

	objc_take_float_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item takeFloatValueFrom:$a_sender];
			 ]"
		end

	objc_take_double_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item takeDoubleValueFrom:$a_sender];
			 ]"
		end

	objc_take_string_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item takeStringValueFrom:$a_sender];
			 ]"
		end

	objc_take_object_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item takeObjectValueFrom:$a_sender];
			 ]"
		end

	objc_current_editor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item currentEditor];
			 ]"
		end

	objc_abort_editing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item abortEditing];
			 ]"
		end

	objc_validate_editing (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item validateEditing];
			 ]"
		end

	objc_base_writing_direction (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item baseWritingDirection];
			 ]"
		end

	objc_set_base_writing_direction_ (an_item: POINTER; a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setBaseWritingDirection:$a_writing_direction];
			 ]"
		end

	objc_integer_value (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item integerValue];
			 ]"
		end

	objc_set_integer_value_ (an_item: POINTER; an_integer: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setIntegerValue:$an_integer];
			 ]"
		end

	objc_take_integer_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item takeIntegerValueFrom:$a_sender];
			 ]"
		end

feature -- NSKeyboardUI

	perform_click_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_perform_click_ (item, a_sender__item)
		end

	set_refuses_first_responder_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_refuses_first_responder_ (item, a_flag)
		end

	refuses_first_responder: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_refuses_first_responder (item)
		end

feature {NONE} -- NSKeyboardUI Externals

	objc_perform_click_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item performClick:$a_sender];
			 ]"
		end

	objc_set_refuses_first_responder_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setRefusesFirstResponder:$a_flag];
			 ]"
		end

	objc_refuses_first_responder (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSControl *)$an_item refusesFirstResponder];
			 ]"
		end

feature -- NSControlAttributedStringMethods

	attributed_string_value: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_string_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_string_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_string_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attributed_string_value_ (a_obj: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_set_attributed_string_value_ (item, a_obj__item)
		end

feature {NONE} -- NSControlAttributedStringMethods Externals

	objc_attributed_string_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSControl *)$an_item attributedStringValue];
			 ]"
		end

	objc_set_attributed_string_value_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSControl *)$an_item setAttributedStringValue:$a_obj];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSControl"
		end

end
