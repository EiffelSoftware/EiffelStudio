indexing
	description: "Registry settings used by Eiffel Codedom Compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_REGISTRY_SETTINGS

inherit
	ECD_REGISTRY_KEYS

	ECD_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature -- Access

	current_process_config_path: STRING is
			-- Path to configuration file for this process if any
			-- otherwise default path to configuration file
			-- Note: this feature does not guarentee the existence of the actual file
		local
			l_file_name: STRING
		do
			l_file_name := feature {SYSTEM_DLL_PROCESS}.get_current_process.main_module.file_name
			if l_file_name /= Void then
				Result := application_config_path (l_file_name)
			else
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_process_file_name, [])
			end
		end
		
	application_config_path (a_file_name: STRING): STRING is
			-- Path to configuration file associated with process `a_file_name' if any
			-- otherwise default path to configuration file
			-- Note: this feature does not guarentee the existence of the actual file
		require
			non_void_file_name: a_file_name /= Void
		local
			l_key: REGISTRY_KEY
			l_guid: STRING
			l_value: SYSTEM_STRING
		do
			l_guid := application_guid (a_file_name)
			l_key := feature {REGISTRY}.local_machine.open_sub_key (Configurations_key, False)
			if l_guid /= Void and l_key /= Void then
				l_value ?= l_key.get_value (l_guid.to_cil)
				if l_value /= Void then
					Result := l_value
				end
			end
			if Result = Void then
				Result := default_config_file_path
			end
			if l_key /= Void then
				l_key.close
			end
		end

	registered_applications: LIST [STRING] is
			-- List of registered applications
		local
			l_key: REGISTRY_KEY
			i, l_count: INTEGER
			l_guids: NATIVE_ARRAY [SYSTEM_STRING]
			l_value: SYSTEM_STRING
		do
			l_key := feature {REGISTRY}.local_machine.open_sub_key (Applications_key, False)
			if l_key /= Void then
				l_guids := l_key.get_value_names
				from
					l_count := l_guids.count
					create {ARRAYED_LIST [STRING]} Result.make (l_count)
				until
					i = l_count
				loop
					l_value ?= l_key.get_value (l_guids.item (i))
					Result.extend (l_value)
					i := i + 1
				end
				l_key.close
			end			
		end
	
	registered_configurations: LIST [STRING] is
			-- List of registered configurations
		local
			l_key: REGISTRY_KEY
			i, l_count: INTEGER
			l_guids: NATIVE_ARRAY [SYSTEM_STRING]
			l_value: SYSTEM_STRING
		do
			l_key := feature {REGISTRY}.local_machine.open_sub_key (Configurations_key, False)
			if l_key /= Void then
				l_guids := l_key.get_value_names
				from
					l_count := l_guids.count
					create {ARRAYED_LIST [STRING]} Result.make (l_count)
					Result.compare_objects
				until
					i = l_count
				loop
					l_value ?= l_key.get_value (l_guids.item (i))
					if not Result.has (l_value) then -- There can be multiple keys for the same configuration because
						Result.extend (l_value)			-- multiple applications may use the same configuration
					end
					i := i + 1
				end
				l_key.close
			end			
		end

	default_config_file_path: STRING is
			-- Path to default configuration file
		local
			l_key: REGISTRY_KEY
			l_value: SYSTEM_STRING
		do
			l_key := feature {REGISTRY}.local_machine.open_sub_key (Configurations_key, False)
			if l_key /= Void then
				l_value ?= l_key.get_value (Void)
				if l_value /= Void then
					Result := l_value
				end
				l_key.close
			end
			if Result = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_default_config, [])
			end
		end

feature -- Status Report

	is_registered (a_file_name: STRING): BOOLEAN is
			-- Is process `a_file_name' registered?
		do
			Result := application_guid (a_file_name) /= Void
		end
		
