indexing
	description:
		"AST representation of an access in an invariant beginning a %
		%call expression or instruction or an access after a creation for %
		%which there is no standard export validation like in %
		%ACCESS_FEAT_AS."
	date: "$Date$"
	revision: "$Revision$"

class 
	ACCESS_INV_AS

inherit
	ACCESS_FEAT_AS
		redefine
			process
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_inv_as (Current)
		end

end -- class ACCESS_INV_AS
