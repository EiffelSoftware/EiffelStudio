indexing
	description: 
		"AST representation for type POINTER."
	date: "Date: $"
	revision: "Revision: $"

class
	POINTER_TYPE_AS

inherit
	BASIC_TYPE

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_pointer_type_as (Current)
		end

feature -- Output

	dump: STRING is "POINTER"

end -- class POINTER_TYPE_AS
