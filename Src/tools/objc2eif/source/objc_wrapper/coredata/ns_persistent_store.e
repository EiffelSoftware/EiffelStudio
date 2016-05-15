note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PERSISTENT_STORE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_persistent_store_coordinator__configuration_name__ur_l__options_,
	make

feature {NONE} -- Initialization

	make_with_persistent_store_coordinator__configuration_name__ur_l__options_ (a_root: detachable NS_PERSISTENT_STORE_COORDINATOR; a_name: detachable NS_STRING; a_url: detachable NS_URL; a_options: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_root__item: POINTER
			a_name__item: POINTER
			a_url__item: POINTER
			a_options__item: POINTER
		do
			if attached a_root as a_root_attached then
				a_root__item := a_root_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			make_with_pointer (objc_init_with_persistent_store_coordinator__configuration_name__ur_l__options_(allocate_object, a_root__item, a_name__item, a_url__item, a_options__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSPersistentStore Externals

	objc_init_with_persistent_store_coordinator__configuration_name__ur_l__options_ (an_item: POINTER; a_root: POINTER; a_name: POINTER; a_url: POINTER; a_options: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStore *)$an_item initWithPersistentStoreCoordinator:$a_root configurationName:$a_name URL:$a_url options:$a_options];
			 ]"
		end

--	objc_load_metadata_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSPersistentStore *)$an_item loadMetadata:];
--			 ]"
--		end

	objc_persistent_store_coordinator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStore *)$an_item persistentStoreCoordinator];
			 ]"
		end

	objc_configuration_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStore *)$an_item configurationName];
			 ]"
		end

	objc_options (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStore *)$an_item options];
			 ]"
		end

	objc_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStore *)$an_item URL];
			 ]"
		end

	objc_set_ur_l_ (an_item: POINTER; a_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPersistentStore *)$an_item setURL:$a_url];
			 ]"
		end

	objc_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStore *)$an_item identifier];
			 ]"
		end

	objc_set_identifier_ (an_item: POINTER; a_identifier: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPersistentStore *)$an_item setIdentifier:$a_identifier];
			 ]"
		end

	objc_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStore *)$an_item type];
			 ]"
		end

	objc_is_read_only (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSPersistentStore *)$an_item isReadOnly];
			 ]"
		end

	objc_set_read_only_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPersistentStore *)$an_item setReadOnly:$a_flag];
			 ]"
		end

	objc_metadata (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentStore *)$an_item metadata];
			 ]"
		end

	objc_set_metadata_ (an_item: POINTER; a_store_metadata: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPersistentStore *)$an_item setMetadata:$a_store_metadata];
			 ]"
		end

	objc_did_add_to_persistent_store_coordinator_ (an_item: POINTER; a_coordinator: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPersistentStore *)$an_item didAddToPersistentStoreCoordinator:$a_coordinator];
			 ]"
		end

	objc_will_remove_from_persistent_store_coordinator_ (an_item: POINTER; a_coordinator: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPersistentStore *)$an_item willRemoveFromPersistentStoreCoordinator:$a_coordinator];
			 ]"
		end

feature -- NSPersistentStore

--	load_metadata_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_load_metadata_ (item, a_error__item)
--		end

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

	configuration_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_configuration_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like configuration_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like configuration_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	options: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_options (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like options} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like options} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_ur_l_ (a_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			objc_set_ur_l_ (item, a_url__item)
		end

	identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_identifier_ (a_identifier: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			objc_set_identifier_ (item, a_identifier__item)
		end

	type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_read_only: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_read_only (item)
		end

	set_read_only_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_read_only_ (item, a_flag)
		end

	metadata: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_metadata (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like metadata} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like metadata} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_metadata_ (a_store_metadata: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_store_metadata__item: POINTER
		do
			if attached a_store_metadata as a_store_metadata_attached then
				a_store_metadata__item := a_store_metadata_attached.item
			end
			objc_set_metadata_ (item, a_store_metadata__item)
		end

	did_add_to_persistent_store_coordinator_ (a_coordinator: detachable NS_PERSISTENT_STORE_COORDINATOR)
			-- Auto generated Objective-C wrapper.
		local
			a_coordinator__item: POINTER
		do
			if attached a_coordinator as a_coordinator_attached then
				a_coordinator__item := a_coordinator_attached.item
			end
			objc_did_add_to_persistent_store_coordinator_ (item, a_coordinator__item)
		end

	will_remove_from_persistent_store_coordinator_ (a_coordinator: detachable NS_PERSISTENT_STORE_COORDINATOR)
			-- Auto generated Objective-C wrapper.
		local
			a_coordinator__item: POINTER
		do
			if attached a_coordinator as a_coordinator_attached then
				a_coordinator__item := a_coordinator_attached.item
			end
			objc_will_remove_from_persistent_store_coordinator_ (item, a_coordinator__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPersistentStore"
		end

end
