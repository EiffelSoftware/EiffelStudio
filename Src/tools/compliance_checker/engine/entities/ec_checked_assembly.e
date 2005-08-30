indexing
	description: "[
		Checked entity that describes and examines an assembly.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_ASSEMBLY

inherit		
	EC_CACHABLE_CHECKED_ENTITY

create
	make
	
feature {NONE} -- Initialization

	make (a_assembly: like assembly) is
			-- Create an initialize CLS-compliant checked assembly.
		require
			a_assembly_not_void: a_assembly /= Void
		do
			assembly := a_assembly
		end
		
feature -- Access
		
	assembly: ASSEMBLY
			-- Assembly that was examined.
		
feature {NONE} -- Basic Operations

	check_eiffel_compliance is
			-- Checks entity to see if it is Eiffel-compliant.
		do
			internal_is_eiffel_compliant := True
		end
		
feature {NONE} -- Query {EC_CHECKED_ENTITY}

	custom_attribute_provider: ICUSTOM_ATTRIBUTE_PROVIDER is
			-- Retrieve custom attribute provider for entity.
		do
			Result := assembly
		end
			
invariant
	assembly_not_void: assembly /= Void
			
end -- class EC_CHECKED_ASSEMBLY
