indexing
	description: 
		"AST representation of a DOUBLE type."
	date: "$Date$"
	revision: "$Revision$"

class
	DOUBLE_TYPE_AS

inherit
	BASIC_TYPE

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_double_type_as (Current)
		end

feature -- Output

	dump: STRING is "DOUBLE"
			-- Dumped trace

end -- class DOUBLE_TYPE_AS
