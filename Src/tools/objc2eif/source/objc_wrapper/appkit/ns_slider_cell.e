note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SLIDER_CELL

inherit
	NS_ACTION_CELL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature -- NSSliderCell

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

	is_vertical: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_vertical (item)
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

	knob_rect_flipped_ (a_flipped: BOOLEAN): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_knob_rect_flipped_ (item, Result.item, a_flipped)
		end

	draw_knob_ (a_knob_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_knob_ (item, a_knob_rect.item)
		end

	draw_knob
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_knob (item)
		end

	draw_bar_inside__flipped_ (a_rect: NS_RECT; a_flipped: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_bar_inside__flipped_ (item, a_rect.item, a_flipped)
		end

	track_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_track_rect (item, Result.item)
		end

	set_slider_type_ (a_slider_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_slider_type_ (item, a_slider_type)
		end

	slider_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_slider_type (item)
		end

feature {NONE} -- NSSliderCell Externals

	objc_min_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item minValue];
			 ]"
		end

	objc_set_min_value_ (an_item: POINTER; a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setMinValue:$a_double];
			 ]"
		end

	objc_max_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item maxValue];
			 ]"
		end

	objc_set_max_value_ (an_item: POINTER; a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setMaxValue:$a_double];
			 ]"
		end

	objc_set_alt_increment_value_ (an_item: POINTER; a_inc_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setAltIncrementValue:$a_inc_value];
			 ]"
		end

	objc_alt_increment_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item altIncrementValue];
			 ]"
		end

	objc_is_vertical (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item isVertical];
			 ]"
		end

	objc_set_title_color_ (an_item: POINTER; a_new_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setTitleColor:$a_new_color];
			 ]"
		end

	objc_title_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSliderCell *)$an_item titleColor];
			 ]"
		end

	objc_set_title_font_ (an_item: POINTER; a_font_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setTitleFont:$a_font_obj];
			 ]"
		end

	objc_title_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSliderCell *)$an_item titleFont];
			 ]"
		end

	objc_set_title_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setTitleCell:$a_cell];
			 ]"
		end

	objc_title_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSliderCell *)$an_item titleCell];
			 ]"
		end

	objc_set_knob_thickness_ (an_item: POINTER; a_float: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setKnobThickness:$a_float];
			 ]"
		end

	objc_knob_thickness (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item knobThickness];
			 ]"
		end

	objc_knob_rect_flipped_ (an_item: POINTER; result_pointer: POINTER; a_flipped: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSSliderCell *)$an_item knobRectFlipped:$a_flipped];
			 ]"
		end

	objc_draw_knob_ (an_item: POINTER; a_knob_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item drawKnob:*((NSRect *)$a_knob_rect)];
			 ]"
		end

	objc_draw_knob (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item drawKnob];
			 ]"
		end

	objc_draw_bar_inside__flipped_ (an_item: POINTER; a_rect: POINTER; a_flipped: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item drawBarInside:*((NSRect *)$a_rect) flipped:$a_flipped];
			 ]"
		end

	objc_track_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSSliderCell *)$an_item trackRect];
			 ]"
		end

	objc_set_slider_type_ (an_item: POINTER; a_slider_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setSliderType:$a_slider_type];
			 ]"
		end

	objc_slider_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item sliderType];
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
				[(NSSliderCell *)$an_item setNumberOfTickMarks:$a_count];
			 ]"
		end

	objc_number_of_tick_marks (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item numberOfTickMarks];
			 ]"
		end

	objc_set_tick_mark_position_ (an_item: POINTER; a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setTickMarkPosition:$a_position];
			 ]"
		end

	objc_tick_mark_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item tickMarkPosition];
			 ]"
		end

	objc_set_allows_tick_mark_values_only_ (an_item: POINTER; a_yorn: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSliderCell *)$an_item setAllowsTickMarkValuesOnly:$a_yorn];
			 ]"
		end

	objc_allows_tick_mark_values_only (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item allowsTickMarkValuesOnly];
			 ]"
		end

	objc_tick_mark_value_at_index_ (an_item: POINTER; a_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item tickMarkValueAtIndex:$a_index];
			 ]"
		end

	objc_rect_of_tick_mark_at_index_ (an_item: POINTER; result_pointer: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSSliderCell *)$an_item rectOfTickMarkAtIndex:$a_index];
			 ]"
		end

	objc_index_of_tick_mark_at_point_ (an_item: POINTER; a_point: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item indexOfTickMarkAtPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_closest_tick_mark_value_to_value_ (an_item: POINTER; a_value: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSliderCell *)$an_item closestTickMarkValueToValue:$a_value];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSliderCell"
		end

end
