note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT_CONTROLLER

inherit
	NS_CONTROLLER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_content_,
	make

feature {NONE} -- Initialization

	make_with_content_ (a_content: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_content__item: POINTER
		do
			if attached a_content as a_content_attached then
				a_content__item := a_content_attached.item
			end
			make_with_pointer (objc_init_with_content_(allocate_object, a_content__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSObjectController Externals

	objc_init_with_content_ (an_item: POINTER; a_content: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item initWithContent:$a_content];
			 ]"
		end

	objc_set_content_ (an_item: POINTER; a_content: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item setContent:$a_content];
			 ]"
		end

	objc_content (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item content];
			 ]"
		end

	objc_selection (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item selection];
			 ]"
		end

	objc_selected_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item selectedObjects];
			 ]"
		end

	objc_set_automatically_prepares_content_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item setAutomaticallyPreparesContent:$a_flag];
			 ]"
		end

	objc_automatically_prepares_content (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObjectController *)$an_item automaticallyPreparesContent];
			 ]"
		end

	objc_prepare_content (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item prepareContent];
			 ]"
		end

	objc_set_object_class_ (an_item: POINTER; a_object_class: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item setObjectClass:$a_object_class];
			 ]"
		end

	objc_object_class (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item objectClass];
			 ]"
		end

	objc_new_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item newObject];
			 ]"
		end

	objc_add_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item addObject:$a_object];
			 ]"
		end

	objc_remove_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item removeObject:$a_object];
			 ]"
		end

	objc_set_editable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item setEditable:$a_flag];
			 ]"
		end

	objc_is_editable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObjectController *)$an_item isEditable];
			 ]"
		end

	objc_add_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item add:$a_sender];
			 ]"
		end

	objc_can_add (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObjectController *)$an_item canAdd];
			 ]"
		end

	objc_remove_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item remove:$a_sender];
			 ]"
		end

	objc_can_remove (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObjectController *)$an_item canRemove];
			 ]"
		end

	objc_validate_user_interface_item_ (an_item: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObjectController *)$an_item validateUserInterfaceItem:$a_item];
			 ]"
		end

feature -- NSObjectController

	set_content_ (a_content: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_content__item: POINTER
		do
			if attached a_content as a_content_attached then
				a_content__item := a_content_attached.item
			end
			objc_set_content_ (item, a_content__item)
		end

	content: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_content (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like content} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like content} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selection: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selection (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selection} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selection} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_objects: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_automatically_prepares_content_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_automatically_prepares_content_ (item, a_flag)
		end

	automatically_prepares_content: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_automatically_prepares_content (item)
		end

	prepare_content
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_prepare_content (item)
		end

	set_object_class_ (a_object_class: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			a_object_class__item: POINTER
		do
			if attached a_object_class as a_object_class_attached then
				a_object_class__item := a_object_class_attached.item
			end
			objc_set_object_class_ (item, a_object_class__item)
		end

	object_class: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_class (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_class} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_class} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	new_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_new_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like new_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like new_object} new_eiffel_object (result_pointer, False) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_object_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_add_object_ (item, a_object__item)
		end

	remove_object_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_remove_object_ (item, a_object__item)
		end

	set_editable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_editable_ (item, a_flag)
		end

	is_editable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_editable (item)
		end

	add_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_add_ (item, a_sender__item)
		end

	can_add: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_add (item)
		end

	remove_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_remove_ (item, a_sender__item)
		end

	can_remove: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_remove (item)
		end

	validate_user_interface_item_ (a_item: detachable NS_VALIDATED_USER_INTERFACE_ITEM_PROTOCOL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_validate_user_interface_item_ (item, a_item__item)
		end

feature -- NSManagedController

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

	entity_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_entity_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entity_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entity_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_entity_name_ (a_entity_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_entity_name__item: POINTER
		do
			if attached a_entity_name as a_entity_name_attached then
				a_entity_name__item := a_entity_name_attached.item
			end
			objc_set_entity_name_ (item, a_entity_name__item)
		end

	fetch_predicate: detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_fetch_predicate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like fetch_predicate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like fetch_predicate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_fetch_predicate_ (a_predicate: detachable NS_PREDICATE)
			-- Auto generated Objective-C wrapper.
		local
			a_predicate__item: POINTER
		do
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			objc_set_fetch_predicate_ (item, a_predicate__item)
		end

--	fetch_with_request__merge__error_ (a_fetch_request: detachable NS_FETCH_REQUEST; a_merge: BOOLEAN; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_fetch_request__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_fetch_request as a_fetch_request_attached then
--				a_fetch_request__item := a_fetch_request_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_fetch_with_request__merge__error_ (item, a_fetch_request__item, a_merge, a_error__item)
--		end

	fetch_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_fetch_ (item, a_sender__item)
		end

	set_uses_lazy_fetching_ (a_enabled: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_lazy_fetching_ (item, a_enabled)
		end

	uses_lazy_fetching: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_lazy_fetching (item)
		end

	default_fetch_request: detachable NS_FETCH_REQUEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_default_fetch_request (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_fetch_request} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_fetch_request} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSManagedController Externals

	objc_managed_object_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item managedObjectContext];
			 ]"
		end

	objc_set_managed_object_context_ (an_item: POINTER; a_managed_object_context: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item setManagedObjectContext:$a_managed_object_context];
			 ]"
		end

	objc_entity_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item entityName];
			 ]"
		end

	objc_set_entity_name_ (an_item: POINTER; a_entity_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item setEntityName:$a_entity_name];
			 ]"
		end

	objc_fetch_predicate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item fetchPredicate];
			 ]"
		end

	objc_set_fetch_predicate_ (an_item: POINTER; a_predicate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item setFetchPredicate:$a_predicate];
			 ]"
		end

--	objc_fetch_with_request__merge__error_ (an_item: POINTER; a_fetch_request: POINTER; a_merge: BOOLEAN; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSObjectController *)$an_item fetchWithRequest:$a_fetch_request merge:$a_merge error:];
--			 ]"
--		end

	objc_fetch_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item fetch:$a_sender];
			 ]"
		end

	objc_set_uses_lazy_fetching_ (an_item: POINTER; a_enabled: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObjectController *)$an_item setUsesLazyFetching:$a_enabled];
			 ]"
		end

	objc_uses_lazy_fetching (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObjectController *)$an_item usesLazyFetching];
			 ]"
		end

	objc_default_fetch_request (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObjectController *)$an_item defaultFetchRequest];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSObjectController"
		end

end
