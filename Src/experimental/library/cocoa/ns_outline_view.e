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
			callback_marshal.register_object (Current)
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

feature -- Expanding and Collapsing the Outline

--	outline_view_should_expand_item (a_outline_view: NS_OUTLINE_VIEW; a_item: NS_OBJECT): BOOLEAN
--			-- Returns a Boolean value that indicates whether the outline view should expand a given item.
--		do
--			Result := {NS_OUTLINE_VIEW_API}.outline_view_should_expand_item (item, a_outline_view.item, a_item.item)
--		end

	outline_view_item_will_expand (a_notification: NS_NOTIFICATION)

		do
			{NS_OUTLINE_VIEW_API}.outline_view_item_will_expand (item, a_notification.item)
		end

	expand_item (a_item: NS_OBJECT)
			-- Expands a given item.
		do
			{NS_OUTLINE_VIEW_API}.expand_item (item, a_item.item)
		end

	expand_item_expand_children (a_item: NS_OBJECT; a_expand_children: BOOLEAN)
			-- Expands a specified item and, optionally, its children.
		do
			{NS_OUTLINE_VIEW_API}.expand_item_expand_children (item, a_item.item, a_expand_children.item)
		end

	outline_view_item_did_expand (a_notification: NS_NOTIFICATION)

		do
			{NS_OUTLINE_VIEW_API}.outline_view_item_did_expand (item, a_notification.item)
		end

--	outline_view_should_collapse_item (a_outline_view: NS_OUTLINE_VIEW; a_item: NS_OBJECT): BOOLEAN
--			-- Returns a Boolean value that indicates whether the outline view should collapse a given item.
--		do
--			Result := {NS_OUTLINE_VIEW_API}.outline_view_should_collapse_item (item, a_outline_view.item, a_item.item)
--		end

	outline_view_item_will_collapse (a_notification: NS_NOTIFICATION)

		do
			{NS_OUTLINE_VIEW_API}.outline_view_item_will_collapse (item, a_notification.item)
		end

	collapse_item (a_item: NS_OBJECT)
			-- Collapses a given item.
		do
			{NS_OUTLINE_VIEW_API}.collapse_item (item, a_item.item)
		end

	collapse_item_collapse_children (a_item: NS_OBJECT; a_collapse_children: BOOLEAN)

		do
			{NS_OUTLINE_VIEW_API}.collapse_item_collapse_children (item, a_item.item, a_collapse_children.item)
		end

	outline_view_item_did_collapse (a_notification: NS_NOTIFICATION)

		do
			{NS_OUTLINE_VIEW_API}.outline_view_item_did_collapse (item, a_notification.item)
		end

end
