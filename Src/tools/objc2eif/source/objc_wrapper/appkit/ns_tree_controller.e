note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TREE_CONTROLLER

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

feature -- NSTreeController

	rearrange_objects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_rearrange_objects (item)
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

	set_children_key_path_ (a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_set_children_key_path_ (item, a_key_path__item)
		end

	children_key_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_children_key_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like children_key_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like children_key_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_count_key_path_ (a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_set_count_key_path_ (item, a_key_path__item)
		end

	count_key_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_count_key_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like count_key_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like count_key_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_leaf_key_path_ (a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_set_leaf_key_path_ (item, a_key_path__item)
		end

	leaf_key_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_leaf_key_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like leaf_key_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like leaf_key_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
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

	add_child_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_add_child_ (item, a_sender__item)
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

	insert_child_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_insert_child_ (item, a_sender__item)
		end

	can_insert: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_insert (item)
		end

	can_insert_child: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_insert_child (item)
		end

	can_add_child: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_add_child (item)
		end

	insert_object__at_arranged_object_index_path_ (a_object: detachable NS_OBJECT; a_index_path: detachable NS_INDEX_PATH)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
			a_index_path__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_index_path as a_index_path_attached then
				a_index_path__item := a_index_path_attached.item
			end
			objc_insert_object__at_arranged_object_index_path_ (item, a_object__item, a_index_path__item)
		end

	insert_objects__at_arranged_object_index_paths_ (a_objects: detachable NS_ARRAY; a_index_paths: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
			a_index_paths__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			if attached a_index_paths as a_index_paths_attached then
				a_index_paths__item := a_index_paths_attached.item
			end
			objc_insert_objects__at_arranged_object_index_paths_ (item, a_objects__item, a_index_paths__item)
		end

	remove_object_at_arranged_object_index_path_ (a_index_path: detachable NS_INDEX_PATH)
			-- Auto generated Objective-C wrapper.
		local
			a_index_path__item: POINTER
		do
			if attached a_index_path as a_index_path_attached then
				a_index_path__item := a_index_path_attached.item
			end
			objc_remove_object_at_arranged_object_index_path_ (item, a_index_path__item)
		end

	remove_objects_at_arranged_object_index_paths_ (a_index_paths: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_index_paths__item: POINTER
		do
			if attached a_index_paths as a_index_paths_attached then
				a_index_paths__item := a_index_paths_attached.item
			end
			objc_remove_objects_at_arranged_object_index_paths_ (item, a_index_paths__item)
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

	set_selection_index_paths_ (a_index_paths: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_index_paths__item: POINTER
		do
			if attached a_index_paths as a_index_paths_attached then
				a_index_paths__item := a_index_paths_attached.item
			end
			Result := objc_set_selection_index_paths_ (item, a_index_paths__item)
		end

	selection_index_paths: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selection_index_paths (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selection_index_paths} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selection_index_paths} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selection_index_path_ (a_index_path: detachable NS_INDEX_PATH): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_index_path__item: POINTER
		do
			if attached a_index_path as a_index_path_attached then
				a_index_path__item := a_index_path_attached.item
			end
			Result := objc_set_selection_index_path_ (item, a_index_path__item)
		end

	selection_index_path: detachable NS_INDEX_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selection_index_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selection_index_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selection_index_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_selection_index_paths_ (a_index_paths: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_index_paths__item: POINTER
		do
			if attached a_index_paths as a_index_paths_attached then
				a_index_paths__item := a_index_paths_attached.item
			end
			Result := objc_add_selection_index_paths_ (item, a_index_paths__item)
		end

	remove_selection_index_paths_ (a_index_paths: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_index_paths__item: POINTER
		do
			if attached a_index_paths as a_index_paths_attached then
				a_index_paths__item := a_index_paths_attached.item
			end
			Result := objc_remove_selection_index_paths_ (item, a_index_paths__item)
		end

	selected_nodes: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_nodes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_nodes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_nodes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	move_node__to_index_path_ (a_node: detachable NS_TREE_NODE; a_index_path: detachable NS_INDEX_PATH)
			-- Auto generated Objective-C wrapper.
		local
			a_node__item: POINTER
			a_index_path__item: POINTER
		do
			if attached a_node as a_node_attached then
				a_node__item := a_node_attached.item
			end
			if attached a_index_path as a_index_path_attached then
				a_index_path__item := a_index_path_attached.item
			end
			objc_move_node__to_index_path_ (item, a_node__item, a_index_path__item)
		end

	move_nodes__to_index_path_ (a_nodes: detachable NS_ARRAY; a_starting_index_path: detachable NS_INDEX_PATH)
			-- Auto generated Objective-C wrapper.
		local
			a_nodes__item: POINTER
			a_starting_index_path__item: POINTER
		do
			if attached a_nodes as a_nodes_attached then
				a_nodes__item := a_nodes_attached.item
			end
			if attached a_starting_index_path as a_starting_index_path_attached then
				a_starting_index_path__item := a_starting_index_path_attached.item
			end
			objc_move_nodes__to_index_path_ (item, a_nodes__item, a_starting_index_path__item)
		end

	children_key_path_for_node_ (a_node: detachable NS_TREE_NODE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_node__item: POINTER
		do
			if attached a_node as a_node_attached then
				a_node__item := a_node_attached.item
			end
			result_pointer := objc_children_key_path_for_node_ (item, a_node__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like children_key_path_for_node_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like children_key_path_for_node_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	count_key_path_for_node_ (a_node: detachable NS_TREE_NODE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_node__item: POINTER
		do
			if attached a_node as a_node_attached then
				a_node__item := a_node_attached.item
			end
			result_pointer := objc_count_key_path_for_node_ (item, a_node__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like count_key_path_for_node_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like count_key_path_for_node_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	leaf_key_path_for_node_ (a_node: detachable NS_TREE_NODE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_node__item: POINTER
		do
			if attached a_node as a_node_attached then
				a_node__item := a_node_attached.item
			end
			result_pointer := objc_leaf_key_path_for_node_ (item, a_node__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like leaf_key_path_for_node_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like leaf_key_path_for_node_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSTreeController Externals

	objc_rearrange_objects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item rearrangeObjects];
			 ]"
		end

	objc_arranged_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item arrangedObjects];
			 ]"
		end

	objc_set_children_key_path_ (an_item: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item setChildrenKeyPath:$a_key_path];
			 ]"
		end

	objc_children_key_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item childrenKeyPath];
			 ]"
		end

	objc_set_count_key_path_ (an_item: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item setCountKeyPath:$a_key_path];
			 ]"
		end

	objc_count_key_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item countKeyPath];
			 ]"
		end

	objc_set_leaf_key_path_ (an_item: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item setLeafKeyPath:$a_key_path];
			 ]"
		end

	objc_leaf_key_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item leafKeyPath];
			 ]"
		end

	objc_set_sort_descriptors_ (an_item: POINTER; a_sort_descriptors: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item setSortDescriptors:$a_sort_descriptors];
			 ]"
		end

	objc_sort_descriptors (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item sortDescriptors];
			 ]"
		end

	objc_add_child_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item addChild:$a_sender];
			 ]"
		end

	objc_insert_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item insert:$a_sender];
			 ]"
		end

	objc_insert_child_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item insertChild:$a_sender];
			 ]"
		end

	objc_can_insert (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item canInsert];
			 ]"
		end

	objc_can_insert_child (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item canInsertChild];
			 ]"
		end

	objc_can_add_child (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item canAddChild];
			 ]"
		end

	objc_insert_object__at_arranged_object_index_path_ (an_item: POINTER; a_object: POINTER; a_index_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item insertObject:$a_object atArrangedObjectIndexPath:$a_index_path];
			 ]"
		end

	objc_insert_objects__at_arranged_object_index_paths_ (an_item: POINTER; a_objects: POINTER; a_index_paths: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item insertObjects:$a_objects atArrangedObjectIndexPaths:$a_index_paths];
			 ]"
		end

	objc_remove_object_at_arranged_object_index_path_ (an_item: POINTER; a_index_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item removeObjectAtArrangedObjectIndexPath:$a_index_path];
			 ]"
		end

	objc_remove_objects_at_arranged_object_index_paths_ (an_item: POINTER; a_index_paths: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item removeObjectsAtArrangedObjectIndexPaths:$a_index_paths];
			 ]"
		end

	objc_set_avoids_empty_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item setAvoidsEmptySelection:$a_flag];
			 ]"
		end

	objc_avoids_empty_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item avoidsEmptySelection];
			 ]"
		end

	objc_set_preserves_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item setPreservesSelection:$a_flag];
			 ]"
		end

	objc_preserves_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item preservesSelection];
			 ]"
		end

	objc_set_selects_inserted_objects_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item setSelectsInsertedObjects:$a_flag];
			 ]"
		end

	objc_selects_inserted_objects (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item selectsInsertedObjects];
			 ]"
		end

	objc_set_always_uses_multiple_values_marker_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item setAlwaysUsesMultipleValuesMarker:$a_flag];
			 ]"
		end

	objc_always_uses_multiple_values_marker (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item alwaysUsesMultipleValuesMarker];
			 ]"
		end

	objc_set_selection_index_paths_ (an_item: POINTER; a_index_paths: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item setSelectionIndexPaths:$a_index_paths];
			 ]"
		end

	objc_selection_index_paths (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item selectionIndexPaths];
			 ]"
		end

	objc_set_selection_index_path_ (an_item: POINTER; a_index_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item setSelectionIndexPath:$a_index_path];
			 ]"
		end

	objc_selection_index_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item selectionIndexPath];
			 ]"
		end

	objc_add_selection_index_paths_ (an_item: POINTER; a_index_paths: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item addSelectionIndexPaths:$a_index_paths];
			 ]"
		end

	objc_remove_selection_index_paths_ (an_item: POINTER; a_index_paths: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeController *)$an_item removeSelectionIndexPaths:$a_index_paths];
			 ]"
		end

	objc_selected_nodes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item selectedNodes];
			 ]"
		end

	objc_move_node__to_index_path_ (an_item: POINTER; a_node: POINTER; a_index_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item moveNode:$a_node toIndexPath:$a_index_path];
			 ]"
		end

	objc_move_nodes__to_index_path_ (an_item: POINTER; a_nodes: POINTER; a_starting_index_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeController *)$an_item moveNodes:$a_nodes toIndexPath:$a_starting_index_path];
			 ]"
		end

	objc_children_key_path_for_node_ (an_item: POINTER; a_node: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item childrenKeyPathForNode:$a_node];
			 ]"
		end

	objc_count_key_path_for_node_ (an_item: POINTER; a_node: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item countKeyPathForNode:$a_node];
			 ]"
		end

	objc_leaf_key_path_for_node_ (an_item: POINTER; a_node: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeController *)$an_item leafKeyPathForNode:$a_node];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTreeController"
		end

end
