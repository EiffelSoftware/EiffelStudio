indexing
	description: "Access to the Eiffel Assembly Cache history"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end
	
class
	HISTORY
	
inherit
	REFLECTION_INTERFACE_SUPPORT
	
create
	make
	
feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `assemblies_table' and `types_table'."
		do
			create assemblies_table.make (1)
			create types_table.make (1)
		ensure
			non_void_assemblies_table: assemblies_table /= Void
			non_void_types_table: types_table /= Void
		end

feature -- Access

	assemblies_table: HASH_TABLE [ EIFFEL_ASSEMBLY, ASSEMBLY_DESCRIPTOR ]
			-- Key: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Value: ISE_REFLECTION_EIFFELASSEMBLY
		indexing
			description: "Last 50 retrieved assemblies"
		end

	types_table: HASH_TABLE [ EIFFEL_CLASS, INTEGER ]
			-- Key: SYSTEM_TYPE.get_hash_code
			-- Value: ISE_REFLECTION_EIFFELCLASS
		indexing
			description: "Last 50 retrieved types"
		end
	
	Maximum_count: INTEGER is 50
		indexing
			description: "Number of assemblies and types kept in the history"
		end
	
	search_for_assembly_result: EIFFEL_ASSEMBLY
		indexing
			description: "Assembly found during search: Result of `search_for_assembly'"
		end

	search_for_type_result: EIFFEL_CLASS
		indexing
			description: "Eiffel class found during search: Result of `search_for_type'"
		end

feature -- Status Report

	assembly_found: BOOLEAN
		indexing
			description: "Has assembly be found? (Result of `search_for_assembly')"
		end

	type_found: BOOLEAN
		indexing
			description: "Has type be found? (Result of `search_for_type')"
		end

	has_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR): BOOLEAN is
		indexing
			description: "Does `assemblies_table' contain `a_descriptor'?"
		require
			non_void_descriptor: a_descriptor /= Void
		do
			Result := assemblies_table.has (a_descriptor)
		end

	has_type (a_type: TYPE): BOOLEAN is
		indexing
			description: "Does `types_table' contain `a_type'?"
		require
			non_void_type: a_type /= Void
		do
			Result := types_table.has ( a_type.get_hash_code )
		end
		
feature -- Basic Operations

	add_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR; an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		indexing
			description: "Add `an_eiffel_assembly' to `assemblies_table' with key `a_descriptor'."
		require
			not_added: not has_assembly (a_descriptor)
			non_void_descriptor: a_descriptor /= Void
			non_void_eiffel_assembly: an_eiffel_assembly /= Void
		local
			first_key: ASSEMBLY_DESCRIPTOR
			--item: CLI_CELL [ISE_REFLECTION_EIFFEL_COMPONENTS_EIFFEL_ASSEMBLY]
		do
			if assemblies_table.count > Maximum_count then
				assemblies_table.start
				first_key ?= assemblies_table.key_for_iteration
				if first_key /= Void then
					assemblies_table.remove (first_key)
				end
			end
			--create item.put (an_eiffel_assembly)
			assemblies_table.extend (an_eiffel_assembly, a_descriptor)
		ensure
			assembly_added: assemblies_table.has (a_descriptor)
		end

	add_type (a_type: TYPE; an_eiffel_class: EIFFEL_CLASS) is
		indexing
			description: "Add `an_eiffel_class' to `types_table' with key `a_type'."
		require
			not_added: not has_type (a_type)
			non_void_type: a_type /= Void
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			first_key: INTEGER
			--item: CLI_CELL [ISE_REFLECTION_EIFFEL_COMPONENTS_EIFFEL_CLASS]
		do
			if types_table.count > Maximum_count then
				types_table.start
				first_key := types_table.key_for_iteration
				if first_key /= Void then
					types_table.remove ( first_key )
				end
			end
			--create item.put (an_eiffel_class)
			types_table.extend (an_eiffel_class, a_type.get_hash_code)
		ensure
			assembly_added: types_table.has ( a_type.get_hash_code)
		end
	
	search_for_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		indexing
			description: "Does `assemblies_table' contain `a_descriptor'? Make found assembly available in `search_for_assembly_result'."
		require
			non_void_descriptor: a_descriptor /= Void
		do
			assembly_found := assemblies_table.has (a_descriptor)
			if assembly_found then
				search_for_assembly_result ?= assemblies_table.item (a_descriptor)
			end
		end

	search_for_type (a_type: TYPE) is
		indexing
			description: "Does `types_table' contain `a_type'? Make found class available in `search_for_type_result'."
		require
			non_void_type: a_type /= Void
		local
			--enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			current_type: TYPE
			found: BOOLEAN
		do
			type_found := types_table.has ( a_type.get_hash_code )
			if type_found then
				search_for_type_result ?= types_table.item (a_type.get_hash_code)
			end
		end
		
invariant
	non_void_assemblies_table: assemblies_table /= Void
	non_void_types_table: types_table /= Void	
	assemblies_table_count_under_maximum: assemblies_table.count <= 50
	types_table_count_under_maximum: types_table.count <= 50
	
end -- class HISTORY