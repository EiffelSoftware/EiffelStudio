note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ENTITY_MIGRATION_POLICY

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

feature -- NSEntityMigrationPolicy

--	begin_entity_mapping__manager__error_ (a_mapping: detachable NS_ENTITY_MAPPING; a_manager: detachable NS_MIGRATION_MANAGER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_mapping__item: POINTER
--			a_manager__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_mapping as a_mapping_attached then
--				a_mapping__item := a_mapping_attached.item
--			end
--			if attached a_manager as a_manager_attached then
--				a_manager__item := a_manager_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_begin_entity_mapping__manager__error_ (item, a_mapping__item, a_manager__item, a_error__item)
--		end

--	create_destination_instances_for_source_instance__entity_mapping__manager__error_ (a_s_instance: detachable NS_MANAGED_OBJECT; a_mapping: detachable NS_ENTITY_MAPPING; a_manager: detachable NS_MIGRATION_MANAGER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_s_instance__item: POINTER
--			a_mapping__item: POINTER
--			a_manager__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_s_instance as a_s_instance_attached then
--				a_s_instance__item := a_s_instance_attached.item
--			end
--			if attached a_mapping as a_mapping_attached then
--				a_mapping__item := a_mapping_attached.item
--			end
--			if attached a_manager as a_manager_attached then
--				a_manager__item := a_manager_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_create_destination_instances_for_source_instance__entity_mapping__manager__error_ (item, a_s_instance__item, a_mapping__item, a_manager__item, a_error__item)
--		end

--	end_instance_creation_for_entity_mapping__manager__error_ (a_mapping: detachable NS_ENTITY_MAPPING; a_manager: detachable NS_MIGRATION_MANAGER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_mapping__item: POINTER
--			a_manager__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_mapping as a_mapping_attached then
--				a_mapping__item := a_mapping_attached.item
--			end
--			if attached a_manager as a_manager_attached then
--				a_manager__item := a_manager_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_end_instance_creation_for_entity_mapping__manager__error_ (item, a_mapping__item, a_manager__item, a_error__item)
--		end

--	create_relationships_for_destination_instance__entity_mapping__manager__error_ (a_d_instance: detachable NS_MANAGED_OBJECT; a_mapping: detachable NS_ENTITY_MAPPING; a_manager: detachable NS_MIGRATION_MANAGER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_d_instance__item: POINTER
--			a_mapping__item: POINTER
--			a_manager__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_d_instance as a_d_instance_attached then
--				a_d_instance__item := a_d_instance_attached.item
--			end
--			if attached a_mapping as a_mapping_attached then
--				a_mapping__item := a_mapping_attached.item
--			end
--			if attached a_manager as a_manager_attached then
--				a_manager__item := a_manager_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_create_relationships_for_destination_instance__entity_mapping__manager__error_ (item, a_d_instance__item, a_mapping__item, a_manager__item, a_error__item)
--		end

--	end_relationship_creation_for_entity_mapping__manager__error_ (a_mapping: detachable NS_ENTITY_MAPPING; a_manager: detachable NS_MIGRATION_MANAGER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_mapping__item: POINTER
--			a_manager__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_mapping as a_mapping_attached then
--				a_mapping__item := a_mapping_attached.item
--			end
--			if attached a_manager as a_manager_attached then
--				a_manager__item := a_manager_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_end_relationship_creation_for_entity_mapping__manager__error_ (item, a_mapping__item, a_manager__item, a_error__item)
--		end

--	perform_custom_validation_for_entity_mapping__manager__error_ (a_mapping: detachable NS_ENTITY_MAPPING; a_manager: detachable NS_MIGRATION_MANAGER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_mapping__item: POINTER
--			a_manager__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_mapping as a_mapping_attached then
--				a_mapping__item := a_mapping_attached.item
--			end
--			if attached a_manager as a_manager_attached then
--				a_manager__item := a_manager_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_perform_custom_validation_for_entity_mapping__manager__error_ (item, a_mapping__item, a_manager__item, a_error__item)
--		end

--	end_entity_mapping__manager__error_ (a_mapping: detachable NS_ENTITY_MAPPING; a_manager: detachable NS_MIGRATION_MANAGER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_mapping__item: POINTER
--			a_manager__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_mapping as a_mapping_attached then
--				a_mapping__item := a_mapping_attached.item
--			end
--			if attached a_manager as a_manager_attached then
--				a_manager__item := a_manager_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_end_entity_mapping__manager__error_ (item, a_mapping__item, a_manager__item, a_error__item)
--		end

feature {NONE} -- NSEntityMigrationPolicy Externals

--	objc_begin_entity_mapping__manager__error_ (an_item: POINTER; a_mapping: POINTER; a_manager: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSEntityMigrationPolicy *)$an_item beginEntityMapping:$a_mapping manager:$a_manager error:];
--			 ]"
--		end

--	objc_create_destination_instances_for_source_instance__entity_mapping__manager__error_ (an_item: POINTER; a_s_instance: POINTER; a_mapping: POINTER; a_manager: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSEntityMigrationPolicy *)$an_item createDestinationInstancesForSourceInstance:$a_s_instance entityMapping:$a_mapping manager:$a_manager error:];
--			 ]"
--		end

--	objc_end_instance_creation_for_entity_mapping__manager__error_ (an_item: POINTER; a_mapping: POINTER; a_manager: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSEntityMigrationPolicy *)$an_item endInstanceCreationForEntityMapping:$a_mapping manager:$a_manager error:];
--			 ]"
--		end

--	objc_create_relationships_for_destination_instance__entity_mapping__manager__error_ (an_item: POINTER; a_d_instance: POINTER; a_mapping: POINTER; a_manager: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSEntityMigrationPolicy *)$an_item createRelationshipsForDestinationInstance:$a_d_instance entityMapping:$a_mapping manager:$a_manager error:];
--			 ]"
--		end

--	objc_end_relationship_creation_for_entity_mapping__manager__error_ (an_item: POINTER; a_mapping: POINTER; a_manager: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSEntityMigrationPolicy *)$an_item endRelationshipCreationForEntityMapping:$a_mapping manager:$a_manager error:];
--			 ]"
--		end

--	objc_perform_custom_validation_for_entity_mapping__manager__error_ (an_item: POINTER; a_mapping: POINTER; a_manager: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSEntityMigrationPolicy *)$an_item performCustomValidationForEntityMapping:$a_mapping manager:$a_manager error:];
--			 ]"
--		end

--	objc_end_entity_mapping__manager__error_ (an_item: POINTER; a_mapping: POINTER; a_manager: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return [(NSEntityMigrationPolicy *)$an_item endEntityMapping:$a_mapping manager:$a_manager error:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSEntityMigrationPolicy"
		end

end
