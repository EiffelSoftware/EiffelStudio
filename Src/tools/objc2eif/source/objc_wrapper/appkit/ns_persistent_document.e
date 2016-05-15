note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PERSISTENT_DOCUMENT

inherit
	NS_DOCUMENT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSPersistentDocument

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

	set_managed_object_context_ (a_managed_object_context: detachable NS_MANAGED_OBJECT_CONTEXT)
			-- Auto generated Objective-C wrapper.
		local
			a_managed_object_context__item: POINTER
		do
			if attached a_managed_object_context as a_managed_object_context_attached then
				a_managed_object_context__item := a_managed_object_context_attached.item
			end
			objc_set_managed_object_context_ (item, a_managed_object_context__item)
		end

	managed_object_model: detachable NS_OBJECT
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

--	configure_persistent_store_coordinator_for_ur_l__of_type__model_configuration__store_options__error_ (a_url: detachable NS_URL; a_file_type: detachable NS_STRING; a_configuration: detachable NS_STRING; a_store_options: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_file_type__item: POINTER
--			a_configuration__item: POINTER
--			a_store_options__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_file_type as a_file_type_attached then
--				a_file_type__item := a_file_type_attached.item
--			end
--			if attached a_configuration as a_configuration_attached then
--				a_configuration__item := a_configuration_attached.item
--			end
--			if attached a_store_options as a_store_options_attached then
--				a_store_options__item := a_store_options_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_configure_persistent_store_coordinator_for_ur_l__of_type__model_configuration__store_options__error_ (item, a_url__item, a_file_type__item, a_configuration__item, a_store_options__item, a_error__item)
--		end

	persistent_store_type_for_file_type_ (a_file_type: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_file_type__item: POINTER
		do
			if attached a_file_type as a_file_type_attached then
				a_file_type__item := a_file_type_attached.item
			end
			result_pointer := objc_persistent_store_type_for_file_type_ (item, a_file_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like persistent_store_type_for_file_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like persistent_store_type_for_file_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPersistentDocument Externals

	objc_managed_object_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentDocument *)$an_item managedObjectContext];
			 ]"
		end

	objc_set_managed_object_context_ (an_item: POINTER; a_managed_object_context: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPersistentDocument *)$an_item setManagedObjectContext:$a_managed_object_context];
			 ]"
		end

	objc_managed_object_model (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentDocument *)$an_item managedObjectModel];
			 ]"
		end

--	objc_configure_persistent_store_coordinator_for_ur_l__of_type__model_configuration__store_options__error_ (an_item: POINTER; a_url: POINTER; a_file_type: POINTER; a_configuration: POINTER; a_store_options: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSPersistentDocument *)$an_item configurePersistentStoreCoordinatorForURL:$a_url ofType:$a_file_type modelConfiguration:$a_configuration storeOptions:$a_store_options error:];
--			 ]"
--		end

	objc_persistent_store_type_for_file_type_ (an_item: POINTER; a_file_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPersistentDocument *)$an_item persistentStoreTypeForFileType:$a_file_type];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPersistentDocument"
		end

end
