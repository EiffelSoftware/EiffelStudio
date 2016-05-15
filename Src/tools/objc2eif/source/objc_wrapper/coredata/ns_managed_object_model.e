note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MANAGED_OBJECT_MODEL

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
	make,
	make_with_contents_of_ur_l_

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

feature {NONE} -- NSManagedObjectModel Externals

	objc_init_with_contents_of_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item initWithContentsOfURL:$a_url];
			 ]"
		end

	objc_entities_by_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item entitiesByName];
			 ]"
		end

	objc_entities (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item entities];
			 ]"
		end

	objc_set_entities_ (an_item: POINTER; a_entities: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectModel *)$an_item setEntities:$a_entities];
			 ]"
		end

	objc_configurations (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item configurations];
			 ]"
		end

	objc_entities_for_configuration_ (an_item: POINTER; a_configuration: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item entitiesForConfiguration:$a_configuration];
			 ]"
		end

	objc_set_entities__for_configuration_ (an_item: POINTER; a_entities: POINTER; a_configuration: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectModel *)$an_item setEntities:$a_entities forConfiguration:$a_configuration];
			 ]"
		end

	objc_set_fetch_request_template__for_name_ (an_item: POINTER; a_fetch_request_template: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectModel *)$an_item setFetchRequestTemplate:$a_fetch_request_template forName:$a_name];
			 ]"
		end

	objc_fetch_request_template_for_name_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item fetchRequestTemplateForName:$a_name];
			 ]"
		end

	objc_fetch_request_from_template_with_name__substitution_variables_ (an_item: POINTER; a_name: POINTER; a_variables: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item fetchRequestFromTemplateWithName:$a_name substitutionVariables:$a_variables];
			 ]"
		end

	objc_localization_dictionary (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item localizationDictionary];
			 ]"
		end

	objc_set_localization_dictionary_ (an_item: POINTER; a_localization_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectModel *)$an_item setLocalizationDictionary:$a_localization_dictionary];
			 ]"
		end

	objc_fetch_request_templates_by_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item fetchRequestTemplatesByName];
			 ]"
		end

	objc_version_identifiers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item versionIdentifiers];
			 ]"
		end

	objc_set_version_identifiers_ (an_item: POINTER; a_identifiers: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSManagedObjectModel *)$an_item setVersionIdentifiers:$a_identifiers];
			 ]"
		end

	objc_is_configuration__compatible_with_store_metadata_ (an_item: POINTER; a_configuration: POINTER; a_metadata: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSManagedObjectModel *)$an_item isConfiguration:$a_configuration compatibleWithStoreMetadata:$a_metadata];
			 ]"
		end

	objc_entity_version_hashes_by_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSManagedObjectModel *)$an_item entityVersionHashesByName];
			 ]"
		end

feature -- NSManagedObjectModel

	entities_by_name: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_entities_by_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entities_by_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entities_by_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	entities: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_entities (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entities} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entities} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_entities_ (a_entities: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_entities__item: POINTER
		do
			if attached a_entities as a_entities_attached then
				a_entities__item := a_entities_attached.item
			end
			objc_set_entities_ (item, a_entities__item)
		end

	configurations: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_configurations (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like configurations} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like configurations} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	entities_for_configuration_ (a_configuration: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_configuration__item: POINTER
		do
			if attached a_configuration as a_configuration_attached then
				a_configuration__item := a_configuration_attached.item
			end
			result_pointer := objc_entities_for_configuration_ (item, a_configuration__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entities_for_configuration_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entities_for_configuration_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_entities__for_configuration_ (a_entities: detachable NS_ARRAY; a_configuration: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_entities__item: POINTER
			a_configuration__item: POINTER
		do
			if attached a_entities as a_entities_attached then
				a_entities__item := a_entities_attached.item
			end
			if attached a_configuration as a_configuration_attached then
				a_configuration__item := a_configuration_attached.item
			end
			objc_set_entities__for_configuration_ (item, a_entities__item, a_configuration__item)
		end

	set_fetch_request_template__for_name_ (a_fetch_request_template: detachable NS_FETCH_REQUEST; a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_fetch_request_template__item: POINTER
			a_name__item: POINTER
		do
			if attached a_fetch_request_template as a_fetch_request_template_attached then
				a_fetch_request_template__item := a_fetch_request_template_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_fetch_request_template__for_name_ (item, a_fetch_request_template__item, a_name__item)
		end

	fetch_request_template_for_name_ (a_name: detachable NS_STRING): detachable NS_FETCH_REQUEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			result_pointer := objc_fetch_request_template_for_name_ (item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like fetch_request_template_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like fetch_request_template_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	fetch_request_from_template_with_name__substitution_variables_ (a_name: detachable NS_STRING; a_variables: detachable NS_DICTIONARY): detachable NS_FETCH_REQUEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
			a_variables__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_variables as a_variables_attached then
				a_variables__item := a_variables_attached.item
			end
			result_pointer := objc_fetch_request_from_template_with_name__substitution_variables_ (item, a_name__item, a_variables__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like fetch_request_from_template_with_name__substitution_variables_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like fetch_request_from_template_with_name__substitution_variables_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localization_dictionary: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localization_dictionary (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localization_dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localization_dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_localization_dictionary_ (a_localization_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_localization_dictionary__item: POINTER
		do
			if attached a_localization_dictionary as a_localization_dictionary_attached then
				a_localization_dictionary__item := a_localization_dictionary_attached.item
			end
			objc_set_localization_dictionary_ (item, a_localization_dictionary__item)
		end

	fetch_request_templates_by_name: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_fetch_request_templates_by_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like fetch_request_templates_by_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like fetch_request_templates_by_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	version_identifiers: detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_version_identifiers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like version_identifiers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like version_identifiers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_version_identifiers_ (a_identifiers: detachable NS_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_identifiers__item: POINTER
		do
			if attached a_identifiers as a_identifiers_attached then
				a_identifiers__item := a_identifiers_attached.item
			end
			objc_set_version_identifiers_ (item, a_identifiers__item)
		end

	is_configuration__compatible_with_store_metadata_ (a_configuration: detachable NS_STRING; a_metadata: detachable NS_DICTIONARY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_configuration__item: POINTER
			a_metadata__item: POINTER
		do
			if attached a_configuration as a_configuration_attached then
				a_configuration__item := a_configuration_attached.item
			end
			if attached a_metadata as a_metadata_attached then
				a_metadata__item := a_metadata_attached.item
			end
			Result := objc_is_configuration__compatible_with_store_metadata_ (item, a_configuration__item, a_metadata__item)
		end

	entity_version_hashes_by_name: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_entity_version_hashes_by_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entity_version_hashes_by_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entity_version_hashes_by_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSManagedObjectModel"
		end

end
