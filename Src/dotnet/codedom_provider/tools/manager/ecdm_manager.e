indexing
	description: "Configuration files manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDM_MANAGER

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize configurations path.
		do
			create registry_settings
			create transactions.make (10)
		end
		
feature -- Access

	applications (a_configuration: ECDM_CONFIGURATION): LIST [STRING] is
			-- List of applications configured with `a_configuration'.
		require
			non_void_configuration: a_configuration /= Void
		local
			l_apps: LIST [STRING]
			l_config: ECDM_CONFIGURATION
		do
			l_apps := registry_settings.registered_applications
			if l_apps /= Void then
				from
					l_apps.start
					create {ARRAYED_LIST [STRING]} Result.make (l_apps.count)
				until
					l_apps.after
				loop
					l_config := configuration (l_apps.item)
					if l_config /= Void and then l_config.is_equal (a_configuration) then
						Result.extend (l_apps.item)
					end
					l_apps.forth
				end
			end
		end
		
	configuration (a_app_path: STRING): ECDM_CONFIGURATION is
			-- Configuration for application `a_app_path' if any.
		require
			non_void_app_path: a_app_path /= Void
		local
			l_config_path: STRING
		do
			l_config_path := registry_settings.application_config_path (a_app_path)
			if l_config_path /= Void and then {SYSTEM_FILE}.exists (l_config_path) then
				create Result.load (l_config_path)
			end
		end

	all_configurations: LIST [ECDM_CONFIGURATION] is
			-- All registered configurations
		local
			l_configs: LIST [STRING]
		do
			l_configs := registry_settings.registered_configurations
			from
				l_configs.start
				create {ARRAYED_LIST [ECDM_CONFIGURATION]} Result.make (l_configs.count)
			until
				l_configs.after
			loop
				if {SYSTEM_FILE}.exists (l_configs.item) then
					Result.extend (create {ECDM_CONFIGURATION}.load (l_configs.item))
				end
				l_configs.forth
			end
		end
		
	Default_configuration: ECDM_CONFIGURATION is
			-- Default configuration
		local
			l_path: STRING
		once
			l_path := registry_settings.default_config_file_path
			if l_path /= Void and then {SYSTEM_FILE}.exists (l_path) then
				create Result.load (l_path)
				Result.set_folder (l_path.substring (1, l_path.last_index_of ((create {OPERATING_ENVIRONMENT}).Directory_separator, l_path.count) - 1))
				Result.set_name ("Default")
			end
		end
		
feature -- Factory

	new_configuration (a_config_folder, a_config_name, a_app_path: STRING): ECDM_CONFIGURATION is
			-- New configuration `a_config_name' in folder `a_config_folder' for application `a_app_path'.
		require
			non_void_config_name: a_config_name /= Void
			non_void_config_folder: a_config_folder /= Void
			non_void_app_path: a_app_path /= Void
		do
			create Result.make_empty (a_config_folder, a_config_name)
			if Result.last_save_successful then
				registry_settings.register (a_app_path, Result.path)
			else
				Result := Void
			end
		ensure
			config_file_created_if_successful: Result /= Void implies (create {RAW_FILE}.make (Result.path)).exists
		end

feature -- Status Report

	is_registered (a_app_path: STRING): BOOLEAN is
			-- Is application `a_app_path' already configured?
		do
			Result := registry_settings.is_registered (a_app_path)
		end
		
feature -- Basic Operations

	register (a_app_path: STRING; a_configuration: ECDM_CONFIGURATION) is
			-- Configure application `a_app_path' with `a_configuration'.
		require
			non_void_app_path: a_app_path /= Void
			non_void_configuration: a_configuration /= Void
		do
			if not is_registered (a_app_path) then
				registry_settings.register (a_app_path, a_configuration.path)
			end
		end
	
	replace_configuration (a_app_path: STRING; a_configuration: ECDM_CONFIGURATION) is
			-- Change configuration file for application `a_app_path' to `a_configuration'.
		require
			non_void_app_path: a_app_path /= Void
			non_void_configuration: a_configuration /= Void
		do
			if registry_settings.is_registered (a_app_path) then
				registry_settings.change_application_config_path (a_app_path, a_configuration.path)
			end
		end
	
	delete_configuration (a_configuration: ECDM_CONFIGURATION) is
			-- Delete configuration `a_configuration'.
			-- Reset configured applications so they used default configuration.
		require
			non_configuration: a_configuration /= Void
		local
			l_config_file: RAW_FILE
			l_apps: LIST [STRING]
		do
			l_apps := applications (a_configuration)
			from
				l_apps.start
			until
				l_apps.after
			loop
				registry_settings.remove_application (l_apps.item)
				l_apps.forth
			end
			create l_config_file.make (a_configuration.path)
			if l_config_file.exists then
				l_config_file.delete
			end
		end

	register_default_configuration (a_config_path: STRING) is
			-- Register default configuration to use `a_config_path'.
		require
			non_void_config_path: a_config_path /= Void
		do
			registry_settings.register_default_configuration (a_config_path)
		end
		
	delete_default_configuration is
			-- Remove default configuration settings.
		do
			registry_settings.unregister_default_configuration
		end		

	delete_application (a_app_path: STRING) is
			-- Remove configuration information for application `a_app_path'
		require
			non_void_app_path: a_app_path /= Void
		do
			if is_registered (a_app_path) then
				registry_settings.remove_application (a_app_path)
			end
		end
	
feature -- Transactions

	add_application_to_register (an_app: STRING; a_configuration: ECDM_CONFIGURATION) is
			-- Add `an_app' to list of applications to register when `commit' is called.
		require
			non_void_app: an_app /= Void
			non_void_configuration: a_configuration /= Void
		do
			transactions.extend (create {ECDM_REGISTRATION}.make (an_app, a_configuration, Current))
		ensure
			registration_added: transactions.count = old transactions.count + 1
		end
		
	add_application_to_delete (an_app: STRING; a_configuration: ECDM_CONFIGURATION) is
			-- Add `an_app' to list of applications to register when `commit' is called.
		require
			non_void_app: an_app /= Void
			non_void_configuration: a_configuration /= Void
		do
			transactions.extend (create {ECDM_UNREGISTRATION}.make (an_app, a_configuration, Current))
		ensure
			registration_added: transactions.count = old transactions.count + 1
		end
	
	commit is
			-- Commit all registrations and unregistrations
		do
			from
				transactions.start
			until
				transactions.after
			loop
				transactions.item.commit
				transactions.forth
			end
			transactions.wipe_out
		end
	
	roll_back is
			-- Reset pending transactions.
		do
			transactions.wipe_out
		end
		
feature {NONE} -- Implementation

	transactions: ARRAYED_LIST [ECDM_TRANSACTION]
			-- List of registrations/unregistrations

	registry_settings: CODE_CONFIGURATION_REGISTRY_SETTINGS
			-- Eiffel Codedom Provider registry settings

invariant
	non_void_registry_settings: registry_settings /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ECDM_MANAGER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Manager
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------