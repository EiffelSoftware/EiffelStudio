indexing
	description: "Useful constants for assembly manager"
	external_name: "AssemblyManager.ViewDictionary"

class
	VIEW_DICTIONARY
	
inherit
	DIALOG_DICTIONARY

feature -- Access

	Assembly_description (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is 
			-- Text representing `a_descriptor' (does not include assembly name).
		indexing
			external_name: "AssemblyDescription"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			non_void_assembly_name: a_descriptor.name /= Void
			not_empty_assembly_name: a_descriptor.name.Length > 0
		once
			Result := Opening_bracket
			Result := Result.concat_string_string_string (Result, Description (a_descriptor), Closing_bracket)
		end
		
	Closing_bracket: STRING is ")"
			-- Closing round bracket
		indexing
			external_name: "ClosingBracket"
		end
	
	Opening_bracket: STRING is "("
			-- Opening round bracket
		indexing
			external_name: "OpeningBracket"
		end

	Space: STRING is " "
			-- Space 
		indexing
			external_name: "Space"
		end
		
--	Window_height: INTEGER is 600
--			-- Window height
--		indexing
--			external_name: "WindowHeight"
--		end
	
end -- class VIEW_DICTIONARY