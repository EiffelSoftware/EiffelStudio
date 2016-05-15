note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ATOMIC_STORE

inherit
	NS_PERSISTENT_STORE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_persistent_store_coordinator__configuration_name__ur_l__options_,
	make

feature -- NSAtomicStore

--	load_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_load_ (item, a_error__item)
--		end

--	save_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_save_ (item, a_error__item)
--		end

	new_cache_node_for_managed_object_ (a_managed_object: detachable NS_MANAGED_OBJECT): detachable NS_ATOMIC_STORE_CACHE_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_managed_object__item: POINTER
		do
			if attached a_managed_object as a_managed_object_attached then
				a_managed_object__item := a_managed_object_attached.item
			end
			result_pointer := objc_new_cache_node_for_managed_object_ (item, a_managed_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like new_cache_node_for_managed_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like new_cache_node_for_managed_object_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	update_cache_node__from_managed_object_ (a_node: detachable NS_ATOMIC_STORE_CACHE_NODE; a_managed_object: detachable NS_MANAGED_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_node__item: POINTER
			a_managed_object__item: POINTER
		do
			if attached a_node as a_node_attached then
				a_node__item := a_node_attached.item
			end
			if attached a_managed_object as a_managed_object_attached then
				a_managed_object__item := a_managed_object_attached.item
			end
			objc_update_cache_node__from_managed_object_ (item, a_node__item, a_managed_object__item)
		end

	cache_nodes: detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cache_nodes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cache_nodes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cache_nodes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_cache_nodes_ (a_cache_nodes: detachable NS_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_cache_nodes__item: POINTER
		do
			if attached a_cache_nodes as a_cache_nodes_attached then
				a_cache_nodes__item := a_cache_nodes_attached.item
			end
			objc_add_cache_nodes_ (item, a_cache_nodes__item)
		end

	will_remove_cache_nodes_ (a_cache_nodes: detachable NS_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_cache_nodes__item: POINTER
		do
			if attached a_cache_nodes as a_cache_nodes_attached then
				a_cache_nodes__item := a_cache_nodes_attached.item
			end
			objc_will_remove_cache_nodes_ (item, a_cache_nodes__item)
		end

	cache_node_for_object_i_d_ (a_object_id: detachable NS_MANAGED_OBJECT_ID): detachable NS_ATOMIC_STORE_CACHE_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_object_id__item: POINTER
		do
			if attached a_object_id as a_object_id_attached then
				a_object_id__item := a_object_id_attached.item
			end
			result_pointer := objc_cache_node_for_object_i_d_ (item, a_object_id__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cache_node_for_object_i_d_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cache_node_for_object_i_d_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	object_id_for_entity__reference_object_ (a_entity: detachable NS_ENTITY_DESCRIPTION; a_data: detachable NS_OBJECT): detachable NS_MANAGED_OBJECT_ID
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_entity__item: POINTER
			a_data__item: POINTER
		do
			if attached a_entity as a_entity_attached then
				a_entity__item := a_entity_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			result_pointer := objc_object_id_for_entity__reference_object_ (item, a_entity__item, a_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_id_for_entity__reference_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_id_for_entity__reference_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	new_reference_object_for_managed_object_ (a_managed_object: detachable NS_MANAGED_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_managed_object__item: POINTER
		do
			if attached a_managed_object as a_managed_object_attached then
				a_managed_object__item := a_managed_object_attached.item
			end
			result_pointer := objc_new_reference_object_for_managed_object_ (item, a_managed_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like new_reference_object_for_managed_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like new_reference_object_for_managed_object_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	reference_object_for_object_i_d_ (a_object_id: detachable NS_MANAGED_OBJECT_ID): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_object_id__item: POINTER
		do
			if attached a_object_id as a_object_id_attached then
				a_object_id__item := a_object_id_attached.item
			end
			result_pointer := objc_reference_object_for_object_i_d_ (item, a_object_id__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like reference_object_for_object_i_d_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like reference_object_for_object_i_d_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSAtomicStore Externals

--	objc_load_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSAtomicStore *)$an_item load:];
--			 ]"
--		end

--	objc_save_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSAtomicStore *)$an_item save:];
--			 ]"
--		end

	objc_new_cache_node_for_managed_object_ (an_item: POINTER; a_managed_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAtomicStore *)$an_item newCacheNodeForManagedObject:$a_managed_object];
			 ]"
		end

	objc_update_cache_node__from_managed_object_ (an_item: POINTER; a_node: POINTER; a_managed_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSAtomicStore *)$an_item updateCacheNode:$a_node fromManagedObject:$a_managed_object];
			 ]"
		end

	objc_cache_nodes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAtomicStore *)$an_item cacheNodes];
			 ]"
		end

	objc_add_cache_nodes_ (an_item: POINTER; a_cache_nodes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSAtomicStore *)$an_item addCacheNodes:$a_cache_nodes];
			 ]"
		end

	objc_will_remove_cache_nodes_ (an_item: POINTER; a_cache_nodes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSAtomicStore *)$an_item willRemoveCacheNodes:$a_cache_nodes];
			 ]"
		end

	objc_cache_node_for_object_i_d_ (an_item: POINTER; a_object_id: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAtomicStore *)$an_item cacheNodeForObjectID:$a_object_id];
			 ]"
		end

	objc_object_id_for_entity__reference_object_ (an_item: POINTER; a_entity: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAtomicStore *)$an_item objectIDForEntity:$a_entity referenceObject:$a_data];
			 ]"
		end

	objc_new_reference_object_for_managed_object_ (an_item: POINTER; a_managed_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAtomicStore *)$an_item newReferenceObjectForManagedObject:$a_managed_object];
			 ]"
		end

	objc_reference_object_for_object_i_d_ (an_item: POINTER; a_object_id: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAtomicStore *)$an_item referenceObjectForObjectID:$a_object_id];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAtomicStore"
		end

end
