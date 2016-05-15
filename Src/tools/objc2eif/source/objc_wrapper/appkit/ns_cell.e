note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CELL

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature {NONE} -- Initialization

	make_text_cell_ (a_string: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			make_with_pointer (objc_init_text_cell_(allocate_object, a_string__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_image_cell_ (a_image: detachable NS_IMAGE)
			-- Initialize `Current'.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			make_with_pointer (objc_init_image_cell_(allocate_object, a_image__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSCell Externals

	objc_init_text_cell_ (an_item: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item initTextCell:$a_string];
			 ]"
		end

	objc_init_image_cell_ (an_item: POINTER; a_image: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item initImageCell:$a_image];
			 ]"
		end

	objc_control_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item controlView];
			 ]"
		end

	objc_set_control_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setControlView:$a_view];
			 ]"
		end

	objc_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item type];
			 ]"
		end

	objc_set_type_ (an_item: POINTER; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setType:$a_type];
			 ]"
		end

	objc_state (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item state];
			 ]"
		end

	objc_set_state_ (an_item: POINTER; a_value: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setState:$a_value];
			 ]"
		end

	objc_target (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item target];
			 ]"
		end

	objc_set_target_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setTarget:$an_object];
			 ]"
		end

	objc_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item action];
			 ]"
		end

	objc_set_action_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setAction:$a_selector];
			 ]"
		end

	objc_tag (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item tag];
			 ]"
		end

	objc_set_tag_ (an_item: POINTER; an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setTag:$an_int];
			 ]"
		end

	objc_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item title];
			 ]"
		end

	objc_set_title_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setTitle:$a_string];
			 ]"
		end

	objc_is_opaque (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isOpaque];
			 ]"
		end

	objc_is_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isEnabled];
			 ]"
		end

	objc_set_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setEnabled:$a_flag];
			 ]"
		end

	objc_send_action_on_ (an_item: POINTER; a_mask: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item sendActionOn:$a_mask];
			 ]"
		end

	objc_is_continuous (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isContinuous];
			 ]"
		end

	objc_set_continuous_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setContinuous:$a_flag];
			 ]"
		end

	objc_is_editable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isEditable];
			 ]"
		end

	objc_set_editable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setEditable:$a_flag];
			 ]"
		end

	objc_is_selectable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isSelectable];
			 ]"
		end

	objc_set_selectable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setSelectable:$a_flag];
			 ]"
		end

	objc_is_bordered (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isBordered];
			 ]"
		end

	objc_set_bordered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setBordered:$a_flag];
			 ]"
		end

	objc_is_bezeled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isBezeled];
			 ]"
		end

	objc_set_bezeled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setBezeled:$a_flag];
			 ]"
		end

	objc_is_scrollable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isScrollable];
			 ]"
		end

	objc_set_scrollable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setScrollable:$a_flag];
			 ]"
		end

	objc_is_highlighted (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isHighlighted];
			 ]"
		end

	objc_set_highlighted_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setHighlighted:$a_flag];
			 ]"
		end

	objc_alignment (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item alignment];
			 ]"
		end

	objc_set_alignment_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setAlignment:$a_mode];
			 ]"
		end

	objc_wraps (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item wraps];
			 ]"
		end

	objc_set_wraps_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setWraps:$a_flag];
			 ]"
		end

	objc_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item font];
			 ]"
		end

	objc_set_font_ (an_item: POINTER; a_font_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setFont:$a_font_obj];
			 ]"
		end

	objc_is_entry_acceptable_ (an_item: POINTER; a_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item isEntryAcceptable:$a_string];
			 ]"
		end

	objc_key_equivalent (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item keyEquivalent];
			 ]"
		end

	objc_set_formatter_ (an_item: POINTER; a_new_formatter: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setFormatter:$a_new_formatter];
			 ]"
		end

	objc_formatter (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item formatter];
			 ]"
		end

	objc_object_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item objectValue];
			 ]"
		end

	objc_set_object_value_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setObjectValue:$a_obj];
			 ]"
		end

	objc_has_valid_object_value (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item hasValidObjectValue];
			 ]"
		end

	objc_string_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item stringValue];
			 ]"
		end

	objc_set_string_value_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setStringValue:$a_string];
			 ]"
		end

	objc_compare_ (an_item: POINTER; a_other_cell: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item compare:$a_other_cell];
			 ]"
		end

	objc_int_value (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item intValue];
			 ]"
		end

	objc_set_int_value_ (an_item: POINTER; an_int: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setIntValue:$an_int];
			 ]"
		end

	objc_float_value (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item floatValue];
			 ]"
		end

	objc_set_float_value_ (an_item: POINTER; a_float: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setFloatValue:$a_float];
			 ]"
		end

	objc_double_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item doubleValue];
			 ]"
		end

	objc_set_double_value_ (an_item: POINTER; a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setDoubleValue:$a_double];
			 ]"
		end

	objc_take_int_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item takeIntValueFrom:$a_sender];
			 ]"
		end

	objc_take_float_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item takeFloatValueFrom:$a_sender];
			 ]"
		end

	objc_take_double_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item takeDoubleValueFrom:$a_sender];
			 ]"
		end

	objc_take_string_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item takeStringValueFrom:$a_sender];
			 ]"
		end

	objc_take_object_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item takeObjectValueFrom:$a_sender];
			 ]"
		end

	objc_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item image];
			 ]"
		end

	objc_set_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setImage:$a_image];
			 ]"
		end

	objc_set_control_tint_ (an_item: POINTER; a_control_tint: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setControlTint:$a_control_tint];
			 ]"
		end

	objc_control_tint (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item controlTint];
			 ]"
		end

	objc_set_control_size_ (an_item: POINTER; a_size: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setControlSize:$a_size];
			 ]"
		end

	objc_control_size (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item controlSize];
			 ]"
		end

	objc_represented_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item representedObject];
			 ]"
		end

	objc_set_represented_object_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setRepresentedObject:$an_object];
			 ]"
		end

	objc_cell_attribute_ (an_item: POINTER; a_parameter: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item cellAttribute:$a_parameter];
			 ]"
		end

	objc_set_cell_attribute__to_ (an_item: POINTER; a_parameter: NATURAL_64; a_value: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setCellAttribute:$a_parameter to:$a_value];
			 ]"
		end

	objc_image_rect_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_the_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSCell *)$an_item imageRectForBounds:*((NSRect *)$a_the_rect)];
			 ]"
		end

	objc_title_rect_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_the_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSCell *)$an_item titleRectForBounds:*((NSRect *)$a_the_rect)];
			 ]"
		end

	objc_drawing_rect_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_the_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSCell *)$an_item drawingRectForBounds:*((NSRect *)$a_the_rect)];
			 ]"
		end

	objc_cell_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSCell *)$an_item cellSize];
			 ]"
		end

	objc_cell_size_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSCell *)$an_item cellSizeForBounds:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_highlight_color_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item highlightColorWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_calc_draw_info_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item calcDrawInfo:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_set_up_field_editor_attributes_ (an_item: POINTER; a_text_obj: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item setUpFieldEditorAttributes:$a_text_obj];
			 ]"
		end

	objc_draw_interior_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item drawInteriorWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_draw_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item drawWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_highlight__with_frame__in_view_ (an_item: POINTER; a_flag: BOOLEAN; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item highlight:$a_flag withFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_mouse_down_flags (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item mouseDownFlags];
			 ]"
		end

--	objc_get_periodic_delay__interval_ (an_item: POINTER; a_delay: UNSUPPORTED_TYPE; a_interval: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSCell *)$an_item getPeriodicDelay: interval:];
--			 ]"
--		end

	objc_start_tracking_at__in_view_ (an_item: POINTER; a_start_point: POINTER; a_control_view: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item startTrackingAt:*((NSPoint *)$a_start_point) inView:$a_control_view];
			 ]"
		end

	objc_continue_tracking__at__in_view_ (an_item: POINTER; a_last_point: POINTER; a_current_point: POINTER; a_control_view: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item continueTracking:*((NSPoint *)$a_last_point) at:*((NSPoint *)$a_current_point) inView:$a_control_view];
			 ]"
		end

	objc_stop_tracking__at__in_view__mouse_is_up_ (an_item: POINTER; a_last_point: POINTER; a_stop_point: POINTER; a_control_view: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item stopTracking:*((NSPoint *)$a_last_point) at:*((NSPoint *)$a_stop_point) inView:$a_control_view mouseIsUp:$a_flag];
			 ]"
		end

	objc_track_mouse__in_rect__of_view__until_mouse_up_ (an_item: POINTER; a_the_event: POINTER; a_cell_frame: POINTER; a_control_view: POINTER; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item trackMouse:$a_the_event inRect:*((NSRect *)$a_cell_frame) ofView:$a_control_view untilMouseUp:$a_flag];
			 ]"
		end

	objc_edit_with_frame__in_view__editor__delegate__event_ (an_item: POINTER; a_rect: POINTER; a_control_view: POINTER; a_text_obj: POINTER; an_object: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item editWithFrame:*((NSRect *)$a_rect) inView:$a_control_view editor:$a_text_obj delegate:$an_object event:$a_the_event];
			 ]"
		end

	objc_select_with_frame__in_view__editor__delegate__start__length_ (an_item: POINTER; a_rect: POINTER; a_control_view: POINTER; a_text_obj: POINTER; an_object: POINTER; a_sel_start: INTEGER_64; a_sel_length: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item selectWithFrame:*((NSRect *)$a_rect) inView:$a_control_view editor:$a_text_obj delegate:$an_object start:$a_sel_start length:$a_sel_length];
			 ]"
		end

	objc_end_editing_ (an_item: POINTER; a_text_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item endEditing:$a_text_obj];
			 ]"
		end

	objc_reset_cursor_rect__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item resetCursorRect:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_set_menu_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setMenu:$a_menu];
			 ]"
		end

	objc_menu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item menu];
			 ]"
		end

	objc_menu_for_event__in_rect__of_view_ (an_item: POINTER; a_event: POINTER; a_cell_frame: POINTER; a_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item menuForEvent:$a_event inRect:*((NSRect *)$a_cell_frame) ofView:$a_view];
			 ]"
		end

	objc_set_sends_action_on_end_editing_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setSendsActionOnEndEditing:$a_flag];
			 ]"
		end

	objc_sends_action_on_end_editing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item sendsActionOnEndEditing];
			 ]"
		end

	objc_base_writing_direction (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item baseWritingDirection];
			 ]"
		end

	objc_set_base_writing_direction_ (an_item: POINTER; a_writing_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setBaseWritingDirection:$a_writing_direction];
			 ]"
		end

	objc_set_line_break_mode_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setLineBreakMode:$a_mode];
			 ]"
		end

	objc_line_break_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item lineBreakMode];
			 ]"
		end

	objc_set_allows_undo_ (an_item: POINTER; a_allows_undo: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setAllowsUndo:$a_allows_undo];
			 ]"
		end

	objc_allows_undo (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item allowsUndo];
			 ]"
		end

	objc_integer_value (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item integerValue];
			 ]"
		end

	objc_set_integer_value_ (an_item: POINTER; an_integer: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setIntegerValue:$an_integer];
			 ]"
		end

	objc_take_integer_value_from_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item takeIntegerValueFrom:$a_sender];
			 ]"
		end

	objc_truncates_last_visible_line (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item truncatesLastVisibleLine];
			 ]"
		end

	objc_set_truncates_last_visible_line_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setTruncatesLastVisibleLine:$a_flag];
			 ]"
		end

	objc_user_interface_layout_direction (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item userInterfaceLayoutDirection];
			 ]"
		end

	objc_set_user_interface_layout_direction_ (an_item: POINTER; a_layout_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setUserInterfaceLayoutDirection:$a_layout_direction];
			 ]"
		end

	objc_field_editor_for_view_ (an_item: POINTER; a_control_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item fieldEditorForView:$a_control_view];
			 ]"
		end

	objc_uses_single_line_mode (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item usesSingleLineMode];
			 ]"
		end

	objc_set_uses_single_line_mode_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setUsesSingleLineMode:$a_flag];
			 ]"
		end

feature -- NSCell

	control_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_control_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_control_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_control_view_ (item, a_view__item)
		end

	type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_type (item)
		end

	set_type_ (a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_type_ (item, a_type)
		end

	state: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_state (item)
		end

	set_state_ (a_value: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_state_ (item, a_value)
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

	tag: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tag (item)
		end

	set_tag_ (an_int: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tag_ (item, an_int)
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

	is_opaque: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_opaque (item)
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

	is_editable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_editable (item)
		end

	set_editable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_editable_ (item, a_flag)
		end

	is_selectable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_selectable (item)
		end

	set_selectable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selectable_ (item, a_flag)
		end

	is_bordered: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bordered (item)
		end

	set_bordered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bordered_ (item, a_flag)
		end

	is_bezeled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bezeled (item)
		end

	set_bezeled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bezeled_ (item, a_flag)
		end

	is_scrollable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_scrollable (item)
		end

	set_scrollable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_scrollable_ (item, a_flag)
		end

	is_highlighted: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_highlighted (item)
		end

	set_highlighted_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_highlighted_ (item, a_flag)
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

	wraps: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_wraps (item)
		end

	set_wraps_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_wraps_ (item, a_flag)
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

	is_entry_acceptable_ (a_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_is_entry_acceptable_ (item, a_string__item)
		end

	key_equivalent: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_equivalent (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_equivalent} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_equivalent} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
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

	has_valid_object_value: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_valid_object_value (item)
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

	compare_ (a_other_cell: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_other_cell__item: POINTER
		do
			if attached a_other_cell as a_other_cell_attached then
				a_other_cell__item := a_other_cell_attached.item
			end
			Result := objc_compare_ (item, a_other_cell__item)
		end

	int_value: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_int_value (item)
		end

	set_int_value_ (an_int: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_int_value_ (item, an_int)
		end

	float_value: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_float_value (item)
		end

	set_float_value_ (a_float: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_float_value_ (item, a_float)
		end

	double_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_double_value (item)
		end

	set_double_value_ (a_double: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_double_value_ (item, a_double)
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

	set_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_image_ (item, a_image__item)
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

	set_control_size_ (a_size: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_control_size_ (item, a_size)
		end

	control_size: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_control_size (item)
		end

	represented_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_represented_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like represented_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like represented_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_represented_object_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_represented_object_ (item, an_object__item)
		end

	cell_attribute_ (a_parameter: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_cell_attribute_ (item, a_parameter)
		end

	set_cell_attribute__to_ (a_parameter: NATURAL_64; a_value: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_cell_attribute__to_ (item, a_parameter, a_value)
		end

	image_rect_for_bounds_ (a_the_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_image_rect_for_bounds_ (item, Result.item, a_the_rect.item)
		end

	title_rect_for_bounds_ (a_the_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_title_rect_for_bounds_ (item, Result.item, a_the_rect.item)
		end

	drawing_rect_for_bounds_ (a_the_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_drawing_rect_for_bounds_ (item, Result.item, a_the_rect.item)
		end

	cell_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_cell_size (item, Result.item)
		end

	cell_size_for_bounds_ (a_rect: NS_RECT): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_cell_size_for_bounds_ (item, Result.item, a_rect.item)
		end

	highlight_color_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			result_pointer := objc_highlight_color_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like highlight_color_with_frame__in_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like highlight_color_with_frame__in_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	calc_draw_info_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_calc_draw_info_ (item, a_rect.item)
		end

	set_up_field_editor_attributes_ (a_text_obj: detachable NS_TEXT): detachable NS_TEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_text_obj__item: POINTER
		do
			if attached a_text_obj as a_text_obj_attached then
				a_text_obj__item := a_text_obj_attached.item
			end
			result_pointer := objc_set_up_field_editor_attributes_ (item, a_text_obj__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like set_up_field_editor_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like set_up_field_editor_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	draw_interior_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_interior_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	draw_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	highlight__with_frame__in_view_ (a_flag: BOOLEAN; a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_highlight__with_frame__in_view_ (item, a_flag, a_cell_frame.item, a_control_view__item)
		end

	mouse_down_flags: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_mouse_down_flags (item)
		end

--	get_periodic_delay__interval_ (a_delay: UNSUPPORTED_TYPE; a_interval: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_delay__item: POINTER
--			a_interval__item: POINTER
--		do
--			if attached a_delay as a_delay_attached then
--				a_delay__item := a_delay_attached.item
--			end
--			if attached a_interval as a_interval_attached then
--				a_interval__item := a_interval_attached.item
--			end
--			objc_get_periodic_delay__interval_ (item, a_delay__item, a_interval__item)
--		end

	start_tracking_at__in_view_ (a_start_point: NS_POINT; a_control_view: detachable NS_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			Result := objc_start_tracking_at__in_view_ (item, a_start_point.item, a_control_view__item)
		end

	continue_tracking__at__in_view_ (a_last_point: NS_POINT; a_current_point: NS_POINT; a_control_view: detachable NS_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			Result := objc_continue_tracking__at__in_view_ (item, a_last_point.item, a_current_point.item, a_control_view__item)
		end

	stop_tracking__at__in_view__mouse_is_up_ (a_last_point: NS_POINT; a_stop_point: NS_POINT; a_control_view: detachable NS_VIEW; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_stop_tracking__at__in_view__mouse_is_up_ (item, a_last_point.item, a_stop_point.item, a_control_view__item, a_flag)
		end

	track_mouse__in_rect__of_view__until_mouse_up_ (a_the_event: detachable NS_EVENT; a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW; a_flag: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
			a_control_view__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			Result := objc_track_mouse__in_rect__of_view__until_mouse_up_ (item, a_the_event__item, a_cell_frame.item, a_control_view__item, a_flag)
		end

	edit_with_frame__in_view__editor__delegate__event_ (a_rect: NS_RECT; a_control_view: detachable NS_VIEW; a_text_obj: detachable NS_TEXT; an_object: detachable NS_OBJECT; a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
			a_text_obj__item: POINTER
			an_object__item: POINTER
			a_the_event__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			if attached a_text_obj as a_text_obj_attached then
				a_text_obj__item := a_text_obj_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_edit_with_frame__in_view__editor__delegate__event_ (item, a_rect.item, a_control_view__item, a_text_obj__item, an_object__item, a_the_event__item)
		end

	select_with_frame__in_view__editor__delegate__start__length_ (a_rect: NS_RECT; a_control_view: detachable NS_VIEW; a_text_obj: detachable NS_TEXT; an_object: detachable NS_OBJECT; a_sel_start: INTEGER_64; a_sel_length: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
			a_text_obj__item: POINTER
			an_object__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			if attached a_text_obj as a_text_obj_attached then
				a_text_obj__item := a_text_obj_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_select_with_frame__in_view__editor__delegate__start__length_ (item, a_rect.item, a_control_view__item, a_text_obj__item, an_object__item, a_sel_start, a_sel_length)
		end

	end_editing_ (a_text_obj: detachable NS_TEXT)
			-- Auto generated Objective-C wrapper.
		local
			a_text_obj__item: POINTER
		do
			if attached a_text_obj as a_text_obj_attached then
				a_text_obj__item := a_text_obj_attached.item
			end
			objc_end_editing_ (item, a_text_obj__item)
		end

	reset_cursor_rect__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_reset_cursor_rect__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	set_menu_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_set_menu_ (item, a_menu__item)
		end

	menu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_menu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	menu_for_event__in_rect__of_view_ (a_event: detachable NS_EVENT; a_cell_frame: NS_RECT; a_view: detachable NS_VIEW): detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_event__item: POINTER
			a_view__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			result_pointer := objc_menu_for_event__in_rect__of_view_ (item, a_event__item, a_cell_frame.item, a_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu_for_event__in_rect__of_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu_for_event__in_rect__of_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_sends_action_on_end_editing_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_sends_action_on_end_editing_ (item, a_flag)
		end

	sends_action_on_end_editing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_sends_action_on_end_editing (item)
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

	set_line_break_mode_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_break_mode_ (item, a_mode)
		end

	line_break_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_break_mode (item)
		end

	set_allows_undo_ (a_allows_undo: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_undo_ (item, a_allows_undo)
		end

	allows_undo: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_undo (item)
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

	truncates_last_visible_line: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_truncates_last_visible_line (item)
		end

	set_truncates_last_visible_line_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_truncates_last_visible_line_ (item, a_flag)
		end

	user_interface_layout_direction: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_user_interface_layout_direction (item)
		end

	set_user_interface_layout_direction_ (a_layout_direction: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_user_interface_layout_direction_ (item, a_layout_direction)
		end

	field_editor_for_view_ (a_control_view: detachable NS_VIEW): detachable NS_TEXT_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			result_pointer := objc_field_editor_for_view_ (item, a_control_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like field_editor_for_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like field_editor_for_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	uses_single_line_mode: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_single_line_mode (item)
		end

	set_uses_single_line_mode_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_single_line_mode_ (item, a_flag)
		end

feature -- NSKeyboardUI

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

	accepts_first_responder: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_accepts_first_responder (item)
		end

	set_shows_first_responder_ (a_show_fr: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_first_responder_ (item, a_show_fr)
		end

	shows_first_responder: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_first_responder (item)
		end

	set_mnemonic_location_ (a_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_mnemonic_location_ (item, a_location)
		end

	mnemonic_location: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_mnemonic_location (item)
		end

	mnemonic: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mnemonic (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mnemonic} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mnemonic} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_title_with_mnemonic_ (a_string_with_ampersand: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string_with_ampersand__item: POINTER
		do
			if attached a_string_with_ampersand as a_string_with_ampersand_attached then
				a_string_with_ampersand__item := a_string_with_ampersand_attached.item
			end
			objc_set_title_with_mnemonic_ (item, a_string_with_ampersand__item)
		end

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

	set_focus_ring_type_ (a_focus_ring_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_focus_ring_type_ (item, a_focus_ring_type)
		end

	focus_ring_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_focus_ring_type (item)
		end

	wants_notification_for_marked_text: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_wants_notification_for_marked_text (item)
		end

feature {NONE} -- NSKeyboardUI Externals

	objc_set_refuses_first_responder_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setRefusesFirstResponder:$a_flag];
			 ]"
		end

	objc_refuses_first_responder (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item refusesFirstResponder];
			 ]"
		end

	objc_accepts_first_responder (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item acceptsFirstResponder];
			 ]"
		end

	objc_set_shows_first_responder_ (an_item: POINTER; a_show_fr: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setShowsFirstResponder:$a_show_fr];
			 ]"
		end

	objc_shows_first_responder (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item showsFirstResponder];
			 ]"
		end

	objc_set_mnemonic_location_ (an_item: POINTER; a_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setMnemonicLocation:$a_location];
			 ]"
		end

	objc_mnemonic_location (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item mnemonicLocation];
			 ]"
		end

	objc_mnemonic (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item mnemonic];
			 ]"
		end

	objc_set_title_with_mnemonic_ (an_item: POINTER; a_string_with_ampersand: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setTitleWithMnemonic:$a_string_with_ampersand];
			 ]"
		end

	objc_perform_click_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item performClick:$a_sender];
			 ]"
		end

	objc_set_focus_ring_type_ (an_item: POINTER; a_focus_ring_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setFocusRingType:$a_focus_ring_type];
			 ]"
		end

	objc_focus_ring_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item focusRingType];
			 ]"
		end

	objc_wants_notification_for_marked_text (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item wantsNotificationForMarkedText];
			 ]"
		end

feature -- NSCellAttributedStringMethods

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

	allows_editing_text_attributes: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_editing_text_attributes (item)
		end

	set_allows_editing_text_attributes_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_editing_text_attributes_ (item, a_flag)
		end

	imports_graphics: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_imports_graphics (item)
		end

	set_imports_graphics_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_imports_graphics_ (item, a_flag)
		end

feature {NONE} -- NSCellAttributedStringMethods Externals

	objc_attributed_string_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCell *)$an_item attributedStringValue];
			 ]"
		end

	objc_set_attributed_string_value_ (an_item: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setAttributedStringValue:$a_obj];
			 ]"
		end

	objc_allows_editing_text_attributes (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item allowsEditingTextAttributes];
			 ]"
		end

	objc_set_allows_editing_text_attributes_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setAllowsEditingTextAttributes:$a_flag];
			 ]"
		end

	objc_imports_graphics (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item importsGraphics];
			 ]"
		end

	objc_set_imports_graphics_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setImportsGraphics:$a_flag];
			 ]"
		end

feature -- NSCellMixedState

	set_allows_mixed_state_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_mixed_state_ (item, a_flag)
		end

	allows_mixed_state: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_mixed_state (item)
		end

	next_state: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_next_state (item)
		end

	set_next_state
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_next_state (item)
		end

feature {NONE} -- NSCellMixedState Externals

	objc_set_allows_mixed_state_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setAllowsMixedState:$a_flag];
			 ]"
		end

	objc_allows_mixed_state (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item allowsMixedState];
			 ]"
		end

	objc_next_state (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item nextState];
			 ]"
		end

	objc_set_next_state (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setNextState];
			 ]"
		end

feature -- NSCellHitTest

	hit_test_for_event__in_rect__of_view_ (a_event: detachable NS_EVENT; a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
			a_control_view__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			Result := objc_hit_test_for_event__in_rect__of_view_ (item, a_event__item, a_cell_frame.item, a_control_view__item)
		end

feature {NONE} -- NSCellHitTest Externals

	objc_hit_test_for_event__in_rect__of_view_ (an_item: POINTER; a_event: POINTER; a_cell_frame: POINTER; a_control_view: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item hitTestForEvent:$a_event inRect:*((NSRect *)$a_cell_frame) ofView:$a_control_view];
			 ]"
		end

feature -- NSCellExpansion

	expansion_frame_with_frame__in_view_ (a_cell_frame: NS_RECT; a_view: detachable NS_VIEW): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create Result.make
			objc_expansion_frame_with_frame__in_view_ (item, Result.item, a_cell_frame.item, a_view__item)
		end

	draw_with_expansion_frame__in_view_ (a_cell_frame: NS_RECT; a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_draw_with_expansion_frame__in_view_ (item, a_cell_frame.item, a_view__item)
		end

feature {NONE} -- NSCellExpansion Externals

	objc_expansion_frame_with_frame__in_view_ (an_item: POINTER; result_pointer: POINTER; a_cell_frame: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSCell *)$an_item expansionFrameWithFrame:*((NSRect *)$a_cell_frame) inView:$a_view];
			 ]"
		end

	objc_draw_with_expansion_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item drawWithExpansionFrame:*((NSRect *)$a_cell_frame) inView:$a_view];
			 ]"
		end

feature -- NSCellBackgroundStyle

	background_style: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_background_style (item)
		end

	set_background_style_ (a_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_background_style_ (item, a_style)
		end

	interior_background_style: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_interior_background_style (item)
		end

feature {NONE} -- NSCellBackgroundStyle Externals

	objc_background_style (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item backgroundStyle];
			 ]"
		end

	objc_set_background_style_ (an_item: POINTER; a_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCell *)$an_item setBackgroundStyle:$a_style];
			 ]"
		end

	objc_interior_background_style (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCell *)$an_item interiorBackgroundStyle];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCell"
		end

end
