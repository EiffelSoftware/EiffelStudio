indexing
	-- Representation of a referenced assembly

class
	ECDP_REFERENCED_ASSEMBLY

create 
	make,
	make_with_prefix
		
feature {NONE} -- Initialization

	make (an_assembly: ASSEMBLY) is
			-- Initialization.
			-- Set `assembly' with `an_assembly'.
		require
			non_void_an_assembly: an_assembly /= Void
		do
			assembly := an_assembly
			assembly_prefix := (create {ECDP_ASSEMBLY_PREFIX_FACTORY}).assembly_prefix (assembly.get_name.name)
		ensure
			assembly_prefix_set: assembly_prefix.is_equal ((create {ECDP_ASSEMBLY_PREFIX_FACTORY}).assembly_prefix (assembly.get_name.name))
			assembly_set: assembly = an_assembly
		end

	make_with_prefix (an_assembly: ASSEMBLY; a_prefix: STRING) is
			-- Initialization.
			-- Set `assembly' with `an_assembly'.
			-- Set `assembly_prefix' with `a_prefix'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_prefix: a_prefix /= Void
		do
			assembly := an_assembly
			assembly_prefix := a_prefix
		ensure
			assembly_prefix_set: assembly_prefix = a_prefix
			assembly_set: assembly = an_assembly
		end


feature -- Access

	assembly_prefix: STRING
			-- prefix used for assembly.
			
	assembly: ASSEMBLY
			-- actual assembly.

invariant
	non_void_assembly_prefix: assembly_prefix /= Void
	non_void_assembly: assembly /= Void

end -- Class ECDP_REFERENCED_ASSEMBLY