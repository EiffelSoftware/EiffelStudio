note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PROPERTY_DESCRIPTION

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSPropertyDescription

	entity: detachable NS_ENTITY_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_entity (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entity} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entity} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_name_ (item, a_name__item)
		end

	is_optional: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_optional (item)
		end

	set_optional_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_optional_ (item, a_flag)
		end

	is_transient: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_transient (item)
		end

	set_transient_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_transient_ (item, a_flag)
		end

	validation_predicates: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_validation_predicates (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like validation_predicates} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like validation_predicates} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	validation_warnings: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_validation_warnings (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like validation_warnings} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like validation_warnings} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_validation_predicates__with_validation_warnings_ (a_validation_predicates: detachable NS_ARRAY; a_validation_warnings: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_validation_predicates__item: POINTER
			a_validation_warnings__item: POINTER
		do
			if attached a_validation_predicates as a_validation_predicates_attached then
				a_validation_predicates__item := a_validation_predicates_attached.item
			end
			if attached a_validation_warnings as a_validation_warnings_attached then
				a_validation_warnings__item := a_validation_warnings_attached.item
			end
			objc_set_validation_predicates__with_validation_warnings_ (item, a_validation_predicates__item, a_validation_warnings__item)
		end

	user_info: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user_info (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_info} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_info} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_user_info_ (a_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_dictionary__item: POINTER
		do
			if attached a_dictionary as a_dictionary_attached then
				a_dictionary__item := a_dictionary_attached.item
			end
			objc_set_user_info_ (item, a_dictionary__item)
		end

	is_indexed: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_indexed (item)
		end

	set_indexed_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_indexed_ (item, a_flag)
		end

	version_hash: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_version_hash (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like version_hash} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like version_hash} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	version_hash_modifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_version_hash_modifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like version_hash_modifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like version_hash_modifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_version_hash_modifier_ (a_modifier_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_modifier_string__item: POINTER
		do
			if attached a_modifier_string as a_modifier_string_attached then
				a_modifier_string__item := a_modifier_string_attached.item
			end
			objc_set_version_hash_modifier_ (item, a_modifier_string__item)
		end

	is_indexed_by_spotlight: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_indexed_by_spotlight (item)
		end

	set_indexed_by_spotlight_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_indexed_by_spotlight_ (item, a_flag)
		end

	is_stored_in_external_record: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_stored_in_external_record (item)
		end

	set_stored_in_external_record_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_stored_in_external_record_ (item, a_flag)
		end

	renaming_identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_renaming_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like renaming_identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like renaming_identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_renaming_identifier_ (a_value: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_set_renaming_identifier_ (item, a_value__item)
		end

feature {NONE} -- NSPropertyDescription Externals

	objc_entity (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPropertyDescription *)$an_item entity];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPropertyDescription *)$an_item name];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setName:$a_name];
			 ]"
		end

	objc_is_optional (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSPropertyDescription *)$an_item isOptional];
			 ]"
		end

	objc_set_optional_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setOptional:$a_flag];
			 ]"
		end

	objc_is_transient (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSPropertyDescription *)$an_item isTransient];
			 ]"
		end

	objc_set_transient_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setTransient:$a_flag];
			 ]"
		end

	objc_validation_predicates (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPropertyDescription *)$an_item validationPredicates];
			 ]"
		end

	objc_validation_warnings (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPropertyDescription *)$an_item validationWarnings];
			 ]"
		end

	objc_set_validation_predicates__with_validation_warnings_ (an_item: POINTER; a_validation_predicates: POINTER; a_validation_warnings: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setValidationPredicates:$a_validation_predicates withValidationWarnings:$a_validation_warnings];
			 ]"
		end

	objc_user_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPropertyDescription *)$an_item userInfo];
			 ]"
		end

	objc_set_user_info_ (an_item: POINTER; a_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setUserInfo:$a_dictionary];
			 ]"
		end

	objc_is_indexed (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSPropertyDescription *)$an_item isIndexed];
			 ]"
		end

	objc_set_indexed_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setIndexed:$a_flag];
			 ]"
		end

	objc_version_hash (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPropertyDescription *)$an_item versionHash];
			 ]"
		end

	objc_version_hash_modifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPropertyDescription *)$an_item versionHashModifier];
			 ]"
		end

	objc_set_version_hash_modifier_ (an_item: POINTER; a_modifier_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setVersionHashModifier:$a_modifier_string];
			 ]"
		end

	objc_is_indexed_by_spotlight (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSPropertyDescription *)$an_item isIndexedBySpotlight];
			 ]"
		end

	objc_set_indexed_by_spotlight_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setIndexedBySpotlight:$a_flag];
			 ]"
		end

	objc_is_stored_in_external_record (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSPropertyDescription *)$an_item isStoredInExternalRecord];
			 ]"
		end

	objc_set_stored_in_external_record_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setStoredInExternalRecord:$a_flag];
			 ]"
		end

	objc_renaming_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPropertyDescription *)$an_item renamingIdentifier];
			 ]"
		end

	objc_set_renaming_identifier_ (an_item: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSPropertyDescription *)$an_item setRenamingIdentifier:$a_value];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPropertyDescription"
		end

end
