indexing
	description: "Information on an assembly in Ace file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_PROPERTIES
    
inherit
	LACE_AST_FACTORY
		export
			{NONE} all
		end

	IEIFFEL_ASSEMBLY_PROPERTIES_IMPL_STUB
		redefine
			is_local,
			prefix1,
			name,
			version,
			culture,
			cluster_name,
			public_key_token,
			set_prefix
		end
            
    
create
	make,
	make_local,
	make_with_assembly_sd
    
feature {NONE} -- initalization

	make (a_cluster_name, a_name, a_prefix, a_version, a_culture, a_public_key_token: STRING) is
			-- create a new instance 
		require
			non_void_cluster_name: a_cluster_name /= Void
			valid_cluster_name: not a_cluster_name.is_empty
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_version: a_version /= Void
			valid_version: not a_version.is_empty
			non_void_culture: a_culture /= Void
			valid_culture: not a_culture.is_empty
			non_void_public_key_token: a_public_key_token /= Void
			valid_public_key_token: not a_public_key_token.is_empty
		local
			l_cluster_name_sd: ID_SD
			l_name_sd: ID_SD
			l_version_sd: ID_SD
			l_culture_sd: ID_SD
			l_public_key_token_sd: ID_SD
		do
			l_cluster_name_sd := new_id_sd (a_cluster_name, True)
			l_name_sd := new_id_sd (a_name, True)

			l_version_sd := new_id_sd (a_version, True)
			l_culture_sd := new_id_sd (a_culture, True)  
			l_public_key_token_sd := new_id_sd (a_public_key_token, True)    

			create assembly_sd.initialize (l_cluster_name_sd, l_name_sd, Void, l_version_sd, l_culture_sd, l_public_key_token_sd)
			is_local := False

			set_prefix (a_prefix)
		end
        
	make_local (a_cluster_name, a_assembly_path, a_prefix: STRING) is
			-- create a new instance defining a local assembly
		require
			non_void_cluster_name: a_cluster_name /= VOid
			valid_cluster_path: not a_cluster_name.is_empty
			non_void_assembly_path: a_assembly_path /= Void
			valid_assembly_path: not a_assembly_path.is_empty
		local
			l_cluster_name_sd: ID_SD
			l_path_sd: ID_SD
			l_version_sd: ID_SD
			l_culture_sd: ID_SD
		do
			l_cluster_name_sd := new_id_sd(a_cluster_name, false)
			l_path_sd := new_id_sd(a_assembly_path, true)

			is_local := True
			create assembly_sd.initialize (l_cluster_name_sd, l_path_sd, Void, Void, Void, Void)
			set_prefix (a_prefix)
		end
        
	make_with_assembly_sd (a_assembly: ASSEMBLY_SD) is
			-- Make with ASSEMBLY_SD and ACE_FILE_ACCESSER.
		require
			non_void_assembly: a_assembly /= Void
		do
			assembly_sd := a_assembly
			is_local := public_key_token.count = 0
		end

feature -- Status setting

	set_prefix (a_prefix: STRING) is
			-- set 'assembly_prefix' with 'a_prefix'
		do
			if a_prefix /= Void and then not a_prefix.is_empty then
				assembly_sd.set_prefix_name (new_id_sd (a_prefix, True).as_upper)
			else
				assembly_sd.set_prefix_name (Void)
			end
		end

feature -- Access

	prefix1: STRING is
			-- the prefix assigned to all classes in the system
		do
			Result := assembly_sd.prefix_name
			if Result = Void then
				Result := ""
			else
				Result := Result.as_upper
			end
		ensure then
			non_void_Result: Result /= Void
			is_upper: Result.as_upper.is_equal (Result)
		end
        
	cluster_name: STRING is
			-- the cluster name for the assembly
		do
			Result := assembly_sd.cluster_name
		ensure then
			non_void_Result: Result /= Void
		end
        
	name: STRING is
			-- the name/path for the assembly
		do
			Result := assembly_sd.assembly_name
		ensure then
			non_void_Result: Result /= Void
		end
        
	version: STRING is
			-- the version for the assembly
		do
			Result := assembly_sd.version
			if Result = Void then
				Result := ""
			end
		ensure then
			non_void_Result: Result /= Void
		end
        
	culture: STRING is
			-- the culture for the assembly
		do
			Result := assembly_sd.culture
			if Result = Void then
				Result := ""
			end
		ensure then
			non_void_Result: Result /= Void
		end
        
	public_key_token: STRING is
		-- the public key token of the assembly
	do
		Result := assembly_sd.public_key_token
		if Result = Void then
			Result := ""
		end
	ensure then
		non_void_Result: Result /= Void
	end
    
	is_local: BOOLEAN
		-- is assembly local?
            
	assembly_sd: ASSEMBLY_SD
		-- lace assembly object
            
feature {NONE} -- Implementation


	format_hash_assembly_name (a_name, a_public_key: STRING): STRING is
		-- format an assembly name and public key toekn into a hashable representation
		-- to match with `known_prefixes'
	require
		non_void_name: a_name /= Void
		valid_name: not a_name.is_empty
		non_void_public_key: a_public_key /= Void
	do
		create Result.make (a_name.count + a_public_key.count)
		Result.append (a_name)
		Result.append (a_public_key.as_lower)
	end
        
	known_prefixes: HASH_TABLE [STRING, STRING] is
		-- known assembly prefixes
		-- key: name + public key token
		-- value: prefix
	do
		create Result.make (7)
		Result.put ("SYSTEM_DLL_", format_hash_assembly_name ("System", "b77a5c561934e089"))
		Result.put ("XML_", format_hash_assembly_name ("System.Xml", "b77a5c561934e089"))
		Result.put ("WINFORMS_", format_hash_assembly_name ("System.Windows.Forms", "b77a5c561934e089"))
		Result.put ("DATA_", format_hash_assembly_name ("System.Data", "b77a5c561934e089"))
		Result.put ("DRAWING_", format_hash_assembly_name ("System.Drawing", "b03f5f7f11d50a3a"))
		Result.put ("WEB_", format_hash_assembly_name ("System.Web", "b03f5f7f11d50a3a"))
	end
    
invariant
	non_void_cluster_name: cluster_name /= Void
	non_void_name: name /= Void
	non_void_version: not is_local implies (version /= Void and not version.is_empty)
	non_void_culture: not is_local implies (culture /= Void and not culture.is_empty)
	non_void_public_key: not is_local implies (public_key_token /= Void and not public_key_token.is_empty)
	non_void_sd: assembly_sd /= Void
    
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
end -- class ASSEMBLY_PROPERTIES
