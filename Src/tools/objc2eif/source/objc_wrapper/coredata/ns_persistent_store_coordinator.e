note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PERSISTENT_STORE_COORDINATOR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

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
	make_with_managed_object_model_,
	make

feature -- NSPersistentStoreCoordinator

--	import_store_with_identifier__from_external_records_directory__to_ur_l__options__with_type__error_ (a_store_identifier: detachable NS_STRING; a_external_records_url: detachable NS_URL; a_destination_url: detachable NS_URL; a_options: detachable NS_DICTIONARY; a_store_type: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): detachable NS_PERSISTENT_STORE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_store_identifier__item: POINTER
--			a_external_records_url__item: POINTER
--			a_destination_url__item: POINTER
--			a_options__item: POINTER
--			a_store_type__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_store_identifier as a_store_identifier_attached then
--				a_store_identifier__item := a_store_identifier_attached.item
--			end
--			if attached a_external_records_url as a_external_records_url_attached then
--				a_external_records_url__item := a_external_records_url_attached.item
--			end
--			if attached a_destination_url as a_destination_url_attached then
--				a_destination_url__item := a_destination_url_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			if attached a_store_type as a_store_type_attached then
--				a_store_type__item := a_store_type_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_import_store_with_identifier__from_external_records_directory__to_ur_l__options__with_type__error_ (item, a_store_identifier__item, a_external_records_url__item, a_destination_url__item, a_options__item, a_store_type__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like import_store_with_identifier__from_external_records_directory__to_ur_l__options__with_type__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like import_store_with_identifier__from_external_records_directory__to_ur_l__options__with_type__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_metadata__for_persistent_store_ (a_metadata: detachable NS_DICTIONARY; a_store: detachable NS_PERSISTENT_STORE)
			-- Auto generated Objective-C wrapper.
		local
			a_metadata__item: POINTER
			a_store__item: POINTER
		do
			if attached a_metadata as a_metadata_attached then
				a_metadata__item := a_metadata_attached.item
			end
			if attached a_store as a_store_attached then
				a_store__item := a_store_attached.item
			end
			objc_set_metadata__for_persistent_store_ (item, a_metadata__item, a_store__item)
		end

	metadata_for_persistent_store_ (a_store: detachable NS_PERSISTENT_STORE): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_store__item: POINTER
		do
			if attached a_store as a_store_attached then
				a_store__item := a_store_attached.item
			end
			result_pointer := objc_metadata_for_persistent_store_ (item, a_store__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like metadata_for_persistent_store_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like metadata_for_persistent_store_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	managed_object_model: detachable NS_MANAGED_OBJECT_MODEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_managed_object_model (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like managed_object_model} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like managed_object_model} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	persistent_stores: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_persistent_stores (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like persistent_stores} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like persistent_stores} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	persistent_store_for_ur_l_ (a_url: detachable NS_URL): detachable NS_PERSISTENT_STORE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			result_pointer := objc_persistent_store_for_ur_l_ (item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like persistent_store_for_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like persistent_store_for_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url_for_persistent_store_ (a_store: detachable NS_PERSISTENT_STORE): detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_store__item: POINTER
		do
			if attached a_store as a_store_attached then
				a_store__item := a_store_attached.item
			end
			result_pointer := objc_url_for_persistent_store_ (item, a_store__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url_for_persistent_store_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url_for_persistent_store_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_ur_l__for_persistent_store_ (a_url: detachable NS_URL; a_store: detachable NS_PERSISTENT_STORE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
			a_store__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			if attached a_store as a_store_attached then
				a_store__item := a_store_attached.item
			end
			Result := objc_set_ur_l__for_persistent_store_ (item, a_url__item, a_store__item)
		end

--	add_persistent_store_with_type__configuration__ur_l__options__error_ (a_store_type: detachable NS_STRING; a_configuration: detachable NS_STRING; a_store_url: detachable NS_URL; a_options: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): detachable NS_PERSISTENT_STORE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_store_type__item: POINTER
--			a_configuration__item: POINTER
--			a_store_url__item: POINTER
--			a_options__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_store_type as a_store_type_attached then
--				a_store_type__item := a_store_type_attached.item
--			end
--			if attached a_configuration as a_configuration_attached then
--				a_configuration__item := a_configuration_attached.item
--			end
--			if attached a_store_url as a_store_url_attached then
--				a_store_url__item := a_store_url_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_add_persistent_store_with_type__configuration__ur_l__options__error_ (item, a_store_type__item, a_configuration__item, a_store_url__item, a_options__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like add_persistent_store_with_type__configuration__ur_l__options__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like add_persistent_store_with_type__configuration__ur_l__options__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	remove_persistent_store__error_ (a_store: detachable NS_PERSISTENT_STORE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_store__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_store as a_store_attached then
--				a_store__item := a_store_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_remove_persistent_store__error_ (item, a_store__item, a_error__item)
--		end

--	migrate_persistent_store__to_ur_l__options__with_type__error_ (a_store: detachable NS_PERSISTENT_STORE; a_url: detachable NS_URL; a_options: detachable NS_DICTIONARY; a_store_type: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): detachable NS_PERSISTENT_STORE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_store__item: POINTER
--			a_url__item: POINTER
--			a_options__item: POINTER
--			a_store_type__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_store as a_store_attached then
--				a_store__item := a_store_attached.item
--			end
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			if attached a_store_type as a_store_type_attached then
--				a_store_type__item := a_store_type_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_migrate_persistent_store__to_ur_l__options__with_type__error_ (item, a_store__item, a_url__item, a_options__item, a_store_type__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like migrate_persistent_store__to_ur_l__options__with_type__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like migrate_persistent_store__to_ur_l__options__with_type__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	managed_object_id_for_uri_representation_ (a_url: detachable NS_URL): detachable NS_MANAGED_OBJECT_ID
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			result_pointer := objc_managed_object_id_for_uri_representation_ (item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like managed_object_id_for_uri_representation_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like managed_object_id_for_uri_representation_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

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

feature {NONE} -- NSPersistentStoreCoordinator Externals

--	objc_import_store_with_identifier__from_external_records_directory__to_ur_l__options__with_type__error_ (an_item: POINTER; a_store_identifier: POINTER; a_external_records_url: POINTER; a_destination_url: POINTER; a_options: POINTER; a_store_type: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item importStoreWithIdentifier:$a_store_identifier fromExternalRecordsDirectory:$a_external_records_url toURL:$a_destination_url options:$a_options withType:$a_store_type error:];
--			 ]"
--		end

	objc_set_metadata__for_persistent_store_ (an_item: POINTER; a_metadata: POINTER; a_store: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPersistentStoreCoordinator *)$an_item setMetadata:$a_metadata forPersistentStore:$a_store];
			 ]"
		end

	objc_metadata_for_persistent_store_ (an_item: POINTER; a_store: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item metadataForPersistentStore:$a_store];
			 ]"
		end

	objc_init_with_managed_object_model_ (an_item: POINTER; a_model: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item initWithManagedObjectModel:$a_model];
			 ]"
		end

	objc_managed_object_model (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item managedObjectModel];
			 ]"
		end

	objc_persistent_stores (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item persistentStores];
			 ]"
		end

	objc_persistent_store_for_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item persistentStoreForURL:$a_url];
			 ]"
		end

	objc_url_for_persistent_store_ (an_item: POINTER; a_store: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item URLForPersistentStore:$a_store];
			 ]"
		end

	objc_set_ur_l__for_persistent_store_ (an_item: POINTER; a_url: POINTER; a_store: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSPersistentStoreCoordinator *)$an_item setURL:$a_url forPersistentStore:$a_store];
			 ]"
		end

