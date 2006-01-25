indexing
	description: "Implement all features to install and uninstall the Eiffel CodeDom Provider."
	date: "$Date$"
	revision: "$Revision$"

	metadata: create {SYSTEM_DLL_RUN_INSTALLER_ATTRIBUTE}.make (True) end

class
	CODE_INSTALLER

inherit
	CONFIG_INSTALL_INSTALLER
		redefine
			install,
			uninstall,
			commit,
			rollback
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature -- Access

	Eiffel_codedom_provider_fully_qualified_name: STRING is
			-- Eiffel CodeDom provider assembly fully qualified name
		once
			Result := (create {CODE_DOM_PROVIDER}).get_type.assembly_qualified_name
		ensure
			non_void_Eiffel_codedom_provider_fully_qualified_name: Result /= Void
			not_empty_Eiffel_codedom_provider_fully_qualified_name: not Result.is_empty
		end

	Eiffel_language: STRING is "Eiffel"
			-- Keyword that distinguish an Eiffel asp page to C# page.

	Eiffel_extension: STRING is ".e"
			-- Eiffel files extension.

feature -- Basic Operations

	install (saved_state: IDICTIONARY) is
			-- Redefine `install' feature.
		local
			l_exists: BOOLEAN
			l_log_name: STRING
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state);
			add_entry
			if {SYSTEM_DLL_EVENT_LOG}.source_exists (Event_source, ".") then
				l_log_name := {SYSTEM_DLL_EVENT_LOG}.log_name_from_source_name (Event_source, ".")
				l_exists := l_log_name.is_equal (Event_log)
			end
			if not l_exists then
				{SYSTEM_DLL_EVENT_LOG}.create_event_source (Event_source, Event_log, ".")
			end
		end
	
	uninstall (saved_state: IDICTIONARY) is
			-- Redefine `install' feature.
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state)
			remove_entry
			if {SYSTEM_DLL_EVENT_LOG}.source_exists (Event_source, ".") then
				{SYSTEM_DLL_EVENT_LOG}.delete_event_source (Event_source, ".")
			end
		end
	
	commit (saved_state: IDICTIONARY) is
			-- Redefine `commit' feature.
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state)
		end
	
	rollback (saved_state: IDICTIONARY) is
			-- Redefine `rollback' feature.
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state)
		end

feature {NONE} -- Implementation
	
	add_entry is
			-- Add Eiffel CodeDom provider to list of CodeDom providers
			-- in configuration file "machine.config"
		do
			(create {CODE_MACHINE_CONFIGURATION}.make).add_compiler_entry (Eiffel_language, Eiffel_extension, Eiffel_codedom_provider_fully_qualified_name)
		end

	remove_entry is
			-- Remove Eiffel CodeDom provider from list of CodeDom providers
			-- in configuration file "machine.config" if present
			-- otherwise do nothing.
		do
			(create {CODE_MACHINE_CONFIGURATION}.make).remove_compiler_entry (Eiffel_language)
		end
	
	Event_source: STRING is "Eiffel Codedom Provider"
			-- Event source
	
	Event_log: STRING is "Application"
			-- Event log

end -- Class CODE_INSTALLER

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