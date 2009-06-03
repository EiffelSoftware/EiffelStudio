note
	description: "Wrapper for NSTableHeaderCell."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_HEADER_CELL

inherit
	NS_TEXT_FIELD_CELL

create
	make

feature {NONE} -- Creation

--	alloc
--		do
--			cocoa_object := table_header_cell_alloc
--		end

	make
		do
			make_shared (table_header_cell_new)
		end

feature {NONE} -- Objective-C interface

	frozen table_header_cell_alloc: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTableHeaderCell alloc];"
		end

	frozen table_header_cell_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTableHeaderCell new];"
		end

end