--	objc_add_persistent_store_with_type__configuration__ur_l__options__error_ (an_item: POINTER; a_store_type: POINTER; a_configuration: POINTER; a_store_url: POINTER; a_options: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item addPersistentStoreWithType:$a_store_type configuration:$a_configuration URL:$a_store_url options:$a_options error:];
--			 ]"
--		end

--	objc_remove_persistent_store__error_ (an_item: POINTER; a_store: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSPersistentStoreCoordinator *)$an_item removePersistentStore:$a_store error:];
--			 ]"
--		end

--	objc_migrate_persistent_store__to_ur_l__options__with_type__error_ (an_item: POINTER; a_store: POINTER; a_url: POINTER; a_options: POINTER; a_store_type: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item migratePersistentStore:$a_store toURL:$a_url options:$a_options withType:$a_store_type error:];
--			 ]"
--		end

	objc_managed_object_id_for_uri_representation_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStoreCoordinator *)$an_item managedObjectIDForURIRepresentation:$a_url];
			 ]"
		end

	objc_lock (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPersistentStoreCoordinator *)$an_item lock];
			 ]"
		end

	objc_unlock (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPersistentStoreCoordinator *)$an_item unlock];
			 ]"
		end

	objc_try_lock (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSPersistentStoreCoordinator *)$an_item tryLock];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_managed_object_model_ (a_model: detachable NS_MANAGED_OBJECT_MODEL)
			-- Initialize `Current'.
		local
			a_model__item: POINTER
		do
			if attached a_model as a_model_attached then
				a_model__item := a_model_attached.item
			end
			make_with_pointer (objc_init_with_managed_object_model_(allocate_object, a_model__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPersistentStoreCoordinator"
		end

end
