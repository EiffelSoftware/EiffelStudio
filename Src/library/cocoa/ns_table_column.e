note
	description: "Wrapper for NSTableColumn."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_COLUMN

inherit
	NS_OBJECT

create
	new

feature -- Creation and Initialization

	new
		do
			cocoa_object := table_column_new
		end

	init_with_identifier (a_identifier: NS_OBJECT)
		do
			table_column_init_with_identifier (cocoa_object, a_identifier.cocoa_object)
		end

feature -- ...

	set_identifier (a_identifier: NS_OBJECT)
		do
			table_column_set_identifier (cocoa_object, a_identifier.cocoa_object)
		end

	identifier: NS_OBJECT
		do
			create Result.make_shared (table_column_identifier (cocoa_object))
		end

	set_table_view (a_table_view: NS_TABLE_VIEW)
		do
			table_column_set_table_view (cocoa_object, a_table_view.cocoa_object)
		end

	table_view: NS_TABLE_VIEW
		do
			create Result.make_shared (table_column_table_view (cocoa_object))
		end

	set_width (a_width: REAL)
		do
			table_column_set_width (cocoa_object, a_width)
		end

	width: REAL
		do
			Result := table_column_width (cocoa_object)
		end

	set_min_width (a_min_width: REAL)
		do
			table_column_set_min_width (cocoa_object, a_min_width)
		end

	min_width: REAL
		do
			Result := table_column_min_width (cocoa_object)
		end

	set_max_width (a_max_width: REAL)
		do
			table_column_set_max_width (cocoa_object, a_max_width)
		end

	max_width: REAL
		do
			Result := table_column_max_width (cocoa_object)
		end

	set_header_cell (a_cell: NS_CELL)
		do
			table_column_set_header_cell (cocoa_object, a_cell.cocoa_object)
		end

	header_cell: NS_CELL
		do
			create Result.make_shared (table_column_header_cell (cocoa_object))
		end

	set_data_cell (a_cell: NS_CELL)
		do
			table_column_set_data_cell (cocoa_object, a_cell.cocoa_object)
		end

	data_cell: NS_CELL
			-- Note: Original signature returns NS_OBJECT
		do
			create Result.make_shared (table_column_data_cell (cocoa_object))
		end

--	data_cell_for_row (a_row: INTEGER): NS_OBJECT
--		do
--			Result := table_column_data_cell_for_row (cocoa_object, a_row)
--		end

	set_editable (a_flag: BOOLEAN)
		do
			table_column_set_editable (cocoa_object, a_flag)
		end

	is_editable: BOOLEAN
		do
			Result := table_column_is_editable (cocoa_object)
		end

	size_to_fit
		do
			table_column_size_to_fit (cocoa_object)
		end

--	set_sort_descriptor_prototype (a_sort_descriptor: NS_SORT_DESCRIPTOR)
--		do
--			table_column_set_sort_descriptor_prototype (cocoa_object, a_sort_descriptor.cocoa_object)
--		end

--	sort_descriptor_prototype: NS_SORT_DESCRIPTOR
--		do
--			create Result.make_shared (table_column_sort_descriptor_prototype (cocoa_object))
--		end

	set_resizing_mask (a_resizing_mask: INTEGER)
		do
			table_column_set_resizing_mask (cocoa_object, a_resizing_mask)
		end

	resizing_mask: INTEGER
		do
			Result := table_column_resizing_mask (cocoa_object)
		end

	set_header_tool_tip (a_string: NS_STRING)
		do
			table_column_set_header_tool_tip (cocoa_object, a_string.cocoa_object)
		end

	header_tool_tip: NS_STRING
		do
			create Result.make_shared (table_column_header_tool_tip (cocoa_object))
		end

	is_hidden: BOOLEAN
		do
			Result := table_column_is_hidden (cocoa_object)
		end

	set_hidden (a_hidden: BOOLEAN)
		do
			table_column_set_hidden (cocoa_object, a_hidden)
		end

	set_resizable (a_flag: BOOLEAN)
		do
			table_column_set_resizable (cocoa_object, a_flag)
		end

	is_resizable: BOOLEAN
		do
			Result := table_column_is_resizable (cocoa_object)
		end

feature {NONE} -- Objective-C implementation

	frozen table_column_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTableColumn new];"
		end

	frozen table_column_init_with_identifier (a_table_column: POINTER; a_identifier: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column initWithIdentifier: $a_identifier];"
		end

	frozen table_column_set_identifier (a_table_column: POINTER; a_identifier: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setIdentifier: $a_identifier];"
		end

	frozen table_column_identifier (a_table_column: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column identifier];"
		end

	frozen table_column_set_table_view (a_table_column: POINTER; a_table_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setTableView: $a_table_view];"
		end

	frozen table_column_table_view (a_table_column: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column tableView];"
		end

	frozen table_column_set_width (a_table_column: POINTER; a_width: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setWidth: $a_width];"
		end

	frozen table_column_width (a_table_column: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column width];"
		end

	frozen table_column_set_min_width (a_table_column: POINTER; a_min_width: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setMinWidth: $a_min_width];"
		end

	frozen table_column_min_width (a_table_column: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column minWidth];"
		end

	frozen table_column_set_max_width (a_table_column: POINTER; a_max_width: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setMaxWidth: $a_max_width];"
		end

	frozen table_column_max_width (a_table_column: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column maxWidth];"
		end

	frozen table_column_set_header_cell (a_table_column: POINTER; a_cell: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setHeaderCell: $a_cell];"
		end

	frozen table_column_header_cell (a_table_column: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column headerCell];"
		end

	frozen table_column_set_data_cell (a_table_column: POINTER; a_cell: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setDataCell: $a_cell];"
		end

	frozen table_column_data_cell (a_table_column: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column dataCell];"
		end

	frozen table_column_data_cell_for_row (a_table_column: POINTER; a_row: INTEGER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column dataCellForRow: $a_row];"
		end

	frozen table_column_set_editable (a_table_column: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setEditable: $a_flag];"
		end

	frozen table_column_is_editable (a_table_column: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column isEditable];"
		end

	frozen table_column_size_to_fit (a_table_column: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column sizeToFit];"
		end

	frozen table_column_set_sort_descriptor_prototype (a_table_column: POINTER; a_sort_descriptor: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setSortDescriptorPrototype: $a_sort_descriptor];"
		end

	frozen table_column_sort_descriptor_prototype (a_table_column: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column sortDescriptorPrototype];"
		end

	frozen table_column_set_resizing_mask (a_table_column: POINTER; a_resizing_mask: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setResizingMask: $a_resizing_mask];"
		end

	frozen table_column_resizing_mask (a_table_column: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column resizingMask];"
		end

	frozen table_column_set_header_tool_tip (a_table_column: POINTER; a_string: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setHeaderToolTip: $a_string];"
		end

	frozen table_column_header_tool_tip (a_table_column: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column headerToolTip];"
		end

	frozen table_column_is_hidden (a_table_column: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column isHidden];"
		end

	frozen table_column_set_hidden (a_table_column: POINTER; a_hidden: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setHidden: $a_hidden];"
		end

	frozen table_column_set_resizable (a_table_column: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTableColumn*)$a_table_column setResizable: $a_flag];"
		end

	frozen table_column_is_resizable (a_table_column: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTableColumn*)$a_table_column isResizable];"
		end
end
