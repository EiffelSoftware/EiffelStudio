indexing
	description: "Warning detected when parsing the Ace file specified in LACE.";
	date: "$Date$";
	revision: "$Revision $"

deferred class LACE_WARNING

inherit
	WARNING
	
	REFACTORING_HELPER
		export
			{NONE} all
		end

feature -- Property

	code: STRING is
			-- Error code
		do
			Result := generator
		end

	file_name: STRING is
			-- File in which error occurs.
		do
			to_implement ("May be we will never implement this when we go away from Lace?")
		end
		
end
