indexing
	description:	"Codedom referenced assemblies."
	date:			"$Date$"
	revision:		"$Revision$"

class
	CODE_REFERENCED_ASSEMBLIES

inherit
	CODE_CONFIGURATION
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature -- Access

	referenced_assemblies: LINKED_LIST [CODE_REFERENCED_ASSEMBLY] is
			-- Linked list of assemblies used by the codeDOM.
		once
			create Result.make
			add_referenced_assembly ("mscorlib.dll")
		ensure
			non_void_result: Result /= Void
		end		

	assemblies_initialized: BOOLEAN is
			-- Is referenced assemblies initialized?
		do
			Result := (Referenced_assemblies.count > 0)
		end

feature -- Status Report

	has_file_name (a_assembly: CODE_REFERENCED_ASSEMBLY; a_file_name: STRING): BOOLEAN is
			-- Does assembly `a_assembly' have file name `a_name'?
			-- Can be either simple name of full path name with or without extension
		require
			non_void_assembly: a_assembly /= Void
			non_void_name: a_file_name /= Void
		local
			l_name, l_full_name, l_assembly_name, l_location: STRING
			l_index: INTEGER
		do
			l_index := a_file_name.last_index_of ('.', a_file_name.count)
			if l_index > 1 then
				l_name := a_file_name.substring (1, l_index - 1)
			else
				l_name := a_file_name
			end
			l_assembly_name := a_assembly.assembly.get_name.name
			Result := l_assembly_name.is_equal (l_name)
			if not Result then
				l_location := a_assembly.assembly.location
				if l_location /= Void then
					create l_full_name.make (l_location.count + l_assembly_name.count + 1)
					l_full_name.append (l_location)
					l_full_name.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
					l_full_name.append (l_assembly_name)
					Result := l_full_name.is_equal (l_name)
				end
			end
		end

	assembly_added: BOOLEAN
			-- Was last call to `add_referenced_assembly_from_file_name' successful?

feature -- Status Setting

	add_referenced_assembly (a_file_name: STRING) is
			-- Add assembly with file name `a_file_name' to `referenced_assemblies' if found.
			-- Set `assembly_added' accordingly.
		require
			non_void_name: a_file_name /= Void
		local
			l_path: STRING
			l_assembly: ASSEMBLY
			l_retried: BOOLEAN
			l_referenced_assembly: CODE_REFERENCED_ASSEMBLY
		do
			assembly_added := False
			if not l_retried then
				if feature {SYSTEM_FILE}.exists (a_file_name) then
					l_assembly := feature {ASSEMBLY}.load_from (a_file_name)
				else
					l_path := feature {RUNTIME_ENVIRONMENT}.get_runtime_directory
					l_path.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
					l_path.append (a_file_name)
					if feature {SYSTEM_FILE}.exists (l_path) then
						l_assembly := feature {ASSEMBLY}.load_from (l_path)
					end
				end
				if l_assembly /= Void then
					create l_referenced_assembly.make_with_prefix (l_assembly, assembly_prefix (a_file_name))
					Referenced_assemblies.extend (l_referenced_assembly)
					assembly_added := True
				end
			end
		ensure
			added: referenced_assemblies.there_exists (agent has_file_name (?, a_file_name))
		rescue
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Rescued_exception, [(create {EXCEPTIONS}).exception_trace])
			l_retried := True
			retry
		end

end -- Class CODE_REFERENCED_ASSEMBLIES

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