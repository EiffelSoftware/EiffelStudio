note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_BLOCK

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSTextBlock

	set_value__type__for_dimension_ (a_val: REAL_64; a_type: NATURAL_64; a_dimension: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_value__type__for_dimension_ (item, a_val, a_type, a_dimension)
		end

	value_for_dimension_ (a_dimension: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_value_for_dimension_ (item, a_dimension)
		end

	value_type_for_dimension_ (a_dimension: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_value_type_for_dimension_ (item, a_dimension)
		end

	set_content_width__type_ (a_val: REAL_64; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_content_width__type_ (item, a_val, a_type)
		end

	content_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_content_width (item)
		end

	content_width_value_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_content_width_value_type (item)
		end

	set_width__type__for_layer__edge_ (a_val: REAL_64; a_type: NATURAL_64; a_layer: INTEGER_64; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_width__type__for_layer__edge_ (item, a_val, a_type, a_layer, a_edge)
		end

	set_width__type__for_layer_ (a_val: REAL_64; a_type: NATURAL_64; a_layer: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_width__type__for_layer_ (item, a_val, a_type, a_layer)
		end

	width_for_layer__edge_ (a_layer: INTEGER_64; a_edge: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_width_for_layer__edge_ (item, a_layer, a_edge)
		end

	width_value_type_for_layer__edge_ (a_layer: INTEGER_64; a_edge: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_width_value_type_for_layer__edge_ (item, a_layer, a_edge)
		end

	set_vertical_alignment_ (a_alignment: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_vertical_alignment_ (item, a_alignment)
		end

	vertical_alignment: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_vertical_alignment (item)
		end

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_border_color__for_edge_ (a_color: detachable NS_COLOR; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_border_color__for_edge_ (item, a_color__item, a_edge)
		end

	set_border_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_border_color_ (item, a_color__item)
		end

	border_color_for_edge_ (a_edge: NATURAL_64): detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_border_color_for_edge_ (item, a_edge)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like border_color_for_edge_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like border_color_for_edge_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	rect_for_layout_at_point__in_rect__text_container__character_range_ (a_starting_point: NS_POINT; a_rect: NS_RECT; a_text_container: detachable NS_TEXT_CONTAINER; a_char_range: NS_RANGE): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_text_container__item: POINTER
		do
			if attached a_text_container as a_text_container_attached then
				a_text_container__item := a_text_container_attached.item
			end
			create Result.make
			objc_rect_for_layout_at_point__in_rect__text_container__character_range_ (item, Result.item, a_starting_point.item, a_rect.item, a_text_container__item, a_char_range.item)
		end

	bounds_rect_for_content_rect__in_rect__text_container__character_range_ (a_content_rect: NS_RECT; a_rect: NS_RECT; a_text_container: detachable NS_TEXT_CONTAINER; a_char_range: NS_RANGE): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_text_container__item: POINTER
		do
			if attached a_text_container as a_text_container_attached then
				a_text_container__item := a_text_container_attached.item
			end
			create Result.make
			objc_bounds_rect_for_content_rect__in_rect__text_container__character_range_ (item, Result.item, a_content_rect.item, a_rect.item, a_text_container__item, a_char_range.item)
		end

	draw_background_with_frame__in_view__character_range__layout_manager_ (a_frame_rect: NS_RECT; a_control_view: detachable NS_VIEW; a_char_range: NS_RANGE; a_layout_manager: detachable NS_LAYOUT_MANAGER)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
			a_layout_manager__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			if attached a_layout_manager as a_layout_manager_attached then
				a_layout_manager__item := a_layout_manager_attached.item
			end
			objc_draw_background_with_frame__in_view__character_range__layout_manager_ (item, a_frame_rect.item, a_control_view__item, a_char_range.item, a_layout_manager__item)
		end

feature {NONE} -- NSTextBlock Externals

	objc_set_value__type__for_dimension_ (an_item: POINTER; a_val: REAL_64; a_type: NATURAL_64; a_dimension: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextBlock *)$an_item setValue:$a_val type:$a_type forDimension:$a_dimension];
			 ]"
		end

	objc_value_for_dimension_ (an_item: POINTER; a_dimension: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextBlock *)$an_item valueForDimension:$a_dimension];
			 ]"
		end

	objc_value_type_for_dimension_ (an_item: POINTER; a_dimension: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextBlock *)$an_item valueTypeForDimension:$a_dimension];
			 ]"
		end

	objc_set_content_width__type_ (an_item: POINTER; a_val: REAL_64; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextBlock *)$an_item setContentWidth:$a_val type:$a_type];
			 ]"
		end

	objc_content_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextBlock *)$an_item contentWidth];
			 ]"
		end

	objc_content_width_value_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextBlock *)$an_item contentWidthValueType];
			 ]"
		end

	objc_set_width__type__for_layer__edge_ (an_item: POINTER; a_val: REAL_64; a_type: NATURAL_64; a_layer: INTEGER_64; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextBlock *)$an_item setWidth:$a_val type:$a_type forLayer:$a_layer edge:$a_edge];
			 ]"
		end

	objc_set_width__type__for_layer_ (an_item: POINTER; a_val: REAL_64; a_type: NATURAL_64; a_layer: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextBlock *)$an_item setWidth:$a_val type:$a_type forLayer:$a_layer];
			 ]"
		end

	objc_width_for_layer__edge_ (an_item: POINTER; a_layer: INTEGER_64; a_edge: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextBlock *)$an_item widthForLayer:$a_layer edge:$a_edge];
			 ]"
		end

	objc_width_value_type_for_layer__edge_ (an_item: POINTER; a_layer: INTEGER_64; a_edge: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextBlock *)$an_item widthValueTypeForLayer:$a_layer edge:$a_edge];
			 ]"
		end

	objc_set_vertical_alignment_ (an_item: POINTER; a_alignment: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextBlock *)$an_item setVerticalAlignment:$a_alignment];
			 ]"
		end

	objc_vertical_alignment (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextBlock *)$an_item verticalAlignment];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextBlock *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextBlock *)$an_item backgroundColor];
			 ]"
		end

	objc_set_border_color__for_edge_ (an_item: POINTER; a_color: POINTER; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextBlock *)$an_item setBorderColor:$a_color forEdge:$a_edge];
			 ]"
		end

	objc_set_border_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextBlock *)$an_item setBorderColor:$a_color];
			 ]"
		end

	objc_border_color_for_edge_ (an_item: POINTER; a_edge: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextBlock *)$an_item borderColorForEdge:$a_edge];
			 ]"
		end

	objc_rect_for_layout_at_point__in_rect__text_container__character_range_ (an_item: POINTER; result_pointer: POINTER; a_starting_point: POINTER; a_rect: POINTER; a_text_container: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTextBlock *)$an_item rectForLayoutAtPoint:*((NSPoint *)$a_starting_point) inRect:*((NSRect *)$a_rect) textContainer:$a_text_container characterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_bounds_rect_for_content_rect__in_rect__text_container__character_range_ (an_item: POINTER; result_pointer: POINTER; a_content_rect: POINTER; a_rect: POINTER; a_text_container: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTextBlock *)$an_item boundsRectForContentRect:*((NSRect *)$a_content_rect) inRect:*((NSRect *)$a_rect) textContainer:$a_text_container characterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_draw_background_with_frame__in_view__character_range__layout_manager_ (an_item: POINTER; a_frame_rect: POINTER; a_control_view: POINTER; a_char_range: POINTER; a_layout_manager: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextBlock *)$an_item drawBackgroundWithFrame:*((NSRect *)$a_frame_rect) inView:$a_control_view characterRange:*((NSRange *)$a_char_range) layoutManager:$a_layout_manager];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextBlock"
		end

end
