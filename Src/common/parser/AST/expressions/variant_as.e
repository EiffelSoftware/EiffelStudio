indexing
	description: 
		"AST representation of variant loop."
	date: "$Date$"
	revision: "$Revision$"

class
	VARIANT_AS

inherit
	TAGGED_AS
		redefine
			process
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_variant_as (Current)
		end

end -- class VARIANT_AS
