note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCROLLER

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

feature -- NSScroller

	draw_parts
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_parts (item)
		end

	rect_for_part_ (a_part_code: NATURAL_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rect_for_part_ (item, Result.item, a_part_code)
		end

	check_space_for_parts
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_check_space_for_parts (item)
		end

	usable_parts: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_usable_parts (item)
		end

	set_arrows_position_ (a_where: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_arrows_position_ (item, a_where)
		end

	arrows_position: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_arrows_position (item)
		end

	set_control_tint_ (a_control_tint: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_control_tint_ (item, a_control_tint)
		end

	control_tint: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_control_tint (item)
		end

	set_control_size_ (a_control_size: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_control_size_ (item, a_control_size)
		end

	control_size: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_control_size (item)
		end

	draw_arrow__highlight_ (a_which_arrow: NATURAL_64; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_arrow__highlight_ (item, a_which_arrow, a_flag)
		end

	draw_knob
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_knob (item)
		end

	draw_knob_slot_in_rect__highlight_ (a_slot_rect: NS_RECT; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_knob_slot_in_rect__highlight_ (item, a_slot_rect.item, a_flag)
		end

	highlight_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_highlight_ (item, a_flag)
		end

	test_part_ (a_the_point: NS_POINT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_test_part_ (item, a_the_point.item)
		end

	track_knob_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_track_knob_ (item, a_the_event__item)
		end

	track_scroll_buttons_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_track_scroll_buttons_ (item, a_the_event__item)
		end

	hit_part: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hit_part (item)
		end

	knob_proportion: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_knob_proportion (item)
		end

	set_knob_proportion_ (a_proportion: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_knob_proportion_ (item, a_proportion)
		end

feature {NONE} -- NSScroller Externals

	objc_draw_parts (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item drawParts];
			 ]"
		end

	objc_rect_for_part_ (an_item: POINTER; result_pointer: POINTER; a_part_code: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSScroller *)$an_item rectForPart:$a_part_code];
			 ]"
		end

	objc_check_space_for_parts (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item checkSpaceForParts];
			 ]"
		end

	objc_usable_parts (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSScroller *)$an_item usableParts];
			 ]"
		end

	objc_set_arrows_position_ (an_item: POINTER; a_where: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item setArrowsPosition:$a_where];
			 ]"
		end

	objc_arrows_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSScroller *)$an_item arrowsPosition];
			 ]"
		end

	objc_set_control_tint_ (an_item: POINTER; a_control_tint: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item setControlTint:$a_control_tint];
			 ]"
		end

	objc_control_tint (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSScroller *)$an_item controlTint];
			 ]"
		end

	objc_set_control_size_ (an_item: POINTER; a_control_size: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item setControlSize:$a_control_size];
			 ]"
		end

	objc_control_size (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSScroller *)$an_item controlSize];
			 ]"
		end

	objc_draw_arrow__highlight_ (an_item: POINTER; a_which_arrow: NATURAL_64; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item drawArrow:$a_which_arrow highlight:$a_flag];
			 ]"
		end

	objc_draw_knob (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item drawKnob];
			 ]"
		end

	objc_draw_knob_slot_in_rect__highlight_ (an_item: POINTER; a_slot_rect: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item drawKnobSlotInRect:*((NSRect *)$a_slot_rect) highlight:$a_flag];
			 ]"
		end

	objc_highlight_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item highlight:$a_flag];
			 ]"
		end

	objc_test_part_ (an_item: POINTER; a_the_point: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSScroller *)$an_item testPart:*((NSPoint *)$a_the_point)];
			 ]"
		end

	objc_track_knob_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item trackKnob:$a_the_event];
			 ]"
		end

	objc_track_scroll_buttons_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item trackScrollButtons:$a_the_event];
			 ]"
		end

	objc_hit_part (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSScroller *)$an_item hitPart];
			 ]"
		end

	objc_knob_proportion (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSScroller *)$an_item knobProportion];
			 ]"
		end

	objc_set_knob_proportion_ (an_item: POINTER; a_proportion: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSScroller *)$an_item setKnobProportion:$a_proportion];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScroller"
		end

end
