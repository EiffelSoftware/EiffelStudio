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

	Default_assemblies: ARRAY [STRING] is
			-- Default assemblies added with `add_default_assemblies'
		once
			Result := <<"mscorlib.dll", "system.dll", "system.xml.dll">>
		end
		
feature -- Status Report

	assembly_added: BOOLEAN
			-- Was last call to `add_referenced_assembly_from_file_name' successful?

	has_file (a_file_name: STRING): BOOLEAN is
			-- Do referenced assemblies have assembly with path `a_file_name'?
		require
			non_void_file_name: a_file_name /= Void
		local
			l_assembly: ASSEMBLY
		do
			if feature {SYSTEM_FILE}.exists (a_file_name) then
				l_assembly := feature {ASSEMBLY}.load_from (a_file_name)
				if l_assembly /= Void then
					Result := has (l_assembly.get_name)
				end
			end
		ensure
			cusor_unchanged: Referenced_assemblies.index = old Referenced_assemblies.index
		end
		
	has (a_name: ASSEMBLY_NAME): BOOLEAN is
			-- Do referenced assemblies have assembly with name `a_name'?
		local
			l_old_cursor: CURSOR
			l_full_name, l_other_full_name: SYSTEM_STRING
		do
			l_old_cursor := Referenced_assemblies.cursor
			l_full_name := a_name.full_name
			from
				Referenced_assemblies.start
			until
				Referenced_assemblies.after or Result
			loop
				l_other_full_name := Referenced_assemblies.item.assembly.get_name.full_name
				Result := l_other_full_name.equals (l_full_name)
				Referenced_assemblies.forth
			end
			Referenced_assemblies.go_to (l_old_cursor)
		ensure
			cusor_unchanged: Referenced_assemblies.index = old Referenced_assemblies.index
		end
		
feature -- Status Setting

	add_referenced_assembly (a_file_name: STRING) is
			-- Add assembly with file name `a_file_name' to `referenced_assemblies' if found.
			-- Set `assembly_added' accordingly.
		require
			non_void_name: a_file_name /= Void
			not_has_assembly: not has_file (a_file_name)
		local
			l_path: STRING
			l_assembly: ASSEMBLY
			l_retried: BOOLEAN
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
					Referenced_assemblies.extend (create {CODE_REFERENCED_ASSEMBLY}.make (l_assembly))
					assembly_added := True
				end
			end
		ensure
			added: assembly_added implies referenced_assemblies.count = old referenced_assemblies.count + 1
		rescue
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Rescued_exception, [(create {EXCEPTIONS}).exception_trace])
			l_retried := True
			retry
		end

	add_default_assemblies is
			-- Add mscorlib, system and system.xml if not already in list.
		local
			i, l_count: INTEGER
			l_assembly: STRING
		do
			from
				l_count := Default_assemblies.count
				i := 1
			until
				i > l_count
			loop
				l_assembly := Default_assemblies.item (i)
				if not has_file (l_assembly) then
					add_referenced_assembly (l_assembly)
				end
				i := i + 1
			end
		end
		
	reset_referenced_assemblies is
			-- Reset content of `Referenced_assemblies'.
		do
			Referenced_assemblies.wipe_out
			add_referenced_assembly ("mscorlib.dll")
		end

feature -- Basic Operations

	complete is
			-- Complete `Referenced_assemblies' with all assembly references
		local
			l_assembly: ASSEMBLY
			l_referenced_assemblies: NATIVE_ARRAY [ASSEMBLY_NAME]
			i, l_count: INTEGER
			l_assembly_list: ARRAYED_LIST [STRING]
			l_found_new: BOOLEAN
			l_code_base, l_location: STRING
			l_uri: SYSTEM_DLL_URI
			l_name: ASSEMBLY_NAME
		do
			from
				create l_assembly_list.make (30)
				Referenced_assemblies.start
			until
				Referenced_assemblies.after				
			loop
				l_referenced_assemblies := referenced_assemblies.item.assembly.get_referenced_assemblies
				from
					i := 0
					l_count := l_referenced_assemblies.count
				until
					i = l_count
				loop
					l_name := l_referenced_assemblies.item (i)
					l_found_new := not has (l_name)
					if l_found_new then
						l_code_base := l_name.code_base
						if l_code_base /= Void and then not l_code_base.is_empty then
							create l_uri.make (l_code_base)
							if l_uri.is_file then
								l_location := l_uri.local_path
							end
						end
						if l_location = Void then
							l_assembly := feature {ASSEMBLY}.load (l_name)
							if l_assembly /= Void then
								l_location := l_assembly.location
							end
						end
						if l_location /= Void then
							add_referenced_assembly (l_location)
							l_location := Void
						end
					end
					i := i + 1
				end
				Referenced_assemblies.forth
			end
			if l_found_new then
				complete -- Complete until all references are added
			end
		end
		
feature {NONE} -- Implementation

	Directory_separator: CHARACTER is
			-- Platform specific directory separator
		once
			Result := (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

invariant
	non_void_default_assemblies: Default_assemblies /= Void

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