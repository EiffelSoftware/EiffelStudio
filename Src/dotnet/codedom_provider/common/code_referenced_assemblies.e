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

	Referenced_assemblies: LIST [CODE_REFERENCED_ASSEMBLY] is
			-- Linked list of assemblies used by the codeDOM.
		once
			create {ARRAYED_LIST [CODE_REFERENCED_ASSEMBLY]} Result.make (16)
		ensure
			non_void_result: Result /= Void
		end		

feature -- Status Report

	assembly_added: BOOLEAN
			-- Was last call to `add_referenced_assembly_from_file_name' successful?

	has_file_name (a_assembly: CODE_REFERENCED_ASSEMBLY; a_file_name: STRING): BOOLEAN is
			-- Does assembly have file name `a_name'?
			-- Can be either simple name of full path name with or without extension
		require
			non_void_name: a_file_name /= Void
			non_void_assembly: a_assembly /= Void
		local
			l_location: STRING
			l_index: INTEGER
			l_file_name: STRING
		do
			l_file_name := a_file_name.as_lower
			l_location := a_assembly.assembly.location
			Result := l_file_name.is_equal (l_location)
			if not Result then
				l_index := l_location.last_index_of (Directory_separator, l_location.count)
				if l_index > 1 then
					l_location.keep_tail (l_location.count - l_index)
					Result := l_file_name.is_equal (l_location)
					if not Result then
						l_location.keep_head ((l_location.last_index_of ('.', l_location.count) - 1).max (1))
						Result := l_file_name.is_equal (l_location)
					end
				end
			end
		end

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
			added: assembly_added implies referenced_assemblies.there_exists (agent has_file_name (?, a_file_name))
		rescue
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Rescued_exception, [(create {EXCEPTIONS}).exception_trace])
			l_retried := True
			retry
		end

	reset_referenced_assemblies is
			-- Reset content of `Referenced_assemblies'.
		do
			Referenced_assemblies.wipe_out
			add_referenced_assembly ("mscorlib.dll")
		end
		
feature {NONE} -- Implementation

	Directory_separator: CHARACTER is
			-- Platform specific directory separator
		once
			Result := (create {OPERATING_ENVIRONMENT}).Directory_separator
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