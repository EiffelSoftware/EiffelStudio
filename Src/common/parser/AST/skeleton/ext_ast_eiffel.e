indexing

	description: 
		"Extended abstract syntax tree node. Keeps position information";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	EXT_AST_EIFFEL

feature -- Access

		start_position, end_position: INTEGER is
				-- Beginning and end position of structure in 
				-- the class text (in characters)
				--| Valid only after `simple_format' has been called.
			deferred
			end

end -- class EXT_AST_EIFFEL
