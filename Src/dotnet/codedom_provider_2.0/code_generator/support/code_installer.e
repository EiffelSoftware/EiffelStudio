indexing
	description: "Implement all features to install and uninstall the Eiffel CodeDom Provider."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	Eiffel_extensions: STRING is ".e"
			-- Eiffel files extensions

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
			(create {CODE_MACHINE_CONFIGURATION}.make).add_compiler_entry (Eiffel_language, Eiffel_extensions, Eiffel_codedom_provider_fully_qualified_name)
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
	
	Event_log: STRING is "Application";
			-- Event log

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- Class CODE_INSTALLER

