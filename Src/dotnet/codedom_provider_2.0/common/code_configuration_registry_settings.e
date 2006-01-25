indexing
	description: "Registry settings used by Eiffel Codedom Compiler for configurations"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_CONFIGURATION_REGISTRY_SETTINGS

inherit
	CODE_REGISTRY_KEYS

	CODE_SHARED_EVENT_MANAGER
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
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_file_name := {SYSTEM_DLL_PROCESS}.get_current_process.main_module.file_name
				if l_file_name /= Void then
					Result := application_config_path (l_file_name)
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_process_file_name, [])
				end
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
		
	application_config_path (a_file_name: STRING): STRING is
			-- Path to configuration file associated with process `a_file_name' if any
			-- otherwise default path to configuration file
			-- Note: this feature does not guarentee the existence of the actual file
		require
			non_void_file_name: a_file_name /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := Config_table.item (a_file_name)
			end
			if Result = Void then
				Result := default_config_file_path
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

	registered_applications: LIST [STRING] is
			-- List of registered applications
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := Config_table.current_keys
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
	
	registered_configurations: LIST [STRING] is
			-- List of registered configurations
		local
			l_retried: BOOLEAN
			l_conf: STRING
			l_configs: LIST [STRING]
		do
			if not l_retried then
				create {ARRAYED_LIST [STRING]} Result.make (10)
				l_conf := default_config_file_path
				if l_conf /= Void then
					Result.extend (l_conf)
				end
				l_configs := Config_table.linear_representation
				if l_configs /= Void then
					Result.append (l_configs)
				end
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

	default_config_file_path: STRING is
			-- Path to default configuration file
		local
			l_key: REGISTRY_KEY
			l_value: SYSTEM_STRING
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_key := {REGISTRY}.local_machine.open_sub_key (Configurations_key, False)
				if l_key /= Void then
					l_value ?= l_key.get_value (Void)
					if l_value /= Void then
						Result := l_value
					end
					l_key.close
				end
				if Result = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_default_config, [])
				end
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

feature -- Status Report

	is_registered (a_file_name: STRING): BOOLEAN is
			-- Is application with file name `a_file_name' registered?
		require
			non_void_file_name: a_file_name /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := Config_table.has (a_file_name)
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
		
feature -- Basic Operation

	register (a_file_name, a_config_path: STRING) is
			-- Register process `a_file_name' to use configuration file `a_config_path'.
		require
			non_void_file_name: a_file_name /= Void
			non_void_config_path: a_config_path /= Void
			not_registered: not is_registered (a_file_name)
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Config_table.put (a_config_path, a_file_name)	
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
	
	change_application_config_path (a_file_name, a_config_path: STRING) is
			-- Change registered process configuration path
		require
			non_void_file_name: a_file_name /= Void
			non_void_config_path: a_config_path /= Void
			registered: is_registered (a_file_name)
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Config_table.replace (a_config_path, a_file_name)
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

	remove_application (a_file_name: STRING) is
			-- Remove registry information related to application `a_file_name'
			--| Used by Eiffel Codedom Provider Manager
		require
			non_void_file_name: a_file_name /= Void
			registered: is_registered (a_file_name)
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Config_table.remove (a_file_name)
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

	register_default_configuration (a_config_path: STRING) is
			-- Register default configuration to use `a_config_path'.
		require
			non_void_config_path: a_config_path /= Void
		local
			l_key: REGISTRY_KEY
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_key := {REGISTRY}.local_machine.open_sub_key (Configurations_key, True)
				if l_key = Void then
					l_key := {REGISTRY}.local_machine.create_sub_key (Configurations_key)
				end
				l_key.set_value (Void, a_config_path.to_cil)
				l_key.close
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
	
	unregister_default_configuration is
			-- Register default configuration to use `a_config_path'.
		local
			l_key: REGISTRY_KEY
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_key := {REGISTRY}.local_machine.open_sub_key (Configurations_key, True)
				if l_key /= Void then
					l_key.delete_value (("").to_cil)
					l_key.close
				end
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

feature {NONE} -- Private Access

	Config_table: CODE_REGISTRY_TABLE is
			-- Table holding configuration files path and applications
		once
			create Result.make (Configurations_key, Applications_key)
		end

end -- class CODE_CONFIGURATION_REGISTRY_SETTINGS

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