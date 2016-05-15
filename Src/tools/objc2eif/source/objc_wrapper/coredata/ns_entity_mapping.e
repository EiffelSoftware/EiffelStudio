note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ENTITY_MAPPING

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSEntityMapping

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

	mapping_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_mapping_type (item)
		end

	set_mapping_type_ (a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_mapping_type_ (item, a_type)
		end

	source_entity_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_source_entity_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like source_entity_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like source_entity_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_source_entity_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_source_entity_name_ (item, a_name__item)
		end

	source_entity_version_hash: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_source_entity_version_hash (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like source_entity_version_hash} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like source_entity_version_hash} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_source_entity_version_hash_ (a_vhash: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_vhash__item: POINTER
		do
			if attached a_vhash as a_vhash_attached then
				a_vhash__item := a_vhash_attached.item
			end
			objc_set_source_entity_version_hash_ (item, a_vhash__item)
		end

	destination_entity_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_destination_entity_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like destination_entity_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like destination_entity_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_destination_entity_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_destination_entity_name_ (item, a_name__item)
		end

	destination_entity_version_hash: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_destination_entity_version_hash (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like destination_entity_version_hash} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like destination_entity_version_hash} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_destination_entity_version_hash_ (a_vhash: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_vhash__item: POINTER
		do
			if attached a_vhash as a_vhash_attached then
				a_vhash__item := a_vhash_attached.item
			end
			objc_set_destination_entity_version_hash_ (item, a_vhash__item)
		end

	attribute_mappings: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attribute_mappings (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_mappings} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_mappings} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attribute_mappings_ (a_mappings: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_mappings__item: POINTER
		do
			if attached a_mappings as a_mappings_attached then
				a_mappings__item := a_mappings_attached.item
			end
			objc_set_attribute_mappings_ (item, a_mappings__item)
		end

	relationship_mappings: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_relationship_mappings (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like relationship_mappings} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like relationship_mappings} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_relationship_mappings_ (a_mappings: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_mappings__item: POINTER
		do
			if attached a_mappings as a_mappings_attached then
				a_mappings__item := a_mappings_attached.item
			end
			objc_set_relationship_mappings_ (item, a_mappings__item)
		end

	source_expression: detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_source_expression (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like source_expression} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like source_expression} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_source_expression_ (a_source: detachable NS_EXPRESSION)
			-- Auto generated Objective-C wrapper.
		local
			a_source__item: POINTER
		do
			if attached a_source as a_source_attached then
				a_source__item := a_source_attached.item
			end
			objc_set_source_expression_ (item, a_source__item)
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

	set_user_info_ (a_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_dict__item: POINTER
		do
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			objc_set_user_info_ (item, a_dict__item)
		end

	entity_migration_policy_class_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_entity_migration_policy_class_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entity_migration_policy_class_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entity_migration_policy_class_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_entity_migration_policy_class_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_entity_migration_policy_class_name_ (item, a_name__item)
		end

feature {NONE} -- NSEntityMapping Externals

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item name];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setName:$a_name];
			 ]"
		end

	objc_mapping_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSEntityMapping *)$an_item mappingType];
			 ]"
		end

	objc_set_mapping_type_ (an_item: POINTER; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setMappingType:$a_type];
			 ]"
		end

	objc_source_entity_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item sourceEntityName];
			 ]"
		end

	objc_set_source_entity_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setSourceEntityName:$a_name];
			 ]"
		end

	objc_source_entity_version_hash (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item sourceEntityVersionHash];
			 ]"
		end

	objc_set_source_entity_version_hash_ (an_item: POINTER; a_vhash: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setSourceEntityVersionHash:$a_vhash];
			 ]"
		end

	objc_destination_entity_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item destinationEntityName];
			 ]"
		end

	objc_set_destination_entity_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setDestinationEntityName:$a_name];
			 ]"
		end

	objc_destination_entity_version_hash (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item destinationEntityVersionHash];
			 ]"
		end

	objc_set_destination_entity_version_hash_ (an_item: POINTER; a_vhash: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setDestinationEntityVersionHash:$a_vhash];
			 ]"
		end

	objc_attribute_mappings (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item attributeMappings];
			 ]"
		end

	objc_set_attribute_mappings_ (an_item: POINTER; a_mappings: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setAttributeMappings:$a_mappings];
			 ]"
		end

	objc_relationship_mappings (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item relationshipMappings];
			 ]"
		end

	objc_set_relationship_mappings_ (an_item: POINTER; a_mappings: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setRelationshipMappings:$a_mappings];
			 ]"
		end

	objc_source_expression (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item sourceExpression];
			 ]"
		end

	objc_set_source_expression_ (an_item: POINTER; a_source: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setSourceExpression:$a_source];
			 ]"
		end

	objc_user_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item userInfo];
			 ]"
		end

	objc_set_user_info_ (an_item: POINTER; a_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setUserInfo:$a_dict];
			 ]"
		end

	objc_entity_migration_policy_class_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSEntityMapping *)$an_item entityMigrationPolicyClassName];
			 ]"
		end

	objc_set_entity_migration_policy_class_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSEntityMapping *)$an_item setEntityMigrationPolicyClassName:$a_name];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSEntityMapping"
		end

end
