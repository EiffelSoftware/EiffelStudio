indexing
	description: 
		"AST representation for type REAL."
	date: "$Date$"
	revision: "$Revision$"

class
	REAL_TYPE_AS

inherit
	BASIC_TYPE

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_real_type_as (Current)
		end

feature -- Output

	dump: STRING is "REAL"
			-- Dumped trace

end -- class REAL_TYPE_AS
