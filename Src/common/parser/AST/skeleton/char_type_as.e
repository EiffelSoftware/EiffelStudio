indexing
	description: 
		"AST representation of type CHARACTER."
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_TYPE_AS

inherit
	BASIC_TYPE

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_char_type_as (Current)
		end

feature -- Output

	dump: STRING is "CHARACTER"
			-- Dumped trace

end -- class CHAR_TYPE_AS
