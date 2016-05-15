note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_COLUMN

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_identifier_,
	make

feature {NONE} -- Initialization

	make_with_identifier_ (a_identifier: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			make_with_pointer (objc_init_with_identifier_(allocate_object, a_identifier__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTableColumn Externals

	objc_init_with_identifier_ (an_item: POINTER; a_identifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableColumn *)$an_item initWithIdentifier:$a_identifier];
			 ]"
		end

	objc_set_identifier_ (an_item: POINTER; a_identifier: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setIdentifier:$a_identifier];
			 ]"
		end

	objc_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableColumn *)$an_item identifier];
			 ]"
		end

	objc_set_table_view_ (an_item: POINTER; a_table_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setTableView:$a_table_view];
			 ]"
		end

	objc_table_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableColumn *)$an_item tableView];
			 ]"
		end

	objc_set_width_ (an_item: POINTER; a_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setWidth:$a_width];
			 ]"
		end

	objc_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableColumn *)$an_item width];
			 ]"
		end

	objc_set_min_width_ (an_item: POINTER; a_min_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setMinWidth:$a_min_width];
			 ]"
		end

	objc_min_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableColumn *)$an_item minWidth];
			 ]"
		end

	objc_set_max_width_ (an_item: POINTER; a_max_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setMaxWidth:$a_max_width];
			 ]"
		end

	objc_max_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableColumn *)$an_item maxWidth];
			 ]"
		end

	objc_set_header_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setHeaderCell:$a_cell];
			 ]"
		end

	objc_header_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableColumn *)$an_item headerCell];
			 ]"
		end

	objc_set_data_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setDataCell:$a_cell];
			 ]"
		end

	objc_data_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableColumn *)$an_item dataCell];
			 ]"
		end

	objc_data_cell_for_row_ (an_item: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableColumn *)$an_item dataCellForRow:$a_row];
			 ]"
		end

	objc_set_editable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setEditable:$a_flag];
			 ]"
		end

	objc_is_editable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableColumn *)$an_item isEditable];
			 ]"
		end

	objc_size_to_fit (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item sizeToFit];
			 ]"
		end

	objc_set_sort_descriptor_prototype_ (an_item: POINTER; a_sort_descriptor: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setSortDescriptorPrototype:$a_sort_descriptor];
			 ]"
		end

	objc_sort_descriptor_prototype (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableColumn *)$an_item sortDescriptorPrototype];
			 ]"
		end

	objc_set_resizing_mask_ (an_item: POINTER; a_resizing_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setResizingMask:$a_resizing_mask];
			 ]"
		end

	objc_resizing_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableColumn *)$an_item resizingMask];
			 ]"
		end

	objc_set_header_tool_tip_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setHeaderToolTip:$a_string];
			 ]"
		end

	objc_header_tool_tip (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableColumn *)$an_item headerToolTip];
			 ]"
		end

	objc_is_hidden (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableColumn *)$an_item isHidden];
			 ]"
		end

	objc_set_hidden_ (an_item: POINTER; a_hidden: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableColumn *)$an_item setHidden:$a_hidden];
			 ]"
		end

feature -- NSTableColumn

	set_identifier_ (a_identifier: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			objc_set_identifier_ (item, a_identifier__item)
		end

	identifier: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

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

	set_width_ (a_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_width_ (item, a_width)
		end

	width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_width (item)
		end

	set_min_width_ (a_min_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_width_ (item, a_min_width)
		end

	min_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_min_width (item)
		end

	set_max_width_ (a_max_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_width_ (item, a_max_width)
		end

	max_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_width (item)
		end

	set_header_cell_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_header_cell_ (item, a_cell__item)
		end

	header_cell: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_header_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like header_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like header_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_data_cell_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_data_cell_ (item, a_cell__item)
		end

	data_cell: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data_cell_for_row_ (a_row: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_cell_for_row_ (item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_cell_for_row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_cell_for_row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_editable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_editable_ (item, a_flag)
		end

	is_editable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_editable (item)
		end

	size_to_fit
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_size_to_fit (item)
		end

	set_sort_descriptor_prototype_ (a_sort_descriptor: detachable NS_SORT_DESCRIPTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_sort_descriptor__item: POINTER
		do
			if attached a_sort_descriptor as a_sort_descriptor_attached then
				a_sort_descriptor__item := a_sort_descriptor_attached.item
			end
			objc_set_sort_descriptor_prototype_ (item, a_sort_descriptor__item)
		end

	sort_descriptor_prototype: detachable NS_SORT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_sort_descriptor_prototype (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sort_descriptor_prototype} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sort_descriptor_prototype} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_resizing_mask_ (a_resizing_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_resizing_mask_ (item, a_resizing_mask)
		end

	resizing_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_resizing_mask (item)
		end

	set_header_tool_tip_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_header_tool_tip_ (item, a_string__item)
		end

	header_tool_tip: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_header_tool_tip (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like header_tool_tip} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like header_tool_tip} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_hidden: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_hidden (item)
		end

	set_hidden_ (a_hidden: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hidden_ (item, a_hidden)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTableColumn"
		end

end
