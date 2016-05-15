note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_HEADER_VIEW

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

feature -- NSTableHeaderView

	set_table_view_ (a_table_view: detachable NS_TABLE_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_table_view__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			objc_set_table_view_ (item, a_table_view__item)
		end

	table_view: detachable NS_TABLE_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_table_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like table_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like table_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dragged_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_dragged_column (item)
		end

	dragged_distance: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_dragged_distance (item)
		end

	resized_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_resized_column (item)
		end

	header_rect_of_column_ (a_column: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_header_rect_of_column_ (item, Result.item, a_column)
		end

	column_at_point_ (a_point: NS_POINT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_column_at_point_ (item, a_point.item)
		end

feature {NONE} -- NSTableHeaderView Externals

	objc_set_table_view_ (an_item: POINTER; a_table_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableHeaderView *)$an_item setTableView:$a_table_view];
			 ]"
		end

	objc_table_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableHeaderView *)$an_item tableView];
			 ]"
		end

	objc_dragged_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableHeaderView *)$an_item draggedColumn];
			 ]"
		end

	objc_dragged_distance (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableHeaderView *)$an_item draggedDistance];
			 ]"
		end

	objc_resized_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableHeaderView *)$an_item resizedColumn];
			 ]"
		end

	objc_header_rect_of_column_ (an_item: POINTER; result_pointer: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTableHeaderView *)$an_item headerRectOfColumn:$a_column];
			 ]"
		end

	objc_column_at_point_ (an_item: POINTER; a_point: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableHeaderView *)$an_item columnAtPoint:*((NSPoint *)$a_point)];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTableHeaderView"
		end

end
