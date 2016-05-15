note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_TABLE_BLOCK

inherit
	NS_TEXT_BLOCK
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_table__starting_row__row_span__starting_column__column_span_,
	make

feature {NONE} -- Initialization

	make_with_table__starting_row__row_span__starting_column__column_span_ (a_table: detachable NS_TEXT_TABLE; a_row: INTEGER_64; a_row_span: INTEGER_64; a_col: INTEGER_64; a_col_span: INTEGER_64)
			-- Initialize `Current'.
		local
			a_table__item: POINTER
		do
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			make_with_pointer (objc_init_with_table__starting_row__row_span__starting_column__column_span_(allocate_object, a_table__item, a_row, a_row_span, a_col, a_col_span))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTextTableBlock Externals

	objc_init_with_table__starting_row__row_span__starting_column__column_span_ (an_item: POINTER; a_table: POINTER; a_row: INTEGER_64; a_row_span: INTEGER_64; a_col: INTEGER_64; a_col_span: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextTableBlock *)$an_item initWithTable:$a_table startingRow:$a_row rowSpan:$a_row_span startingColumn:$a_col columnSpan:$a_col_span];
			 ]"
		end

	objc_table (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextTableBlock *)$an_item table];
			 ]"
		end

	objc_starting_row (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTableBlock *)$an_item startingRow];
			 ]"
		end

	objc_row_span (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTableBlock *)$an_item rowSpan];
			 ]"
		end

	objc_starting_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTableBlock *)$an_item startingColumn];
			 ]"
		end

	objc_column_span (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextTableBlock *)$an_item columnSpan];
			 ]"
		end

feature -- NSTextTableBlock

	table: detachable NS_TEXT_TABLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_table (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like table} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like table} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	starting_row: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_starting_row (item)
		end

	row_span: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_row_span (item)
		end

	starting_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_starting_column (item)
		end

	column_span: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_column_span (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextTableBlock"
		end

end
