indexing
	description: "Information on an assembly in Ace file"
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
			assembly_prefix,
			assembly_name,
			assembly_version,
			assembly_culture,
			assembly_cluster_name,
			assembly_public_key_token,
			set_assembly_prefix,
			is_prefix_read_only,
			set_assembly_prefix_user_precondition
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
			l_cluster_name_sd := new_id_sd(a_cluster_name, false)
			l_name_sd := new_id_sd(a_name, true)
			
			l_version_sd := new_id_sd(a_version, true)
			l_culture_sd := new_id_sd(a_culture, true)	
			l_public_key_token_sd := new_id_sd(a_public_key_token, true)	
		
			create assembly_sd.initialize (l_cluster_name_sd, l_name_sd, Void, l_version_sd, l_culture_sd, l_public_key_token_sd)
			is_local := False
			
			if not is_prefix_read_only then
				set_assembly_prefix (a_prefix)
			else
				-- force setting of known prefix
				assembly_sd.set_prefix_name (new_id_sd (assembly_prefix, True))
			end
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
		do
			l_cluster_name_sd := new_id_sd(a_cluster_name, false)
			l_path_sd := new_id_sd(a_assembly_path, true)
			
			is_local := True
			create assembly_sd.initialize (l_cluster_name_sd, l_path_sd, Void, Void, Void, Void)
			if not is_prefix_read_only then
				set_assembly_prefix (a_prefix)
			else
				-- force setting of known prefix
				assembly_sd.set_prefix_name (new_id_sd (assembly_prefix, True))
			end
		end
		
	make_with_assembly_sd (a_assembly: ASSEMBLY_SD) is
			-- Make with ASSEMBLY_SD and ACE_FILE_ACCESSER.
		require
			non_void_assembly: a_assembly /= Void
		do
			assembly_sd := a_assembly
			if assembly_public_key_token.count > 0 then
				is_local := False
			else
				is_local := True
			end
			if is_prefix_read_only then
				-- force setting of known prefix
				assembly_sd.set_prefix_name (new_id_sd (assembly_prefix, True))
			end
		end

feature -- Status setting

	set_assembly_prefix (a_prefix: STRING) is
			-- set 'assembly_prefix' with 'a_prefix'
		require else
			editable_prefix: not is_prefix_read_only
		local
			asm_prefix: ID_SD
		do
			if a_prefix /= Void and not a_prefix.is_empty then
				asm_prefix := new_id_sd(a_prefix.clone(a_prefix), true)
				asm_prefix.to_upper				
				assembly_sd.set_prefix_name (asm_prefix)
			else
				assembly_sd.set_prefix_name (Void)
			end
		end
		
	set_assembly_prefix_user_precondition (a_prefix: STRING): BOOLEAN is
			-- `set_assembly_prefix' precondition
		do
			Result := False
		end

feature -- Access

	is_prefix_read_only: BOOLEAN is
			-- can assembly's prefix be changed?
		do
			Result := known_prefixes.has (format_hash_assembly_name (assembly_name, assembly_public_key_token))
		end

	assembly_prefix: STRING is
			-- the prefix assigned to all classes in the system
		local
			a_prefix: ID_SD
		do
			if not is_prefix_read_only then
				a_prefix := assembly_sd.prefix_name
				if a_prefix = Void then
					Result := ""
				else
					Result := a_prefix
					Result.to_upper
				end
			else
				Result := known_prefixes.item (format_hash_assembly_name (assembly_name, assembly_public_key_token))
			end
		ensure
			non_void_Result: Result /= Void
		end
		
	assembly_cluster_name: STRING is
			-- the cluster name for the assembly
		do
			Result := assembly_sd.cluster_name
		ensure
			non_void_Result: Result /= Void
		end
		
	assembly_name: STRING is
				-- the name/path for the assembly
		do
			Result := assembly_sd.assembly_name
		ensure
			non_void_Result: Result /= Void
		end
		
	assembly_version: STRING is
				-- the version for the assembly
		do
			Result := assembly_sd.version
			if Result = Void then
				Result := ""
			end
		ensure
			non_void_Result: Result /= Void
		end
		
	assembly_culture: STRING is
			-- the culture for the assembly
		do
			Result := assembly_sd.culture
			if Result = Void then
				Result := ""
			end
		ensure
			non_void_Result: Result /= Void
		end
		
	assembly_public_key_token: STRING is
				-- the public key token of the assembly
		do
			Result := assembly_sd.public_key_token
			if Result = Void then
				Result := ""
			end
		ensure
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
		local
			l_key: STRING
		do
			Result := clone (a_name)
			l_key := clone (a_public_key)
			l_key.to_lower
			Result.append (l_key)
		end
		
	known_prefixes: HASH_TABLE [STRING, STRING] is
			-- known assembly prefixes
			-- key: name + public key token
			-- value: prefix
		do
			create Result.make (13)
			Result.put ("SYSTEM_DLL_", format_hash_assembly_name ("System", "b77a5c561934e089"))
			Result.put ("XML_", format_hash_assembly_name ("System.Xml", "b77a5c561934e089"))
			Result.put ("WINFORMS_", format_hash_assembly_name ("System.Windows.Forms", "b77a5c561934e089"))
		end
		
			
invariant
	non_void_cluster_name: assembly_cluster_name /= Void
	non_void_name: assembly_name /= Void
	non_void_version: not is_local implies (assembly_version /= Void and not assembly_version.is_empty)
	non_void_culture: not is_local implies (assembly_culture /= Void and not assembly_culture.is_empty)
	non_void_public_key: not is_local implies (assembly_public_key_token /= Void and not assembly_public_key_token.is_empty)
	non_void_sd: assembly_sd /= Void
	
end -- class ASSEMBLY_PROPERTIES
