indexing
	description: "Keep session parameter."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	SESSION

feature -- Access

	current_assembly: CONSUMED_ASSEMBLY is
			-- Current assembly.
		do
			Result := internal_current_assembly.item
		end

	current_type: CONSUMED_TYPE is
			-- Current type.
		do
			Result := internal_current_type.item
		end


feature -- Status Setting

	set_current_assembly (an_assembly: CONSUMED_ASSEMBLY) is
			-- Put `an_assembly' in `internal_current_assembly'.
			-- Set `current_type' to void.
		require
			non_void_an_assembly: an_assembly /= Void
		do
			internal_current_assembly.put (an_assembly)
			Internal_current_type.put (Void)
		ensure
			current_assembly_set: current_assembly = an_assembly
			current_type_void: current_type = Void
		end

	set_current_type (an_type: CONSUMED_TYPE) is
			-- Put `an_type' in `internal_current_type'.
		require
			non_void_an_type: an_type /= Void
		do
			internal_current_type.put (an_type)
		ensure
			current_type_set: current_type = an_type
		end


feature {NONE} -- Implementation
	
	internal_current_assembly: CELL [CONSUMED_ASSEMBLY] is
			-- Internal representation of `current_assembly'.
		once
			Create Result.put (Void)
		ensure
			non_void_result: Result /= Void
		end
		
	internal_current_type: CELL [CONSUMED_TYPE] is
			-- Internal representation of `current_type'.
		once
			Create Result.put (Void)
		ensure
			non_void_result: Result /= Void
		end
		

end -- class SESSION

