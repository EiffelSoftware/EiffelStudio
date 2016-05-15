note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ARRAY_CONTROLLER

inherit
	NS_OBJECT_CONTROLLER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_content_,
	make

feature -- NSArrayController

	rearrange_objects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_rearrange_objects (item)
		end

	set_automatically_rearranges_objects_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_automatically_rearranges_objects_ (item, a_flag)
		end

	automatically_rearranges_objects: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_automatically_rearranges_objects (item)
		end

	automatic_rearrangement_key_paths: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_automatic_rearrangement_key_paths (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like automatic_rearrangement_key_paths} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like automatic_rearrangement_key_paths} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	did_change_arrangement_criteria
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_did_change_arrangement_criteria (item)
		end

	set_sort_descriptors_ (a_sort_descriptors: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_sort_descriptors__item: POINTER
		do
			if attached a_sort_descriptors as a_sort_descriptors_attached then
				a_sort_descriptors__item := a_sort_descriptors_attached.item
			end
			objc_set_sort_descriptors_ (item, a_sort_descriptors__item)
		end

	sort_descriptors: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_sort_descriptors (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sort_descriptors} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sort_descriptors} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_filter_predicate_ (a_filter_predicate: detachable NS_PREDICATE)
			-- Auto generated Objective-C wrapper.
		local
			a_filter_predicate__item: POINTER
		do
			if attached a_filter_predicate as a_filter_predicate_attached then
				a_filter_predicate__item := a_filter_predicate_attached.item
			end
			objc_set_filter_predicate_ (item, a_filter_predicate__item)
		end

	filter_predicate: detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_filter_predicate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like filter_predicate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like filter_predicate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_clears_filter_predicate_on_insertion_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_clears_filter_predicate_on_insertion_ (item, a_flag)
		end

	clears_filter_predicate_on_insertion: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_clears_filter_predicate_on_insertion (item)
		end

	arrange_objects_ (a_objects: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_objects__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			result_pointer := objc_arrange_objects_ (item, a_objects__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like arrange_objects_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like arrange_objects_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	arranged_objects: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_arranged_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like arranged_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like arranged_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_avoids_empty_selection_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_avoids_empty_selection_ (item, a_flag)
		end

	avoids_empty_selection: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_avoids_empty_selection (item)
		end

	set_preserves_selection_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_preserves_selection_ (item, a_flag)
		end

	preserves_selection: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_preserves_selection (item)
		end

	set_selects_inserted_objects_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selects_inserted_objects_ (item, a_flag)
		end

	selects_inserted_objects: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selects_inserted_objects (item)
		end

	set_always_uses_multiple_values_marker_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_always_uses_multiple_values_marker_ (item, a_flag)
		end

	always_uses_multiple_values_marker: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_always_uses_multiple_values_marker (item)
		end

	set_selection_indexes_ (a_indexes: detachable NS_INDEX_SET): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			Result := objc_set_selection_indexes_ (item, a_indexes__item)
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

	set_selection_index_ (a_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_set_selection_index_ (item, a_index)
		end

	selection_index: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selection_index (item)
		end

	add_selection_indexes_ (a_indexes: detachable NS_INDEX_SET): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			Result := objc_add_selection_indexes_ (item, a_indexes__item)
		end

	remove_selection_indexes_ (a_indexes: detachable NS_INDEX_SET): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			Result := objc_remove_selection_indexes_ (item, a_indexes__item)
		end

	set_selected_objects_ (a_objects: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			Result := objc_set_selected_objects_ (item, a_objects__item)
		end

	add_selected_objects_ (a_objects: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			Result := objc_add_selected_objects_ (item, a_objects__item)
		end

	remove_selected_objects_ (a_objects: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			Result := objc_remove_selected_objects_ (item, a_objects__item)
		end

	insert_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_ (item, a_sender__item)
		end

	can_insert: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_insert (item)
		end

	select_next_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_next_ (item, a_sender__item)
		end

	select_previous_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_previous_ (item, a_sender__item)
		end

	can_select_next: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_select_next (item)
		end

	can_select_previous: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_select_previous (item)
		end

	add_objects_ (a_objects: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			objc_add_objects_ (item, a_objects__item)
		end

	insert_object__at_arranged_object_index_ (a_object: detachable NS_OBJECT; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_insert_object__at_arranged_object_index_ (item, a_object__item, a_index)
		end

	insert_objects__at_arranged_object_indexes_ (a_objects: detachable NS_ARRAY; a_indexes: detachable NS_INDEX_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
			a_indexes__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			objc_insert_objects__at_arranged_object_indexes_ (item, a_objects__item, a_indexes__item)
		end

	remove_object_at_arranged_object_index_ (a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_object_at_arranged_object_index_ (item, a_index)
		end

	remove_objects_at_arranged_object_indexes_ (a_indexes: detachable NS_INDEX_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			objc_remove_objects_at_arranged_object_indexes_ (item, a_indexes__item)
		end

	remove_objects_ (a_objects: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			objc_remove_objects_ (item, a_objects__item)
		end

feature {NONE} -- NSArrayController Externals

	objc_rearrange_objects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item rearrangeObjects];
			 ]"
		end

	objc_set_automatically_rearranges_objects_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item setAutomaticallyRearrangesObjects:$a_flag];
			 ]"
		end

	objc_automatically_rearranges_objects (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item automaticallyRearrangesObjects];
			 ]"
		end

	objc_automatic_rearrangement_key_paths (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArrayController *)$an_item automaticRearrangementKeyPaths];
			 ]"
		end

	objc_did_change_arrangement_criteria (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item didChangeArrangementCriteria];
			 ]"
		end

	objc_set_sort_descriptors_ (an_item: POINTER; a_sort_descriptors: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item setSortDescriptors:$a_sort_descriptors];
			 ]"
		end

	objc_sort_descriptors (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArrayController *)$an_item sortDescriptors];
			 ]"
		end

	objc_set_filter_predicate_ (an_item: POINTER; a_filter_predicate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item setFilterPredicate:$a_filter_predicate];
			 ]"
		end

	objc_filter_predicate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArrayController *)$an_item filterPredicate];
			 ]"
		end

	objc_set_clears_filter_predicate_on_insertion_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item setClearsFilterPredicateOnInsertion:$a_flag];
			 ]"
		end

	objc_clears_filter_predicate_on_insertion (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item clearsFilterPredicateOnInsertion];
			 ]"
		end

	objc_arrange_objects_ (an_item: POINTER; a_objects: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArrayController *)$an_item arrangeObjects:$a_objects];
			 ]"
		end

	objc_arranged_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArrayController *)$an_item arrangedObjects];
			 ]"
		end

	objc_set_avoids_empty_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item setAvoidsEmptySelection:$a_flag];
			 ]"
		end

	objc_avoids_empty_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item avoidsEmptySelection];
			 ]"
		end

	objc_set_preserves_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item setPreservesSelection:$a_flag];
			 ]"
		end

	objc_preserves_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item preservesSelection];
			 ]"
		end

	objc_set_selects_inserted_objects_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item setSelectsInsertedObjects:$a_flag];
			 ]"
		end

	objc_selects_inserted_objects (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item selectsInsertedObjects];
			 ]"
		end

	objc_set_always_uses_multiple_values_marker_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item setAlwaysUsesMultipleValuesMarker:$a_flag];
			 ]"
		end

	objc_always_uses_multiple_values_marker (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item alwaysUsesMultipleValuesMarker];
			 ]"
		end

	objc_set_selection_indexes_ (an_item: POINTER; a_indexes: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item setSelectionIndexes:$a_indexes];
			 ]"
		end

	objc_selection_indexes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArrayController *)$an_item selectionIndexes];
			 ]"
		end

	objc_set_selection_index_ (an_item: POINTER; a_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item setSelectionIndex:$a_index];
			 ]"
		end

	objc_selection_index (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item selectionIndex];
			 ]"
		end

	objc_add_selection_indexes_ (an_item: POINTER; a_indexes: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item addSelectionIndexes:$a_indexes];
			 ]"
		end

	objc_remove_selection_indexes_ (an_item: POINTER; a_indexes: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item removeSelectionIndexes:$a_indexes];
			 ]"
		end

	objc_set_selected_objects_ (an_item: POINTER; a_objects: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item setSelectedObjects:$a_objects];
			 ]"
		end

	objc_add_selected_objects_ (an_item: POINTER; a_objects: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item addSelectedObjects:$a_objects];
			 ]"
		end

	objc_remove_selected_objects_ (an_item: POINTER; a_objects: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item removeSelectedObjects:$a_objects];
			 ]"
		end

	objc_insert_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item insert:$a_sender];
			 ]"
		end

	objc_can_insert (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item canInsert];
			 ]"
		end

	objc_select_next_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item selectNext:$a_sender];
			 ]"
		end

	objc_select_previous_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item selectPrevious:$a_sender];
			 ]"
		end

	objc_can_select_next (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item canSelectNext];
			 ]"
		end

	objc_can_select_previous (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSArrayController *)$an_item canSelectPrevious];
			 ]"
		end

	objc_add_objects_ (an_item: POINTER; a_objects: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item addObjects:$a_objects];
			 ]"
		end

	objc_insert_object__at_arranged_object_index_ (an_item: POINTER; a_object: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item insertObject:$a_object atArrangedObjectIndex:$a_index];
			 ]"
		end

	objc_insert_objects__at_arranged_object_indexes_ (an_item: POINTER; a_objects: POINTER; a_indexes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item insertObjects:$a_objects atArrangedObjectIndexes:$a_indexes];
			 ]"
		end

	objc_remove_object_at_arranged_object_index_ (an_item: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item removeObjectAtArrangedObjectIndex:$a_index];
			 ]"
		end

	objc_remove_objects_at_arranged_object_indexes_ (an_item: POINTER; a_indexes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item removeObjectsAtArrangedObjectIndexes:$a_indexes];
			 ]"
		end

	objc_remove_objects_ (an_item: POINTER; a_objects: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSArrayController *)$an_item removeObjects:$a_objects];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSArrayController"
		end

end
