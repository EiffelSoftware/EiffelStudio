note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PERSISTENT_STORE_COORDINATOR_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPersistentStoreCoordinator

	registered_store_types: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_registered_store_types (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like registered_store_types} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like registered_store_types} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	register_store_class__for_store_type_ (a_store_class: detachable OBJC_CLASS; a_store_type: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_store_class__item: POINTER
			a_store_type__item: POINTER
		do
			if attached a_store_class as a_store_class_attached then
				a_store_class__item := a_store_class_attached.item
			end
			if attached a_store_type as a_store_type_attached then
				a_store_type__item := a_store_type_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_register_store_class__for_store_type_ (l_objc_class.item, a_store_class__item, a_store_type__item)
		end

--	metadata_for_persistent_store_of_type__ur_l__error_ (a_store_type: detachable NS_STRING; a_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_store_type__item: POINTER
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_store_type as a_store_type_attached then
--				a_store_type__item := a_store_type_attached.item
--			end
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_metadata_for_persistent_store_of_type__ur_l__error_ (l_objc_class.item, a_store_type__item, a_url__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like metadata_for_persistent_store_of_type__ur_l__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like metadata_for_persistent_store_of_type__ur_l__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	set_metadata__for_persistent_store_of_type__ur_l__error_ (a_metadata: detachable NS_DICTIONARY; a_store_type: detachable NS_STRING; a_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--			a_metadata__item: POINTER
--			a_store_type__item: POINTER
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_metadata as a_metadata_attached then
--				a_metadata__item := a_metadata_attached.item
--			end
--			if attached a_store_type as a_store_type_attached then
--				a_store_type__item := a_store_type_attached.item
--			end
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			Result := objc_set_metadata__for_persistent_store_of_type__ur_l__error_ (l_objc_class.item, a_metadata__item, a_store_type__item, a_url__item, a_error__item)
--		end

	elements_derived_from_external_record_ur_l_ (a_file_url: detachable NS_URL): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_file_url__item: POINTER
		do
			if attached a_file_url as a_file_url_attached then
				a_file_url__item := a_file_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_elements_derived_from_external_record_ur_l_ (l_objc_class.item, a_file_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like elements_derived_from_external_record_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like elements_derived_from_external_record_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPersistentStoreCoordinator Externals

	objc_registered_store_types (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object registeredStoreTypes];
			 ]"
		end

	objc_register_store_class__for_store_type_ (a_class_object: POINTER; a_store_class: POINTER; a_store_type: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(Class)$a_class_object registerStoreClass:$a_store_class forStoreType:$a_store_type];
			 ]"
		end

--	objc_metadata_for_persistent_store_of_type__ur_l__error_ (a_class_object: POINTER; a_store_type: POINTER; a_url: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object metadataForPersistentStoreOfType:$a_store_type URL:$a_url error:];
--			 ]"
--		end

--	objc_set_metadata__for_persistent_store_of_type__ur_l__error_ (a_class_object: POINTER; a_metadata: POINTER; a_store_type: POINTER; a_url: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(Class)$a_class_object setMetadata:$a_metadata forPersistentStoreOfType:$a_store_type URL:$a_url error:];
--			 ]"
--		end

	objc_elements_derived_from_external_record_ur_l_ (a_class_object: POINTER; a_file_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object elementsDerivedFromExternalRecordURL:$a_file_url];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPersistentStoreCoordinator"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
