indexing
	-- Referenced assemblies.

class
	ECDP_REFERENCED_ASSEMBLIES

feature -- Access

	referenced_assemblies: LINKED_LIST [ECDP_REFERENCED_ASSEMBLY] is
			-- Linked list of assemblies used by the codeDOM.
		once
			create Result.make
		ensure
			non_void_result: Result /= Void
		end		

	assemblies_initialized: BOOLEAN is
			-- Is referenced assemblies initialized?
		do
			Result := (Referenced_assemblies.count > 0)
		end

feature -- Status Setting

	add_referenced_assembly (a_referenced_assembly: ECDP_REFERENCED_ASSEMBLY) is
			-- Add `a_referenced_assembly' to `referenced_assemblies'.
		require
			non_void_a_referenced_assembly: a_referenced_assembly /= Void
		do
			referenced_assemblies.extend (a_referenced_assembly)
		ensure
			a_referenced_assembly_added: referenced_assemblies.has (a_referenced_assembly)
		end

	add_referenced_assembly_with_prefix (a_referenced_assembly: ASSEMBLY; a_prefix: STRING) is
			-- Add `a_referenced_assembly' to `referenced_assemblies'.
		require
			non_void_referenced_assembly: a_referenced_assembly /= Void
			non_void_prefix: a_prefix /= Void
		local
			l_referenced_assembly: ECDP_REFERENCED_ASSEMBLY
		do
			create l_referenced_assembly.make_with_prefix (a_referenced_assembly, a_prefix)
			Referenced_assemblies.extend (l_referenced_assembly)
		end

end -- Class ECDP_REFERENCED_ASSEMBLIES