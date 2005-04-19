indexing

	description:
			"Abstract description of an Eiffel retry instruction. %
			%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class RETRY_AS

inherit
	INSTRUCTION_AS
		
	LEAF_AS

create
	make_with_location

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_retry_as (Current)
		end

feature -- Comparison
		
	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

end -- class RETRY_AS
