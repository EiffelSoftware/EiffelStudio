note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_COLLECTION_VIEW_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	collection_view__can_drag_items_at_indexes__with_event_ (a_collection_view: detachable NS_COLLECTION_VIEW; a_indexes: detachable NS_INDEX_SET; a_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_collection_view__can_drag_items_at_indexes__with_event_: has_collection_view__can_drag_items_at_indexes__with_event_
		local
			a_collection_view__item: POINTER
			a_indexes__item: POINTER
			a_event__item: POINTER
		do
			if attached a_collection_view as a_collection_view_attached then
				a_collection_view__item := a_collection_view_attached.item
			end
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			Result := objc_collection_view__can_drag_items_at_indexes__with_event_ (item, a_collection_view__item, a_indexes__item, a_event__item)
		end

	collection_view__write_items_at_indexes__to_pasteboard_ (a_collection_view: detachable NS_COLLECTION_VIEW; a_indexes: detachable NS_INDEX_SET; a_pasteboard: detachable NS_PASTEBOARD): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_collection_view__write_items_at_indexes__to_pasteboard_: has_collection_view__write_items_at_indexes__to_pasteboard_
		local
			a_collection_view__item: POINTER
			a_indexes__item: POINTER
			a_pasteboard__item: POINTER
		do
			if attached a_collection_view as a_collection_view_attached then
				a_collection_view__item := a_collection_view_attached.item
			end
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			Result := objc_collection_view__write_items_at_indexes__to_pasteboard_ (item, a_collection_view__item, a_indexes__item, a_pasteboard__item)
		end

	collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_ (a_collection_view: detachable NS_COLLECTION_VIEW; a_drop_url: detachable NS_URL; a_indexes: detachable NS_INDEX_SET): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_: has_collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_
		local
			result_pointer: POINTER
			a_collection_view__item: POINTER
			a_drop_url__item: POINTER
			a_indexes__item: POINTER
		do
			if attached a_collection_view as a_collection_view_attached then
				a_collection_view__item := a_collection_view_attached.item
			end
			if attached a_drop_url as a_drop_url_attached then
				a_drop_url__item := a_drop_url_attached.item
			end
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			result_pointer := objc_collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_ (item, a_collection_view__item, a_drop_url__item, a_indexes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	collection_view__dragging_image_for_items_at_indexes__with_event__offset_ (a_collection_view: detachable NS_COLLECTION_VIEW; a_indexes: detachable NS_INDEX_SET; a_event: detachable NS_EVENT; a_drag_image_offset: UNSUPPORTED_TYPE): detachable NS_IMAGE
--			-- Auto generated Objective-C wrapper.
--		require
--			has_collection_view__dragging_image_for_items_at_indexes__with_event__offset_: has_collection_view__dragging_image_for_items_at_indexes__with_event__offset_
--		local
--			result_pointer: POINTER
--			a_collection_view__item: POINTER
--			a_indexes__item: POINTER
--			a_event__item: POINTER
--			a_drag_image_offset__item: POINTER
--		do
--			if attached a_collection_view as a_collection_view_attached then
--				a_collection_view__item := a_collection_view_attached.item
--			end
--			if attached a_indexes as a_indexes_attached then
--				a_indexes__item := a_indexes_attached.item
--			end
--			if attached a_event as a_event_attached then
--				a_event__item := a_event_attached.item
--			end
--			if attached a_drag_image_offset as a_drag_image_offset_attached then
--				a_drag_image_offset__item := a_drag_image_offset_attached.item
--			end
--			result_pointer := objc_collection_view__dragging_image_for_items_at_indexes__with_event__offset_ (item, a_collection_view__item, a_indexes__item, a_event__item, a_drag_image_offset__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like collection_view__dragging_image_for_items_at_indexes__with_event__offset_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like collection_view__dragging_image_for_items_at_indexes__with_event__offset_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	collection_view__validate_drop__proposed_index__drop_operation_ (a_collection_view: detachable NS_COLLECTION_VIEW; a_dragging_info: detachable NS_DRAGGING_INFO_PROTOCOL; a_proposed_drop_index: UNSUPPORTED_TYPE; a_proposed_drop_operation: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		require
--			has_collection_view__validate_drop__proposed_index__drop_operation_: has_collection_view__validate_drop__proposed_index__drop_operation_
--		local
--			a_collection_view__item: POINTER
--			a_dragging_info__item: POINTER
--			a_proposed_drop_index__item: POINTER
--			a_proposed_drop_operation__item: POINTER
--		do
--			if attached a_collection_view as a_collection_view_attached then
--				a_collection_view__item := a_collection_view_attached.item
--			end
--			if attached a_dragging_info as a_dragging_info_attached then
--				a_dragging_info__item := a_dragging_info_attached.item
--			end
--			if attached a_proposed_drop_index as a_proposed_drop_index_attached then
--				a_proposed_drop_index__item := a_proposed_drop_index_attached.item
--			end
--			if attached a_proposed_drop_operation as a_proposed_drop_operation_attached then
--				a_proposed_drop_operation__item := a_proposed_drop_operation_attached.item
--			end
--			Result := objc_collection_view__validate_drop__proposed_index__drop_operation_ (item, a_collection_view__item, a_dragging_info__item, a_proposed_drop_index__item, a_proposed_drop_operation__item)
--		end

	collection_view__accept_drop__index__drop_operation_ (a_collection_view: detachable NS_COLLECTION_VIEW; a_dragging_info: detachable NS_DRAGGING_INFO_PROTOCOL; a_index: INTEGER_64; a_drop_operation: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_collection_view__accept_drop__index__drop_operation_: has_collection_view__accept_drop__index__drop_operation_
		local
			a_collection_view__item: POINTER
			a_dragging_info__item: POINTER
		do
			if attached a_collection_view as a_collection_view_attached then
				a_collection_view__item := a_collection_view_attached.item
			end
			if attached a_dragging_info as a_dragging_info_attached then
				a_dragging_info__item := a_dragging_info_attached.item
			end
			Result := objc_collection_view__accept_drop__index__drop_operation_ (item, a_collection_view__item, a_dragging_info__item, a_index, a_drop_operation)
		end

feature -- Status Report

	has_collection_view__can_drag_items_at_indexes__with_event_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_collection_view__can_drag_items_at_indexes__with_event_ (item)
		end

	has_collection_view__write_items_at_indexes__to_pasteboard_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_collection_view__write_items_at_indexes__to_pasteboard_ (item)
		end

	has_collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_ (item)
		end

--	has_collection_view__dragging_image_for_items_at_indexes__with_event__offset_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_collection_view__dragging_image_for_items_at_indexes__with_event__offset_ (item)
--		end

--	has_collection_view__validate_drop__proposed_index__drop_operation_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_collection_view__validate_drop__proposed_index__drop_operation_ (item)
--		end

	has_collection_view__accept_drop__index__drop_operation_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_collection_view__accept_drop__index__drop_operation_ (item)
		end

feature -- Status Report Externals

	objc_has_collection_view__can_drag_items_at_indexes__with_event_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(collectionView:canDragItemsAtIndexes:withEvent:)];
			 ]"
		end

	objc_has_collection_view__write_items_at_indexes__to_pasteboard_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(collectionView:writeItemsAtIndexes:toPasteboard:)];
			 ]"
		end

	objc_has_collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(collectionView:namesOfPromisedFilesDroppedAtDestination:forDraggedItemsAtIndexes:)];
			 ]"
		end

