note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_TABLE

inherit
	NS_TEXT_BLOCK
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSTextTable

	number_of_columns: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_columns (item)
		end

	set_number_of_columns_ (a_num_cols: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_number_of_columns_ (item, a_num_cols)
		end

	layout_algorithm: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_layout_algorithm (item)
		end

	set_layout_algorithm_ (a_algorithm: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_layout_algorithm_ (item, a_algorithm)
		end

	collapses_borders: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_collapses_borders (item)
		end

	set_collapses_borders_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_collapses_borders_ (item, a_flag)
		end

	hides_empty_cells: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hides_empty_cells (item)
		end

	set_hides_empty_cells_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hides_empty_cells_ (item, a_flag)
		end

	rect_for_block__layout_at_point__in_rect__text_container__character_range_ (a_block: detachable NS_TEXT_TABLE_BLOCK; a_starting_point: NS_POINT; a_rect: NS_RECT; a_text_container: detachable NS_TEXT_CONTAINER; a_char_range: NS_RANGE): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_block__item: POINTER
			a_text_container__item: POINTER
		do
			if attached a_block as a_block_attached then
				a_block__item := a_block_attached.item
			end
			if attached a_text_container as a_text_container_attached then
				a_text_container__item := a_text_container_attached.item
			end
			create Result.make
			objc_rect_for_block__layout_at_point__in_rect__text_container__character_range_ (item, Result.item, a_block__item, a_starting_point.item, a_rect.item, a_text_container__item, a_char_range.item)
		end

	bounds_rect_for_block__content_rect__in_rect__text_container__character_range_ (a_block: detachable NS_TEXT_TABLE_BLOCK; a_content_rect: NS_RECT; a_rect: NS_RECT; a_text_container: detachable NS_TEXT_CONTAINER; a_char_range: NS_RANGE): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_block__item: POINTER
			a_text_container__item: POINTER
		do
			if attached a_block as a_block_attached then
				a_block__item := a_block_attached.item
			end
			if attached a_text_container as a_text_container_attached then
				a_text_container__item := a_text_container_attached.item
			end
			create Result.make
			objc_bounds_rect_for_block__content_rect__in_rect__text_container__character_range_ (item, Result.item, a_block__item, a_content_rect.item, a_rect.item, a_text_container__item, a_char_range.item)
		end

	draw_background_for_block__with_frame__in_view__character_range__layout_manager_ (a_block: detachable NS_TEXT_TABLE_BLOCK; a_frame_rect: NS_RECT; a_control_view: detachable NS_VIEW; a_char_range: NS_RANGE; a_layout_manager: detachable NS_LAYOUT_MANAGER)
			-- Auto generated Objective-C wrapper.
		local
			a_block__item: POINTER
			a_control_view__item: POINTER
			a_layout_manager__item: POINTER
		do
			if attached a_block as a_block_attached then
				a_block__item := a_block_attached.item
			end
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			if attached a_layout_manager as a_layout_manager_attached then
				a_layout_manager__item := a_layout_manager_attached.item
			end
			objc_draw_background_for_block__with_frame__in_view__character_range__layout_manager_ (item, a_block__item, a_frame_rect.item, a_control_view__item, a_char_range.item, a_layout_manager__item)
		end

feature {NONE} -- NSTextTable Externals

	objc_number_of_columns (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTable *)$an_item numberOfColumns];
			 ]"
		end

	objc_set_number_of_columns_ (an_item: POINTER; a_num_cols: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextTable *)$an_item setNumberOfColumns:$a_num_cols];
			 ]"
		end

	objc_layout_algorithm (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTable *)$an_item layoutAlgorithm];
			 ]"
		end

	objc_set_layout_algorithm_ (an_item: POINTER; a_algorithm: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextTable *)$an_item setLayoutAlgorithm:$a_algorithm];
			 ]"
		end

	objc_collapses_borders (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTable *)$an_item collapsesBorders];
			 ]"
		end

	objc_set_collapses_borders_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextTable *)$an_item setCollapsesBorders:$a_flag];
			 ]"
		end

	objc_hides_empty_cells (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTable *)$an_item hidesEmptyCells];
			 ]"
		end

	objc_set_hides_empty_cells_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextTable *)$an_item setHidesEmptyCells:$a_flag];
			 ]"
		end

	objc_rect_for_block__layout_at_point__in_rect__text_container__character_range_ (an_item: POINTER; result_pointer: POINTER; a_block: POINTER; a_starting_point: POINTER; a_rect: POINTER; a_text_container: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTextTable *)$an_item rectForBlock:$a_block layoutAtPoint:*((NSPoint *)$a_starting_point) inRect:*((NSRect *)$a_rect) textContainer:$a_text_container characterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_bounds_rect_for_block__content_rect__in_rect__text_container__character_range_ (an_item: POINTER; result_pointer: POINTER; a_block: POINTER; a_content_rect: POINTER; a_rect: POINTER; a_text_container: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTextTable *)$an_item boundsRectForBlock:$a_block contentRect:*((NSRect *)$a_content_rect) inRect:*((NSRect *)$a_rect) textContainer:$a_text_container characterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_draw_background_for_block__with_frame__in_view__character_range__layout_manager_ (an_item: POINTER; a_block: POINTER; a_frame_rect: POINTER; a_control_view: POINTER; a_char_range: POINTER; a_layout_manager: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextTable *)$an_item drawBackgroundForBlock:$a_block withFrame:*((NSRect *)$a_frame_rect) inView:$a_control_view characterRange:*((NSRange *)$a_char_range) layoutManager:$a_layout_manager];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextTable"
		end

end
