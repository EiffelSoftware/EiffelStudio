note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PREDICATE_EDITOR_ROW_TEMPLATE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPredicateEditorRowTemplate

	templates_with_attribute_key_paths__in_entity_description_ (a_key_paths: detachable NS_ARRAY; a_entity_description: detachable NS_ENTITY_DESCRIPTION): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_key_paths__item: POINTER
			a_entity_description__item: POINTER
		do
			if attached a_key_paths as a_key_paths_attached then
				a_key_paths__item := a_key_paths_attached.item
			end
			if attached a_entity_description as a_entity_description_attached then
				a_entity_description__item := a_entity_description_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_templates_with_attribute_key_paths__in_entity_description_ (l_objc_class.item, a_key_paths__item, a_entity_description__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like templates_with_attribute_key_paths__in_entity_description_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like templates_with_attribute_key_paths__in_entity_description_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPredicateEditorRowTemplate Externals

	objc_templates_with_attribute_key_paths__in_entity_description_ (a_class_object: POINTER; a_key_paths: POINTER; a_entity_description: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object templatesWithAttributeKeyPaths:$a_key_paths inEntityDescription:$a_entity_description];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPredicateEditorRowTemplate"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
