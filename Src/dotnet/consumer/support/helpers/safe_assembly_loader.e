indexing
	description: "Loads assemblies without raising a FILE_NOT_FOUND_EXCEPTION"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SAFE_ASSEMBLY_LOADER
	
inherit
	KEY_ENCODER
		export
			{NONE} all
		end

feature -- Basic Operations

	load_assembly_from_path (a_path: STRING): ASSEMBLY is
			-- loads an assembly from `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_path: STRING
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_path := a_path.as_lower
				Result := assembly_table.item (l_path)
				if Result = Void then
					Result := feature {ASSEMBLY}.load_from (l_path)
					if Result /= Void then
						assembly_table.put (Result, l_path)
					end
				end
			end
		rescue
			l_retried := True
			retry
		end
		
	load_assembly_by_name (a_name: ASSEMBLY_NAME): ASSEMBLY is
			-- loads an assembly by `a_name'
		require
			non_void_name: a_name /= Void
		do
			Result := load_assembly_from_full_name (a_name.to_string)
		end
		
	load_assembly_from_full_name (a_name: STRING): ASSEMBLY is
			-- loads an assembly from it's full name
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_retried: BOOLEAN
			l_path: STRING
		do
			if not l_retried then
				Result := assembly_table.item (a_name)
				if Result = Void then
					Result := feature {ASSEMBLY}.load (a_name)
					l_path := Result.location.to_lower
					if not assembly_table.has (l_path) then
						assembly_table.put (Result, l_path)
					end
					assembly_table.put (Result, a_name)
				end
			end
		rescue
			l_retried := True
			retry
		end
		
	load_from_gac_or_path (a_path: STRING): ASSEMBLY is
			-- Attempt to load a version of assembly `a_path' from GAC, failing that
			-- the version loaded from `a_path' will be returned
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_assembly, l_gac_assembly: ASSEMBLY
			l_name: ASSEMBLY_NAME
			l_pkt: NATIVE_ARRAY [NATURAL_8]
		do
			l_assembly := load_assembly_from_path (a_path)
			if l_assembly /= Void then
				l_name := l_assembly.get_name
				l_pkt := l_name.get_public_key_token
				if l_pkt /= Void and then l_pkt.length > 0 then
					l_gac_assembly := load_from_gac (l_assembly.get_name)	
				end
			end
			if l_gac_assembly = Void or else not l_gac_assembly.global_assembly_cache then
				Result := l_assembly
			else
				Result := l_gac_assembly
			end
		end
		
	gac_path_of_assembly_path (a_path: STRING): STRING is
			-- Retrieves GAC path for `a_path'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_assembly: ASSEMBLY
		do
				-- No path cached
			l_assembly := load_from_gac_or_path (a_path)
			if l_assembly /= Void then
				Result := l_assembly.location.to_lower
			end
		end
		
feature -- Query

	is_mscorlib (a_assembly: ASSEMBLY): BOOLEAN is
			-- is `a_assembly' mscorlib?
		require
			a_assembly_not_void: a_assembly /= Void
		local
			l_name: ASSEMBLY_NAME
			l_pkt: NATIVE_ARRAY [NATURAL_8]
		do
			l_name := a_assembly.get_name
			if ("mscorlib").is_equal (l_name.name) then
				l_pkt := l_name.get_public_key_token
				if l_pkt /= Void and then l_pkt.length > 0 then
					Result := encoded_key (l_pkt).as_lower.is_equal ("b77a5c561934e089")
				end				
			end
		end

feature {NONE} -- Implementation

	load_from_gac (a_name: ASSEMBLY_NAME): ASSEMBLY is
			-- Load `a_name' from GAC if possible
		require
			a_name_not_void: a_name /= Void
			a_name_has_pkt: a_name.get_public_key_token /= Void and then a_name.get_public_key_token.length > 0
		local
			l_path: STRING
			l_new_domain: APP_DOMAIN
			retried: BOOLEAN
		do
			if not retried then
				l_path := a_name.to_string.to_lower
				Result := assembly_table.item (l_path)
				if Result = Void then
					l_new_domain := feature {APP_DOMAIN}.create_domain ("gac_loader")
					Result := l_new_domain.load (a_name)
					assembly_table.put (Result, l_path)
					l_path := Result.location.to_lower
					if not assembly_table.has (l_path) then
						assembly_table.put (Result, l_path)
					end
				end
			end
			if l_new_domain /= Void then
				feature {APP_DOMAIN}.unload (l_new_domain)
			end
		rescue
			retried := True
			retry
		end
		
feature {NONE} -- Implementation

	assembly_table: HASH_TABLE [ASSEMBLY, STRING] is
			-- Table of assemblies in GAC.
			-- Key: Assembly location
			-- Value: GAC assembly
		once
			create Result.make (5)
			Result.compare_objects
		ensure
			result_not_void: Result /= Void
			result_compares_objects: Result.object_comparison
		end
		
	release_cached_assemblies is
			-- Releases cached assemblies
		do
			assembly_table.clear_all
		ensure
			assembly_table_is_empty: assembly_table.is_empty
		end

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


end -- class SAFE_ASSEMBLY_LOADER
