note
	description: "Wrapper for NSOutlineView"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OUTLINE_VIEW

inherit
	NS_TABLE_VIEW
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_OUTLINE_VIEW_API}.new)
			insert_in_table
		end

feature -- Access

	set_outline_table_column (a_table_column: NS_TABLE_COLUMN)
			-- Sets the table column in which hierarchical data is displayed
		do
			{NS_OUTLINE_VIEW_API}.set_outline_table_column (item, a_table_column.item)
		end

	set_data_source (a_data_source: NS_OUTLINE_VIEW_DATA_SOURCE[ANY])
		do
			{NS_OUTLINE_VIEW_API}.set_data_source (item, a_data_source.item)
		end

	set_delegate (a_delegate: NS_OUTLINE_VIEW_DELEGATE)
		do
			{NS_OUTLINE_VIEW_API}.set_delegate (item, a_delegate.item)
		end

	reload_item_reload_children (an_item: POINTER; a_flag: BOOLEAN)
		do
			{NS_OUTLINE_VIEW_API}.reload_item_reload_children (item, an_item, a_flag)
		end

	item_at_row (a_row: INTEGER): ANY
		do
			Result := {NS_OUTLINE_VIEW_DATA_SOURCE[ANY]}.outline_view_date_source_item_to_any ({NS_OUTLINE_VIEW_API}.item_at_row (item, a_row))
		end

	size_to_fit
		do
			{NS_OUTLINE_VIEW_API}.site_to_fit (item)
		end

end
