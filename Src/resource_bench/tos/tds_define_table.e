indexing
	description: "To store the `#define' data";
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_DEFINE_TABLE

feature -- Access

	define_table: HASH_TABLE [COUPLE, STRING] is
			-- Contain the define name and the define value.
		do
			Result := define_table_cell.item
		end

feature -- Element change

	set_define_table (a_define_table: HASH_TABLE [COUPLE, STRING]) is
			-- Set `define_table' to `a_define_table'.
		require
			a_define_table_not_void: a_define_table /= Void
		do
			define_table_cell.put (a_define_table)
		ensure
			define_table_set: define_table = a_define_table
		end

feature {NONE} -- Implementation

	define_table_cell: CELL [HASH_TABLE [COUPLE, STRING]] is
			-- The current `define_table'.
		once
			!!Result.put (Void)
		ensure
			result_not_void: Result /= Void
		end

end -- class TDS_DEFINE_TABLE
