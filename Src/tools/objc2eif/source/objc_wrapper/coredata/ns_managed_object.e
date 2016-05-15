note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MANAGED_OBJECT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_entity__insert_into_managed_object_context_,
	make

feature {NONE} -- Initialization

	make_with_entity__insert_into_managed_object_context_ (a_entity: detachable NS_ENTITY_DESCRIPTION; a_context: detachable NS_MANAGED_OBJECT_CONTEXT)
			-- Initialize `Current'.
		local
			a_entity__item: POINTER
			a_context__item: POINTER
		do
			if attached a_entity as a_entity_attached then
				a_entity__item := a_entity_attached.item
			end
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			make_with_pointer (objc_init_with_entity__insert_into_managed_object_context_(allocate_object, a_entity__item, a_context__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSManagedObject Externals

	objc_init_with_entity__insert_into_managed_object_context_ (an_item: POINTER; a_entity: POINTER; a_context: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObject *)$an_item initWithEntity:$a_entity insertIntoManagedObjectContext:$a_context];
			 ]"
		end

	objc_managed_object_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObject *)$an_item managedObjectContext];
			 ]"
		end

	objc_entity (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObject *)$an_item entity];
			 ]"
		end

	objc_object_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObject *)$an_item objectID];
			 ]"
		end

	objc_is_inserted (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObject *)$an_item isInserted];
			 ]"
		end

	objc_is_updated (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObject *)$an_item isUpdated];
			 ]"
		end

	objc_is_deleted (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObject *)$an_item isDeleted];
			 ]"
		end

	objc_is_fault (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObject *)$an_item isFault];
			 ]"
		end

	objc_has_fault_for_relationship_named_ (an_item: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObject *)$an_item hasFaultForRelationshipNamed:$a_key];
			 ]"
		end

	objc_faulting_state (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObject *)$an_item faultingState];
			 ]"
		end

	objc_will_access_value_for_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item willAccessValueForKey:$a_key];
			 ]"
		end

	objc_did_access_value_for_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item didAccessValueForKey:$a_key];
			 ]"
		end

	objc_awake_from_fetch (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item awakeFromFetch];
			 ]"
		end

	objc_awake_from_insert (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item awakeFromInsert];
			 ]"
		end

	objc_awake_from_snapshot_events_ (an_item: POINTER; a_flags: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item awakeFromSnapshotEvents:$a_flags];
			 ]"
		end

	objc_prepare_for_deletion (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item prepareForDeletion];
			 ]"
		end

	objc_will_save (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item willSave];
			 ]"
		end

	objc_did_save (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item didSave];
			 ]"
		end

	objc_will_turn_into_fault (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item willTurnIntoFault];
			 ]"
		end

	objc_did_turn_into_fault (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item didTurnIntoFault];
			 ]"
		end

	objc_primitive_value_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObject *)$an_item primitiveValueForKey:$a_key];
			 ]"
		end

	objc_set_primitive_value__for_key_ (an_item: POINTER; a_value: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObject *)$an_item setPrimitiveValue:$a_value forKey:$a_key];
			 ]"
		end

	objc_committed_values_for_keys_ (an_item: POINTER; a_keys: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObject *)$an_item committedValuesForKeys:$a_keys];
			 ]"
		end

	objc_changed_values (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObject *)$an_item changedValues];
			 ]"
		end

--	objc_validate_for_delete_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSManagedObject *)$an_item validateForDelete:];
--			 ]"
--		end

--	objc_validate_for_insert_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSManagedObject *)$an_item validateForInsert:];
--			 ]"
--		end

--	objc_validate_for_update_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSManagedObject *)$an_item validateForUpdate:];
--			 ]"
--		end

feature -- NSManagedObject

	managed_object_context: detachable NS_MANAGED_OBJECT_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_managed_object_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like managed_object_context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like managed_object_context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	entity: detachable NS_ENTITY_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_entity (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entity} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entity} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	object_id: detachable NS_MANAGED_OBJECT_ID
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_id (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_id} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_id} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_inserted: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_inserted (item)
		end

	is_updated: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_updated (item)
		end

	is_deleted: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_deleted (item)
		end

	is_fault: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_fault (item)
		end

	has_fault_for_relationship_named_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_has_fault_for_relationship_named_ (item, a_key__item)
		end

	faulting_state: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_faulting_state (item)
		end

	will_access_value_for_key_ (a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_will_access_value_for_key_ (item, a_key__item)
		end

	did_access_value_for_key_ (a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_did_access_value_for_key_ (item, a_key__item)
		end

	awake_from_fetch
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_awake_from_fetch (item)
		end

	awake_from_insert
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_awake_from_insert (item)
		end

	awake_from_snapshot_events_ (a_flags: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_awake_from_snapshot_events_ (item, a_flags)
		end

	prepare_for_deletion
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_prepare_for_deletion (item)
		end

	will_save
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_will_save (item)
		end

	did_save
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_did_save (item)
		end

	will_turn_into_fault
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_will_turn_into_fault (item)
		end

	did_turn_into_fault
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_did_turn_into_fault (item)
		end

	primitive_value_for_key_ (a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_primitive_value_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like primitive_value_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like primitive_value_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_primitive_value__for_key_ (a_value: detachable NS_OBJECT; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_key__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_primitive_value__for_key_ (item, a_value__item, a_key__item)
		end

	committed_values_for_keys_ (a_keys: detachable NS_ARRAY): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_keys__item: POINTER
		do
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			result_pointer := objc_committed_values_for_keys_ (item, a_keys__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like committed_values_for_keys_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like committed_values_for_keys_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	changed_values: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_changed_values (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like changed_values} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like changed_values} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	validate_for_delete_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_validate_for_delete_ (item, a_error__item)
--		end

--	validate_for_insert_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_validate_for_insert_ (item, a_error__item)
--		end

--	validate_for_update_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_validate_for_update_ (item, a_error__item)
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSManagedObject"
		end

end
