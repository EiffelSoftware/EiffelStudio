note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MANAGED_OBJECT_CONTEXT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_LOCKING_PROTOCOL
		undefine
			lock,
			objc_lock,
			unlock,
			objc_unlock
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSManagedObjectContext

	set_persistent_store_coordinator_ (a_coordinator: detachable NS_PERSISTENT_STORE_COORDINATOR)
			-- Auto generated Objective-C wrapper.
		local
			a_coordinator__item: POINTER
		do
			if attached a_coordinator as a_coordinator_attached then
				a_coordinator__item := a_coordinator_attached.item
			end
			objc_set_persistent_store_coordinator_ (item, a_coordinator__item)
		end

	persistent_store_coordinator: detachable NS_PERSISTENT_STORE_COORDINATOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_persistent_store_coordinator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like persistent_store_coordinator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like persistent_store_coordinator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_undo_manager_ (a_undo_manager: detachable NS_UNDO_MANAGER)
			-- Auto generated Objective-C wrapper.
		local
			a_undo_manager__item: POINTER
		do
			if attached a_undo_manager as a_undo_manager_attached then
				a_undo_manager__item := a_undo_manager_attached.item
			end
			objc_set_undo_manager_ (item, a_undo_manager__item)
		end

	undo_manager: detachable NS_UNDO_MANAGER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_undo_manager (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like undo_manager} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like undo_manager} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	has_changes: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_changes (item)
		end

	object_registered_for_i_d_ (a_object_id: detachable NS_MANAGED_OBJECT_ID): detachable NS_MANAGED_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_object_id__item: POINTER
		do
			if attached a_object_id as a_object_id_attached then
				a_object_id__item := a_object_id_attached.item
			end
			result_pointer := objc_object_registered_for_i_d_ (item, a_object_id__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_registered_for_i_d_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_registered_for_i_d_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	object_with_i_d_ (a_object_id: detachable NS_MANAGED_OBJECT_ID): detachable NS_MANAGED_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_object_id__item: POINTER
		do
			if attached a_object_id as a_object_id_attached then
				a_object_id__item := a_object_id_attached.item
			end
			result_pointer := objc_object_with_i_d_ (item, a_object_id__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_with_i_d_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_with_i_d_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	existing_object_with_i_d__error_ (a_object_id: detachable NS_MANAGED_OBJECT_ID; a_error: UNSUPPORTED_TYPE): detachable NS_MANAGED_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_object_id__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_object_id as a_object_id_attached then
--				a_object_id__item := a_object_id_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_existing_object_with_i_d__error_ (item, a_object_id__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like existing_object_with_i_d__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like existing_object_with_i_d__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	execute_fetch_request__error_ (a_request: detachable NS_FETCH_REQUEST; a_error: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_request__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_request as a_request_attached then
--				a_request__item := a_request_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_execute_fetch_request__error_ (item, a_request__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like execute_fetch_request__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like execute_fetch_request__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	count_for_fetch_request__error_ (a_request: detachable NS_FETCH_REQUEST; a_error: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_request__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_request as a_request_attached then
--				a_request__item := a_request_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_count_for_fetch_request__error_ (item, a_request__item, a_error__item)
--		end

	insert_object_ (a_object: detachable NS_MANAGED_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_insert_object_ (item, a_object__item)
		end

	delete_object_ (a_object: detachable NS_MANAGED_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_delete_object_ (item, a_object__item)
		end

	refresh_object__merge_changes_ (a_object: detachable NS_MANAGED_OBJECT; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_refresh_object__merge_changes_ (item, a_object__item, a_flag)
		end

	detect_conflicts_for_object_ (a_object: detachable NS_MANAGED_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_detect_conflicts_for_object_ (item, a_object__item)
		end

	process_pending_changes
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_process_pending_changes (item)
		end

	assign_object__to_persistent_store_ (a_object: detachable NS_OBJECT; a_store: detachable NS_PERSISTENT_STORE)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
			a_store__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_store as a_store_attached then
				a_store__item := a_store_attached.item
			end
			objc_assign_object__to_persistent_store_ (item, a_object__item, a_store__item)
		end

	inserted_objects: detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_inserted_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like inserted_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like inserted_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	updated_objects: detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_updated_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like updated_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like updated_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	deleted_objects: detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_deleted_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like deleted_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like deleted_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	registered_objects: detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_registered_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like registered_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like registered_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	undo
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_undo (item)
		end

	redo
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_redo (item)
		end

	reset
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reset (item)
		end

	rollback
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_rollback (item)
		end

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

	lock
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_lock (item)
		end

	unlock
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unlock (item)
		end

	try_lock: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_try_lock (item)
		end

	propagates_deletes_at_end_of_event: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_propagates_deletes_at_end_of_event (item)
		end

	set_propagates_deletes_at_end_of_event_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_propagates_deletes_at_end_of_event_ (item, a_flag)
		end

	retains_registered_objects: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_retains_registered_objects (item)
		end

	set_retains_registered_objects_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_retains_registered_objects_ (item, a_flag)
		end

	staleness_interval: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_staleness_interval (item)
		end

	set_staleness_interval_ (a_expiration: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_staleness_interval_ (item, a_expiration)
		end

	set_merge_policy_ (a_merge_policy: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_merge_policy__item: POINTER
		do
			if attached a_merge_policy as a_merge_policy_attached then
				a_merge_policy__item := a_merge_policy_attached.item
			end
			objc_set_merge_policy_ (item, a_merge_policy__item)
		end

	merge_policy: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_merge_policy (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like merge_policy} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like merge_policy} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	obtain_permanent_i_ds_for_objects__error_ (a_objects: detachable NS_ARRAY; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_objects__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_objects as a_objects_attached then
--				a_objects__item := a_objects_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_obtain_permanent_i_ds_for_objects__error_ (item, a_objects__item, a_error__item)
--		end

	merge_changes_from_context_did_save_notification_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_merge_changes_from_context_did_save_notification_ (item, a_notification__item)
		end

feature {NONE} -- NSManagedObjectContext Externals

	objc_set_persistent_store_coordinator_ (an_item: POINTER; a_coordinator: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item setPersistentStoreCoordinator:$a_coordinator];
			 ]"
		end

	objc_persistent_store_coordinator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item persistentStoreCoordinator];
			 ]"
		end

	objc_set_undo_manager_ (an_item: POINTER; a_undo_manager: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item setUndoManager:$a_undo_manager];
			 ]"
		end

	objc_undo_manager (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item undoManager];
			 ]"
		end

	objc_has_changes (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObjectContext *)$an_item hasChanges];
			 ]"
		end

	objc_object_registered_for_i_d_ (an_item: POINTER; a_object_id: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item objectRegisteredForID:$a_object_id];
			 ]"
		end

	objc_object_with_i_d_ (an_item: POINTER; a_object_id: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item objectWithID:$a_object_id];
			 ]"
		end

--	objc_existing_object_with_i_d__error_ (an_item: POINTER; a_object_id: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item existingObjectWithID:$a_object_id error:];
--			 ]"
--		end

--	objc_execute_fetch_request__error_ (an_item: POINTER; a_request: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item executeFetchRequest:$a_request error:];
--			 ]"
--		end

--	objc_count_for_fetch_request__error_ (an_item: POINTER; a_request: POINTER; a_error: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSManagedObjectContext *)$an_item countForFetchRequest:$a_request error:];
--			 ]"
--		end

	objc_insert_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item insertObject:$a_object];
			 ]"
		end

	objc_delete_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item deleteObject:$a_object];
			 ]"
		end

	objc_refresh_object__merge_changes_ (an_item: POINTER; a_object: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item refreshObject:$a_object mergeChanges:$a_flag];
			 ]"
		end

	objc_detect_conflicts_for_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item detectConflictsForObject:$a_object];
			 ]"
		end

	objc_process_pending_changes (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item processPendingChanges];
			 ]"
		end

	objc_assign_object__to_persistent_store_ (an_item: POINTER; a_object: POINTER; a_store: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item assignObject:$a_object toPersistentStore:$a_store];
			 ]"
		end

	objc_inserted_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item insertedObjects];
			 ]"
		end

	objc_updated_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item updatedObjects];
			 ]"
		end

	objc_deleted_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item deletedObjects];
			 ]"
		end

	objc_registered_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item registeredObjects];
			 ]"
		end

	objc_undo (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item undo];
			 ]"
		end

	objc_redo (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item redo];
			 ]"
		end

	objc_reset (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item reset];
			 ]"
		end

	objc_rollback (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item rollback];
			 ]"
		end

