indexing
	description: "[
					Find features names in EAC
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	SPECIFIC_TYPE

create
	make

feature -- Initialization

	make (an_assembly: CONSUMED_ASSEMBLY; a_type: CONSUMED_TYPE) is
			-- initialize type and assembly.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_type: a_type /= Void
		do
			assembly := an_assembly
			type := a_type
		ensure
			assembly_set: assembly = an_assembly implies assembly /= Void
			type_set: type = a_type implies type /= Void
		end

feature -- Access

	type: CONSUMED_TYPE
			-- type.
			
	assembly: CONSUMED_ASSEMBLY
			-- assembly where is defined `type'.
			
invariant
	non_void_assembly: assembly /= Void
	non_void_type: type /= Void

end -- SPECIFIC_TYPE