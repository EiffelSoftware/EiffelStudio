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
			add_signed_assembly,
			add_unsigned_assembly,
			remove_assembly,
			rename_assembly,
			assemblies,
			assembly_properties,
			is_valid_identifier,
			is_valid_prefix,
			is_prefix_allocated,
			contains_assembly,
			contains_signed_assembly,
			contains_unsigned_assembly,
			identifier_from_signed_assembly,
			identifier_from_unsigned_assembly
		end
	LACE_AST_FACTORY
		export
			{NONE} all
		end

create 
	make
	
feature {NONE} -- Initialization

	make (ace: ACE_FILE_ACCESSER) is
			-- create an instance
		do
			ace_accesser := ace
			create assemblies_table.make(0)
			create assemblies_impl.make(0)
			
--			-- TODO: Add assembly references into here (pending assembly addition to compiler/ace impl)
--			
--			-- TEMP
			add_signed_assembly("pref1", "assembly1", "Accessibility", "1.0.3300.0", "neutral", "b03f5f7f11d50a3a")
			add_unsigned_assembly("pref2", "assembly2", "c:\accessibility.dll")
		end	

feature -- Basic operations

	rename_assembly (new_name, old_name: STRING) is
			-- changes an assemblies identifer
		do
			if assemblies_table.has(old_name) then
				assemblies_table.item(old_name).set_assembly_identifier (new_name)
				assemblies_table.replace_key (new_name, old_name)
			end	
		end
		

feature -- Access

	store is
			-- save the assemblies to the ace file
		do
			
			-- TODO: store the assemblies when ace file can support
			
			-- TODO: set all of the clusters to include the set prefixes
			-- from the assemblies
		end
	
	add_signed_assembly (a_prefix, identifier, name, version, culture, public_key:STRING) is
			-- add an assembly to the ace file
		local
			assembly: ASSEMBLY_PROPERTIES
			name_dup: STRING
		do
			if not contains_assembly(identifier) then
				
				-- if the name contains a file extension such as dll or exe
				name_dup := name.clone(name)
				if name_dup.substring_index(".dll", name_dup.count-4) > 0 or name_dup.substring_index(".exe", name_dup.count-4) > 0 then
					create assembly.make_local_signed (a_prefix, identifier, name, version, culture, public_key)
				else
					create assembly.make_signed (a_prefix, identifier, name, version, culture, public_key)
				end

				assemblies_table.put (assembly, identifier)
				assemblies_impl.extend (assembly)
			end
		end
		
	add_unsigned_assembly (a_prefix, identifier, path:STRING) is
			-- add an assembly to the ace file
		local
			assembly: ASSEMBLY_PROPERTIES
		do
			if not contains_assembly(identifier) then
				create assembly.make_local(a_prefix, identifier, path)
				assemblies_table.put (assembly, identifier)
				assemblies_impl.extend (assembly)
			end
		end
		
	remove_assembly (identifier: STRING) is
			-- remove an assembly
		local
			assembly: ASSEMBLY_PROPERTIES
			removed: BOOLEAN
		do
			if contains_assembly(identifier) then
				assembly := assemblies_table.item (identifier)
				from 
					removed := false
					assemblies_impl.start
				until
					assemblies_impl.after or removed = true
				loop
					if assemblies_impl.item.is_equal (assembly) then
						assemblies_impl.remove
						assemblies_table.remove (identifier)
						removed := true
					end
					assemblies_impl.forth
				end
			end
		end
		
	assembly_properties (identifier: STRING): ASSEMBLY_PROPERTIES is
			-- Retrieve an assemblies properties by the assembly reference name
		do
			Result := assemblies_table.item (identifier)	
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
		
	is_valid_identifier (identifier: STRING): BOOLEAN is
			-- is 'indentifier' a valid assembly indentifer name
			-- only verifies that the identifier is correct, and not if the
			-- name is a duplicate
		local
			identifier_dup: STRING
			keyword: STRING
		do
			Result := is_valid_prefix(identifier)
			if Result then
				identifier_dup := identifier.clone(identifier)
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
		
	contains_assembly (identifier: STRING): BOOLEAN is
			-- does the system already contains an assembly with an the indentifer = 'identifier'
		do
			Result := assemblies_table.has (identifier)
		end
		
	contains_signed_assembly (name, version, culture, public_key: STRING): BOOLEAN is
			-- does the system already contain the specified signed assembly reference
		do
			Result := identifier_from_signed_assembly (name, version, culture, public_key).count > 0
		end
		
	contains_unsigned_assembly (path: STRING): BOOLEAN is
			-- does the system already contain an assembly reference to 'path'
		do
			Result := identifier_from_unsigned_assembly (path).count > 0
		end
		
		
	identifier_from_signed_assembly (name, version, culture, public_key: STRING): STRING is
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
							lcstring_b := assembly.assembly_public_key.clone(assembly.assembly_public_key)
							lcstring_a.to_lower
							lcstring_b.to_lower
							if lcstring_a.is_equal(lcstring_b) then
								if assembly.assembly_culture.is_equal(culture) then
									Result := assembly.assembly_identifier
								end
							end
						end
					end
				end
				assemblies_impl.forth
			end
		end
		
	
	identifier_from_unsigned_assembly (path: STRING): STRING is
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
					lcstring_a := assembly.assembly_path.clone(assembly.assembly_path)
					lcstring_b := path.clone(path)
					lcstring_a.to_lower
					lcstring_b.to_lower
					if lcstring_a.is_equal(lcstring_b) then
						Result := assembly.assembly_identifier	
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
