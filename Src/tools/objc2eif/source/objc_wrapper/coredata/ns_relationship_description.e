note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RELATIONSHIP_DESCRIPTION

inherit
	NS_PROPERTY_DESCRIPTION
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSRelationshipDescription

	destination_entity: detachable NS_ENTITY_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_destination_entity (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like destination_entity} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like destination_entity} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_destination_entity_ (a_entity: detachable NS_ENTITY_DESCRIPTION)
			-- Auto generated Objective-C wrapper.
		local
			a_entity__item: POINTER
		do
			if attached a_entity as a_entity_attached then
				a_entity__item := a_entity_attached.item
			end
			objc_set_destination_entity_ (item, a_entity__item)
		end

	inverse_relationship: detachable NS_RELATIONSHIP_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_inverse_relationship (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like inverse_relationship} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like inverse_relationship} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_inverse_relationship_ (a_relationship: detachable NS_RELATIONSHIP_DESCRIPTION)
			-- Auto generated Objective-C wrapper.
		local
			a_relationship__item: POINTER
		do
			if attached a_relationship as a_relationship_attached then
				a_relationship__item := a_relationship_attached.item
			end
			objc_set_inverse_relationship_ (item, a_relationship__item)
		end

	max_count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_count (item)
		end

	set_max_count_ (a_max_count: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_count_ (item, a_max_count)
		end

	min_count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_min_count (item)
		end

	set_min_count_ (a_min_count: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_count_ (item, a_min_count)
		end

	delete_rule: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_delete_rule (item)
		end

	set_delete_rule_ (a_rule: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_delete_rule_ (item, a_rule)
		end

	is_to_many: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_to_many (item)
		end

feature {NONE} -- NSRelationshipDescription Externals

	objc_destination_entity (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRelationshipDescription *)$an_item destinationEntity];
			 ]"
		end

	objc_set_destination_entity_ (an_item: POINTER; a_entity: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSRelationshipDescription *)$an_item setDestinationEntity:$a_entity];
			 ]"
		end

	objc_inverse_relationship (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRelationshipDescription *)$an_item inverseRelationship];
			 ]"
		end

	objc_set_inverse_relationship_ (an_item: POINTER; a_relationship: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSRelationshipDescription *)$an_item setInverseRelationship:$a_relationship];
			 ]"
		end

	objc_max_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSRelationshipDescription *)$an_item maxCount];
			 ]"
		end

	objc_set_max_count_ (an_item: POINTER; a_max_count: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSRelationshipDescription *)$an_item setMaxCount:$a_max_count];
			 ]"
		end

	objc_min_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSRelationshipDescription *)$an_item minCount];
			 ]"
		end

	objc_set_min_count_ (an_item: POINTER; a_min_count: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSRelationshipDescription *)$an_item setMinCount:$a_min_count];
			 ]"
		end

	objc_delete_rule (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSRelationshipDescription *)$an_item deleteRule];
			 ]"
		end

	objc_set_delete_rule_ (an_item: POINTER; a_rule: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSRelationshipDescription *)$an_item setDeleteRule:$a_rule];
			 ]"
		end

	objc_is_to_many (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSRelationshipDescription *)$an_item isToMany];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRelationshipDescription"
		end

end
