indexing
	description:
			"Abstract description of an access in an invariant beginning a %
			%call expression or instruction or an access after a creation for %
			%which there is no standard export validation like in %
			%ACCESS_FEAT_AS. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class ACCESS_INV_AS

inherit
	ACCESS_FEAT_AS
		redefine
			process,
			is_export_valid
		end

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_inv_as (Current)
		end

feature

	is_export_valid (feat: FEATURE_I): BOOLEAN is
			-- Is the call export valid ?
		do
			Result := True
		end

end -- class ACCESS_INV_AS
