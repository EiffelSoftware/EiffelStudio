note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ENTITY_DESCRIPTION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSEntityDescription

	entity_for_name__in_managed_object_context_ (a_entity_name: detachable NS_STRING; a_context: detachable NS_MANAGED_OBJECT_CONTEXT): detachable NS_ENTITY_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_entity_name__item: POINTER
			a_context__item: POINTER
		do
			if attached a_entity_name as a_entity_name_attached then
				a_entity_name__item := a_entity_name_attached.item
			end
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_entity_for_name__in_managed_object_context_ (l_objc_class.item, a_entity_name__item, a_context__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entity_for_name__in_managed_object_context_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entity_for_name__in_managed_object_context_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	insert_new_object_for_entity_for_name__in_managed_object_context_ (a_entity_name: detachable NS_STRING; a_context: detachable NS_MANAGED_OBJECT_CONTEXT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_entity_name__item: POINTER
			a_context__item: POINTER
		do
			if attached a_entity_name as a_entity_name_attached then
				a_entity_name__item := a_entity_name_attached.item
			end
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_insert_new_object_for_entity_for_name__in_managed_object_context_ (l_objc_class.item, a_entity_name__item, a_context__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like insert_new_object_for_entity_for_name__in_managed_object_context_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like insert_new_object_for_entity_for_name__in_managed_object_context_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSEntityDescription Externals

	objc_entity_for_name__in_managed_object_context_ (a_class_object: POINTER; a_entity_name: POINTER; a_context: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object entityForName:$a_entity_name inManagedObjectContext:$a_context];
			 ]"
		end

	objc_insert_new_object_for_entity_for_name__in_managed_object_context_ (a_class_object: POINTER; a_entity_name: POINTER; a_context: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object insertNewObjectForEntityForName:$a_entity_name inManagedObjectContext:$a_context];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSEntityDescription"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
