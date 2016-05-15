note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SLIDER

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

feature -- NSSlider

	min_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_min_value (item)
		end

	set_min_value_ (a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_value_ (item, a_double)
		end

	max_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_value (item)
		end

	set_max_value_ (a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_value_ (item, a_double)
		end

	set_alt_increment_value_ (a_inc_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alt_increment_value_ (item, a_inc_value)
		end

	alt_increment_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alt_increment_value (item)
		end

	set_title_cell_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_title_cell_ (item, a_cell__item)
		end

	title_cell: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_title_color_ (a_new_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_new_color__item: POINTER
		do
			if attached a_new_color as a_new_color_attached then
				a_new_color__item := a_new_color_attached.item
			end
			objc_set_title_color_ (item, a_new_color__item)
		end

	title_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_title_font_ (a_font_obj: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			objc_set_title_font_ (item, a_font_obj__item)
		end

	title_font: detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title_font (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title_font} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title_font} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_title_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_title_ (item, a_string__item)
		end

	set_knob_thickness_ (a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_knob_thickness_ (item, a_float)
		end

	knob_thickness: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_knob_thickness (item)
		end

	set_image_ (a_background_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_background_image__item: POINTER
		do
			if attached a_background_image as a_background_image_attached then
				a_background_image__item := a_background_image_attached.item
			end
			objc_set_image_ (item, a_background_image__item)
		end

	image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_vertical: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_vertical (item)
		end

feature {NONE} -- NSSlider Externals

	objc_min_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item minValue];
			 ]"
		end

	objc_set_min_value_ (an_item: POINTER; a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setMinValue:$a_double];
			 ]"
		end

	objc_max_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item maxValue];
			 ]"
		end

	objc_set_max_value_ (an_item: POINTER; a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setMaxValue:$a_double];
			 ]"
		end

	objc_set_alt_increment_value_ (an_item: POINTER; a_inc_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setAltIncrementValue:$a_inc_value];
			 ]"
		end

	objc_alt_increment_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item altIncrementValue];
			 ]"
		end

	objc_set_title_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setTitleCell:$a_cell];
			 ]"
		end

	objc_title_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSlider *)$an_item titleCell];
			 ]"
		end

	objc_set_title_color_ (an_item: POINTER; a_new_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setTitleColor:$a_new_color];
			 ]"
		end

	objc_title_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSlider *)$an_item titleColor];
			 ]"
		end

	objc_set_title_font_ (an_item: POINTER; a_font_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setTitleFont:$a_font_obj];
			 ]"
		end

	objc_title_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSlider *)$an_item titleFont];
			 ]"
		end

	objc_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSlider *)$an_item title];
			 ]"
		end

	objc_set_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setTitle:$a_string];
			 ]"
		end

	objc_set_knob_thickness_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setKnobThickness:$a_float];
			 ]"
		end

	objc_knob_thickness (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item knobThickness];
			 ]"
		end

	objc_set_image_ (an_item: POINTER; a_background_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setImage:$a_background_image];
			 ]"
		end

	objc_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSlider *)$an_item image];
			 ]"
		end

	objc_is_vertical (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item isVertical];
			 ]"
		end

feature -- NSTickMarkSupport

	set_number_of_tick_marks_ (a_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_number_of_tick_marks_ (item, a_count)
		end

	number_of_tick_marks: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_tick_marks (item)
		end

	set_tick_mark_position_ (a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tick_mark_position_ (item, a_position)
		end

	tick_mark_position: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tick_mark_position (item)
		end

	set_allows_tick_mark_values_only_ (a_yorn: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_tick_mark_values_only_ (item, a_yorn)
		end

	allows_tick_mark_values_only: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_tick_mark_values_only (item)
		end

	tick_mark_value_at_index_ (a_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tick_mark_value_at_index_ (item, a_index)
		end

	rect_of_tick_mark_at_index_ (a_index: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rect_of_tick_mark_at_index_ (item, Result.item, a_index)
		end

	index_of_tick_mark_at_point_ (a_point: NS_POINT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_of_tick_mark_at_point_ (item, a_point.item)
		end

	closest_tick_mark_value_to_value_ (a_value: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_closest_tick_mark_value_to_value_ (item, a_value)
		end

feature {NONE} -- NSTickMarkSupport Externals

	objc_set_number_of_tick_marks_ (an_item: POINTER; a_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setNumberOfTickMarks:$a_count];
			 ]"
		end

	objc_number_of_tick_marks (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item numberOfTickMarks];
			 ]"
		end

	objc_set_tick_mark_position_ (an_item: POINTER; a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setTickMarkPosition:$a_position];
			 ]"
		end

	objc_tick_mark_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item tickMarkPosition];
			 ]"
		end

	objc_set_allows_tick_mark_values_only_ (an_item: POINTER; a_yorn: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSlider *)$an_item setAllowsTickMarkValuesOnly:$a_yorn];
			 ]"
		end

	objc_allows_tick_mark_values_only (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item allowsTickMarkValuesOnly];
			 ]"
		end

	objc_tick_mark_value_at_index_ (an_item: POINTER; a_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item tickMarkValueAtIndex:$a_index];
			 ]"
		end

	objc_rect_of_tick_mark_at_index_ (an_item: POINTER; result_pointer: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSSlider *)$an_item rectOfTickMarkAtIndex:$a_index];
			 ]"
		end

	objc_index_of_tick_mark_at_point_ (an_item: POINTER; a_point: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item indexOfTickMarkAtPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_closest_tick_mark_value_to_value_ (an_item: POINTER; a_value: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSlider *)$an_item closestTickMarkValueToValue:$a_value];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSlider"
		end

end
