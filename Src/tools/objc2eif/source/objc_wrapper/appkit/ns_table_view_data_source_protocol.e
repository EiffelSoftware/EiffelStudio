note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TABLE_VIEW_DATA_SOURCE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	number_of_rows_in_table_view_ (a_table_view: detachable NS_TABLE_VIEW): INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_number_of_rows_in_table_view_: has_number_of_rows_in_table_view_
		local
			a_table_view__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			Result := objc_number_of_rows_in_table_view_ (item, a_table_view__item)
		end

	table_view__object_value_for_table_column__row_ (a_table_view: detachable NS_TABLE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_row: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__object_value_for_table_column__row_: has_table_view__object_value_for_table_column__row_
		local
			result_pointer: POINTER
			a_table_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			result_pointer := objc_table_view__object_value_for_table_column__row_ (item, a_table_view__item, a_table_column__item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like table_view__object_value_for_table_column__row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like table_view__object_value_for_table_column__row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	table_view__set_object_value__for_table_column__row_ (a_table_view: detachable NS_TABLE_VIEW; a_object: detachable NS_OBJECT; a_table_column: detachable NS_TABLE_COLUMN; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__set_object_value__for_table_column__row_: has_table_view__set_object_value__for_table_column__row_
		local
			a_table_view__item: POINTER
			a_object__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_table_view__set_object_value__for_table_column__row_ (item, a_table_view__item, a_object__item, a_table_column__item, a_row)
		end

	table_view__sort_descriptors_did_change_ (a_table_view: detachable NS_TABLE_VIEW; a_old_descriptors: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__sort_descriptors_did_change_: has_table_view__sort_descriptors_did_change_
		local
			a_table_view__item: POINTER
			a_old_descriptors__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_old_descriptors as a_old_descriptors_attached then
				a_old_descriptors__item := a_old_descriptors_attached.item
			end
			objc_table_view__sort_descriptors_did_change_ (item, a_table_view__item, a_old_descriptors__item)
		end

	table_view__write_rows_with_indexes__to_pasteboard_ (a_table_view: detachable NS_TABLE_VIEW; a_row_indexes: detachable NS_INDEX_SET; a_pboard: detachable NS_PASTEBOARD): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__write_rows_with_indexes__to_pasteboard_: has_table_view__write_rows_with_indexes__to_pasteboard_
		local
			a_table_view__item: POINTER
			a_row_indexes__item: POINTER
			a_pboard__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_row_indexes as a_row_indexes_attached then
				a_row_indexes__item := a_row_indexes_attached.item
			end
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			Result := objc_table_view__write_rows_with_indexes__to_pasteboard_ (item, a_table_view__item, a_row_indexes__item, a_pboard__item)
		end

	table_view__validate_drop__proposed_row__proposed_drop_operation_ (a_table_view: detachable NS_TABLE_VIEW; a_info: detachable NS_DRAGGING_INFO_PROTOCOL; a_row: INTEGER_64; a_drop_operation: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__validate_drop__proposed_row__proposed_drop_operation_: has_table_view__validate_drop__proposed_row__proposed_drop_operation_
		local
			a_table_view__item: POINTER
			a_info__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_info as a_info_attached then
				a_info__item := a_info_attached.item
			end
			Result := objc_table_view__validate_drop__proposed_row__proposed_drop_operation_ (item, a_table_view__item, a_info__item, a_row, a_drop_operation)
		end

	table_view__accept_drop__row__drop_operation_ (a_table_view: detachable NS_TABLE_VIEW; a_info: detachable NS_DRAGGING_INFO_PROTOCOL; a_row: INTEGER_64; a_drop_operation: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__accept_drop__row__drop_operation_: has_table_view__accept_drop__row__drop_operation_
		local
			a_table_view__item: POINTER
			a_info__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_info as a_info_attached then
				a_info__item := a_info_attached.item
			end
			Result := objc_table_view__accept_drop__row__drop_operation_ (item, a_table_view__item, a_info__item, a_row, a_drop_operation)
		end

	table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_ (a_table_view: detachable NS_TABLE_VIEW; a_drop_destination: detachable NS_URL; a_index_set: detachable NS_INDEX_SET): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_: has_table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_
		local
			result_pointer: POINTER
			a_table_view__item: POINTER
			a_drop_destination__item: POINTER
			a_index_set__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_drop_destination as a_drop_destination_attached then
				a_drop_destination__item := a_drop_destination_attached.item
			end
			if attached a_index_set as a_index_set_attached then
				a_index_set__item := a_index_set_attached.item
			end
			result_pointer := objc_table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_ (item, a_table_view__item, a_drop_destination__item, a_index_set__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- Status Report

	has_number_of_rows_in_table_view_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_number_of_rows_in_table_view_ (item)
		end

	has_table_view__object_value_for_table_column__row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__object_value_for_table_column__row_ (item)
		end

	has_table_view__set_object_value__for_table_column__row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__set_object_value__for_table_column__row_ (item)
		end

	has_table_view__sort_descriptors_did_change_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__sort_descriptors_did_change_ (item)
		end

	has_table_view__write_rows_with_indexes__to_pasteboard_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__write_rows_with_indexes__to_pasteboard_ (item)
		end

	has_table_view__validate_drop__proposed_row__proposed_drop_operation_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__validate_drop__proposed_row__proposed_drop_operation_ (item)
		end

	has_table_view__accept_drop__row__drop_operation_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__accept_drop__row__drop_operation_ (item)
		end

	has_table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_ (item)
		end

feature -- Status Report Externals

	objc_has_number_of_rows_in_table_view_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(numberOfRowsInTableView:)];
			 ]"
		end

	objc_has_table_view__object_value_for_table_column__row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:objectValueForTableColumn:row:)];
			 ]"
		end

	objc_has_table_view__set_object_value__for_table_column__row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:setObjectValue:forTableColumn:row:)];
			 ]"
		end

	objc_has_table_view__sort_descriptors_did_change_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:sortDescriptorsDidChange:)];
			 ]"
		end

	objc_has_table_view__write_rows_with_indexes__to_pasteboard_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:writeRowsWithIndexes:toPasteboard:)];
			 ]"
		end

	objc_has_table_view__validate_drop__proposed_row__proposed_drop_operation_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:validateDrop:proposedRow:proposedDropOperation:)];
			 ]"
		end

	objc_has_table_view__accept_drop__row__drop_operation_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:acceptDrop:row:dropOperation:)];
			 ]"
		end

	objc_has_table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:namesOfPromisedFilesDroppedAtDestination:forDraggedRowsWithIndexes:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_number_of_rows_in_table_view_ (an_item: POINTER; a_table_view: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDataSource>)$an_item numberOfRowsInTableView:$a_table_view];
			 ]"
		end

	objc_table_view__object_value_for_table_column__row_ (an_item: POINTER; a_table_view: POINTER; a_table_column: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTableViewDataSource>)$an_item tableView:$a_table_view objectValueForTableColumn:$a_table_column row:$a_row];
			 ]"
		end

	objc_table_view__set_object_value__for_table_column__row_ (an_item: POINTER; a_table_view: POINTER; a_object: POINTER; a_table_column: POINTER; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDataSource>)$an_item tableView:$a_table_view setObjectValue:$a_object forTableColumn:$a_table_column row:$a_row];
			 ]"
		end

	objc_table_view__sort_descriptors_did_change_ (an_item: POINTER; a_table_view: POINTER; a_old_descriptors: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDataSource>)$an_item tableView:$a_table_view sortDescriptorsDidChange:$a_old_descriptors];
			 ]"
		end

	objc_table_view__write_rows_with_indexes__to_pasteboard_ (an_item: POINTER; a_table_view: POINTER; a_row_indexes: POINTER; a_pboard: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDataSource>)$an_item tableView:$a_table_view writeRowsWithIndexes:$a_row_indexes toPasteboard:$a_pboard];
			 ]"
		end

	objc_table_view__validate_drop__proposed_row__proposed_drop_operation_ (an_item: POINTER; a_table_view: POINTER; a_info: POINTER; a_row: INTEGER_64; a_drop_operation: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDataSource>)$an_item tableView:$a_table_view validateDrop:$a_info proposedRow:$a_row proposedDropOperation:$a_drop_operation];
			 ]"
		end

	objc_table_view__accept_drop__row__drop_operation_ (an_item: POINTER; a_table_view: POINTER; a_info: POINTER; a_row: INTEGER_64; a_drop_operation: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDataSource>)$an_item tableView:$a_table_view acceptDrop:$a_info row:$a_row dropOperation:$a_drop_operation];
			 ]"
		end

	objc_table_view__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes_ (an_item: POINTER; a_table_view: POINTER; a_drop_destination: POINTER; a_index_set: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTableViewDataSource>)$an_item tableView:$a_table_view namesOfPromisedFilesDroppedAtDestination:$a_drop_destination forDraggedRowsWithIndexes:$a_index_set];
			 ]"
		end

end
