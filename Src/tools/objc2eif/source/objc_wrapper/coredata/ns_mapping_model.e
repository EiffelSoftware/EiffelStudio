note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MAPPING_MODEL

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_contents_of_ur_l_,
	make

feature {NONE} -- Initialization

	make_with_contents_of_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSMappingModel Externals

	objc_init_with_contents_of_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMappingModel *)$an_item initWithContentsOfURL:$a_url];
			 ]"
		end

	objc_entity_mappings (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMappingModel *)$an_item entityMappings];
			 ]"
		end

	objc_set_entity_mappings_ (an_item: POINTER; a_mappings: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSMappingModel *)$an_item setEntityMappings:$a_mappings];
			 ]"
		end

	objc_entity_mappings_by_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMappingModel *)$an_item entityMappingsByName];
			 ]"
		end

feature -- NSMappingModel

	entity_mappings: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_entity_mappings (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entity_mappings} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entity_mappings} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_entity_mappings_ (a_mappings: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_mappings__item: POINTER
		do
			if attached a_mappings as a_mappings_attached then
				a_mappings__item := a_mappings_attached.item
			end
			objc_set_entity_mappings_ (item, a_mappings__item)
		end

	entity_mappings_by_name: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_entity_mappings_by_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entity_mappings_by_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entity_mappings_by_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMappingModel"
		end

end
