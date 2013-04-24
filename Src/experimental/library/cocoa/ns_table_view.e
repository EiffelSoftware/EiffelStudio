note
	description: "Summary description for {NS_TABLE_VIEW}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_VIEW

inherit
	NS_VIEW
		redefine
			make
		end

create
	make
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature {NONE} -- Creation

	make
		do
			check
				not_implemented: False
			end
		end

feature -- Access

	selected_row: INTEGER
		do
			Result := {NS_TABLE_VIEW_API}.selected_row (item)
		end

	set_header_view (a_view: POINTER)
			--
		do
			{NS_TABLE_VIEW_API}.set_header_view (item, a_view)
		end

feature -- Column Management

	add_table_column (a_table_column: NS_TABLE_COLUMN)
			-- Adds a given column as the last column of the receiver.
		do
			{NS_TABLE_VIEW_API}.add_table_column (item, a_table_column.item)
		end

	table_columns: NS_ARRAY [NS_TABLE_COLUMN]
			-- An array containing the NS_TABLE_COLUMN objects.
		do
			create Result.share_from_pointer ({NS_TABLE_VIEW_API}.table_columns (item))
		end

end
