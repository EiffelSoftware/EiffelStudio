note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_CLASS_DESCRIPTION

inherit
	NS_CLASS_DESCRIPTION
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_suite_name__class_name__dictionary_,
	make

feature {NONE} -- Initialization

	make_with_suite_name__class_name__dictionary_ (a_suite_name: detachable NS_STRING; a_class_name: detachable NS_STRING; a_class_declaration: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_suite_name__item: POINTER
			a_class_name__item: POINTER
			a_class_declaration__item: POINTER
		do
			if attached a_suite_name as a_suite_name_attached then
				a_suite_name__item := a_suite_name_attached.item
			end
			if attached a_class_name as a_class_name_attached then
				a_class_name__item := a_class_name_attached.item
			end
			if attached a_class_declaration as a_class_declaration_attached then
				a_class_declaration__item := a_class_declaration_attached.item
			end
			make_with_pointer (objc_init_with_suite_name__class_name__dictionary_(allocate_object, a_suite_name__item, a_class_name__item, a_class_declaration__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSScriptClassDescription Externals

	objc_init_with_suite_name__class_name__dictionary_ (an_item: POINTER; a_suite_name: POINTER; a_class_name: POINTER; a_class_declaration: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptClassDescription *)$an_item initWithSuiteName:$a_suite_name className:$a_class_name dictionary:$a_class_declaration];
			 ]"
		end

	objc_suite_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptClassDescription *)$an_item suiteName];
			 ]"
		end

	objc_implementation_class_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptClassDescription *)$an_item implementationClassName];
			 ]"
		end

	objc_superclass_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptClassDescription *)$an_item superclassDescription];
			 ]"
		end

	objc_apple_event_code (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptClassDescription *)$an_item appleEventCode];
			 ]"
		end

	objc_matches_apple_event_code_ (an_item: POINTER; a_apple_event_code: NATURAL_32): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptClassDescription *)$an_item matchesAppleEventCode:$a_apple_event_code];
			 ]"
		end

	objc_supports_command_ (an_item: POINTER; a_command_description: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptClassDescription *)$an_item supportsCommand:$a_command_description];
			 ]"
		end

	objc_selector_for_command_ (an_item: POINTER; a_command_description: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptClassDescription *)$an_item selectorForCommand:$a_command_description];
			 ]"
		end

	objc_type_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptClassDescription *)$an_item typeForKey:$a_key];
			 ]"
		end

	objc_class_description_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptClassDescription *)$an_item classDescriptionForKey:$a_key];
			 ]"
		end

	objc_apple_event_code_for_key_ (an_item: POINTER; a_key: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptClassDescription *)$an_item appleEventCodeForKey:$a_key];
			 ]"
		end

	objc_key_with_apple_event_code_ (an_item: POINTER; a_apple_event_code: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptClassDescription *)$an_item keyWithAppleEventCode:$a_apple_event_code];
			 ]"
		end

	objc_default_subcontainer_attribute_key (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptClassDescription *)$an_item defaultSubcontainerAttributeKey];
			 ]"
		end

	objc_is_location_required_to_create_for_key_ (an_item: POINTER; a_to_many_relationship_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptClassDescription *)$an_item isLocationRequiredToCreateForKey:$a_to_many_relationship_key];
			 ]"
		end

	objc_has_property_for_key_ (an_item: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptClassDescription *)$an_item hasPropertyForKey:$a_key];
			 ]"
		end

	objc_has_ordered_to_many_relationship_for_key_ (an_item: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptClassDescription *)$an_item hasOrderedToManyRelationshipForKey:$a_key];
			 ]"
		end

	objc_has_readable_property_for_key_ (an_item: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptClassDescription *)$an_item hasReadablePropertyForKey:$a_key];
			 ]"
		end

	objc_has_writable_property_for_key_ (an_item: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptClassDescription *)$an_item hasWritablePropertyForKey:$a_key];
			 ]"
		end

feature -- NSScriptClassDescription

	suite_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_suite_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like suite_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like suite_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	implementation_class_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_implementation_class_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like implementation_class_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like implementation_class_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	superclass_description: detachable NS_SCRIPT_CLASS_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_superclass_description (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like superclass_description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like superclass_description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	apple_event_code: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_apple_event_code (item)
		end

	matches_apple_event_code_ (a_apple_event_code: NATURAL_32): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_matches_apple_event_code_ (item, a_apple_event_code)
		end

	supports_command_ (a_command_description: detachable NS_SCRIPT_COMMAND_DESCRIPTION): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_command_description__item: POINTER
		do
			if attached a_command_description as a_command_description_attached then
				a_command_description__item := a_command_description_attached.item
			end
			Result := objc_supports_command_ (item, a_command_description__item)
		end

	selector_for_command_ (a_command_description: detachable NS_SCRIPT_COMMAND_DESCRIPTION): detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_command_description__item: POINTER
		do
			if attached a_command_description as a_command_description_attached then
				a_command_description__item := a_command_description_attached.item
			end
			result_pointer := objc_selector_for_command_ (item, a_command_description__item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	type_for_key_ (a_key: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_type_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like type_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like type_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	class_description_for_key_ (a_key: detachable NS_STRING): detachable NS_SCRIPT_CLASS_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_class_description_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_description_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_description_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	apple_event_code_for_key_ (a_key: detachable NS_STRING): NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_apple_event_code_for_key_ (item, a_key__item)
		end

	key_with_apple_event_code_ (a_apple_event_code: NATURAL_32): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_with_apple_event_code_ (item, a_apple_event_code)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_with_apple_event_code_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_with_apple_event_code_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	default_subcontainer_attribute_key: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_default_subcontainer_attribute_key (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_subcontainer_attribute_key} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_subcontainer_attribute_key} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_location_required_to_create_for_key_ (a_to_many_relationship_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_to_many_relationship_key__item: POINTER
		do
			if attached a_to_many_relationship_key as a_to_many_relationship_key_attached then
				a_to_many_relationship_key__item := a_to_many_relationship_key_attached.item
			end
			Result := objc_is_location_required_to_create_for_key_ (item, a_to_many_relationship_key__item)
		end

	has_property_for_key_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_has_property_for_key_ (item, a_key__item)
		end

	has_ordered_to_many_relationship_for_key_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_has_ordered_to_many_relationship_for_key_ (item, a_key__item)
		end

	has_readable_property_for_key_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_has_readable_property_for_key_ (item, a_key__item)
		end

	has_writable_property_for_key_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			Result := objc_has_writable_property_for_key_ (item, a_key__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptClassDescription"
		end

end
