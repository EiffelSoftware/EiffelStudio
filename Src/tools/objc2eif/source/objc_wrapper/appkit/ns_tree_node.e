note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TREE_NODE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_represented_object_,
	make

feature {NONE} -- Initialization

	make_with_represented_object_ (a_model_object: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_model_object__item: POINTER
		do
			if attached a_model_object as a_model_object_attached then
				a_model_object__item := a_model_object_attached.item
			end
			make_with_pointer (objc_init_with_represented_object_(allocate_object, a_model_object__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTreeNode Externals

	objc_init_with_represented_object_ (an_item: POINTER; a_model_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeNode *)$an_item initWithRepresentedObject:$a_model_object];
			 ]"
		end

	objc_represented_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeNode *)$an_item representedObject];
			 ]"
		end

	objc_index_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeNode *)$an_item indexPath];
			 ]"
		end

	objc_is_leaf (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTreeNode *)$an_item isLeaf];
			 ]"
		end

	objc_child_nodes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeNode *)$an_item childNodes];
			 ]"
		end

	objc_mutable_child_nodes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeNode *)$an_item mutableChildNodes];
			 ]"
		end

	objc_descendant_node_at_index_path_ (an_item: POINTER; a_index_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeNode *)$an_item descendantNodeAtIndexPath:$a_index_path];
			 ]"
		end

	objc_parent_node (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTreeNode *)$an_item parentNode];
			 ]"
		end

	objc_sort_with_sort_descriptors__recursively_ (an_item: POINTER; a_sort_descriptors: POINTER; a_recursively: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTreeNode *)$an_item sortWithSortDescriptors:$a_sort_descriptors recursively:$a_recursively];
			 ]"
		end

feature -- NSTreeNode

	represented_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_represented_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like represented_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like represented_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index_path: detachable NS_INDEX_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_index_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like index_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like index_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_leaf: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_leaf (item)
		end

	child_nodes: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_child_nodes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like child_nodes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like child_nodes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mutable_child_nodes: detachable NS_MUTABLE_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mutable_child_nodes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mutable_child_nodes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mutable_child_nodes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	descendant_node_at_index_path_ (a_index_path: detachable NS_INDEX_PATH): detachable NS_TREE_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_index_path__item: POINTER
		do
			if attached a_index_path as a_index_path_attached then
				a_index_path__item := a_index_path_attached.item
			end
			result_pointer := objc_descendant_node_at_index_path_ (item, a_index_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like descendant_node_at_index_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like descendant_node_at_index_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	parent_node: detachable NS_TREE_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_parent_node (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parent_node} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parent_node} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	sort_with_sort_descriptors__recursively_ (a_sort_descriptors: detachable NS_ARRAY; a_recursively: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_sort_descriptors__item: POINTER
		do
			if attached a_sort_descriptors as a_sort_descriptors_attached then
				a_sort_descriptors__item := a_sort_descriptors_attached.item
			end
			objc_sort_with_sort_descriptors__recursively_ (item, a_sort_descriptors__item, a_recursively)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTreeNode"
		end

end
