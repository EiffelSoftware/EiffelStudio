indexing
	description: 
		"AST representation for NONE type."
	date: "$Date$"
	revision: "$Revision$"

class
	NONE_TYPE_AS

inherit
	BASIC_TYPE

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_none_type_as (Current)
		end

feature -- Output

	dump: STRING is "NONE"
			-- Dumped trace

end -- class NONE_TYPE_AS
