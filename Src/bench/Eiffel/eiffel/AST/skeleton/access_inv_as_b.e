indexing

	description:
			"Abstract description of an access in an invariant beginning a %
			%call expression or instruction or an access after a creation for %
			%which there is no standard export validation like in %
			%ACCESS_FEAT_AS. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class ACCESS_INV_AS_B

inherit

	ACCESS_INV_AS
		redefine
			feature_name, parameters
		end;

	ACCESS_FEAT_AS_B
		redefine
			is_export_valid, feature_name, parameters
		end

feature -- Properties

	feature_name: ID_AS_B

	parameters: EIFFEL_LIST_B [EXPR_AS_B]

feature

	is_export_valid (feat: FEATURE_I): BOOLEAN is
			-- Is the call export valid ?
		do
			Result := True;
		end;

end -- class ACCESS_INV_AS_B