feature -- Basic Operation

	register (a_file_name, a_config_path: STRING) is
			-- Register process `a_file_name' to use configuration file `a_config_path'.
		require
			non_void_file_name: a_file_name /= Void
			non_void_config_path: a_config_path /= Void
			not_registered: not is_registered (a_file_name)
		local
			l_key: REGISTRY_KEY
			l_guid: SYSTEM_STRING
		do
			l_guid := feature {GUID}.new_guid.to_string

			l_key := feature {REGISTRY}.local_machine.open_sub_key (Applications_key, True)
			if l_key = Void then
				l_key := feature {REGISTRY}.local_machine.create_sub_key (Applications_key)
			end
			l_key.set_value (l_guid, a_file_name.to_cil)
			l_key.close

			change_application_config_path (a_file_name, a_config_path)
		end
	
	register_default_configuration (a_config_path: STRING) is
			-- Register default configuration to use `a_config_path'.
		require
			non_void_config_path: a_config_path /= Void
		local
			l_key: REGISTRY_KEY
		do
			l_key := feature {REGISTRY}.local_machine.open_sub_key (Configurations_key, True)
			if l_key = Void then
				l_key := feature {REGISTRY}.local_machine.create_sub_key (Configurations_key)
			end
			l_key.set_value (Void, a_config_path.to_cil)
			l_key.close
		end
	
	change_application_config_path (a_file_name, a_config_path: STRING) is
			-- Change registered process configuration path
		require
			non_void_file_name: a_file_name /= Void
			non_void_config_path: a_config_path /= Void
			registered: is_registered (a_file_name)
		local
			l_key: REGISTRY_KEY
			l_guid: STRING
		do
			l_guid := application_guid (a_file_name)

			l_key := feature {REGISTRY}.local_machine.open_sub_key (Configurations_key, True)
			if l_key = Void then
				l_key := feature {REGISTRY}.local_machine.create_sub_key (Configurations_key)
			end
			l_key.set_value (l_guid, a_config_path.to_cil)
			l_key.close
		end

	remove_application (a_file_name: STRING) is
			-- Remove registry information related to application `a_file_name'
			--| Used by Eiffel Codedom Provider Manager
		require
			non_void_file_name: a_file_name /= Void
			registered: is_registered (a_file_name)
		local
			l_key: REGISTRY_KEY
			l_guid: STRING
		do
			l_guid := application_guid (a_file_name)

			l_key := feature {REGISTRY}.local_machine.open_sub_key (Configurations_key, True)
			if l_key /= Void then
				l_key.delete_value (l_guid)
				l_key.close
			end

			l_key := feature {REGISTRY}.local_machine.open_sub_key (Applications_key, True)
			if l_key /= Void then
				l_key.delete_value (l_guid)
				l_key.close
			end
		end

	unregister_default_configuration is
			-- Register default configuration to use `a_config_path'.
		local
			l_key: REGISTRY_KEY
		do
			l_key := feature {REGISTRY}.local_machine.open_sub_key (Configurations_key, True)
			if l_key /= Void then
				l_key.delete_value ("")
				l_key.close
			end
		end

feature {NONE} -- Implementation

	application_guid (a_file_name: STRING): STRING is
			-- GUID identifying executable `a_file_name' in Eiffel Codedom Provider registry settings if any
		require
			non_void_file_name: a_file_name /= Void
		local
			l_key: REGISTRY_KEY
			l_guids: NATIVE_ARRAY [SYSTEM_STRING]
			i, l_count: INTEGER
			l_value: SYSTEM_STRING
		do
			l_key := feature {REGISTRY}.local_machine.open_sub_key (Applications_key, False)
			if l_key /= Void then
				l_guids := l_key.get_value_names
				from
					l_count := l_guids.count
				until
					i = l_count or Result /= Void
				loop
					l_value ?= l_key.get_value (l_guids.item (i))
					if l_value /= Void and then l_value.equals (a_file_name.to_cil) then
						Result := l_guids.item (i)
					end
					i := i + 1
				end
				l_key.close
			end			
		end

end -- class ECD_REGISTRY_SETTINGS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------