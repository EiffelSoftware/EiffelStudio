note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLLECTION_VIEW

inherit
	NS_VIEW
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSCollectionView

	set_delegate_ (a_delegate: detachable NS_COLLECTION_VIEW_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_COLLECTION_VIEW_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_first_responder: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_first_responder (item)
		end

	set_content_ (a_content: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_content__item: POINTER
		do
			if attached a_content as a_content_attached then
				a_content__item := a_content_attached.item
			end
			objc_set_content_ (item, a_content__item)
		end

	content: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_content (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like content} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like content} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selectable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selectable_ (item, a_flag)
		end

	is_selectable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_selectable (item)
		end

	set_allows_multiple_selection_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_multiple_selection_ (item, a_flag)
		end

	allows_multiple_selection: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_multiple_selection (item)
		end

	set_selection_indexes_ (a_indexes: detachable NS_INDEX_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			objc_set_selection_indexes_ (item, a_indexes__item)
		end

	selection_indexes: detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selection_indexes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selection_indexes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selection_indexes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	new_item_for_represented_object_ (a_object: detachable NS_OBJECT): detachable NS_COLLECTION_VIEW_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			result_pointer := objc_new_item_for_represented_object_ (item, a_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like new_item_for_represented_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like new_item_for_represented_object_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_item_prototype_ (a_prototype: detachable NS_COLLECTION_VIEW_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_prototype__item: POINTER
		do
			if attached a_prototype as a_prototype_attached then
				a_prototype__item := a_prototype_attached.item
			end
			objc_set_item_prototype_ (item, a_prototype__item)
		end

	item_prototype: detachable NS_COLLECTION_VIEW_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_prototype (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_prototype} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_prototype} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_max_number_of_rows_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_number_of_rows_ (item, a_number)
		end

	max_number_of_rows: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_number_of_rows (item)
		end

	set_max_number_of_columns_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_number_of_columns_ (item, a_number)
		end

	max_number_of_columns: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_number_of_columns (item)
		end

	set_min_item_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_item_size_ (item, a_size.item)
		end

	min_item_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_min_item_size (item, Result.item)
		end

	set_max_item_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_item_size_ (item, a_size.item)
		end

	max_item_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_max_item_size (item, Result.item)
		end

	set_background_colors_ (a_colors: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_colors__item: POINTER
		do
			if attached a_colors as a_colors_attached then
				a_colors__item := a_colors_attached.item
			end
			objc_set_background_colors_ (item, a_colors__item)
		end

	background_colors: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_colors (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_colors} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_colors} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	item_at_index_ (a_index: NATURAL_64): detachable NS_COLLECTION_VIEW_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_at_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	frame_for_item_at_index_ (a_index: NATURAL_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame_for_item_at_index_ (item, Result.item, a_index)
		end

	set_dragging_source_operation_mask__for_local_ (a_drag_operation_mask: NATURAL_64; a_local_destination: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_dragging_source_operation_mask__for_local_ (item, a_drag_operation_mask, a_local_destination)
		end

--	dragging_image_for_items_at_indexes__with_event__offset_ (a_indexes: detachable NS_INDEX_SET; a_event: detachable NS_EVENT; a_drag_image_offset: UNSUPPORTED_TYPE): detachable NS_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_indexes__item: POINTER
--			a_event__item: POINTER
--			a_drag_image_offset__item: POINTER
--		do
--			if attached a_indexes as a_indexes_attached then
--				a_indexes__item := a_indexes_attached.item
--			end
--			if attached a_event as a_event_attached then
--				a_event__item := a_event_attached.item
--			end
--			if attached a_drag_image_offset as a_drag_image_offset_attached then
--				a_drag_image_offset__item := a_drag_image_offset_attached.item
--			end
--			result_pointer := objc_dragging_image_for_items_at_indexes__with_event__offset_ (item, a_indexes__item, a_event__item, a_drag_image_offset__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like dragging_image_for_items_at_indexes__with_event__offset_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like dragging_image_for_items_at_indexes__with_event__offset_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSCollectionView Externals

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCollectionView *)$an_item delegate];
			 ]"
		end

	objc_is_first_responder (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCollectionView *)$an_item isFirstResponder];
			 ]"
		end

	objc_set_content_ (an_item: POINTER; a_content: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setContent:$a_content];
			 ]"
		end

	objc_content (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCollectionView *)$an_item content];
			 ]"
		end

	objc_set_selectable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setSelectable:$a_flag];
			 ]"
		end

	objc_is_selectable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCollectionView *)$an_item isSelectable];
			 ]"
		end

	objc_set_allows_multiple_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setAllowsMultipleSelection:$a_flag];
			 ]"
		end

	objc_allows_multiple_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCollectionView *)$an_item allowsMultipleSelection];
			 ]"
		end

	objc_set_selection_indexes_ (an_item: POINTER; a_indexes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setSelectionIndexes:$a_indexes];
			 ]"
		end

	objc_selection_indexes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCollectionView *)$an_item selectionIndexes];
			 ]"
		end

	objc_new_item_for_represented_object_ (an_item: POINTER; a_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCollectionView *)$an_item newItemForRepresentedObject:$a_object];
			 ]"
		end

	objc_set_item_prototype_ (an_item: POINTER; a_prototype: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setItemPrototype:$a_prototype];
			 ]"
		end

	objc_item_prototype (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCollectionView *)$an_item itemPrototype];
			 ]"
		end

	objc_set_max_number_of_rows_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setMaxNumberOfRows:$a_number];
			 ]"
		end

	objc_max_number_of_rows (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCollectionView *)$an_item maxNumberOfRows];
			 ]"
		end

	objc_set_max_number_of_columns_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setMaxNumberOfColumns:$a_number];
			 ]"
		end

	objc_max_number_of_columns (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCollectionView *)$an_item maxNumberOfColumns];
			 ]"
		end

	objc_set_min_item_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setMinItemSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_min_item_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSCollectionView *)$an_item minItemSize];
			 ]"
		end

	objc_set_max_item_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setMaxItemSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_max_item_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSCollectionView *)$an_item maxItemSize];
			 ]"
		end

	objc_set_background_colors_ (an_item: POINTER; a_colors: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setBackgroundColors:$a_colors];
			 ]"
		end

	objc_background_colors (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCollectionView *)$an_item backgroundColors];
			 ]"
		end

	objc_item_at_index_ (an_item: POINTER; a_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCollectionView *)$an_item itemAtIndex:$a_index];
			 ]"
		end

	objc_frame_for_item_at_index_ (an_item: POINTER; result_pointer: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSCollectionView *)$an_item frameForItemAtIndex:$a_index];
			 ]"
		end

	objc_set_dragging_source_operation_mask__for_local_ (an_item: POINTER; a_drag_operation_mask: NATURAL_64; a_local_destination: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionView *)$an_item setDraggingSourceOperationMask:$a_drag_operation_mask forLocal:$a_local_destination];
			 ]"
		end

--	objc_dragging_image_for_items_at_indexes__with_event__offset_ (an_item: POINTER; a_indexes: POINTER; a_event: POINTER; a_drag_image_offset: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSCollectionView *)$an_item draggingImageForItemsAtIndexes:$a_indexes withEvent:$a_event offset:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCollectionView"
		end

end
