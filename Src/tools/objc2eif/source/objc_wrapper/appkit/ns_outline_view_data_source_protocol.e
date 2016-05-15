note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_OUTLINE_VIEW_DATA_SOURCE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	outline_view__child__of_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_index: INTEGER_64; a_item: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__child__of_item_: has_outline_view__child__of_item_
		local
			result_pointer: POINTER
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_outline_view__child__of_item_ (item, a_outline_view__item, a_index, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_view__child__of_item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_view__child__of_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	outline_view__is_item_expandable_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__is_item_expandable_: has_outline_view__is_item_expandable_
		local
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__is_item_expandable_ (item, a_outline_view__item, a_item__item)
		end

	outline_view__number_of_children_of_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_item: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__number_of_children_of_item_: has_outline_view__number_of_children_of_item_
		local
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__number_of_children_of_item_ (item, a_outline_view__item, a_item__item)
		end

	outline_view__object_value_for_table_column__by_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__object_value_for_table_column__by_item_: has_outline_view__object_value_for_table_column__by_item_
		local
			result_pointer: POINTER
			a_outline_view__item: POINTER
			a_table_column__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_outline_view__object_value_for_table_column__by_item_ (item, a_outline_view__item, a_table_column__item, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_view__object_value_for_table_column__by_item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_view__object_value_for_table_column__by_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	outline_view__set_object_value__for_table_column__by_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_object: detachable NS_OBJECT; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__set_object_value__for_table_column__by_item_: has_outline_view__set_object_value__for_table_column__by_item_
		local
			a_outline_view__item: POINTER
			a_object__item: POINTER
			a_table_column__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_outline_view__set_object_value__for_table_column__by_item_ (item, a_outline_view__item, a_object__item, a_table_column__item, a_item__item)
		end

	outline_view__item_for_persistent_object_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_object: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__item_for_persistent_object_: has_outline_view__item_for_persistent_object_
		local
			result_pointer: POINTER
			a_outline_view__item: POINTER
			a_object__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			result_pointer := objc_outline_view__item_for_persistent_object_ (item, a_outline_view__item, a_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_view__item_for_persistent_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_view__item_for_persistent_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	outline_view__persistent_object_for_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_item: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__persistent_object_for_item_: has_outline_view__persistent_object_for_item_
		local
			result_pointer: POINTER
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_outline_view__persistent_object_for_item_ (item, a_outline_view__item, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_view__persistent_object_for_item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_view__persistent_object_for_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	outline_view__sort_descriptors_did_change_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_old_descriptors: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__sort_descriptors_did_change_: has_outline_view__sort_descriptors_did_change_
		local
			a_outline_view__item: POINTER
			a_old_descriptors__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_old_descriptors as a_old_descriptors_attached then
				a_old_descriptors__item := a_old_descriptors_attached.item
			end
			objc_outline_view__sort_descriptors_did_change_ (item, a_outline_view__item, a_old_descriptors__item)
		end

	outline_view__write_items__to_pasteboard_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_items: detachable NS_ARRAY; a_pasteboard: detachable NS_PASTEBOARD): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__write_items__to_pasteboard_: has_outline_view__write_items__to_pasteboard_
		local
			a_outline_view__item: POINTER
			a_items__item: POINTER
			a_pasteboard__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_items as a_items_attached then
				a_items__item := a_items_attached.item
			end
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			Result := objc_outline_view__write_items__to_pasteboard_ (item, a_outline_view__item, a_items__item, a_pasteboard__item)
		end

	outline_view__validate_drop__proposed_item__proposed_child_index_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_info: detachable NS_DRAGGING_INFO_PROTOCOL; a_item: detachable NS_OBJECT; a_index: INTEGER_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__validate_drop__proposed_item__proposed_child_index_: has_outline_view__validate_drop__proposed_item__proposed_child_index_
		local
			a_outline_view__item: POINTER
			a_info__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_info as a_info_attached then
				a_info__item := a_info_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__validate_drop__proposed_item__proposed_child_index_ (item, a_outline_view__item, a_info__item, a_item__item, a_index)
		end

	outline_view__accept_drop__item__child_index_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_info: detachable NS_DRAGGING_INFO_PROTOCOL; a_item: detachable NS_OBJECT; a_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__accept_drop__item__child_index_: has_outline_view__accept_drop__item__child_index_
		local
			a_outline_view__item: POINTER
			a_info__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_info as a_info_attached then
				a_info__item := a_info_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__accept_drop__item__child_index_ (item, a_outline_view__item, a_info__item, a_item__item, a_index)
		end

	outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_drop_destination: detachable NS_URL; a_items: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_: has_outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_
		local
			result_pointer: POINTER
			a_outline_view__item: POINTER
			a_drop_destination__item: POINTER
			a_items__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_drop_destination as a_drop_destination_attached then
				a_drop_destination__item := a_drop_destination_attached.item
			end
			if attached a_items as a_items_attached then
				a_items__item := a_items_attached.item
			end
			result_pointer := objc_outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_ (item, a_outline_view__item, a_drop_destination__item, a_items__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- Status Report

	has_outline_view__child__of_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__child__of_item_ (item)
		end

	has_outline_view__is_item_expandable_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__is_item_expandable_ (item)
		end

	has_outline_view__number_of_children_of_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__number_of_children_of_item_ (item)
		end

	has_outline_view__object_value_for_table_column__by_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__object_value_for_table_column__by_item_ (item)
		end

	has_outline_view__set_object_value__for_table_column__by_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__set_object_value__for_table_column__by_item_ (item)
		end

	has_outline_view__item_for_persistent_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__item_for_persistent_object_ (item)
		end

	has_outline_view__persistent_object_for_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__persistent_object_for_item_ (item)
		end

	has_outline_view__sort_descriptors_did_change_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__sort_descriptors_did_change_ (item)
		end

	has_outline_view__write_items__to_pasteboard_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__write_items__to_pasteboard_ (item)
		end

	has_outline_view__validate_drop__proposed_item__proposed_child_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__validate_drop__proposed_item__proposed_child_index_ (item)
		end

	has_outline_view__accept_drop__item__child_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__accept_drop__item__child_index_ (item)
		end

	has_outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_ (item)
		end

feature -- Status Report Externals

	objc_has_outline_view__child__of_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:child:ofItem:)];
			 ]"
		end

	objc_has_outline_view__is_item_expandable_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:isItemExpandable:)];
			 ]"
		end

	objc_has_outline_view__number_of_children_of_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:numberOfChildrenOfItem:)];
			 ]"
		end

	objc_has_outline_view__object_value_for_table_column__by_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:objectValueForTableColumn:byItem:)];
			 ]"
		end

	objc_has_outline_view__set_object_value__for_table_column__by_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:setObjectValue:forTableColumn:byItem:)];
			 ]"
		end

	objc_has_outline_view__item_for_persistent_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:itemForPersistentObject:)];
			 ]"
		end

	objc_has_outline_view__persistent_object_for_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:persistentObjectForItem:)];
			 ]"
		end

	objc_has_outline_view__sort_descriptors_did_change_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:sortDescriptorsDidChange:)];
			 ]"
		end

	objc_has_outline_view__write_items__to_pasteboard_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:writeItems:toPasteboard:)];
			 ]"
		end

	objc_has_outline_view__validate_drop__proposed_item__proposed_child_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:validateDrop:proposedItem:proposedChildIndex:)];
			 ]"
		end

	objc_has_outline_view__accept_drop__item__child_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:acceptDrop:item:childIndex:)];
			 ]"
		end

	objc_has_outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:namesOfPromisedFilesDroppedAtDestination:forDraggedItems:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_outline_view__child__of_item_ (an_item: POINTER; a_outline_view: POINTER; a_index: INTEGER_64; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view child:$a_index ofItem:$a_item];
			 ]"
		end

	objc_outline_view__is_item_expandable_ (an_item: POINTER; a_outline_view: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view isItemExpandable:$a_item];
			 ]"
		end

	objc_outline_view__number_of_children_of_item_ (an_item: POINTER; a_outline_view: POINTER; a_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view numberOfChildrenOfItem:$a_item];
			 ]"
		end

	objc_outline_view__object_value_for_table_column__by_item_ (an_item: POINTER; a_outline_view: POINTER; a_table_column: POINTER; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view objectValueForTableColumn:$a_table_column byItem:$a_item];
			 ]"
		end

	objc_outline_view__set_object_value__for_table_column__by_item_ (an_item: POINTER; a_outline_view: POINTER; a_object: POINTER; a_table_column: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view setObjectValue:$a_object forTableColumn:$a_table_column byItem:$a_item];
			 ]"
		end

	objc_outline_view__item_for_persistent_object_ (an_item: POINTER; a_outline_view: POINTER; a_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view itemForPersistentObject:$a_object];
			 ]"
		end

	objc_outline_view__persistent_object_for_item_ (an_item: POINTER; a_outline_view: POINTER; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view persistentObjectForItem:$a_item];
			 ]"
		end

	objc_outline_view__sort_descriptors_did_change_ (an_item: POINTER; a_outline_view: POINTER; a_old_descriptors: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view sortDescriptorsDidChange:$a_old_descriptors];
			 ]"
		end

	objc_outline_view__write_items__to_pasteboard_ (an_item: POINTER; a_outline_view: POINTER; a_items: POINTER; a_pasteboard: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view writeItems:$a_items toPasteboard:$a_pasteboard];
			 ]"
		end

	objc_outline_view__validate_drop__proposed_item__proposed_child_index_ (an_item: POINTER; a_outline_view: POINTER; a_info: POINTER; a_item: POINTER; a_index: INTEGER_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view validateDrop:$a_info proposedItem:$a_item proposedChildIndex:$a_index];
			 ]"
		end

	objc_outline_view__accept_drop__item__child_index_ (an_item: POINTER; a_outline_view: POINTER; a_info: POINTER; a_item: POINTER; a_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view acceptDrop:$a_info item:$a_item childIndex:$a_index];
			 ]"
		end

	objc_outline_view__names_of_promised_files_dropped_at_destination__for_dragged_items_ (an_item: POINTER; a_outline_view: POINTER; a_drop_destination: POINTER; a_items: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOutlineViewDataSource>)$an_item outlineView:$a_outline_view namesOfPromisedFilesDroppedAtDestination:$a_drop_destination forDraggedItems:$a_items];
			 ]"
		end

end
