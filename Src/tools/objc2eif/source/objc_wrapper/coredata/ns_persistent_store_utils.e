note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PERSISTENT_STORE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPersistentStore

--	metadata_for_persistent_store_with_ur_l__error_ (a_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_metadata_for_persistent_store_with_ur_l__error_ (l_objc_class.item, a_url__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like metadata_for_persistent_store_with_ur_l__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like metadata_for_persistent_store_with_ur_l__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	set_metadata__for_persistent_store_with_ur_l__error_ (a_metadata: detachable NS_DICTIONARY; a_url: detachable NS_URL; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--			a_metadata__item: POINTER
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_metadata as a_metadata_attached then
--				a_metadata__item := a_metadata_attached.item
--			end
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			Result := objc_set_metadata__for_persistent_store_with_ur_l__error_ (l_objc_class.item, a_metadata__item, a_url__item, a_error__item)
--		end

	migration_manager_class: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_migration_manager_class (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like migration_manager_class} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like migration_manager_class} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPersistentStore Externals

--	objc_metadata_for_persistent_store_with_ur_l__error_ (a_class_object: POINTER; a_url: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object metadataForPersistentStoreWithURL:$a_url error:];
--			 ]"
--		end

--	objc_set_metadata__for_persistent_store_with_ur_l__error_ (a_class_object: POINTER; a_metadata: POINTER; a_url: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(Class)$a_class_object setMetadata:$a_metadata forPersistentStoreWithURL:$a_url error:];
--			 ]"
--		end

	objc_migration_manager_class (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object migrationManagerClass];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPersistentStore"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
