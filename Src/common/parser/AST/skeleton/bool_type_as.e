indexing
	description: 
		"AST representation of BOOLEAN type."
	date: "$Date$"
	revision: "$Revision$"

class
	BOOL_TYPE_AS

inherit
	BASIC_TYPE

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bool_type_as (Current)
		end

feature -- Output

	dump: STRING is "BOOLEAN"
			-- Dumped trace

end -- class BOOL_TYPE_AS