--	objc_has_collection_view__dragging_image_for_items_at_indexes__with_event__offset_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(collectionView:draggingImageForItemsAtIndexes:withEvent:offset:)];
--			 ]"
--		end

--	objc_has_collection_view__validate_drop__proposed_index__drop_operation_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(collectionView:validateDrop:proposedIndex:dropOperation:)];
--			 ]"
--		end

	objc_has_collection_view__accept_drop__index__drop_operation_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(collectionView:acceptDrop:index:dropOperation:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_collection_view__can_drag_items_at_indexes__with_event_ (an_item: POINTER; a_collection_view: POINTER; a_indexes: POINTER; a_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSCollectionViewDelegate>)$an_item collectionView:$a_collection_view canDragItemsAtIndexes:$a_indexes withEvent:$a_event];
			 ]"
		end

	objc_collection_view__write_items_at_indexes__to_pasteboard_ (an_item: POINTER; a_collection_view: POINTER; a_indexes: POINTER; a_pasteboard: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSCollectionViewDelegate>)$an_item collectionView:$a_collection_view writeItemsAtIndexes:$a_indexes toPasteboard:$a_pasteboard];
			 ]"
		end

	objc_collection_view__names_of_promised_files_dropped_at_destination__for_dragged_items_at_indexes_ (an_item: POINTER; a_collection_view: POINTER; a_drop_url: POINTER; a_indexes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSCollectionViewDelegate>)$an_item collectionView:$a_collection_view namesOfPromisedFilesDroppedAtDestination:$a_drop_url forDraggedItemsAtIndexes:$a_indexes];
			 ]"
		end

--	objc_collection_view__dragging_image_for_items_at_indexes__with_event__offset_ (an_item: POINTER; a_collection_view: POINTER; a_indexes: POINTER; a_event: POINTER; a_drag_image_offset: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSCollectionViewDelegate>)$an_item collectionView:$a_collection_view draggingImageForItemsAtIndexes:$a_indexes withEvent:$a_event offset:];
--			 ]"
--		end

--	objc_collection_view__validate_drop__proposed_index__drop_operation_ (an_item: POINTER; a_collection_view: POINTER; a_dragging_info: POINTER; a_proposed_drop_index: UNSUPPORTED_TYPE; a_proposed_drop_operation: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id <NSCollectionViewDelegate>)$an_item collectionView:$a_collection_view validateDrop:$a_dragging_info proposedIndex: dropOperation:];
--			 ]"
--		end

	objc_collection_view__accept_drop__index__drop_operation_ (an_item: POINTER; a_collection_view: POINTER; a_dragging_info: POINTER; a_index: INTEGER_64; a_drop_operation: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSCollectionViewDelegate>)$an_item collectionView:$a_collection_view acceptDrop:$a_dragging_info index:$a_index dropOperation:$a_drop_operation];
			 ]"
		end

end
