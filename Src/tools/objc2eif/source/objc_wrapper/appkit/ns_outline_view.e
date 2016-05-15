note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OUTLINE_VIEW

inherit
	NS_TABLE_VIEW
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSOutlineView

	set_outline_table_column_ (a_outline_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		local
			a_outline_table_column__item: POINTER
		do
			if attached a_outline_table_column as a_outline_table_column_attached then
				a_outline_table_column__item := a_outline_table_column_attached.item
			end
			objc_set_outline_table_column_ (item, a_outline_table_column__item)
		end

	outline_table_column: detachable NS_TABLE_COLUMN
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_outline_table_column (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_table_column} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_table_column} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_expandable_ (a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_is_expandable_ (item, a_item__item)
		end

	expand_item__expand_children_ (a_item: detachable NS_OBJECT; a_expand_children: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_expand_item__expand_children_ (item, a_item__item, a_expand_children)
		end

	expand_item_ (a_item: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_expand_item_ (item, a_item__item)
		end

	collapse_item__collapse_children_ (a_item: detachable NS_OBJECT; a_collapse_children: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_collapse_item__collapse_children_ (item, a_item__item, a_collapse_children)
		end

	collapse_item_ (a_item: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_collapse_item_ (item, a_item__item)
		end

	reload_item__reload_children_ (a_item: detachable NS_OBJECT; a_reload_children: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_reload_item__reload_children_ (item, a_item__item, a_reload_children)
		end

	reload_item_ (a_item: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_reload_item_ (item, a_item__item)
		end

	parent_for_item_ (a_item: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_parent_for_item_ (item, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parent_for_item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parent_for_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	item_at_row_ (a_row: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_at_row_ (item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_at_row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_at_row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	row_for_item_ (a_item: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_row_for_item_ (item, a_item__item)
		end

	level_for_item_ (a_item: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_level_for_item_ (item, a_item__item)
		end

	level_for_row_ (a_row: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_level_for_row_ (item, a_row)
		end

	is_item_expanded_ (a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_is_item_expanded_ (item, a_item__item)
		end

	set_indentation_per_level_ (a_indentation_per_level: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_indentation_per_level_ (item, a_indentation_per_level)
		end

	indentation_per_level: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_indentation_per_level (item)
		end

	set_indentation_marker_follows_cell_ (a_draw_in_cell: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_indentation_marker_follows_cell_ (item, a_draw_in_cell)
		end

	indentation_marker_follows_cell: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_indentation_marker_follows_cell (item)
		end

	set_autoresizes_outline_column_ (a_resize: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autoresizes_outline_column_ (item, a_resize)
		end

	autoresizes_outline_column: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autoresizes_outline_column (item)
		end

	frame_of_outline_cell_at_row_ (a_row: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame_of_outline_cell_at_row_ (item, Result.item, a_row)
		end

	set_drop_item__drop_child_index_ (a_item: detachable NS_OBJECT; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_set_drop_item__drop_child_index_ (item, a_item__item, a_index)
		end

	should_collapse_auto_expanded_items_for_deposited_ (a_deposited: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_collapse_auto_expanded_items_for_deposited_ (item, a_deposited)
		end

	autosave_expanded_items: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autosave_expanded_items (item)
		end

	set_autosave_expanded_items_ (a_save: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autosave_expanded_items_ (item, a_save)
		end

feature {NONE} -- NSOutlineView Externals

	objc_set_outline_table_column_ (an_item: POINTER; a_outline_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item setOutlineTableColumn:$a_outline_table_column];
			 ]"
		end

	objc_outline_table_column (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOutlineView *)$an_item outlineTableColumn];
			 ]"
		end

	objc_is_expandable_ (an_item: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item isExpandable:$a_item];
			 ]"
		end

	objc_expand_item__expand_children_ (an_item: POINTER; a_item: POINTER; a_expand_children: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item expandItem:$a_item expandChildren:$a_expand_children];
			 ]"
		end

	objc_expand_item_ (an_item: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item expandItem:$a_item];
			 ]"
		end

	objc_collapse_item__collapse_children_ (an_item: POINTER; a_item: POINTER; a_collapse_children: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item collapseItem:$a_item collapseChildren:$a_collapse_children];
			 ]"
		end

	objc_collapse_item_ (an_item: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item collapseItem:$a_item];
			 ]"
		end

	objc_reload_item__reload_children_ (an_item: POINTER; a_item: POINTER; a_reload_children: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item reloadItem:$a_item reloadChildren:$a_reload_children];
			 ]"
		end

	objc_reload_item_ (an_item: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item reloadItem:$a_item];
			 ]"
		end

	objc_parent_for_item_ (an_item: POINTER; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOutlineView *)$an_item parentForItem:$a_item];
			 ]"
		end

	objc_item_at_row_ (an_item: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOutlineView *)$an_item itemAtRow:$a_row];
			 ]"
		end

	objc_row_for_item_ (an_item: POINTER; a_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item rowForItem:$a_item];
			 ]"
		end

	objc_level_for_item_ (an_item: POINTER; a_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item levelForItem:$a_item];
			 ]"
		end

	objc_level_for_row_ (an_item: POINTER; a_row: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item levelForRow:$a_row];
			 ]"
		end

	objc_is_item_expanded_ (an_item: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item isItemExpanded:$a_item];
			 ]"
		end

	objc_set_indentation_per_level_ (an_item: POINTER; a_indentation_per_level: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item setIndentationPerLevel:$a_indentation_per_level];
			 ]"
		end

	objc_indentation_per_level (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item indentationPerLevel];
			 ]"
		end

	objc_set_indentation_marker_follows_cell_ (an_item: POINTER; a_draw_in_cell: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item setIndentationMarkerFollowsCell:$a_draw_in_cell];
			 ]"
		end

	objc_indentation_marker_follows_cell (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item indentationMarkerFollowsCell];
			 ]"
		end

	objc_set_autoresizes_outline_column_ (an_item: POINTER; a_resize: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item setAutoresizesOutlineColumn:$a_resize];
			 ]"
		end

	objc_autoresizes_outline_column (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item autoresizesOutlineColumn];
			 ]"
		end

	objc_frame_of_outline_cell_at_row_ (an_item: POINTER; result_pointer: POINTER; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSOutlineView *)$an_item frameOfOutlineCellAtRow:$a_row];
			 ]"
		end

	objc_set_drop_item__drop_child_index_ (an_item: POINTER; a_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item setDropItem:$a_item dropChildIndex:$a_index];
			 ]"
		end

	objc_should_collapse_auto_expanded_items_for_deposited_ (an_item: POINTER; a_deposited: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item shouldCollapseAutoExpandedItemsForDeposited:$a_deposited];
			 ]"
		end

	objc_autosave_expanded_items (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOutlineView *)$an_item autosaveExpandedItems];
			 ]"
		end

	objc_set_autosave_expanded_items_ (an_item: POINTER; a_save: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOutlineView *)$an_item setAutosaveExpandedItems:$a_save];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOutlineView"
		end

end
