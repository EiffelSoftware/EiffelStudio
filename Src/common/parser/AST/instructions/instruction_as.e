indexing
	description: 
		"AST represenation of an instruction node"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INSTRUCTION_AS

inherit
	AST_EIFFEL
		redefine
			location
		end

feature -- Access

	location: TOKEN_LOCATION

end -- class INSTRUCTION_AS
