note
	description:	"List of assembly references, can be completed so that all references are listed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date:			"$Date$"
	revision:		"$Revision$"

class
	CODE_REFERENCES_LIST

inherit
	ARRAYED_LIST [CODE_REFERENCED_ASSEMBLY]
		redefine
			extend
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		undefine
			is_equal,
			copy
		end

	CODE_CONFIGURATION
		rename
			put as env_put
		export
			{NONE} all
		undefine
			is_equal,
			copy
		end

create
	make

feature -- Access

	assembly_from_file (a_file_name: STRING): ASSEMBLY
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
					Result := {ASSEMBLY}.load_file (a_file_name)
				else
					l_path := {RUNTIME_ENVIRONMENT}.get_runtime_directory
					l_path.append (a_file_name)
					if {SYSTEM_FILE}.exists (l_path) then
						Result := {ASSEMBLY}.load_file (l_path)
					end
				end
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
	
	assembly_from_name (a_name: ASSEMBLY_NAME): ASSEMBLY
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

	has_file (a_file_name: STRING): BOOLEAN
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
		
	has_name (a_name: ASSEMBLY_NAME): BOOLEAN
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

	extend (a_assembly: CODE_REFERENCED_ASSEMBLY)
			-- First check for overrides in configuration file
			-- Then add assembly
		local
			l_overrides: like override_assemblies
		do
			l_overrides := override_assemblies
			l_overrides.search (a_assembly.assembly.full_name)
			if l_overrides.found then
				Precursor (l_overrides.found_item)
			else
				Precursor (a_assembly)
			end
		end

	extend_file_with_prefix (a_file_name, a_prefix: STRING)
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

	extend_file (a_file_name: STRING)
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

	extend_name (a_name: ASSEMBLY_NAME)
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

	remove_name (a_name: ASSEMBLY_NAME)
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

	complete
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

note
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
end -- Class CODE_REFERENCES_LIST

