note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MIGRATION_MANAGER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_source_model__destination_model_,
	make

feature {NONE} -- Initialization

	make_with_source_model__destination_model_ (a_source_model: detachable NS_MANAGED_OBJECT_MODEL; a_destination_model: detachable NS_MANAGED_OBJECT_MODEL)
			-- Initialize `Current'.
		local
			a_source_model__item: POINTER
			a_destination_model__item: POINTER
		do
			if attached a_source_model as a_source_model_attached then
				a_source_model__item := a_source_model_attached.item
			end
			if attached a_destination_model as a_destination_model_attached then
				a_destination_model__item := a_destination_model_attached.item
			end
			make_with_pointer (objc_init_with_source_model__destination_model_(allocate_object, a_source_model__item, a_destination_model__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSMigrationManager Externals

	objc_init_with_source_model__destination_model_ (an_item: POINTER; a_source_model: POINTER; a_destination_model: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item initWithSourceModel:$a_source_model destinationModel:$a_destination_model];
			 ]"
		end

--	objc_migrate_store_from_ur_l__type__options__with_mapping_model__to_destination_ur_l__destination_type__destination_options__error_ (an_item: POINTER; a_source_url: POINTER; a_s_store_type: POINTER; a_s_options: POINTER; a_mappings: POINTER; a_d_url: POINTER; a_d_store_type: POINTER; a_d_options: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSMigrationManager *)$an_item migrateStoreFromURL:$a_source_url type:$a_s_store_type options:$a_s_options withMappingModel:$a_mappings toDestinationURL:$a_d_url destinationType:$a_d_store_type destinationOptions:$a_d_options error:];
--			 ]"
--		end

	objc_reset (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSMigrationManager *)$an_item reset];
			 ]"
		end

	objc_mapping_model (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item mappingModel];
			 ]"
		end

	objc_source_model (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item sourceModel];
			 ]"
		end

	objc_destination_model (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item destinationModel];
			 ]"
		end

	objc_source_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item sourceContext];
			 ]"
		end

	objc_destination_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item destinationContext];
			 ]"
		end

	objc_source_entity_for_entity_mapping_ (an_item: POINTER; a_m_entity: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item sourceEntityForEntityMapping:$a_m_entity];
			 ]"
		end

	objc_destination_entity_for_entity_mapping_ (an_item: POINTER; a_m_entity: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item destinationEntityForEntityMapping:$a_m_entity];
			 ]"
		end

	objc_associate_source_instance__with_destination_instance__for_entity_mapping_ (an_item: POINTER; a_source_instance: POINTER; a_destination_instance: POINTER; a_entity_mapping: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSMigrationManager *)$an_item associateSourceInstance:$a_source_instance withDestinationInstance:$a_destination_instance forEntityMapping:$a_entity_mapping];
			 ]"
		end

	objc_destination_instances_for_entity_mapping_named__source_instances_ (an_item: POINTER; a_mapping_name: POINTER; a_source_instances: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item destinationInstancesForEntityMappingNamed:$a_mapping_name sourceInstances:$a_source_instances];
			 ]"
		end

	objc_source_instances_for_entity_mapping_named__destination_instances_ (an_item: POINTER; a_mapping_name: POINTER; a_destination_instances: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item sourceInstancesForEntityMappingNamed:$a_mapping_name destinationInstances:$a_destination_instances];
			 ]"
		end

	objc_current_entity_mapping (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item currentEntityMapping];
			 ]"
		end

	objc_migration_progress (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSMigrationManager *)$an_item migrationProgress];
			 ]"
		end

	objc_user_info (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMigrationManager *)$an_item userInfo];
			 ]"
		end

	objc_set_user_info_ (an_item: POINTER; a_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSMigrationManager *)$an_item setUserInfo:$a_dict];
			 ]"
		end

	objc_cancel_migration_with_error_ (an_item: POINTER; a_error: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSMigrationManager *)$an_item cancelMigrationWithError:$a_error];
			 ]"
		end

feature -- NSMigrationManager

--	migrate_store_from_ur_l__type__options__with_mapping_model__to_destination_ur_l__destination_type__destination_options__error_ (a_source_url: detachable NS_URL; a_s_store_type: detachable NS_STRING; a_s_options: detachable NS_DICTIONARY; a_mappings: detachable NS_MAPPING_MODEL; a_d_url: detachable NS_URL; a_d_store_type: detachable NS_STRING; a_d_options: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_source_url__item: POINTER
--			a_s_store_type__item: POINTER
--			a_s_options__item: POINTER
--			a_mappings__item: POINTER
--			a_d_url__item: POINTER
--			a_d_store_type__item: POINTER
--			a_d_options__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_source_url as a_source_url_attached then
--				a_source_url__item := a_source_url_attached.item
--			end
--			if attached a_s_store_type as a_s_store_type_attached then
--				a_s_store_type__item := a_s_store_type_attached.item
--			end
--			if attached a_s_options as a_s_options_attached then
--				a_s_options__item := a_s_options_attached.item
--			end
--			if attached a_mappings as a_mappings_attached then
--				a_mappings__item := a_mappings_attached.item
--			end
--			if attached a_d_url as a_d_url_attached then
--				a_d_url__item := a_d_url_attached.item
--			end
--			if attached a_d_store_type as a_d_store_type_attached then
--				a_d_store_type__item := a_d_store_type_attached.item
--			end
--			if attached a_d_options as a_d_options_attached then
--				a_d_options__item := a_d_options_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_migrate_store_from_ur_l__type__options__with_mapping_model__to_destination_ur_l__destination_type__destination_options__error_ (item, a_source_url__item, a_s_store_type__item, a_s_options__item, a_mappings__item, a_d_url__item, a_d_store_type__item, a_d_options__item, a_error__item)
--		end

	reset
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reset (item)
		end

	mapping_model: detachable NS_MAPPING_MODEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mapping_model (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mapping_model} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mapping_model} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	source_model: detachable NS_MANAGED_OBJECT_MODEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_source_model (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like source_model} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like source_model} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	destination_model: detachable NS_MANAGED_OBJECT_MODEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_destination_model (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like destination_model} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like destination_model} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	source_context: detachable NS_MANAGED_OBJECT_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_source_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like source_context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like source_context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	destination_context: detachable NS_MANAGED_OBJECT_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_destination_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like destination_context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like destination_context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	source_entity_for_entity_mapping_ (a_m_entity: detachable NS_ENTITY_MAPPING): detachable NS_ENTITY_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_m_entity__item: POINTER
		do
			if attached a_m_entity as a_m_entity_attached then
				a_m_entity__item := a_m_entity_attached.item
			end
			result_pointer := objc_source_entity_for_entity_mapping_ (item, a_m_entity__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like source_entity_for_entity_mapping_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like source_entity_for_entity_mapping_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	destination_entity_for_entity_mapping_ (a_m_entity: detachable NS_ENTITY_MAPPING): detachable NS_ENTITY_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_m_entity__item: POINTER
		do
			if attached a_m_entity as a_m_entity_attached then
				a_m_entity__item := a_m_entity_attached.item
			end
			result_pointer := objc_destination_entity_for_entity_mapping_ (item, a_m_entity__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like destination_entity_for_entity_mapping_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like destination_entity_for_entity_mapping_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	associate_source_instance__with_destination_instance__for_entity_mapping_ (a_source_instance: detachable NS_MANAGED_OBJECT; a_destination_instance: detachable NS_MANAGED_OBJECT; a_entity_mapping: detachable NS_ENTITY_MAPPING)
			-- Auto generated Objective-C wrapper.
		local
			a_source_instance__item: POINTER
			a_destination_instance__item: POINTER
			a_entity_mapping__item: POINTER
		do
			if attached a_source_instance as a_source_instance_attached then
				a_source_instance__item := a_source_instance_attached.item
			end
			if attached a_destination_instance as a_destination_instance_attached then
				a_destination_instance__item := a_destination_instance_attached.item
			end
			if attached a_entity_mapping as a_entity_mapping_attached then
				a_entity_mapping__item := a_entity_mapping_attached.item
			end
			objc_associate_source_instance__with_destination_instance__for_entity_mapping_ (item, a_source_instance__item, a_destination_instance__item, a_entity_mapping__item)
		end

	destination_instances_for_entity_mapping_named__source_instances_ (a_mapping_name: detachable NS_STRING; a_source_instances: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_mapping_name__item: POINTER
			a_source_instances__item: POINTER
		do
			if attached a_mapping_name as a_mapping_name_attached then
				a_mapping_name__item := a_mapping_name_attached.item
			end
			if attached a_source_instances as a_source_instances_attached then
				a_source_instances__item := a_source_instances_attached.item
			end
			result_pointer := objc_destination_instances_for_entity_mapping_named__source_instances_ (item, a_mapping_name__item, a_source_instances__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like destination_instances_for_entity_mapping_named__source_instances_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like destination_instances_for_entity_mapping_named__source_instances_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	source_instances_for_entity_mapping_named__destination_instances_ (a_mapping_name: detachable NS_STRING; a_destination_instances: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_mapping_name__item: POINTER
			a_destination_instances__item: POINTER
		do
			if attached a_mapping_name as a_mapping_name_attached then
				a_mapping_name__item := a_mapping_name_attached.item
			end
			if attached a_destination_instances as a_destination_instances_attached then
				a_destination_instances__item := a_destination_instances_attached.item
			end
			result_pointer := objc_source_instances_for_entity_mapping_named__destination_instances_ (item, a_mapping_name__item, a_destination_instances__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like source_instances_for_entity_mapping_named__destination_instances_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like source_instances_for_entity_mapping_named__destination_instances_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	current_entity_mapping: detachable NS_ENTITY_MAPPING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_entity_mapping (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_entity_mapping} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_entity_mapping} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	migration_progress: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_migration_progress (item)
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

	cancel_migration_with_error_ (a_error: detachable NS_ERROR)
			-- Auto generated Objective-C wrapper.
		local
			a_error__item: POINTER
		do
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			objc_cancel_migration_with_error_ (item, a_error__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMigrationManager"
		end

end