--	objc_save_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSManagedObjectContext *)$an_item save:];
--			 ]"
--		end

	objc_lock (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item lock];
			 ]"
		end

	objc_unlock (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item unlock];
			 ]"
		end

	objc_try_lock (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObjectContext *)$an_item tryLock];
			 ]"
		end

	objc_propagates_deletes_at_end_of_event (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObjectContext *)$an_item propagatesDeletesAtEndOfEvent];
			 ]"
		end

	objc_set_propagates_deletes_at_end_of_event_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item setPropagatesDeletesAtEndOfEvent:$a_flag];
			 ]"
		end

	objc_retains_registered_objects (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObjectContext *)$an_item retainsRegisteredObjects];
			 ]"
		end

	objc_set_retains_registered_objects_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item setRetainsRegisteredObjects:$a_flag];
			 ]"
		end

	objc_staleness_interval (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObjectContext *)$an_item stalenessInterval];
			 ]"
		end

	objc_set_staleness_interval_ (an_item: POINTER; a_expiration: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item setStalenessInterval:$a_expiration];
			 ]"
		end

	objc_set_merge_policy_ (an_item: POINTER; a_merge_policy: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item setMergePolicy:$a_merge_policy];
			 ]"
		end

	objc_merge_policy (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectContext *)$an_item mergePolicy];
			 ]"
		end

--	objc_obtain_permanent_i_ds_for_objects__error_ (an_item: POINTER; a_objects: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSManagedObjectContext *)$an_item obtainPermanentIDsForObjects:$a_objects error:];
--			 ]"
--		end

	objc_merge_changes_from_context_did_save_notification_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectContext *)$an_item mergeChangesFromContextDidSaveNotification:$a_notification];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSManagedObjectContext"
		end

end
