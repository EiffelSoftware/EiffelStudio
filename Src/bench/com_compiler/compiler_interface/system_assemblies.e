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
			remove_assembly,
			assemblies,
			assembly_properties,
			is_valid_cluster_name,
			is_valid_prefix,
			is_prefix_allocated,
			contains_assembly,
			contains_gac_assembly,
			contains_local_assembly,
			cluster_name_from_gac_assembly,
			cluster_name_from_local_assembly
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
	
	add_assembly (a_prefix, a_cluster_name, name, version, culture, public_key:STRING) is
			-- Add an assembly to the list of assemblies
		local
			assembly: ASSEMBLY_PROPERTIES
		do
			create assembly.make (a_cluster_name, name, a_prefix, version, culture, public_key)
			assemblies_table.put (assembly, a_cluster_name)
		    assemblies_impl.extend (assembly)
		end
		
	remove_assembly (a_cluster_name: STRING) is
			-- remove an assembly
		local
			assembly: ASSEMBLY_PROPERTIES
			removed: BOOLEAN
		do
			if contains_assembly(a_cluster_name) then
				assembly := assemblies_table.item (a_cluster_name)
				from 
					removed := false
					assemblies_impl.start
				until
					assemblies_impl.after or removed = true
				loop
					if assemblies_impl.item.is_equal (assembly) then
						assemblies_impl.remove
						assemblies_table.remove (a_cluster_name)
						removed := true
					end
					assemblies_impl.forth
				end
			end
		end
		
	assembly_properties (a_cluster_name: STRING): ASSEMBLY_PROPERTIES is
			-- Retrieve an assemblies properties by the assembly cluster name
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
		local
			i: INTEGER
			c: CHARACTER
		do
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
		
	is_valid_cluster_name (a_cluster_name: STRING): BOOLEAN is
			-- is 'ina_cluster_name' a valid assembly cluster anem
			-- only verifies that the cluster name is correct, and not if the
			-- name is a duplicate
		local
			identifier_dup: STRING
			keyword: STRING
		do
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

	is_prefix_allocated (a_prefix: STRING): BOOLEAN is
			-- has 'a_prefix' already been allocated to another assembly
		local
			new_assembly_prefix: STRING
			assembly_prefix: STRING
		do
			Result := false
			from
				assemblies_impl.start
			until
				assemblies_impl.after or Result
			loop
				assembly_prefix ?= assemblies_impl.item.assembly_prefix
				if assembly_prefix /= Void then
					assembly_prefix := assembly_prefix.clone(assembly_prefix)
					assembly_prefix.to_lower
					
					new_assembly_prefix := a_prefix.clone(a_prefix)
					new_assembly_prefix.to_lower
					
					if assembly_prefix.is_equal(new_assembly_prefix) then
						Result := true
					end
				end
				assemblies_impl.forth
			end
		end
		
	contains_assembly (a_cluster_name: STRING): BOOLEAN is
			-- does the system already contains an assembly with the cluster name 'a_cluster_name'
		do
			Result := assemblies_table.has (a_cluster_name)
		end
		
	contains_gac_assembly (name, version, culture, public_key: STRING): BOOLEAN is
			-- does the system already contain the specified signed assembly reference
		do
			Result := cluster_name_from_gac_assembly (name, version, culture, public_key).count > 0
		end
		
	contains_local_assembly (path: STRING): BOOLEAN is
			-- does the system already contain an assembly reference to 'path'
		do
			Result := cluster_name_from_local_assembly (path).count > 0
		end
		
		
	cluster_name_from_gac_assembly (name, version, culture, public_key: STRING): STRING is
			-- retieve the assembly identifier for a signed assembly from the passed arguements
			-- returns "" if no assembly was found
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
								if assembly.assembly_culture.is_equal(culture) then
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

		
feature {NONE} -- Initialization
	
	ace_accesser: ACE_FILE_ACCESSER
	assemblies_table: HASH_TABLE[ASSEMBLY_PROPERTIES, STRING]
	assemblies_impl: ARRAYED_LIST[ASSEMBLY_PROPERTIES]

end -- class SYSTEM_ASSEMBLIES
