note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ENTITY_DESCRIPTION

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL
	NS_FAST_ENUMERATION_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSEntityDescription

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

	managed_object_class_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_managed_object_class_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like managed_object_class_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like managed_object_class_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_managed_object_class_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_managed_object_class_name_ (item, a_name__item)
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

	is_abstract: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_abstract (item)
		end

	set_abstract_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_abstract_ (item, a_flag)
		end

	subentities_by_name: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_subentities_by_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subentities_by_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subentities_by_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	subentities: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_subentities (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subentities} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subentities} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_subentities_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_subentities_ (item, a_array__item)
		end

	superentity: detachable NS_ENTITY_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_superentity (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like superentity} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like superentity} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	properties_by_name: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_properties_by_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like properties_by_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like properties_by_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	properties: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_properties (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like properties} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like properties} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_properties_ (a_properties: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_properties__item: POINTER
		do
			if attached a_properties as a_properties_attached then
				a_properties__item := a_properties_attached.item
			end
			objc_set_properties_ (item, a_properties__item)
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

	attributes_by_name: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributes_by_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributes_by_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributes_by_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	relationships_by_name: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_relationships_by_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like relationships_by_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like relationships_by_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	relationships_with_destination_entity_ (a_entity: detachable NS_ENTITY_DESCRIPTION): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_entity__item: POINTER
		do
			if attached a_entity as a_entity_attached then
				a_entity__item := a_entity_attached.item
			end
			result_pointer := objc_relationships_with_destination_entity_ (item, a_entity__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like relationships_with_destination_entity_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like relationships_with_destination_entity_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_kind_of_entity_ (a_entity: detachable NS_ENTITY_DESCRIPTION): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_entity__item: POINTER
		do
			if attached a_entity as a_entity_attached then
				a_entity__item := a_entity_attached.item
			end
			Result := objc_is_kind_of_entity_ (item, a_entity__item)
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

feature {NONE} -- NSEntityDescription Externals

	objc_managed_object_model (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item managedObjectModel];
			 ]"
		end

	objc_managed_object_class_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item managedObjectClassName];
			 ]"
		end

	objc_set_managed_object_class_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityDescription *)$an_item setManagedObjectClassName:$a_name];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item name];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityDescription *)$an_item setName:$a_name];
			 ]"
		end

	objc_is_abstract (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSEntityDescription *)$an_item isAbstract];
			 ]"
		end

	objc_set_abstract_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityDescription *)$an_item setAbstract:$a_flag];
			 ]"
		end

	objc_subentities_by_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item subentitiesByName];
			 ]"
		end

	objc_subentities (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item subentities];
			 ]"
		end

	objc_set_subentities_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityDescription *)$an_item setSubentities:$a_array];
			 ]"
		end

	objc_superentity (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item superentity];
			 ]"
		end

	objc_properties_by_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item propertiesByName];
			 ]"
		end

	objc_properties (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item properties];
			 ]"
		end

	objc_set_properties_ (an_item: POINTER; a_properties: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityDescription *)$an_item setProperties:$a_properties];
			 ]"
		end

	objc_user_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item userInfo];
			 ]"
		end

	objc_set_user_info_ (an_item: POINTER; a_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityDescription *)$an_item setUserInfo:$a_dictionary];
			 ]"
		end

	objc_attributes_by_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item attributesByName];
			 ]"
		end

	objc_relationships_by_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item relationshipsByName];
			 ]"
		end

	objc_relationships_with_destination_entity_ (an_item: POINTER; a_entity: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item relationshipsWithDestinationEntity:$a_entity];
			 ]"
		end

	objc_is_kind_of_entity_ (an_item: POINTER; a_entity: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSEntityDescription *)$an_item isKindOfEntity:$a_entity];
			 ]"
		end

	objc_version_hash (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item versionHash];
			 ]"
		end

	objc_version_hash_modifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item versionHashModifier];
			 ]"
		end

	objc_set_version_hash_modifier_ (an_item: POINTER; a_modifier_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityDescription *)$an_item setVersionHashModifier:$a_modifier_string];
			 ]"
		end

	objc_renaming_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityDescription *)$an_item renamingIdentifier];
			 ]"
		end

	objc_set_renaming_identifier_ (an_item: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityDescription *)$an_item setRenamingIdentifier:$a_value];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSEntityDescription"
		end

end
