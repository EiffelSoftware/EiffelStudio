indexing
	description:	"List of assembly references, can be completed so that all references are listed."
	date:			"$Date$"
	revision:		"$Revision$"

class
	CODE_REFERENCES_LIST

inherit
	ARRAYED_LIST [CODE_REFERENCED_ASSEMBLY]

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		undefine
			is_equal,
			copy
		end

create
	make

feature -- Access

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
				if {SYSTEM_FILE}.exists (a_file_name) then
					Result := {ASSEMBLY}.load_from (a_file_name)
				else
					l_path := {RUNTIME_ENVIRONMENT}.get_runtime_directory
					l_path.append (a_file_name)
					if {SYSTEM_FILE}.exists (l_path) then
						Result := {ASSEMBLY}.load_from (l_path)
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
				Result := {ASSEMBLY}.load (a_name)
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

feature -- Status Report

	assembly_added: BOOLEAN
			-- Was last call to `extend_file' successful?

	has_file (a_file_name: STRING): BOOLEAN is
			-- Do referenced assemblies have assembly with path `a_file_name'?
		require
			non_void_file_name: a_file_name /= Void
		local
			l_assembly: ASSEMBLY
		do
			l_assembly := assembly_from_file (a_file_name)
			if l_assembly /= Void then
				Result := has_name (l_assembly.get_name)
			end
		ensure
			cusor_unchanged: index = old index
		end
		
	has_name (a_name: ASSEMBLY_NAME): BOOLEAN is
			-- Do referenced assemblies have assembly with name `a_name'?
		local
			l_old_cursor: CURSOR
			l_full_name: SYSTEM_STRING
		do
			l_old_cursor := cursor
			l_full_name := a_name.full_name
			from
				start
			until
				after or Result
			loop
				Result := item.assembly.get_name.full_name.equals (l_full_name)
				forth
			end
			go_to (l_old_cursor)
		ensure
			cusor_unchanged: index = old index
		end
		
feature -- Status Setting

	extend_file_with_prefix (a_file_name, a_prefix: STRING) is
			-- Add assembly with file name `a_file_name' and prefix `a_prefix' if found.
			-- Set `assembly_added' accordingly.
		require
			non_void_name: a_file_name /= Void
			non_void_prefix: a_prefix /= Void
			not_has_file: not has_file (a_file_name)
		local
			l_assembly: ASSEMBLY
		do
			assembly_added := False
			l_assembly := assembly_from_file (a_file_name)
			if l_assembly /= Void then
				extend (create {CODE_REFERENCED_ASSEMBLY}.make_with_prefix (l_assembly, a_prefix))
				assembly_added := True
			end
		ensure
			added: assembly_added implies count = old count + 1
		end

	extend_file (a_file_name: STRING) is
			-- Add assembly with file name `a_file_name' if found.
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
				extend (create {CODE_REFERENCED_ASSEMBLY}.make (l_assembly))
				assembly_added := True
			end
		ensure
			added: assembly_added implies count = old count + 1
		end

	extend_name (a_name: ASSEMBLY_NAME) is
			-- Add assembly with  name `a_name' if found.
			-- Set `assembly_added' accordingly.
		require
			non_void_name: a_name /= Void
			not_has: not has_name (a_name)
		local
			l_assembly: ASSEMBLY
		do
			assembly_added := False
			l_assembly := assembly_from_name (a_name)
			if l_assembly /= Void then
				extend (create {CODE_REFERENCED_ASSEMBLY}.make (l_assembly))
				assembly_added := True
			end
		ensure
			added: assembly_added implies count = old count + 1
		end

	remove_name (a_name: ASSEMBLY_NAME) is
			-- Remove assembly with name `a_name'.
		require
			non_void_name: a_name /= Void
			has_reference: has_name (a_name)
		local
			l_full_name: SYSTEM_STRING
		do
			l_full_name := a_name.full_name
			from
				start
			until
				after
			loop
				if item.assembly.full_name.equals (l_full_name) then
					remove
					finish
				end
				forth
			end
		end

feature -- Basic Operations

	complete is
			-- Complete `Referenced_assemblies' with all assembly references
		local
			l_assembly: ASSEMBLY
			l_referenced_assemblies: NATIVE_ARRAY [ASSEMBLY_NAME]
			i, l_count: INTEGER
			l_found_new: BOOLEAN
			l_code_base, l_location: STRING
			l_uri: SYSTEM_DLL_URI
			l_name: ASSEMBLY_NAME
		do
			from
				start
			until
				after				
			loop
				l_referenced_assemblies := item.assembly.get_referenced_assemblies
				from
					i := 0
					l_count := l_referenced_assemblies.count
				until
					i = l_count
				loop
					l_name := l_referenced_assemblies.item (i)
					l_found_new := not has_name (l_name)
					if l_found_new then
						l_location := Void
						if l_name.code_base /= Void then
							l_code_base := l_name.code_base
						end
						if l_code_base /= Void and then not l_code_base.is_empty then
							create l_uri.make (l_code_base)
							if l_uri.is_file then
								l_location := l_uri.local_path
							end
						end
						if l_location = Void then
							l_assembly := {ASSEMBLY}.load (l_name)
							if l_assembly /= Void then
								l_location := l_assembly.location
							end
						end
						if l_location /= Void and not has_file (l_location) then
							extend_file (l_location)
							l_location := Void
						end
					end
					i := i + 1
				end
				forth
			end
			if l_found_new then
				complete -- Complete until all references are added
			end
		end

end -- Class CODE_REFERENCES_LIST

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