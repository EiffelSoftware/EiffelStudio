indexing
	description: "Retrieves and sets the Assembly properties of the ace file"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_ASSEMBLIES

inherit
	IEIFFEL_SYSTEM_ASSEMBLIES_IMPL_STUB
		redefine
			store,
			add_assembly,
			add_local_assembly,
			remove_assembly,
			assemblies,
			assembly_properties,
			is_valid_cluster_name,
			is_valid_prefix,
			contains_assembly,
			contains_gac_assembly,
			contains_local_assembly,
			cluster_name_from_gac_assembly,
			cluster_name_from_local_assembly,
			add_assembly_user_precondition,
			add_local_assembly_user_precondition,
			remove_assembly_user_precondition,
			assembly_properties_user_precondition,
			contains_assembly_user_precondition,
			contains_gac_assembly_user_precondition,
			contains_local_assembly_user_precondition,
			cluster_name_from_gac_assembly_user_precondition,
			cluster_name_from_local_assembly_user_precondition
		end
	LACE_AST_FACTORY
		export
			{NONE} all
		end

create 
	make
	
feature {NONE} -- Initialization

	make (ace: ACE_FILE_ACCESSER) is
			-- Initialize with all data taken from `ace_accesser'.
		require
			non_void_ace_accesser: ace /= Void
		local
			al: LACE_LIST [ASSEMBLY_SD]
			assembly: ASSEMBLY_PROPERTIES
			--assembly_prefix: ID_SD
		do
			create assemblies_impl.make (10)
			ace_accesser := ace
			al ?= ace_accesser.root_ast.assemblies
			if al /= Void then
				from
						-- Detached store information from original.
					al := al.duplicate

						-- Initialize assemblies list
					create assemblies_table.make (al.count)
					al.start
				until
					al.after
				loop
					create assembly.make_with_assembly_sd(al.item)
					assemblies_table.put (assembly, assembly.assembly_cluster_name)
				    assemblies_impl.extend (assembly)
					al.forth
				end
			else
				create assemblies_table.make (13)	
			end
		end

feature -- Access

	store is
			-- save the assemblies to the ace file
		local
			l_assemblies: LACE_LIST [ASSEMBLY_SD]
			copy_assemblies: like assemblies_table
			cluster_name: ID_SD
		do
				-- Save assemblies
			copy_assemblies := clone (assemblies_table)
			l_assemblies := ace_accesser.root_ast.assemblies
			if l_assemblies = Void then
					-- if there is no assembly option then we need to create it
				create l_assemblies.make (copy_assemblies.count)
				ace_accesser.root_ast.set_assemblies (l_assemblies)
			end

				-- Insert assemblies in the order in which they were entered
				-- originally.
			from
				l_assemblies.start
			until
				l_assemblies.after
			loop
				cluster_name := l_assemblies.item.cluster_name
				
				if copy_assemblies.has (cluster_name) then
					l_assemblies.put (copy_assemblies.item (cluster_name).assembly_sd)
					copy_assemblies.remove (cluster_name)
					l_assemblies.forth
				else
					l_assemblies.remove
				end
			end

				-- Insert at the end new clusters.
			if not copy_assemblies.is_empty then
				from
					copy_assemblies.start
				until
					copy_assemblies.after
				loop
					l_assemblies.extend (copy_assemblies.item_for_iteration.assembly_sd)
					copy_assemblies.forth
				end
			end

			ace_accesser.apply
		end
	
	add_assembly (a_prefix, a_cluster_name, a_name, a_version, a_culture, a_public_key_token:STRING) is
			-- Add an assembly to the list of assemblies
		require else
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
			assembly: ASSEMBLY_PROPERTIES
		do
			create assembly.make (a_cluster_name, a_name, a_prefix, a_version, a_culture, a_public_key_token)
			assemblies_table.put (assembly, a_cluster_name)
		    assemblies_impl.extend (assembly)
		end
		
	add_local_assembly (a_prefix, a_cluster_name, a_path:STRING) is
			-- Add an assembly to the list of assemblies
		require else
			non_void_cluster_name: a_cluster_name /= Void
			valid_cluster_name: not a_cluster_name.is_empty
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			assembly: ASSEMBLY_PROPERTIES
		do
			create assembly.make_local (a_cluster_name, a_path, a_prefix)
			assemblies_table.put (assembly, a_cluster_name)
		    assemblies_impl.extend (assembly)
		end
		
	remove_assembly (a_cluster_name: STRING) is
			-- remove an assembly
		require else
			non_void_cluster_name: a_cluster_name /= Void
			valid_cluster_name: is_valid_cluster_name (a_cluster_name)
		local
			assembly: ASSEMBLY_PROPERTIES
			removed: BOOLEAN
			l_cluster_name: STRING
			l_assembly_cluster_name: STRING
		do
			if contains_assembly(a_cluster_name) then
				from
					l_cluster_name := a_cluster_name.clone (a_cluster_name)
					l_cluster_name.to_lower
					assemblies_table.start
				until
					assemblies_table.after or assembly /= Void
				loop
					l_assembly_cluster_name := assemblies_table.key_for_iteration.clone (assemblies_table.key_for_iteration)
					l_assembly_cluster_name.to_lower
					if l_assembly_cluster_name.is_equal (l_cluster_name) then
						assembly := assemblies_table.item_for_iteration
					else
						assemblies_table.forth
					end
				end
				from 
					removed := false
					assemblies_impl.start
				until
					assemblies_impl.after or removed = true
				loop
					if assemblies_impl.item.is_equal (assembly) then
						assemblies_impl.remove
						assemblies_table.remove (assembly.assembly_cluster_name)
						removed := true
					else
						assemblies_impl.forth
					end
				end
			end
		end
		
	assembly_properties (a_cluster_name: STRING): ASSEMBLY_PROPERTIES is
			-- Retrieve an assemblies properties by the assembly cluster name
		require else
			non_void_cluster_name: a_cluster_name /= Void
			valid_cluster_name: not a_cluster_name.is_empty
		do
			Result := assemblies_table.item (a_cluster_name)	
		end
		
	assemblies: ASSEMBLY_ENUMERATOR is
			-- Retireve the entire list of assemblies
		do
			create Result.make (assemblies_impl)
		ensure
			non_void_result: Result /= Void
		end	

	is_valid_prefix (a_prefix: STRING): BOOLEAN is
			-- is 'a_prefix' a valid assembly prefix
			-- only verifies that the identifier is correct, and not if the
			-- name is a duplicate
		require else
				non_void_prefix: a_prefix /= Void
		local
			i: INTEGER
			c: CHARACTER
		do
			if a_prefix.is_empty then
				Result := True
			else
				from
					i := 1
					Result := true
				until
					i = a_prefix.count or Result = false
				loop
					c := a_prefix.item (i)
					
					-- first char can only be alpha
					if i = 1 then 
						if not c.is_alpha then
							Result := false
						end
					else
						if not(c.is_alpha or c.is_digit or c = '_') then
							Result := false
						end
					end
					i := i + 1
				end	
			end
		end
		
	is_valid_cluster_name (a_cluster_name: STRING): BOOLEAN is
			-- is 'ina_cluster_name' a valid assembly cluster anem
			-- only verifies that the cluster name is correct, and not if the
			-- name is a duplicate
		require else
			non_void_cluster_name: a_cluster_name /= Void
		local
			identifier_dup: STRING
			keyword: STRING
		do
			if a_cluster_name.is_empty then
				Result := False
			else
				Result := is_valid_prefix(a_cluster_name)
				if Result then
					identifier_dup := a_cluster_name.clone(a_cluster_name)
					identifier_dup.to_lower
					from
						ace_accesser.reserved_keywords.start
					until
						ace_accesser.reserved_keywords.after or (Result = false)
					loop
						keyword := ace_accesser.reserved_keywords.item
						if identifier_dup.is_equal(keyword) then
							Result := false
						end
						ace_accesser.reserved_keywords.forth
					end
				end
			end
		end

	contains_assembly (a_cluster_name: STRING): BOOLEAN is
			-- does the system already contains an assembly with cluster name 'a_cluster_name'
		require else
			non_void_cluster_name: a_cluster_name /= Void
		local
			l_cluster_name: STRING
			l_assembly_cluster_name: STRING
		do
			l_cluster_name := a_cluster_name.clone (a_cluster_name)
			l_cluster_name.to_lower
			
			from
				assemblies_table.start
			until
				assemblies_table.after or Result
			loop
				l_assembly_cluster_name := assemblies_table.key_for_iteration.clone (assemblies_table.key_for_iteration)
				l_assembly_cluster_name.to_lower
				if l_assembly_cluster_name.is_equal (l_cluster_name) then
					Result := True
				else
					assemblies_table.forth
				end
			end
		end
		
	contains_gac_assembly (name, version, culture, public_key: STRING): BOOLEAN is
			-- does the system already contain the specified signed assembly reference
		require else
			non_void_name: name /= Void
			valid_name: not name.is_empty
			non_void_version: version /= Void
			valid_version: not version.is_empty
			non_void_culture: culture /= Void
			non_void_public_key: public_key /= Void
			valid_public_key: not public_key.is_empty
		do
			Result := cluster_name_from_gac_assembly (name, version, culture, public_key).count > 0
		end
		
	contains_local_assembly (path: STRING): BOOLEAN is
			-- does the system already contain an assembly reference to 'path'
		require else
			non_void_path: path /= Void
		do
			Result := cluster_name_from_local_assembly (path).count > 0
		end
		
	cluster_name_from_gac_assembly (name, version, culture, public_key: STRING): STRING is
			-- retieve the assembly identifier for a signed assembly from the passed arguements
			-- returns "" if no assembly was found
		require else
			non_void_name: name /= Void
			valid_name: not name.is_empty
			non_void_version: version /= Void
			valid_version: not version.is_empty
			non_void_culture: culture /= Void
			valid_culture: not culture.is_empty
			non_void_public_key: public_key /= Void
			valid_public_key: not public_key.is_empty
		local
			assembly: ASSEMBLY_PROPERTIES
			lcstring_a, lcstring_b: STRING
		do
			from
				assemblies_impl.start
				Result := ""
			until
				assemblies_impl.after or (not Result.is_empty)
			loop
				assembly := assemblies_impl.item
				if not assembly.is_local then
					if assembly.assembly_name.is_equal(name) then
						if assembly.assembly_version.is_equal(version) then
							-- public key is case-insensitive so check that the key is the same
							lcstring_a := public_key.clone(public_key)
							lcstring_b := assembly.assembly_public_key_token.clone(assembly.assembly_public_key_token)
							lcstring_a.to_lower
							lcstring_b.to_lower
							if lcstring_a.is_equal(lcstring_b) then
								-- culture is case-insensitive so check that the key is the same
								lcstring_a := culture.clone(culture)
								lcstring_b := assembly.assembly_culture.clone(assembly.assembly_culture)
								lcstring_a.to_lower
								lcstring_b.to_lower
								if lcstring_a.is_equal(lcstring_b) then
									Result := assembly.assembly_cluster_name
								end
							end
						end
					end
				end
				assemblies_impl.forth
			end
		end
		
	
	cluster_name_from_local_assembly (path: STRING): STRING is
			-- retieve the assembly identifier for a local assembly from the passed arguments
			-- returns "" if no assembly was found
		require else
			non_void_path: path /= Void
			valid_path: not path.is_empty
		local
			assembly: ASSEMBLY_PROPERTIES
			lcstring_a, lcstring_b: STRING
		do
			from
				assemblies_impl.start
				Result := ""
			until
				assemblies_impl.after or not Result.is_empty
			loop
				assembly := assemblies_impl.item
				if assembly.is_local then
					lcstring_a := assembly.assembly_name.clone(assembly.assembly_name)
					lcstring_b := path.clone(path)
					lcstring_a.to_lower
					lcstring_b.to_lower
					if lcstring_a.is_equal(lcstring_b) then
						Result := assembly.assembly_cluster_name	
					end
				end
				assemblies_impl.forth
			end
		end

feature -- User Preconditions

		add_assembly_user_precondition (assembly_prefix: STRING; cluster_name: STRING; a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
				-- 'add_assembly_user_precondition' preconditions
			do
				Result := False
			end
			
		add_local_assembly_user_precondition (assembly_prefix: STRING; cluster_name: STRING; a_name: STRING): BOOLEAN is
				-- 'add_assembly_user_precondition' preconditions
			do
				Result := False
			end
			
		remove_assembly_user_precondition (assembly_identifier: STRING): BOOLEAN is
				-- 'remove_assembly_user_precondition' preconditions
			do
				Result := False
			end
			
		assembly_properties_user_precondition (cluster_name: STRING): BOOLEAN is
				-- 'assembly_properties_user_precondition' preconditions
			do
				Result := False
			end
			
		contains_assembly_user_precondition (cluster_name: STRING): BOOLEAN is
				-- 'contains_assembly_user_precondition' preconditions
			do
				Result := False
			end
			
		contains_gac_assembly_user_precondition (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
				-- 'contains_gac_assembly_user_precondition' preconditions
			do
				Result := False
			end
			
		contains_local_assembly_user_precondition (a_path: STRING): BOOLEAN is
				-- 'contains_local_assembly_user_precondition' preconditions
			do
				Result := False
			end
			
		cluster_name_from_gac_assembly_user_precondition (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
				-- 'cluster_name_from_gac_assembly_user_precondition' preconditions
			do
				Result := False
			end
			
		cluster_name_from_local_assembly_user_precondition (a_path: STRING): BOOLEAN is
				-- 'cluster_name_from_local_assembly_user_precondition' preconditions
			do
				Result := False
			end
		
feature {NONE} -- Initialization
	
	ace_accesser: ACE_FILE_ACCESSER
	assemblies_table: HASH_TABLE[ASSEMBLY_PROPERTIES, STRING]
	assemblies_impl: ARRAYED_LIST[ASSEMBLY_PROPERTIES]

end -- class SYSTEM_ASSEMBLIES
