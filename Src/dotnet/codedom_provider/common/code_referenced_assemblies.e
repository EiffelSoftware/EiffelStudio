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
		
	assembly_from_file (a_file_name: STRING): ASSEMBLY is
			-- Load assembly at location `a_file_name'.
			-- `a_file_name' can be relative to framework path (e.g. `System.dll')
		require
			non_void_file_name: a_file_name /= Void
		local
			l_retried: BOOLEAN
			l_path: STRING
		do
			if not l_retried then
				if feature {SYSTEM_FILE}.exists (a_file_name) then
					Result := feature {ASSEMBLY}.load_from (a_file_name)
				else
					l_path := feature {RUNTIME_ENVIRONMENT}.get_runtime_directory
					l_path.append (a_file_name)
					if feature {SYSTEM_FILE}.exists (l_path) then
						Result := feature {ASSEMBLY}.load_from (l_path)
					end
				end
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
	
	assembly_from_name (a_name: ASSEMBLY_NAME): ASSEMBLY is
			-- Load assembly with name `a_name'.
		require
			non_void_name: a_name /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := feature {ASSEMBLY}.load (a_name)
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
	
feature -- Status Report

	assembly_added: BOOLEAN
			-- Was last call to `add_file' successful?

	has_file (a_file_name: STRING): BOOLEAN is
			-- Do referenced assemblies have assembly with path `a_file_name'?
		require
			non_void_file_name: a_file_name /= Void
		local
			l_assembly: ASSEMBLY
		do
			l_assembly := assembly_from_file (a_file_name)
			if l_assembly /= Void then
				Result := has (l_assembly.get_name)
			end
		ensure
			cusor_unchanged: Referenced_assemblies.index = old Referenced_assemblies.index
		end
		
	has (a_name: ASSEMBLY_NAME): BOOLEAN is
			-- Do referenced assemblies have assembly with name `a_name'?
		local
			l_old_cursor: CURSOR
			l_full_name, l_other_full_name: SYSTEM_STRING
			l_ref_asms: LIST [CODE_REFERENCED_ASSEMBLY]
		do
			l_ref_asms := Referenced_assemblies
			l_old_cursor := l_ref_asms.cursor
			l_full_name := a_name.full_name
			from
				l_ref_asms.start
			until
				l_ref_asms.after or Result
			loop
				l_other_full_name := l_ref_asms.item.assembly.get_name.full_name
				Result := l_other_full_name.equals (l_full_name)
				l_ref_asms.forth
			end
			l_ref_asms.go_to (l_old_cursor)
		ensure
			cusor_unchanged: Referenced_assemblies.index = old Referenced_assemblies.index
		end
		
feature -- Status Setting

	add_file (a_file_name: STRING) is
			-- Add assembly with file name `a_file_name' to `referenced_assemblies' if found.
			-- Set `assembly_added' accordingly.
		require
			non_void_name: a_file_name /= Void
			not_has_file: not has_file (a_file_name)
		local
			l_assembly: ASSEMBLY
		do
			assembly_added := False
			l_assembly := assembly_from_file (a_file_name)
			if l_assembly /= Void then
				Referenced_assemblies.extend (create {CODE_REFERENCED_ASSEMBLY}.make (l_assembly))
				assembly_added := True
			end
		ensure
			added: assembly_added implies referenced_assemblies.count = old referenced_assemblies.count + 1
		end

	add (a_name: ASSEMBLY_NAME) is
			-- Add assembly with  name `a_name' to `referenced_assemblies' if found.
			-- Set `assembly_added' accordingly.
		require
			non_void_name: a_name /= Void
			not_has: not has (a_name)
		local
			l_assembly: ASSEMBLY
		do
			assembly_added := False
			l_assembly := assembly_from_name (a_name)
			if l_assembly /= Void then
				Referenced_assemblies.extend (create {CODE_REFERENCED_ASSEMBLY}.make (l_assembly))
				assembly_added := True
			end
		ensure
			added: assembly_added implies referenced_assemblies.count = old referenced_assemblies.count + 1
		end

	remove (a_name: ASSEMBLY_NAME) is
			-- Remove assembly with name `a_name' from `referenced_assemblies'.
		require
			non_void_name: a_name /= Void
			has_reference: has (a_name)
		local
			l_ref_asms: LIST [CODE_REFERENCED_ASSEMBLY]
			l_full_name: SYSTEM_STRING
		do
			l_ref_asms := Referenced_assemblies
			l_full_name := a_name.full_name
			from
				l_ref_asms.start
			until
				l_ref_asms.after
			loop
				if l_ref_asms.item.assembly.full_name.equals (l_full_name) then
					l_ref_asms.remove
					l_ref_asms.finish
				end
				l_ref_asms.forth
			end
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
					add_file (l_assembly)
				end
				i := i + 1
			end
		end
		
	reset is
			-- Reset content of `Referenced_assemblies'.
		do
			Referenced_assemblies.wipe_out
			add_file ("mscorlib.dll")
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
			l_ref_asms: LIST [CODE_REFERENCED_ASSEMBLY]
		do
			l_ref_asms := Referenced_assemblies
			from
				create l_assembly_list.make (30)
				l_ref_asms.start
			until
				l_ref_asms.after				
			loop
				l_referenced_assemblies := l_ref_asms.item.assembly.get_referenced_assemblies
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
						if l_location /= Void and not has_file (l_location) then
							add_file (l_location)
							l_location := Void
						end
					end
					i := i + 1
				end
				l_ref_asms.forth
			end
			if l_found_new then
				complete -- Complete until all references are added
			end
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