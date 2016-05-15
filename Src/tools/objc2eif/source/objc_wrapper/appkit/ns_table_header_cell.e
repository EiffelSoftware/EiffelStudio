note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_HEADER_CELL

inherit
	NS_TEXT_FIELD_CELL
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

feature -- NSTableHeaderCell

	draw_sort_indicator_with_frame__in_view__ascending__priority_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW; a_ascending: BOOLEAN; a_priority: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_sort_indicator_with_frame__in_view__ascending__priority_ (item, a_cell_frame.item, a_control_view__item, a_ascending, a_priority)
		end

	sort_indicator_rect_for_bounds_ (a_the_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_sort_indicator_rect_for_bounds_ (item, Result.item, a_the_rect.item)
		end

feature {NONE} -- NSTableHeaderCell Externals

	objc_draw_sort_indicator_with_frame__in_view__ascending__priority_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER; a_ascending: BOOLEAN; a_priority: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableHeaderCell *)$an_item drawSortIndicatorWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view ascending:$a_ascending priority:$a_priority];
			 ]"
		end

	objc_sort_indicator_rect_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_the_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTableHeaderCell *)$an_item sortIndicatorRectForBounds:*((NSRect *)$a_the_rect)];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTableHeaderCell"
		end

end
