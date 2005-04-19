indexing
	description: "AST representation of an Eiffel function pointer for Current.";
	date: "$Date$";
	revision: "$Revision$"

class
	ADDRESS_CURRENT_AS

inherit
	EXPR_AS

	LEAF_AS

create
	make_from_other

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_address_current_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

end -- class ADDRESS_CURRENT_AS
